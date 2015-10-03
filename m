From: David Turner <dturner@twopensource.com>
Subject: Re: [PATCH v2 01/43] refs.c: create a public version of
 verify_refname_available
Date: Sat, 03 Oct 2015 12:50:00 -0400
Organization: Twitter
Message-ID: <1443891000.7753.4.camel@twopensource.com>
References: <1443477738-32023-1-git-send-email-dturner@twopensource.com>
	 <1443477738-32023-2-git-send-email-dturner@twopensource.com>
	 <560F6172.3040404@web.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org, mhagger@alum.mit.edu,
	Ronnie Sahlberg <sahlberg@google.com>
To: Torsten =?ISO-8859-1?Q?B=F6gershausen?= <tboegi@web.de>
X-From: git-owner@vger.kernel.org Sat Oct 03 18:50:42 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZiQ1B-00009f-1w
	for gcvg-git-2@plane.gmane.org; Sat, 03 Oct 2015 18:50:41 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750764AbbJCQuF convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sat, 3 Oct 2015 12:50:05 -0400
Received: from mail-qg0-f54.google.com ([209.85.192.54]:36473 "EHLO
	mail-qg0-f54.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750733AbbJCQuE (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 3 Oct 2015 12:50:04 -0400
Received: by qgx61 with SMTP id 61so119018086qgx.3
        for <git@vger.kernel.org>; Sat, 03 Oct 2015 09:50:02 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:message-id:subject:from:to:cc:date:in-reply-to
         :references:organization:content-type:mime-version
         :content-transfer-encoding;
        bh=fke/O5Z87xMqKIsEG8TUXz0O478Wur20KsKn2ZYA4B4=;
        b=m0aU77yY48rpTDe6fsxxeMmZphkqph5M/u9avnCLZvT7wwbpVUDIt2m1cP3hjLr6ED
         gQYhFlbZGO12+zcLsmoJpWJIVThCqsaCxHUCRHVHUebmBUyxPfOIIbGhkKW5NRTawOVc
         yVcRSW2LM/ZShMga/ioSD3N6a9UXW14bmCWCbLZQcqlPRDDDX18V15Olc88dJgzEcu90
         GtMS88/BC4sG6oOOgjpfhA35wAh6GioxMKKarF7960834P8y6N+HUPDu3+QyzFT4rz7+
         /mWcbLUQEWthEINfLSQlakhvN9NssHZoaULn6ebbVAzi4X2hXog/7YfPliTUtnXaf1qv
         HjFA==
X-Gm-Message-State: ALoCoQnjOrftS2nJprU4ARrquhPl9hbVLsDa5UwVZqVitRHqnvw0m8fpaXoKLPtlVmAfLEO+ac4R
X-Received: by 10.140.99.117 with SMTP id p108mr27734973qge.91.1443891002518;
        Sat, 03 Oct 2015 09:50:02 -0700 (PDT)
Received: from ubuntu (207-38-164-98.c3-0.43d-ubr2.qens-43d.ny.cable.rcn.com. [207.38.164.98])
        by smtp.gmail.com with ESMTPSA id h89sm7174326qgh.33.2015.10.03.09.50.01
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 03 Oct 2015 09:50:01 -0700 (PDT)
In-Reply-To: <560F6172.3040404@web.de>
X-Mailer: Evolution 3.12.11-0ubuntu3 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/278974>

On Sat, 2015-10-03 at 07:02 +0200, Torsten B=C3=B6gershausen wrote:
> On 29.09.15 00:01, David Turner wrote:
> >
> (Not sure if this is the right thread to report on)
>=20
> In file included from builtin/commit.c:20:
> ./refs.h:695:16: warning: redefinition of typedef 'ref_transaction_fr=
ee_fn' is a C11 feature
>       [-Wtypedef-redefinition]
> typedef void (*ref_transaction_free_fn)(struct ref_transaction *trans=
action);
>                ^


=46ixed, thanks.

What compiler flag did you turn on to see that warning?
