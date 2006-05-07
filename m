From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: Unresolved issues #2
Date: Sun, 07 May 2006 02:41:00 +0200
Organization: At home
Message-ID: <e3jfmh$1vc$1@sea.gmane.org>
References: <7v64lcqz9j.fsf@assigned-by-dhcp.cox.net> <7v4q065hq0.fsf@assigned-by-dhcp.cox.net> <Pine.LNX.4.64.0605041627310.6713@iabervon.org> <Pine.LNX.4.64.0605041715500.3611@g5.osdl.org> <7vhd43vgnm.fsf@assigned-by-dhcp.cox.net> <Pine.LNX.4.64.0605060821430.16343@g5.osdl.org> <BAYC1-PASMTP10F63ADF30C26A29D070C5AEAA0@CEZ.ICE> <Pine.LNX.4.64.0605060923050.16343@g5.osdl.org> <BAYC1-PASMTP0824AA77198F95FE28B79DAEAA0@CEZ.ICE> <Pine.LNX.4.64.0605061008340.16343@g5.osdl.org> <7vvesirh0q.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7Bit
X-From: git-owner@vger.kernel.org Sun May 07 02:41:17 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FcXKg-0003pX-V0
	for gcvg-git@gmane.org; Sun, 07 May 2006 02:41:11 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751156AbWEGAlI (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 6 May 2006 20:41:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751159AbWEGAlH
	(ORCPT <rfc822;git-outgoing>); Sat, 6 May 2006 20:41:07 -0400
Received: from main.gmane.org ([80.91.229.2]:56745 "EHLO ciao.gmane.org")
	by vger.kernel.org with ESMTP id S1751156AbWEGAlG (ORCPT
	<rfc822;git@vger.kernel.org>); Sat, 6 May 2006 20:41:06 -0400
Received: from list by ciao.gmane.org with local (Exim 4.43)
	id 1FcXKW-0003kw-94
	for git@vger.kernel.org; Sun, 07 May 2006 02:41:00 +0200
Received: from 193.0.122.19 ([193.0.122.19])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Sun, 07 May 2006 02:41:00 +0200
Received: from jnareb by 193.0.122.19 with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Sun, 07 May 2006 02:41:00 +0200
X-Injected-Via-Gmane: http://gmane.org/
To: git@vger.kernel.org
X-Complaints-To: usenet@sea.gmane.org
X-Gmane-NNTP-Posting-Host: 193.0.122.19
User-Agent: KNode/0.7.7
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/19685>

Junio C Hamano wrote:

> It might make sense to rewrite it to parse and read the existing
> configuration as a whole, do necessary manupulations on the
> parsed internal representation in-core, and write the result out
> from scratch.

Or perhaps do git repo-config read and change config file in two passes:
read and build some kind of index (beginning of section, end of
section/last variable in section, number of elements in section), then in
second pass add some information if needed.

-- 
Jakub Narebski
Warsaw, Poland
