From: =?ISO-8859-1?Q?Ville_Skytt=E4?= <ville.skytta@iki.fi>
Subject: Re: [PATCH 2/2] completion: split __git_ps1 into a separate script
Date: Fri, 25 May 2012 20:51:37 +0300
Message-ID: <4FBFC6A9.1050209@iki.fi>
References: <1337719600-7361-1-git-send-email-felipe.contreras@gmail.com> <1337719600-7361-3-git-send-email-felipe.contreras@gmail.com> <20120524204726.GB2052@goldbirke>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Felipe Contreras <felipe.contreras@gmail.com>, git@vger.kernel.org,
	Junio C Hamano <gitster@pobox.com>,
	Ted Pavlic <ted@tedpavlic.com>,
	Thomas Rast <trast@student.ethz.ch>,
	Kerrick Staley <mail@kerrickstaley.com>,
	Marius Storm-Olsen <mstormo@gmail.com>,
	Dan McGee <dan@archlinux.org>
To: =?ISO-8859-1?Q?SZEDER_G=E1bor?= <szeder@ira.uka.de>
X-From: git-owner@vger.kernel.org Fri May 25 19:51:53 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SXyfz-0002NZ-LK
	for gcvg-git-2@plane.gmane.org; Fri, 25 May 2012 19:51:48 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757698Ab2EYRvn convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 25 May 2012 13:51:43 -0400
Received: from mail-lpp01m010-f46.google.com ([209.85.215.46]:65083 "EHLO
	mail-lpp01m010-f46.google.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1754380Ab2EYRvn (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 25 May 2012 13:51:43 -0400
Received: by lahd3 with SMTP id d3so825974lah.19
        for <git@vger.kernel.org>; Fri, 25 May 2012 10:51:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=sender:message-id:date:from:user-agent:mime-version:to:cc:subject
         :references:in-reply-to:x-enigmail-version:content-type
         :content-transfer-encoding;
        bh=RDH4HjD4mj8ZcnfG92cRNypglRm2KfvBVO9YzbrrIx0=;
        b=Q5wbgBWrkNqoLU20/wouiuQZE6hgbIhfV9WCser5cSCU3cJx12v37el9jChSbpR5+0
         oiO4hmw8wSzEqCDtJ/rRK74U4A9dOx+V/fhLnce7Abtd8HitrJSXEDuJCMPxKmuTD3Ui
         u6p1NRYLCTYT0K799WLugOuKubI8c9QhjJBXnreZSFs/K5+kNkH5XwL/akEV7qZ4rrbR
         LyxRw8qFtR2C/2BiFQIxomEqSntShKZrmuebINDQvOjO4OWePJXXcXCkR1eBjKLu5Qg1
         i+rctiDiHm2cTu/0zfFhnXRc5aqglUC5O4DBYA7NgkKrN+QqSem/ueluQEgZVw4c5I3P
         ZzJA==
Received: by 10.152.104.44 with SMTP id gb12mr4429943lab.29.1337968301631;
        Fri, 25 May 2012 10:51:41 -0700 (PDT)
Received: from michael.steam.fi (cs78200229.pp.htv.fi. [62.78.200.229])
        by mx.google.com with ESMTPS id gi19sm4856287lab.16.2012.05.25.10.51.38
        (version=SSLv3 cipher=OTHER);
        Fri, 25 May 2012 10:51:39 -0700 (PDT)
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:12.0) Gecko/20120430 Thunderbird/12.0.1
In-Reply-To: <20120524204726.GB2052@goldbirke>
X-Enigmail-Version: 1.4.1
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/198495>

On 2012-05-24 23:47, SZEDER G=E1bor wrote:
>=20
> On Tue, May 22, 2012 at 10:46:40PM +0200, Felipe Contreras wrote:
>> bash-completion 1.90 shipped=20
>=20
> That's still beta, right?  (or the bash-completion website is out of
> date...)

1.99 has been out since January, and the website has also mentioned it
since then.  1.99 is a beta or a release candidate if you prefer, but
personally I believe it's very close to 2.0 at least in terms of things
being discussed in this thread.
