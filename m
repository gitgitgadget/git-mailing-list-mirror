From: Junio C Hamano <gitster@pobox.com>
Subject: Re: Get a git diff without taking index into account
Date: Wed, 18 Feb 2015 14:16:52 -0800
Message-ID: <CAPc5daUw8F6fFZk0+-_9Z5nxPG4D56P88yFz=BSfK+xYxLhBxg@mail.gmail.com>
References: <CAAoZyYN-ohiq-Od=u-cd5FRH8=NpJNGS+zEo+NYgwAK7Kjaz_w@mail.gmail.com>
 <CAAoZyYPhiKX1F5ymdSijR7=e8CT1sqaomehBjt-NVDz_A4V4UA@mail.gmail.com>
 <CAPc5daU9km+gr-DHJzJF59mugwGeNX69H27E_DaoyBZnuzoiFw@mail.gmail.com>
 <CAAoZyYPVopmP_bv7EZS912R4bxpzNm49_q0XXZXqa52dTDDM2Q@mail.gmail.com>
 <xmqqfva341sf.fsf@gitster.dls.corp.google.com> <CAAoZyYOst-5cD7qtV=T3Oahja1JN1ZmeyAcELrn7xD0bMc7Mrg@mail.gmail.com>
 <20150218183251.GB6346@peff.net> <CAAoZyYOT_OQZ+rrwFvnsVBV_sYRA4Oti3vRNnE6_RaV9w8qxdg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Jeff King <peff@peff.net>, Git Mailing List <git@vger.kernel.org>
To: Eric Frederich <eric.frederich@gmail.com>
X-From: git-owner@vger.kernel.org Wed Feb 18 23:17:22 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YOCvm-0007yL-G2
	for gcvg-git-2@plane.gmane.org; Wed, 18 Feb 2015 23:17:18 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752610AbbBRWRO (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 18 Feb 2015 17:17:14 -0500
Received: from mail-ob0-f173.google.com ([209.85.214.173]:40045 "EHLO
	mail-ob0-f173.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751728AbbBRWRN (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 18 Feb 2015 17:17:13 -0500
Received: by mail-ob0-f173.google.com with SMTP id uy5so7862337obc.4
        for <git@vger.kernel.org>; Wed, 18 Feb 2015 14:17:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:sender:in-reply-to:references:from:date:message-id
         :subject:to:cc:content-type;
        bh=3z0VD7SQQSZIWj0gPyZwU7+NyiGWOFjB0ewOupRExh4=;
        b=0EuGMLZnirZuXdkQ/p6b4e0vjz8npLd2NLs9zqintqxi4zII0laQH3Q0KpT2U92nSQ
         rAcnDDVRxWyF31VPDQ0X6HNw6w3FuetdmqFjVIDLrLTi/rRVDIaFqq/BfUNvQMlFAqlZ
         TpJJjMc2FTUgl6I//LMdG53v10dUpSryRLvXXUsC6G+cn5hr0Ppx4zj30GJNkkpJ61eJ
         3aStdvz2rEcrEm4dxzGNFC+XdhCyefRTrPjhi+XSpKf9dqfD+3lSrJ062BiaUICAScKV
         xSiPXAXmfhs98LwvtZD9MbHCXtAUGwF/iBe2DozsCVz/H4RWsoLZD3pkBRiEAvT0kag4
         HdyA==
X-Received: by 10.182.149.164 with SMTP id ub4mr981098obb.1.1424297832896;
 Wed, 18 Feb 2015 14:17:12 -0800 (PST)
Received: by 10.202.48.132 with HTTP; Wed, 18 Feb 2015 14:16:52 -0800 (PST)
In-Reply-To: <CAAoZyYOT_OQZ+rrwFvnsVBV_sYRA4Oti3vRNnE6_RaV9w8qxdg@mail.gmail.com>
X-Google-Sender-Auth: SZtOpLUosLxfcuJr4bcDLqjG1Nc
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/264067>

On Wed, Feb 18, 2015 at 1:38 PM, Eric Frederich
<eric.frederich@gmail.com> wrote:
> Could you elaborate on "you can just refresh the index before each diff"
> What command would I use to do this?

"update-index --refresh", perhaps?

> Also, how would I go about detecting untracked files the way status does?

"ls-files"?
