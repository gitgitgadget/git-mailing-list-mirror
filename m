From: David Turner <dturner@twopensource.com>
Subject: Re: [PATCH/RFC 0/2] bisect per-worktree
Date: Sat, 01 Aug 2015 01:43:17 -0400
Organization: Twitter
Message-ID: <1438407797.4735.30.camel@twopensource.com>
References: <CAP8UFD0aCSW3JxneHvSEE3T6zQtgipp5nhWT9VpMqHAmzd_e3Q@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Michael Haggerty <mhagger@alum.mit.edu>,
	Christian Couder <chriscool@tuxfamily.org>,
	git <git@vger.kernel.org>,
	Nguyen Thai Ngoc Duy <pclouds@gmail.com>
To: Christian Couder <christian.couder@gmail.com>
X-From: git-owner@vger.kernel.org Sat Aug 01 07:43:39 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZLPa5-0003H6-M3
	for gcvg-git-2@plane.gmane.org; Sat, 01 Aug 2015 07:43:38 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751029AbbHAFnU convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sat, 1 Aug 2015 01:43:20 -0400
Received: from mail-qg0-f54.google.com ([209.85.192.54]:34617 "EHLO
	mail-qg0-f54.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751010AbbHAFnU (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 1 Aug 2015 01:43:20 -0400
Received: by qgeu79 with SMTP id u79so59694428qge.1
        for <git@vger.kernel.org>; Fri, 31 Jul 2015 22:43:19 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:message-id:subject:from:to:cc:date:in-reply-to
         :references:organization:content-type:mime-version
         :content-transfer-encoding;
        bh=hl28wD7fN/hpUTT+vz1HDau0FLqwSylU3W0yCU8Ep+0=;
        b=WzMI7gJbMmQjP1tWaXXDCAwrJ+3BJqJM/El8bkzCBsvGZc4VU0d1gsDEH8wc1Ajx6k
         Pde/A+6R/5tUPq5wFjN94XlR/jTipOGKax3L7krx3Cmg0cl4pwHw3z15vf2pkPXHBT+5
         J6R+YS9PJX1Ysi+Y9b2ax7gMHgSnCGTpzMsblQJToK2Do9gwPPLoUMIFMsSNOeVxnW40
         PbpGy6TJYinFBTCgwtvQazXOv6zBh/qenVfQLCOY3O3ZmVDW7H7Cm2t0vfKW30L31+Rg
         eprhZwxjcVnxn4t4+9XSJzayTIuK8m+vbI43Lcb3LijzRPM42N6FRIJ7NMPQuYYt3L/f
         fXSA==
X-Gm-Message-State: ALoCoQmH1jloRbMHCAqY5S3AigIWDphgZ9H0J8k4dglwCA5s29kmMzagnnbO1kEk3cYT8idBV77q
X-Received: by 10.141.28.200 with SMTP id f191mr11266651qhe.52.1438407799029;
        Fri, 31 Jul 2015 22:43:19 -0700 (PDT)
Received: from ubuntu (207-38-164-98.c3-0.43d-ubr2.qens-43d.ny.cable.rcn.com. [207.38.164.98])
        by smtp.gmail.com with ESMTPSA id c89sm3389554qga.36.2015.07.31.22.43.17
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 31 Jul 2015 22:43:18 -0700 (PDT)
In-Reply-To: <CAP8UFD0aCSW3JxneHvSEE3T6zQtgipp5nhWT9VpMqHAmzd_e3Q@mail.gmail.com>
X-Mailer: Evolution 3.12.11-0ubuntu3 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/275106>

On Sat, 2015-08-01 at 06:04 +0200, Christian Couder wrote:
>=20
> Le 1 ao=C3=BBt 2015 09:01, "David Turner" <dturner@twopensource.com> =
a
> =C3=A9crit :
> >
> > This is RFC because I'm not sure why show-ref only works on refs/
> (and
> > whether it should learn to look in worktree-refs/).  I'm also not
> sure
> > whether there are other changes I should make to refs.c to handle
> > per-worktree refs; I basically did the simplest thing I could think
> of
> > to start with.
>=20
> (Sorry, I am answering from my phone, as I am having a vacation. )

Enjoy your vacation.

> I wonder what would happen if people upgrade in the middle of a
> bisection or if they have scripts using "bisect/bad" for example.

Junio told me not to worry about this, so I didn't. =20
