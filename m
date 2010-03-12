From: Jari Aalto <jari.aalto@cante.net>
Subject: FEATURE REQUEST: sendemail.aliasesfile support enavironment variables and tilde
Date: Fri, 12 Mar 2010 21:06:19 +0200
Organization: Private
Message-ID: <87zl2dtl5g.fsf@jondo.cante.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Mar 12 20:06:53 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1NqACC-0007fW-VT
	for gcvg-git-2@lo.gmane.org; Fri, 12 Mar 2010 20:06:53 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758382Ab0CLTGr (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 12 Mar 2010 14:06:47 -0500
Received: from lo.gmane.org ([80.91.229.12]:33125 "EHLO lo.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1757170Ab0CLTGq (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 12 Mar 2010 14:06:46 -0500
Received: from list by lo.gmane.org with local (Exim 4.69)
	(envelope-from <gcvg-git-2@m.gmane.org>)
	id 1NqAC5-0007ZB-MR
	for git@vger.kernel.org; Fri, 12 Mar 2010 20:06:45 +0100
Received: from a91-155-187-216.elisa-laajakaista.fi ([91.155.187.216])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Fri, 12 Mar 2010 20:06:45 +0100
Received: from jari.aalto by a91-155-187-216.elisa-laajakaista.fi with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Fri, 12 Mar 2010 20:06:45 +0100
X-Injected-Via-Gmane: http://gmane.org/
X-Complaints-To: usenet@dough.gmane.org
X-Gmane-NNTP-Posting-Host: a91-155-187-216.elisa-laajakaista.fi
User-Agent: Gnus/5.110011 (No Gnus v0.11) Emacs/23.1 (gnu/linux)
Cancel-Lock: sha1:8/Wnwage/o0q1lvhVL7BXVVAczE=
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/142061>



It apperas that this is not possible with 1.7.0:

    # ~/.gitconfig
    [sendemail]
            aliasesfile = $HOME/.mailrc

=> opening $HOME/.mailrc: No such file or directory
ls -la $HOME/.mailrc
lrwxrwxrwx 1 root root 35 2008-05-31 11:08 /home/foo/.mailrc -> vc/git/shell-account-common/.mailrc


Neither seems to be "~/.mailrc" accpeted. Please add support for at
least tilde(~).

Jari
