From: Karthik Nayak <karthik.188@gmail.com>
Subject: Re: [RFC/PATCH 10/11] branch.c: use 'ref-filter' APIs
Date: Wed, 29 Jul 2015 21:07:43 +0530
Message-ID: <CAOLa=ZR6Cu_AgB4sOBX3Tf_M0w8XN57ej8d_fZo+h7pwFDZs+A@mail.gmail.com>
References: <CAOLa=ZT3_DMJWFN62cbF19uxYBFsE69dGaFR=af1HPKsQ42otg@mail.gmail.com>
 <1438067468-6835-1-git-send-email-Karthik.188@gmail.com> <vpqh9oov017.fsf@anie.imag.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Git <git@vger.kernel.org>,
	Christian Couder <christian.couder@gmail.com>,
	Junio C Hamano <gitster@pobox.com>
To: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
X-From: git-owner@vger.kernel.org Wed Jul 29 17:38:20 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZKTQw-0007CL-UG
	for gcvg-git-2@plane.gmane.org; Wed, 29 Jul 2015 17:38:19 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753443AbbG2PiO (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 29 Jul 2015 11:38:14 -0400
Received: from mail-ob0-f179.google.com ([209.85.214.179]:33113 "EHLO
	mail-ob0-f179.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753076AbbG2PiO (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 29 Jul 2015 11:38:14 -0400
Received: by obdeg2 with SMTP id eg2so10005803obd.0
        for <git@vger.kernel.org>; Wed, 29 Jul 2015 08:38:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        bh=M8Aku3KxIm//UcIW07GRw/z8G04kcXaVqh7efdMOvao=;
        b=qCSpkGIh1g+tiUWy+DMBTH/htgw4lLuUJ9p6Jy491Ga0zBhre3wOj5Xnia9dzgVjkv
         wFoXquzwKfHppf5sMCIBbGTjEocWSlPPnTUpFqrmMuOrFz6a/CQcHvhMUIGuQ95aHWsk
         7ZJKNlFyan9fVNAQ9ntSoW+SE1oCYsHZa6SgkNKsfIYmd4nadjc4GkLYOvxpjBD6zAMf
         hokvCNlieidmZjbIjS+Hr3VKY2exeDezrvZ0Jc+SnvTKHAED3z3Fh7vfPetqsOBLBP5E
         dbo9nCHcoXpi68z/3FepLv2CpIOt9yUB4JXVZbSj8o9bm/7riGApBtBnx/3oGf4KO8z6
         LGaA==
X-Received: by 10.182.33.38 with SMTP id o6mr40291689obi.41.1438184293403;
 Wed, 29 Jul 2015 08:38:13 -0700 (PDT)
Received: by 10.182.26.73 with HTTP; Wed, 29 Jul 2015 08:37:43 -0700 (PDT)
In-Reply-To: <vpqh9oov017.fsf@anie.imag.fr>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/274897>

On Tue, Jul 28, 2015 at 7:47 PM, Matthieu Moy
<Matthieu.Moy@grenoble-inp.fr> wrote:
>
> I'm not sure what's the convention, but I think the test description
> should give the expected behavior even with test_expect_failure.
>
> And please help the reviewers by saying what's the status wrt this test
> (any plan on how to fix it?).
>

On the other hand I wonder if the test is even needed as, we don't
really need it
Cause we remove that ability of branch.c by using filter_refs().

-- 
Regards,
Karthik Nayak
