From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: Implementing branch attributes in git config
Date: Tue, 9 May 2006 01:40:52 +0200 (CEST)
Message-ID: <Pine.LNX.4.63.0605090137160.5755@wbgn013.biozentrum.uni-wuerzburg.de>
References: <1147037659.25090.25.camel@dv> <Pine.LNX.4.64.0605071629080.3718@g5.osdl.org>
 <1147048587.17371.13.camel@dv> <Pine.LNX.4.64.0605071740550.3718@g5.osdl.org>
 <7vfyjli9vf.fsf@assigned-by-dhcp.cox.net> <BAYC1-PASMTP0334B471C6908E4E40BFD2AEA80@CEZ.ICE>
 <7vbqu9i6zl.fsf@assigned-by-dhcp.cox.net> <BAYC1-PASMTP110777A694DAF1D7623895AEA80@CEZ.ICE>
 <Pine.LNX.4.64.0605081905240.6713@iabervon.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue May 09 01:41:12 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FdFLZ-0006YY-GW
	for gcvg-git@gmane.org; Tue, 09 May 2006 01:41:01 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750890AbWEHXky (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 8 May 2006 19:40:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750891AbWEHXky
	(ORCPT <rfc822;git-outgoing>); Mon, 8 May 2006 19:40:54 -0400
Received: from wrzx28.rz.uni-wuerzburg.de ([132.187.3.28]:39338 "EHLO
	mailrelay.rz.uni-wuerzburg.de") by vger.kernel.org with ESMTP
	id S1750888AbWEHXky (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 8 May 2006 19:40:54 -0400
Received: from virusscan.mail (localhost [127.0.0.1])
	by mailrelay.mail (Postfix) with ESMTP id D9E901F4A;
	Tue,  9 May 2006 01:40:52 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
	by virusscan.mail (Postfix) with ESMTP id CEB641F44;
	Tue,  9 May 2006 01:40:52 +0200 (CEST)
Received: from dumbo2 (wbgn013.biozentrum.uni-wuerzburg.de [132.187.25.13])
	by mailmaster.uni-wuerzburg.de (Postfix) with ESMTP id B0C9212B4;
	Tue,  9 May 2006 01:40:52 +0200 (CEST)
X-X-Sender: gene099@wbgn013.biozentrum.uni-wuerzburg.de
To: Daniel Barkalow <barkalow@iabervon.org>
In-Reply-To: <Pine.LNX.4.64.0605081905240.6713@iabervon.org>
X-Virus-Scanned: by amavisd-new at uni-wuerzburg.de
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/19782>

Hi,

On Mon, 8 May 2006, Daniel Barkalow wrote:

> You could tell people always to use:
> 
>  [branch."name"]

I find this utterly ugly.

> I don't think that people are likely to use older versions of git on the 
> same repository they've used newer versions on. (Clones of it, sure, but 
> that doesn't matter here.) But we should, in any case, make the code 
> ignore sections or lines with syntax errors, under the assumption that 
> they're a later extension and possibly legal but not anything the code 
> could be interested in getting from a parser that doesn't support them.

I have to bisect git sometimes, just because I have some local changes. 
Older gits do barf with a fatal error when encountering a bad config.

Further, it is probably not a good idea to relax error-checking. It is too 
easy to overlook.

Ciao,
Dscho
