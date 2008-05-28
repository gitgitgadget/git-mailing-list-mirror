From: Lea Wiemann <lewiemann@gmail.com>
Subject: Re: [PATCH] gitweb: only display "next" links in logs if there is
 a next page
Date: Wed, 28 May 2008 02:10:47 +0200
Message-ID: <483CA307.8040900@gmail.com>
References: <483C97E7.2020504@gmail.com> <1211930742-24978-1-git-send-email-LeWiemann@gmail.com> <483C99A2.90909@gmail.com> <7v1w3nz43f.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed May 28 02:12:00 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1K19Go-0002lW-9n
	for gcvg-git-2@gmane.org; Wed, 28 May 2008 02:11:58 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757470AbYE1AKu (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 27 May 2008 20:10:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1757261AbYE1AKu
	(ORCPT <rfc822;git-outgoing>); Tue, 27 May 2008 20:10:50 -0400
Received: from fg-out-1718.google.com ([72.14.220.152]:49394 "EHLO
	fg-out-1718.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751868AbYE1AKt (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 27 May 2008 20:10:49 -0400
Received: by fg-out-1718.google.com with SMTP id 19so1641895fgg.17
        for <git@vger.kernel.org>; Tue, 27 May 2008 17:10:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:user-agent:mime-version:to:cc:subject:references:in-reply-to:content-type:content-transfer-encoding:from;
        bh=VHItRhZtSzVlu7FQpyfP5IC3bbVrtf2qEqamyOZsTY8=;
        b=QD1zNJ2N49vhYIgga17N2WqdHxRGG+rGzx5TYsCA58mrXh8+bTkUSunV+eKndqA4vG+BAzvSJroigglqpow1i4FGa6aDVeXV2X36LL+ZwDadvAaArgdP+tf8C2w9fjm5TTz8s2w7tBIVjyFijeSXD+2eRU5ZjVFB3Su/SoJFbKA=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:user-agent:mime-version:to:cc:subject:references:in-reply-to:content-type:content-transfer-encoding:from;
        b=odLrHBHpXws4ViTELcvEJ8E+/U4hXgPeYmc2T55fpPNIeY8nNWsMaJnya4l6ko920IbZX9ivIP9M+FfhCgwYTXFUW3TzYpIBYHSQ2edGpIQRFy6w/NXBHX1894XoN6eXaJvBe9YhZozR1tMgevN5saq6R3x7a1ynYTXEtbKiKNM=
Received: by 10.86.61.13 with SMTP id j13mr4626426fga.76.1211933447719;
        Tue, 27 May 2008 17:10:47 -0700 (PDT)
Received: from ?192.168.23.50? ( [91.33.209.73])
        by mx.google.com with ESMTPS id e11sm13763907fga.1.2008.05.27.17.10.46
        (version=SSLv3 cipher=RC4-MD5);
        Tue, 27 May 2008 17:10:47 -0700 (PDT)
User-Agent: Thunderbird 2.0.0.14 (X11/20080421)
In-Reply-To: <7v1w3nz43f.fsf@gitster.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/83066>

Junio C Hamano wrote:
> I do not trust people who rely on "tests" to catch counting errors

Oh, I wasn't trying to say that I didn't "brain-check" my code for 
correctness -- I just think it's a good idea to actually test it in 
addition to that. :)

Anyways, thanks for reviewing and confirming it!

> I wonder if it is easier to read to use the more modern @array notation
> than historic $#array notation (it looks very Perl 4 to me), but that is a
> separate issue.  gitweb is littered with such anachronism ;-)

Yup, I was trying to be consistent there.

-- Lea
