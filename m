From: Dmitry Potapov <dpotapov@gmail.com>
Subject: Re: [PATCH] Teach "git add" and friends to be paranoid
Date: Mon, 22 Feb 2010 15:25:05 +0300
Message-ID: <20100222122505.GF10191@dpotapov.dyndns.org>
References: <20100213223733.GP24809@gibbs.hungrycats.org>
 <20100214011812.GA2175@dpotapov.dyndns.org>
 <7vljer1gyg.fsf_-_@alter.siamese.dyndns.org>
 <20100219082813.GB17952@dpotapov.dyndns.org>
 <7v635tkta7.fsf@alter.siamese.dyndns.org>
 <7v8waniue8.fsf@alter.siamese.dyndns.org>
 <20100221072142.GA5829@dpotapov.dyndns.org>
 <7vhbpas7ut.fsf@alter.siamese.dyndns.org>
 <20100222033553.GA10191@dpotapov.dyndns.org>
 <7vwry5pxg8.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Zygo Blaxell <zblaxell@esightcorp.com>,
	Ilari Liusvaara <ilari.liusvaara@elisanet.fi>,
	Thomas Rast <trast@student.ethz.ch>,
	Jonathan Nieder <jrnieder@gmail.com>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon Feb 22 14:27:56 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1NjXLi-0007dj-42
	for gcvg-git-2@lo.gmane.org; Mon, 22 Feb 2010 13:25:18 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752260Ab0BVMZL (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 22 Feb 2010 07:25:11 -0500
Received: from mail-fx0-f219.google.com ([209.85.220.219]:34878 "EHLO
	mail-fx0-f219.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752221Ab0BVMZK (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 22 Feb 2010 07:25:10 -0500
Received: by fxm19 with SMTP id 19so2411971fxm.21
        for <git@vger.kernel.org>; Mon, 22 Feb 2010 04:25:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:date:from:to:cc:subject
         :message-id:references:mime-version:content-type:content-disposition
         :in-reply-to:user-agent;
        bh=eXcxjQtqvqj2kbVXEi9FfYk6rPO8i4OZrzkSd9Tvoqk=;
        b=TwWFR4PUKDiuM9giJG7y2h14lQ3bWbcclTY8PKWxw1odz+uzX5AsD2u7fE6EVwUWKa
         vpGmmHovVpYY5NSmcXQA0HDqYoh1QD9i5Jeb3gjHDUjAwRxWaxCPrmc8JrByoG8uNzvY
         bM+Q1sNO2REm7WRZa+8Z6CkhmzxhWRJwDC2pE=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        b=nUcaDuRtJT7BO2nOTgpl7IliYUHHuXR/oUzunLEr3KA/tgB9VpDv/FZ/EmFe2xm+Cm
         Xtea4e5E20LUG7RnhafNx1Dk7cJ3yAmZSKuZbIIQgylyKUb6Bo2ugb/uA6LFLm/Q5Qft
         8qXu9GQhPWBr9+c5zayMAEMZgXmViWG6T/5dc=
Received: by 10.87.55.18 with SMTP id h18mr2983182fgk.65.1266841508445;
        Mon, 22 Feb 2010 04:25:08 -0800 (PST)
Received: from localhost (ppp91-77-227-64.pppoe.mtu-net.ru [91.77.227.64])
        by mx.google.com with ESMTPS id 14sm1447284fxm.13.2010.02.22.04.25.06
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Mon, 22 Feb 2010 04:25:07 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <7vwry5pxg8.fsf@alter.siamese.dyndns.org>
User-Agent: Mutt/1.5.20 (2009-06-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/140676>

On Sun, Feb 21, 2010 at 10:59:51PM -0800, Junio C Hamano wrote:
> 
> "... a winner, below 128kB; above that the difference is within noise and
> measurement error"?

What I was trying to say is that if you see consistently four or five
points win (based on many trials), it is clear a win; but you have 25%
error bar for the gain number.


Dmitry
