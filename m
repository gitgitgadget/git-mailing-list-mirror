From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: Implementing branch attributes in git config
Date: Tue, 09 May 2006 06:28:09 +0200
Organization: At home
Message-ID: <e3p5om$djs$1@sea.gmane.org>
References: <1147037659.25090.25.camel@dv> <Pine.LNX.4.64.0605071629080.3718@g5.osdl.org> <1147048587.17371.13.camel@dv> <Pine.LNX.4.64.0605071740550.3718@g5.osdl.org> <7vfyjli9vf.fsf@assigned-by-dhcp.cox.net> <BAYC1-PASMTP0334B471C6908E4E40BFD2AEA80@CEZ.ICE> <7vbqu9i6zl.fsf@assigned-by-dhcp.cox.net> <BAYC1-PASMTP110777A694DAF1D7623895AEA80@CEZ.ICE> <Pine.LNX.4.64.0605081905240.6713@iabervon.org> <BAYC1-PASMTP0453E2D70B10C6D116167EAEA80@CEZ.ICE> <Pine.LNX.4.63.0605090142280.5778@wbgn013.biozentrum.uni-wuerzburg.de> <BAYC1-PASMTP03ADC2F3E75E482ADC5CD3AEA90@CEZ.ICE> <Pine.LNX.4.64.0605081731440.3718@g5.osdl.org> <7virogc90u.fsf@assigned-by-dhcp.cox.net> <Pine.LNX.4.64.0605081801360.3718@g5.osdl.org> <7v1wv4c7wk.fsf@assigned-by-dhcp.cox.net> <Pine.LNX.4.64.0605081854190.3718@g5.osdl.org> <BAYC1-PASMTP04C9C4BF5B89E55B9D877AAEA90@CEZ.ICE> <Pine.LNX.4.64.0605082007100.3718@g5.osdl.org> <BAYC1
 -PASMTP05953E2B948CB07A171FD8AEA90@CEZ.ICE> <Pine.LNX.4.64.0605082100460.3718@g5.osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7Bit
X-From: git-owner@vger.kernel.org Tue May 09 06:29:00 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FdJpy-0000Z3-TB
	for gcvg-git@gmane.org; Tue, 09 May 2006 06:28:45 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751371AbWEIE2k (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 9 May 2006 00:28:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751372AbWEIE2k
	(ORCPT <rfc822;git-outgoing>); Tue, 9 May 2006 00:28:40 -0400
Received: from main.gmane.org ([80.91.229.2]:4078 "EHLO ciao.gmane.org")
	by vger.kernel.org with ESMTP id S1751371AbWEIE2j (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 9 May 2006 00:28:39 -0400
Received: from list by ciao.gmane.org with local (Exim 4.43)
	id 1FdJpj-0000WZ-Rc
	for git@vger.kernel.org; Tue, 09 May 2006 06:28:29 +0200
Received: from 193.0.122.19 ([193.0.122.19])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Tue, 09 May 2006 06:28:27 +0200
Received: from jnareb by 193.0.122.19 with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Tue, 09 May 2006 06:28:27 +0200
X-Injected-Via-Gmane: http://gmane.org/
To: git@vger.kernel.org
X-Complaints-To: usenet@sea.gmane.org
X-Gmane-NNTP-Posting-Host: 193.0.122.19
User-Agent: KNode/0.7.7
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/19816>

Linus Torvalds wrote:

> I would suggest a much more readable format:
> 
> [core]
> ...
> 
> [branch "core"]
> ...
> 
> [remote "core"]
> ...
> 
> and yes, enforce the <space>+<quoted name> format. We'd turn it internally
> into some random internal string format (probably replacing the space with
> a dot, and removing the quotes, so it would become "remote.core.<key>").

I'm all for it. Nice compromise of [branch."miXedCaps"] and ["miXedCaps"],
human readable end editable, and easy parsable.

-- 
Jakub Narebski
Warsaw, Poland
