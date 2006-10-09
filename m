From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: [PATCH] gitweb: Cleanup Git logo and Git logo target generation
Date: Mon, 9 Oct 2006 09:14:59 +0200
Message-ID: <200610090914.59834.jnareb@gmail.com>
References: <20060919212725.GA13132@pasky.or.cz> <egbogh$d7d$1@sea.gmane.org> <7vac46gvg8.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Oct 09 09:14:20 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1GWpL3-0003Do-DZ
	for gcvg-git@gmane.org; Mon, 09 Oct 2006 09:14:14 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932272AbWJIHOH (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 9 Oct 2006 03:14:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932262AbWJIHOH
	(ORCPT <rfc822;git-outgoing>); Mon, 9 Oct 2006 03:14:07 -0400
Received: from ug-out-1314.google.com ([66.249.92.175]:32964 "EHLO
	ug-out-1314.google.com") by vger.kernel.org with ESMTP
	id S932272AbWJIHOE (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 9 Oct 2006 03:14:04 -0400
Received: by ug-out-1314.google.com with SMTP id o38so539209ugd
        for <git@vger.kernel.org>; Mon, 09 Oct 2006 00:14:03 -0700 (PDT)
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:from:to:subject:date:user-agent:cc:references:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:message-id;
        b=bzvDIsbcz0LJyFoIJiZU8eExKcTSQeCLt5NfJ5XDY4+TPrGoI+6swGzPOpKg9n+syxVcBWpF4MuGGfap1jhI7sRCLRutiph11EMtgVau9lVrG+WzmZrtOcJ7hog3UnBuH430oqwYK7p7uWazrB5ZGpbn5DED/1g0BSHc23P/xmM=
Received: by 10.66.244.10 with SMTP id r10mr6331758ugh;
        Mon, 09 Oct 2006 00:14:02 -0700 (PDT)
Received: from host-81-190-27-91.torun.mm.pl ( [81.190.27.91])
        by mx.google.com with ESMTP id o30sm1159699ugd.2006.10.09.00.14.02;
        Mon, 09 Oct 2006 00:14:02 -0700 (PDT)
To: Junio C Hamano <junkio@cox.net>
User-Agent: KMail/1.9.3
In-Reply-To: <7vac46gvg8.fsf@assigned-by-dhcp.cox.net>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/28564>

Junio C Hamano wrote:
> Jakub Narebski <jnareb@gmail.com> writes:
> 
>> Junio C Hamano wrote:
>>
>>> Petr Baudis <pasky@suse.cz> writes:
>>> 
>>>> Is there a problem with taking <200610061231.06017.jnareb@gmail.com>?
>>>>
>>>> I think it's currently not worth the complexity and breakage of
>>>> backwards compatibility to do the more elaborate form you proposed.
>>> 
>>> I agree with that, except that the 72x27 dimension bit troubles
>>> me.
>>
>> First, that's the problem for the future. The 72x27 was there, I have not
>> introduced this. 
> 
> That's exactly my point.  This is not a "placing blame" game.
> 
> It just feels wrong to update only two things when we already
> know there are others that need fixing in a very similar way.
 
Well, I'd rather have it corrected, than wait for generalized version
which would allow to set dimensions and stuff... which is most probably
not needed.

Partial improvement is better than no improvement (especially as it
corrects 'href="'.esc_html($githelp_url).'"' bug).
-- 
Jakub Narebski
Poland
