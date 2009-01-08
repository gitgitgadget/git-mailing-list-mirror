From: "=?ISO-8859-1?Q?=D8yvind_Harboe?=" <oyvind.harboe@zylin.com>
Subject: Re: Problems with large compressed binaries when converting from svn
Date: Thu, 8 Jan 2009 08:33:13 +0100
Message-ID: <c09652430901072333r6a2d849cn5dff8f53e18cd6ba@mail.gmail.com>
References: <c09652430901060455l5179888ep3c51ff4e3dd5a6ef@mail.gmail.com>
	 <81b0412b0901071555t62c1da3ar2b2cfd14222b502e@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: "Alex Riesen" <raa.lkml@gmail.com>
X-From: git-owner@vger.kernel.org Thu Jan 08 08:34:43 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LKpPd-0006Pg-Ih
	for gcvg-git-2@gmane.org; Thu, 08 Jan 2009 08:34:42 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753199AbZAHHdR convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 8 Jan 2009 02:33:17 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753191AbZAHHdR
	(ORCPT <rfc822;git-outgoing>); Thu, 8 Jan 2009 02:33:17 -0500
Received: from mail-bw0-f21.google.com ([209.85.218.21]:41174 "EHLO
	mail-bw0-f21.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753055AbZAHHdP convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 8 Jan 2009 02:33:15 -0500
Received: by bwz14 with SMTP id 14so26842127bwz.13
        for <git@vger.kernel.org>; Wed, 07 Jan 2009 23:33:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from:sender
         :to:subject:cc:in-reply-to:mime-version:content-type
         :content-transfer-encoding:content-disposition:references
         :x-google-sender-auth;
        bh=LzbNa41mIdK9oXRhh+Xh745qlt5qVAp9CB2xADvk1CY=;
        b=dTgtAbc8shC1kwnLGwgdvxYfQF7iH/STk+8F/ysglKDCEcGbCdG9plvGbDq25Ezefx
         VW8s49phmEtrHOX5upq0Ysvr2UuXwCcjpsNnTS2fKWvUnebmQv52SgPiBgY9wnY40gtw
         Jf+NZeEALZGj7E/k058KT11OGCOGhdclu4+3Q=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:sender:to:subject:cc:in-reply-to:mime-version
         :content-type:content-transfer-encoding:content-disposition
         :references:x-google-sender-auth;
        b=Qi0iuAqz8It4aDBatG9+LYcDb5LfVW8Z7qkWJa/wJy1SAn5KgtFv3SY119JBnGKOdI
         ZZINJHo4hpuU/d4OXsbDj7vQMIjDC8N6NidWq8DPio4YStKT/A4BbFgkFEKqpyxYSn3q
         z3saA0dToU0hlqUfNXknrHbqsbkBZqagrCvNM=
Received: by 10.223.106.71 with SMTP id w7mr17259867fao.22.1231399993545;
        Wed, 07 Jan 2009 23:33:13 -0800 (PST)
Received: by 10.223.121.142 with HTTP; Wed, 7 Jan 2009 23:33:13 -0800 (PST)
In-Reply-To: <81b0412b0901071555t62c1da3ar2b2cfd14222b502e@mail.gmail.com>
Content-Disposition: inline
X-Google-Sender-Auth: 69746230d4261e81
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/104895>

>> Does git have some capability to store diffs of compressed files eff=
iciently?
>
> No, but you can unpack the tarballs and include the toolchains as sub=
modules
> (aka subprojects) in the projects which need them.
>
> See man page to git submodule, the user-manual.txt on "submodule" and
> gitmodules.txt (submodule configuration formats and conventions).

I'll need the submodule stuff for sure, but in this particular case I w=
as
trying to see if there was a way to keep the svn abuse patterns from
svn under git without a lot of retraining.



--=20
=D8yvind Harboe
http://www.zylin.com/zy1000.html
ARM7 ARM9 XScale Cortex
JTAG debugger and flash programmer
