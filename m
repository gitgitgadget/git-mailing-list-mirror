From: "Josh Boyer" <jwboyer@gmail.com>
Subject: Re: git-unpack-objects
Date: Wed, 3 May 2006 12:35:54 -0500
Message-ID: <625fc13d0605031035l721ab08dmee6f870abb49f4e4@mail.gmail.com>
References: <625fc13d0605011552j4189338bx14083657acffc18e@mail.gmail.com>
	 <7vu089qr4t.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII;
	format=flowed
Content-Transfer-Encoding: 7BIT
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed May 03 19:36:03 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FbLGa-0005lo-G0
	for gcvg-git@gmane.org; Wed, 03 May 2006 19:36:00 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030263AbWECRf4 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 3 May 2006 13:35:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030264AbWECRf4
	(ORCPT <rfc822;git-outgoing>); Wed, 3 May 2006 13:35:56 -0400
Received: from ug-out-1314.google.com ([66.249.92.173]:35455 "EHLO
	ug-out-1314.google.com") by vger.kernel.org with ESMTP
	id S1030263AbWECRf4 convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 3 May 2006 13:35:56 -0400
Received: by ug-out-1314.google.com with SMTP id m3so138343ugc
        for <git@vger.kernel.org>; Wed, 03 May 2006 10:35:54 -0700 (PDT)
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=aBJ57t9IRQcIpZdTDNIrJVb5cV6HFX+ANUEZXQ7DJ10As3POiciWO4BfVr5w5QZzxRqAavw8sTlaQ0/8GyflHW3dm+PO3n1Hdd24uvBvjBQNAhCMhbv8HSonQSlATa9TEuU+fL3zZHudKl4Htj75z6gWbPYZDU8GBFxKe1Qnhbo=
Received: by 10.78.43.1 with SMTP id q1mr5530huq;
        Wed, 03 May 2006 10:35:54 -0700 (PDT)
Received: by 10.78.29.19 with HTTP; Wed, 3 May 2006 10:35:54 -0700 (PDT)
To: "Junio C Hamano" <junkio@cox.net>
In-Reply-To: <7vu089qr4t.fsf@assigned-by-dhcp.cox.net>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/19504>

On 5/1/06, Junio C Hamano <junkio@cox.net> wrote:
>
> unpack tries to unpack and if it already has the object it
> skips.
>
> If you really wanted to do it, here is a way to do so.
>
>         mv .git/objets/pack/pack-49*.pack \
>                 .git/objets/pack/pack-49*.idx .
>         git unpack-objects <pack-49*.pack

Hm..  so it seems that git-unpack-objects is more intended to unpack a
pack one has gotten with git-fetch-pack, right?

I was looking for something more along the lines of an
"un-git-repack", where you have existing pack(s) and want to undo
them.  Maybe you want to repack everything into a single pack or
something like that.

josh
