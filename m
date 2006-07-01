From: "Jakub Narebski" <jnareb@gmail.com>
Subject: Re: [PATCH] autoconf: Use autoconf to write installation directories to config.mak
Date: Sun, 2 Jul 2006 00:04:38 +0200
Message-ID: <8fe92b430607011504t6987b207kbe27640206755af1@mail.gmail.com>
References: <200606290301.51657.jnareb@gmail.com>
	 <E1FvvuX-0002Lr-Nt@moooo.ath.cx>
	 <7vr717rfbw.fsf@assigned-by-dhcp.cox.net>
	 <20060701213305.GA29115@pasky.or.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Cc: "Junio C Hamano" <junkio@cox.net>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Jul 02 00:04:50 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FwnZz-0007An-IA
	for gcvg-git@gmane.org; Sun, 02 Jul 2006 00:04:43 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751031AbWGAWEl (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 1 Jul 2006 18:04:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751191AbWGAWEk
	(ORCPT <rfc822;git-outgoing>); Sat, 1 Jul 2006 18:04:40 -0400
Received: from nf-out-0910.google.com ([64.233.182.190]:182 "EHLO
	nf-out-0910.google.com") by vger.kernel.org with ESMTP
	id S1751031AbWGAWEk (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 1 Jul 2006 18:04:40 -0400
Received: by nf-out-0910.google.com with SMTP id o63so500988nfa
        for <git@vger.kernel.org>; Sat, 01 Jul 2006 15:04:39 -0700 (PDT)
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=MRLrTi8VPTWUI67oixExEPxX43Rv0DV3uVTZl4tiWpKjIb+DaRRoe14QZBxcENaCum28q7hskUqAd6KFWBY+Jc9gHmZX/cOtbztcGf7WLlV3N51Pno+DKLpfVbiJS7j+mv36O9KSZ/0y1VT8icd6CVaxtPAWdQjAdS88YDncGXo=
Received: by 10.78.140.17 with SMTP id n17mr1909241hud;
        Sat, 01 Jul 2006 15:04:38 -0700 (PDT)
Received: by 10.78.116.8 with HTTP; Sat, 1 Jul 2006 15:04:38 -0700 (PDT)
To: "Petr Baudis" <pasky@suse.cz>
In-Reply-To: <20060701213305.GA29115@pasky.or.cz>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/23066>

On 7/1/06, Petr Baudis <pasky@suse.cz> wrote:
> Dear diary, on Thu, Jun 29, 2006 at 08:23:31PM CEST, I got a letter
> where Junio C Hamano <junkio@cox.net> said that...

>> It would have been a bit easier to swallow if this whole
>> machinery to build config.mk were somewhere under contrib/ (say
>> in contrib/autoconf), with an instruction to make an "opt-in"
>> symlink "ln -s contrib/autoconf/config.mk config.mk" for people
>> who want to use it in the toplevel INSTALL file, perhaps.
>
> Well, I don't get the point of that - it doesn't make any sense to me to
> require this.
>
> The point of ./configure is to make things easier for the user, so to
> balance that we should make the ./configure harder to _call_ by requiring
> the user to do strange arbitrary steps after calling it.

Easiest way is to output ./configure result to e.g. configure.mak.autoconf,
and include this file just before configure.mak in main Makefile.

Just as in patches (although you have to discard or revert two alternate
mechanism patches)

-- 
Jakub Narebski
