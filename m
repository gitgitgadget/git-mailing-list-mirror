From: Nguyen Thai Ngoc Duy <pclouds@gmail.com>
Subject: Re: [PATCH nd/struct-pathspec] declare 1-bit bitfields to be unsigned
Date: Wed, 16 Mar 2011 21:20:43 +0700
Message-ID: <AANLkTi=0ifczJw-Thr-XD7JX0YbQbvczSYrWOTB-Pru9@mail.gmail.com>
References: <20110316024959.GA24932@elie> <20110316034232.GA26027@elie>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>
To: Jonathan Nieder <jrnieder@gmail.com>
X-From: git-owner@vger.kernel.org Wed Mar 16 15:21:25 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PzrbE-000754-K5
	for gcvg-git-2@lo.gmane.org; Wed, 16 Mar 2011 15:21:20 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752446Ab1CPOVQ convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 16 Mar 2011 10:21:16 -0400
Received: from mail-wy0-f174.google.com ([74.125.82.174]:44909 "EHLO
	mail-wy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751137Ab1CPOVP convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 16 Mar 2011 10:21:15 -0400
Received: by wya21 with SMTP id 21so1677421wya.19
        for <git@vger.kernel.org>; Wed, 16 Mar 2011 07:21:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc:content-type:content-transfer-encoding;
        bh=OCQ+bAmC+sp79NOo6/qfjZl1VQUt8j5S3FkW/ftBcHw=;
        b=GYXt5z3NuAoDJ1n1hc60kFSJ1NK85Lntx0FvoCidTKH8SHqLI2MojpFv2ZDfusBSA+
         atY1yulHOfxU+wnaqtwY7ZrVkBgiCYoiwGqCnooMS89oUjTVmDV74CHkCSrcTLTcyph3
         nCEmzPb9/yVpJbezSwnVuOM/JrT9WNbW7rvuI=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type:content-transfer-encoding;
        b=C2OLSYRrM7kl+9OdyJ1QwdZzu8VvPlaMiRm3uxZdQuvFY1HHHrzM2yT6SkADnjbA8+
         FleVLwwVtSLRLxPJkr5r6xSOzPRNjjVZCOT8fRBhoheR6+0FeMmNjZ1XJjfmJzrx5cUV
         74zawMVS8DcfyzT97ixxsg1edfhhWI7bE+NW8=
Received: by 10.216.66.131 with SMTP id h3mr1079wed.111.1300285274079; Wed, 16
 Mar 2011 07:21:14 -0700 (PDT)
Received: by 10.216.163.202 with HTTP; Wed, 16 Mar 2011 07:20:43 -0700 (PDT)
In-Reply-To: <20110316034232.GA26027@elie>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/169155>

2011/3/16 Jonathan Nieder <jrnieder@gmail.com>:
> As "gcc -pedantic" notices, a two's complement 1-bit signed integer
> cannot represent the value '1'.
>
> =C2=A0dir.c: In function 'init_pathspec':
> =C2=A0dir.c:1291:4: warning: overflow in implicit constant conversion=
 [-Woverflow]

Thanks. I think I was aware of this but neglected because they are
used as booleans, 1 or -1 does not matter. Good fix anyway.
--=20
Duy
