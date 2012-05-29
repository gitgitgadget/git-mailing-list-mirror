From: Dennis Kaarsemaker <dennis@kaarsemaker.net>
Subject: Re: "docs: stop using asciidoc no-inline-literal" breaks asciidoc
 8.2.5
Date: Wed, 30 May 2012 00:05:00 +0200
Message-ID: <1338329100.2621.3.camel@localhost>
References: <CACBZZX7Y-NTzRP1KYy=eEHTsLHTrzxGms61anXSHVbyCSPgurw@mail.gmail.com>
	 <87ehq3mbxg.fsf@thomas.inf.ethz.ch>
	 <CACBZZX5iOB5PCZUCX5ksR4hpw+DTLTaP4jOnyHAJ8hZVe9xo5w@mail.gmail.com>
	 <20120529215613.GB17598@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: =?ISO-8859-1?Q?=C6var_Arnfj=F6r=F0?= Bjarmason <avarab@gmail.com>,
	Thomas Rast <trast@inf.ethz.ch>,
	Junio C Hamano <gitster@pobox.com>,
	Thomas Rast <trast@student.ethz.ch>,
	Carlos =?ISO-8859-1?Q?Mart=EDn?= Nieto <cmn@elego.de>,
	Matthieu Moy <Matthieu.Moy@imag.fr>, git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Wed May 30 00:05:13 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SZUXQ-0002js-EW
	for gcvg-git-2@plane.gmane.org; Wed, 30 May 2012 00:05:12 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753928Ab2E2WFG convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 29 May 2012 18:05:06 -0400
Received: from mail-ee0-f46.google.com ([74.125.83.46]:62112 "EHLO
	mail-ee0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752511Ab2E2WFF (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 29 May 2012 18:05:05 -0400
Received: by eeit10 with SMTP id t10so1297390eei.19
        for <git@vger.kernel.org>; Tue, 29 May 2012 15:05:03 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=message-id:subject:from:to:cc:date:in-reply-to:references
         :organization:content-type:x-mailer:content-transfer-encoding
         :mime-version:x-gm-message-state;
        bh=j8gYwO+dhwWI08GUvQwO06phMLLMrQAAvHFasUdBJhc=;
        b=TTf/asW23PWIsSTpXTe6HHBkS3TR7rRrSez1z8pVwQBUXbWDDzhk9NcDiJe4Q3TJIs
         vleYTRCZlXRBJ4MwwmvMTLxxykY7FfF6XRx8q0VNBOxn7bJ35DTl/FtaijQPokW9SMi7
         1ZCxMJB9d1r6kSXAWgAZcO8voyXUKM28ygjHhqD13as7p2IdQ26+dOWw1xcjuho5Hq7e
         XzBAghYAEgfdgVERDr7zlVKkFw5UmD30KPSHvVmPd21EvHKeRaGto/z2ziJAJ7pfpHTt
         GLNPwPspzF/KMY4I5Y5uqAROeKfiXP3QsNCh+6+570ei4tEFCZoPCaAV0DPlPGZQCKim
         d8Yw==
Received: by 10.14.119.196 with SMTP id n44mr5358941eeh.29.1338329103460;
        Tue, 29 May 2012 15:05:03 -0700 (PDT)
Received: from [10.42.1.4] (82-168-107-74.ip.telfort.nl. [82.168.107.74])
        by mx.google.com with ESMTPS id c51sm53446628eei.12.2012.05.29.15.05.01
        (version=SSLv3 cipher=OTHER);
        Tue, 29 May 2012 15:05:02 -0700 (PDT)
In-Reply-To: <20120529215613.GB17598@sigill.intra.peff.net>
X-Mailer: Evolution 3.2.3-0ubuntu6
X-Gm-Message-State: ALoCoQmrk5hsztSILEyrdgJ6BWqGCXV4M63jo+N5dApXSIUhWG2zDEDwoZGE49PZlbA2yPQWNRRU
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/198770>

On di, 2012-05-29 at 17:56 -0400, Jeff King wrote:
>=20
> From my searches, there is no stock version in RHEL5 or CentOS 5. The=
y
> did not start shipping asciidoc until RHEL6, which includes 8.4.5. It=
's
> very easy to find 3rd-party RPMs for asciidoc, which is presumably wh=
y
> you have multiple versions. And these days it's easy to find 8.4.5
> packaged for el5.=20

epel (pretty much the default 2=C2=BDth party repo, maintained by the f=
edora
people) ships asciidoc for rhel5/centos5, but not anything newer than
8.1.x=20

--=20
Dennis K.

Life is what happens to you while you're busy making other plans=20
  - John Lennon
