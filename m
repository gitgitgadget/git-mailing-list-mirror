From: "Lars Hjemli" <hjemli@gmail.com>
Subject: Re: [PATCH] git-branch: show detached HEAD
Date: Wed, 3 Jan 2007 08:50:50 +0100
Message-ID: <8c5c35580701022350n13742ec1n6f5fadcf1dfb18aa@mail.gmail.com>
References: <7vac11yirf.fsf@assigned-by-dhcp.cox.net>
	 <1167780131528-git-send-email-hjemli@gmail.com>
	 <20070103051811.GB23358@spearce.org>
	 <7v7iw4r47e.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Cc: "Shawn O. Pearce" <spearce@spearce.org>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Jan 03 08:50:55 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1H20tj-0006K5-7F
	for gcvg-git@gmane.org; Wed, 03 Jan 2007 08:50:55 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754991AbXACHuw (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 3 Jan 2007 02:50:52 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754993AbXACHuw
	(ORCPT <rfc822;git-outgoing>); Wed, 3 Jan 2007 02:50:52 -0500
Received: from nf-out-0910.google.com ([64.233.182.188]:47346 "EHLO
	nf-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754984AbXACHuv (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 3 Jan 2007 02:50:51 -0500
Received: by nf-out-0910.google.com with SMTP id o25so7606972nfa
        for <git@vger.kernel.org>; Tue, 02 Jan 2007 23:50:50 -0800 (PST)
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=XpwXN1yNHKxvXor9DlhhWQHWPHgH4KMVGS8VZ085edopLFPMWGv52Qy7spx6Hlid3hQ8CuNMdadxA9k5H/Nk/ufNC46xvhDY/evO/X6xsLq+N+M3amz1Pft9+QqvO8Grve2Ua3LTbkbnuax4Dlcl+OvfliZ69djmTIHPOACXbmY=
Received: by 10.82.179.9 with SMTP id b9mr1677329buf.1167810650671;
        Tue, 02 Jan 2007 23:50:50 -0800 (PST)
Received: by 10.82.171.10 with HTTP; Tue, 2 Jan 2007 23:50:50 -0800 (PST)
To: "Junio C Hamano" <junkio@cox.net>
In-Reply-To: <7v7iw4r47e.fsf@assigned-by-dhcp.cox.net>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/35850>

On 1/3/07, Junio C Hamano <junkio@cox.net> wrote:
> I would even make it stronger to say something like:
>
>         * You are not on ANY branch right now.
>           master
>           next
>           pu
>           ...
>

Hmm, that wouldn't be very nice for 'git-branch -v' (which suddenly
got extra useful with detached head).

-- 
larsh
