From: Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: Feature request: relative paths
Date: Thu, 6 May 2010 04:01:33 -0500
Message-ID: <20100506090132.GA26079@progeny.tock>
References: <19426.23330.525936.981066@winooski.ccs.neu.edu>
 <20100506083113.GA25993@progeny.tock>
 <20100506084607.GA9921@atjola.homenet>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Eli Barzilay <eli@barzilay.org>, git <git@vger.kernel.org>
To: =?iso-8859-1?Q?Bj=F6rn?= Steinbrink <B.Steinbrink@gmx.de>
X-From: git-owner@vger.kernel.org Thu May 06 11:01:08 2010
connect(): No such file or directory
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1O9wx9-0000bL-6L
	for gcvg-git-2@lo.gmane.org; Thu, 06 May 2010 11:01:07 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755618Ab0EFJBA convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 6 May 2010 05:01:00 -0400
Received: from mail-iw0-f197.google.com ([209.85.223.197]:35622 "EHLO
	mail-iw0-f197.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753958Ab0EFJA7 (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 6 May 2010 05:00:59 -0400
Received: by iwn35 with SMTP id 35so7609292iwn.21
        for <git@vger.kernel.org>; Thu, 06 May 2010 02:00:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:date:from:to:cc:subject
         :message-id:references:mime-version:content-type:content-disposition
         :content-transfer-encoding:in-reply-to:user-agent;
        bh=ubzJ729PhZ+VFHJN7L6Zf5z7yDzSiFPWPdAr+xw3stk=;
        b=gxhTo/AdQZcjLKGqT0ix4eBS/K1a1TfFwqQOrsRulcGjjOQB9EebPkbQegJSB4q1U4
         neCJGoSYgJEANnnirtCCrb2dvKE+r7IMTfYs3b4gxNcWm2Me8wg2mweNVw5AMLDQX/dm
         fxEjldempzYOu2yQZm44BTxqaDLnaC6wy09sc=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        b=NqgNPCsm3sDVYEzPlC6prZ807rErB7AbI8U1HEs5NOYMziI5OPyanfdnUlbWX08kzA
         DWycm5V9WdLRwEnUvVrRI5LgwgSxzFyNwOLW2wwqTRjq40CQHcGPnqs1sgdAmbTcJBUb
         BadkixxXKcNADVcC5cxPAY+8/kjhqJbFVmkG4=
Received: by 10.231.160.195 with SMTP id o3mr1362878ibx.32.1273136459117;
        Thu, 06 May 2010 02:00:59 -0700 (PDT)
Received: from progeny.tock (c-98-212-3-231.hsd1.il.comcast.net [98.212.3.231])
        by mx.google.com with ESMTPS id 21sm634558iwn.7.2010.05.06.02.00.57
        (version=SSLv3 cipher=RC4-MD5);
        Thu, 06 May 2010 02:00:57 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <20100506084607.GA9921@atjola.homenet>
User-Agent: Mutt/1.5.20 (2009-06-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/146463>

Bj=C3=B6rn Steinbrink wrote:
> On 2010.05.06 03:31:13 -0500, Jonathan Nieder wrote:

>> git show -- some-file
>
> That's the same as "git show HEAD -- some-file" though, which shows a
> commit with path-limited diff output.

Thanks for catching the thinko.

> While ":some-file" (most likely)
> identifies a blob, so "git show :some-file" shows the contents stored=
 in
> that blob.

I suggest reviving Dscho=E2=80=99s :./ syntax[1].

Cheers,
Jonathan

[1] http://thread.gmane.org/gmane.comp.version-control.git/68786/focus=3D=
68905
