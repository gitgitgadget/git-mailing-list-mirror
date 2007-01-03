From: "Lars Hjemli" <hjemli@gmail.com>
Subject: Re: Possible regression in git-rev-list --header
Date: Wed, 3 Jan 2007 11:38:07 +0100
Message-ID: <8c5c35580701030238t651af0f3kcff7600768dda722@mail.gmail.com>
References: <e5bfff550612300956mef4691fqf607fad173c571da@mail.gmail.com>
	 <7vlkkphvrb.fsf@assigned-by-dhcp.cox.net>
	 <Pine.LNX.4.63.0612310211300.25709@wbgn013.biozentrum.uni-wuerzburg.de>
	 <7v64bsj0s4.fsf@assigned-by-dhcp.cox.net>
	 <e5bfff550612310345j4c882b7av51879ca1175a1c6b@mail.gmail.com>
	 <Pine.LNX.4.63.0612311613180.22628@wbgn013.biozentrum.uni-wuerzburg.de>
	 <e5bfff550612310743t4ca1b017ubceddffafd06ac59@mail.gmail.com>
	 <7vodpja0u8.fsf@assigned-by-dhcp.cox.net>
	 <e5bfff550701030121n700fab25x63278457c884a3f7@mail.gmail.com>
	 <8c5c35580701030221w5c04e2eaq757d12c4ca0b0780@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Cc: "Junio C Hamano" <junkio@cox.net>, git@vger.kernel.org,
	"Johannes Schindelin" <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Wed Jan 03 11:38:24 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1H23Ve-0001G6-Rh
	for gcvg-git@gmane.org; Wed, 03 Jan 2007 11:38:15 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750695AbXACKiK (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 3 Jan 2007 05:38:10 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750701AbXACKiK
	(ORCPT <rfc822;git-outgoing>); Wed, 3 Jan 2007 05:38:10 -0500
Received: from nf-out-0910.google.com ([64.233.182.187]:32925 "EHLO
	nf-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750695AbXACKiJ (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 3 Jan 2007 05:38:09 -0500
Received: by nf-out-0910.google.com with SMTP id o25so7652738nfa
        for <git@vger.kernel.org>; Wed, 03 Jan 2007 02:38:08 -0800 (PST)
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=LcIPoSGd0LGOnv80BWL8ABkUge/cLWDDT1X4NhHNo7RWj8PtlF4s5XW7ghlseYJOrM/jiKZ63kLIpEsQNRjjFBgLEN13JyGMxH6TkDAlxCpq/UOOfkTWezG/HIVSb0PvqlGWKcuwMT4gTdAJWOd1CH7J04wKlt7nwCMHpU4zGWY=
Received: by 10.82.120.14 with SMTP id s14mr1611767buc.1167820687787;
        Wed, 03 Jan 2007 02:38:07 -0800 (PST)
Received: by 10.82.171.10 with HTTP; Wed, 3 Jan 2007 02:38:07 -0800 (PST)
To: "Marco Costalba" <mcostalba@gmail.com>
In-Reply-To: <8c5c35580701030221w5c04e2eaq757d12c4ca0b0780@mail.gmail.com>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/35857>

On 1/3/07, Lars Hjemli <hjemli@gmail.com> wrote:
>   commit ::= header [blank+ [title+ [blank+ text*]]] '\0'
>   header ::= tree parent* author committer

Sorry, this should have been

   commit ::= header [blank+ [title+ [blank+ text*]]] '\0'
   header ::= tree parent* author committer other_header*

-- 
larsh
