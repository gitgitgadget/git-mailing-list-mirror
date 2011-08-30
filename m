From: Mike Gant <mwgant@gmail.com>
Subject: git tab completion shows ansi escape sequences
Date: Mon, 29 Aug 2011 20:17:07 -0600
Message-ID: <20110830021707.GA27166@gantsfort.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Aug 30 04:24:27 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QyDzy-0002cW-UJ
	for gcvg-git-2@lo.gmane.org; Tue, 30 Aug 2011 04:24:23 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751407Ab1H3CYS (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 29 Aug 2011 22:24:18 -0400
Received: from gantsfort.com ([64.66.245.199]:55260 "EHLO mail.gantsfort.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750966Ab1H3CYS (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 29 Aug 2011 22:24:18 -0400
X-Greylist: delayed 429 seconds by postgrey-1.27 at vger.kernel.org; Mon, 29 Aug 2011 22:24:18 EDT
Received: from mg1 (mg1.gantsfort.com [192.168.0.10])
	by mail.gantsfort.com (Postfix) with SMTP id 8EC4617DFA
	for <git@vger.kernel.org>; Mon, 29 Aug 2011 20:17:07 -0600 (MDT)
Received: by mg1 (sSMTP sendmail emulation); Mon, 29 Aug 2011 20:17:07 -0600
Mail-Followup-To: git@vger.kernel.org
Content-Disposition: inline
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/180386>

Tab completion results in this output:

$ git <TAB><TAB>
^[[31m^[[K                  c^[[m^[[Kount-objects       g^[[m^[[Ket-tar-commit-id   replace 
a^[[m^[[Kdd                 c^[[m^[[Kvsexportcommit     g^[[m^[[Krep                request-pull 
a^[[m^[[Km                  c^[[m^[[Kvsimport           g^[[m^[[Kui                 reset 
a^[[m^[[Knnotate            c^[[m^[[Kvsserver           help                        revert 
a^[[m^[[Kpply               ci                          imap-send                   rl 
a^[[m^[[Krchive             co                          init                        rm 
b^[[m^[[Kisect              d^[[m^[[Kaemon              instaweb                    send-email 
b^[[m^[[Klame               d^[[m^[[Kescribe            log                         shortlog 
b^[[m^[[Kranch              d^[[m^[[Kiff                logk                        show 
b^[[m^[[Kundle              d^[[m^[[Kiff-files          lol                         show-branch 
br                          d^[[m^[[Kiff-index          lola                        st 
c^[[m^[[Kat-file            d^[[m^[[Kiff-tree           ls                          sta 
c^[[m^[[Kheck-attr          d^[[m^[[Kifftool            merge                       stage 
c^[[m^[[Kheck-ref-format    f^[[m^[[Kast-export         mergetool                   stash 
c^[[m^[[Kheckout            f^[[m^[[Kast-import         mv                          status 
c^[[m^[[Kheckout-index      f^[[m^[[Ketch               name-rev                    sts 
c^[[m^[[Kherry              f^[[m^[[Ketch-pack          notes                       submodule 
c^[[m^[[Kherry-pick         f^[[m^[[Kilter-branch       pull                        svn 
c^[[m^[[Kitool              f^[[m^[[Kmt-merge-msg       push                        tag 
c^[[m^[[Klean               f^[[m^[[Kor-each-ref        rebase                      tlog 
c^[[m^[[Klone               f^[[m^[[Kormat-patch        reflog                      unstage 
c^[[m^[[Kommit              f^[[m^[[Ksck                relink                      whatchanged 
c^[[m^[[Kommit-tree         f^[[m^[[Ksck-objects        remote                      
c^[[m^[[Konfig              g^[[m^[[Kc                  repack                      

This is on Linux Mint 11 but it also happens on openSuse 11.4.

$ echo $SHELL
bash

$ echo $BASH_VERSION
4.2.8(1)-release

$ echo $TERM
xterm-256color

The same result when TERM is set to xterm, rxvt, rxvt-256color, rxvt-unicode.

Does anyone know why I'm getting this output?

Thanks,
Mike
