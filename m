From: Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: [PATCH 7/8] Documentation/cherry-pick: describe passing more
 than one commit
Date: Wed, 2 Jun 2010 01:14:52 -0500
Message-ID: <20100602061452.GA9439@progeny.tock>
References: <20100531193359.28729.55562.chriscool@tuxfamily.org>
 <20100531194240.28729.50475.chriscool@tuxfamily.org>
 <20100601095124.GA1033@progeny.tock>
 <201006020757.34186.chriscool@tuxfamily.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Sverre Rabbelier <srabbelier@gmail.com>,
	Ramkumar Ramachandra <artagnon@gmail.com>
To: Christian Couder <chriscool@tuxfamily.org>
X-From: git-owner@vger.kernel.org Wed Jun 02 08:14:57 2010
connect(): No such file or directory
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OJhE8-0003TE-PW
	for gcvg-git-2@lo.gmane.org; Wed, 02 Jun 2010 08:14:57 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754370Ab0FBGOu convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 2 Jun 2010 02:14:50 -0400
Received: from mail-gw0-f46.google.com ([74.125.83.46]:37994 "EHLO
	mail-gw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752020Ab0FBGOt (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 2 Jun 2010 02:14:49 -0400
Received: by gwaa12 with SMTP id a12so4323471gwa.19
        for <git@vger.kernel.org>; Tue, 01 Jun 2010 23:14:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:date:from:to:cc:subject
         :message-id:references:mime-version:content-type:content-disposition
         :content-transfer-encoding:in-reply-to:user-agent;
        bh=/q3A+if+hRY2iXlhWmppP3szjN5erDiwQFe8oS1NNIA=;
        b=pwCLwLLai2wDjTEVmfPAdhro/mArej9z2cdS0VAzZ4XhdMpWqNZKYv19Hio+2X+Qsh
         t/6Qtp6F+Q2MvzIYhCIATRGCppvnWMjxzQKijaZVKKdywr7/EoQ2Qr7lC/OVcrObNEEO
         9j+CN68NYtWPeujFGUWaiqK3cweU53FzxG/g0=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        b=ad/aOd8jG6nRIOSKa00kqlLVl24AaOOJbBeliCPLwdHx9IXYQ9I2ER9JWPqohJOhj7
         9EiOtdAHQkcxVNW/grs/FPCBgODUYiiALsK1oC9zgwjooqmkR2cKJm7mVty/9MdPl3lp
         KdwNYA/oxG5VNhyZwcWK4oktMHv5MtJOGd5j0=
Received: by 10.42.3.197 with SMTP id 5mr7331874icp.24.1275459286308;
        Tue, 01 Jun 2010 23:14:46 -0700 (PDT)
Received: from progeny.tock (c-98-212-3-231.hsd1.il.comcast.net [98.212.3.231])
        by mx.google.com with ESMTPS id f1sm35021914ibg.15.2010.06.01.23.14.44
        (version=SSLv3 cipher=RC4-MD5);
        Tue, 01 Jun 2010 23:14:45 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <201006020757.34186.chriscool@tuxfamily.org>
User-Agent: Mutt/1.5.20 (2009-06-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/148217>

Christian Couder wrote:
> On Tuesday 01 June 2010 11:51:24 Jonathan Nieder wrote:

>> git rev-list master -- README | git cherry-pick -n --stdin::
>>=20
>> 	Apply the changes introduced by all commits on the master
>> 	branch that touched README to the working tree and index,
>> 	so the result can be inspected and made into a single new
>> 	commit if suitable.
>
> I think "--reverse" is needed after "rev-list" and cherry-pick has no=
 --stdin=20
> option.

That=E2=80=99s too bad. :(  git show inherits it from rev-list.

Your new series looks good.  Maybe I will obfuscate the examples some
other day.

Thanks,
Jonathan
