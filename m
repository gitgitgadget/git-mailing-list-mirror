From: "Carlos R. Mafra" <crmafra2@gmail.com>
Subject: Re: Performance issue of 'git branch'
Date: Thu, 23 Jul 2009 04:25:33 +0200
Message-ID: <20090723022533.GB8948@Pilar.aei.mpg.de>
References: <20090722235914.GA13150@Pilar.aei.mpg.de> <20090723002323.GA23021@saturnine>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: SZEDER =?utf-8?B?R8OhYm9y?= <szeder@ira.uka.de>
X-From: git-owner@vger.kernel.org Thu Jul 23 04:27:17 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MTo1c-0007f2-EQ
	for gcvg-git-2@gmane.org; Thu, 23 Jul 2009 04:27:16 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752745AbZGWC0x convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 22 Jul 2009 22:26:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751322AbZGWC0w
	(ORCPT <rfc822;git-outgoing>); Wed, 22 Jul 2009 22:26:52 -0400
Received: from fg-out-1718.google.com ([72.14.220.156]:30686 "EHLO
	fg-out-1718.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752635AbZGWC0w (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 22 Jul 2009 22:26:52 -0400
Received: by fg-out-1718.google.com with SMTP id e21so174053fga.17
        for <git@vger.kernel.org>; Wed, 22 Jul 2009 19:26:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:date:from:to:cc:subject
         :message-id:references:mime-version:content-type:content-disposition
         :content-transfer-encoding:in-reply-to:user-agent;
        bh=Js25zTHffpGvbMwKb8jdvjNKqCb5gFluyA7aoFFFLL8=;
        b=PY6vnarXIloSzcRCGbHyo/tAti2OnveDtsbDlYo7JPjjDl06fA4rGbefNf/SGpF+zC
         gaypeKm+SfL7q9wdppDhA/y2fBWHWErpmy3+YDFHcBmkSUQtym1/BU7pgcUp3Ws1iFvD
         ml1EhxYL3qOEsgXVih5bZrWtgiwTI/ufPbNwI=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        b=okP75sZEzAaGcQJ1dSeOWnpx+Cp1E+qqGThI8rtI42a8Vrm2rJBm+lQar9MBYB8VOJ
         hn87gbyUm2if+xs7hSTIWqxc/ryioBzBxKf3hzkq4MDhP+X49oOL1q3taKJ+6V8Rby2x
         nBAq7/bcA6vKXgcBVecC8TR2hwXZV53CJ5EVQ=
Received: by 10.86.81.16 with SMTP id e16mr1259044fgb.78.1248316011423;
        Wed, 22 Jul 2009 19:26:51 -0700 (PDT)
Received: from Pilar.aei.mpg.de ([82.113.121.18])
        by mx.google.com with ESMTPS id 4sm2527320fgg.2.2009.07.22.19.26.47
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Wed, 22 Jul 2009 19:26:50 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <20090723002323.GA23021@saturnine>
User-Agent: Mutt/1.5.18 (2008-05-17)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/123823>

Hi,

On Wed 22.Jul'09 at 19:23:23 -0500, SZEDER G=C3=A1bor wrote:
> > So I would like to ask what should I do to recover the missing file=
s
> > in .git/refs/heads/ (which apparently is the cause for my issue) an=
d
> > how I can avoid losing them in the first place.
>=20
> have a look at .git/packed-refs and 'git pack-refs'.

Yes, now I learned that the files were not really missing
as in "there is something wrong".

I will also start to use 'git pack-refs --prune' from time to time
now, in adition to 'git gc --prune' and 'git repack -d -a'.

But the takes-too-long 'git branch' issue is apparently caused
by something else.

Thanks G=C3=A1bor,
Carlos
