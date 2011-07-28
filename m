From: Ramkumar Ramachandra <artagnon@gmail.com>
Subject: Re: [PATCH 16/18] revert: Remove sequencer state when no commits are pending
Date: Thu, 28 Jul 2011 21:46:50 +0530
Message-ID: <CALkWK0mUGiCRQoW6UM+mF5tsn4DxRuaiXn0TS2CcEsR0OeusKg@mail.gmail.com>
References: <1311736755-24205-1-git-send-email-artagnon@gmail.com>
 <1311736755-24205-17-git-send-email-artagnon@gmail.com> <20110727051755.GK18470@elie>
 <CALkWK0noPtLgr_t=DC_XFdLrWUNCLhUd00Mw1HbmWRJjeT4jew@mail.gmail.com>
 <20110727141006.GA24785@elie> <CALkWK0k8Lra7LkGJXoXScnGUjrag-xgNptaB_JCiAsgemTq0eQ@mail.gmail.com>
 <20110727154830.GA29924@elie>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Git List <git@vger.kernel.org>, Junio C Hamano <gitster@pobox.com>,
	Christian Couder <chriscool@tuxfamily.org>,
	Daniel Barkalow <barkalow@iabervon.org>,
	Jeff King <peff@peff.net>
To: Jonathan Nieder <jrnieder@gmail.com>
X-From: git-owner@vger.kernel.org Thu Jul 28 18:17:20 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QmTGv-00071t-E4
	for gcvg-git-2@lo.gmane.org; Thu, 28 Jul 2011 18:17:17 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754965Ab1G1QRN (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 28 Jul 2011 12:17:13 -0400
Received: from mail-ww0-f44.google.com ([74.125.82.44]:41073 "EHLO
	mail-ww0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754147Ab1G1QRL (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 28 Jul 2011 12:17:11 -0400
Received: by wwe5 with SMTP id 5so2660896wwe.1
        for <git@vger.kernel.org>; Thu, 28 Jul 2011 09:17:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        bh=8vmIZYw9kxTySyFr3VhF3p92i15sFLX1XseFs/kh6ss=;
        b=Vp+Tt2D1onI8mIbqSL5UaoH0pa3CnMa1datwEFfEO/SoZNqQgbyQ22yV3fdQeD7VSB
         zKlIZaqZD6iEI8Ejf7bIFXlRfYC3vdS9GBMtAWPZoXyVaYwowJiOBSbNaOcT+fl8zTdP
         lEByIgZ1+3x70o/yfA7TbRGx0c9sczTgItjOM=
Received: by 10.227.152.146 with SMTP id g18mr219819wbw.79.1311869830404; Thu,
 28 Jul 2011 09:17:10 -0700 (PDT)
Received: by 10.216.137.134 with HTTP; Thu, 28 Jul 2011 09:16:50 -0700 (PDT)
In-Reply-To: <20110727154830.GA29924@elie>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/178075>

Hi again,

Jonathan Nieder writes:
> If "tight coupling" means "builtin/commit.c calls a function declared
> in sequencer.h", then yes, I think it should be fine.

My bad. I'll first have to figure out a way to expose the todo parsing
functions (and dependent functions) without touching much else.
This'll be a huge non-trivial patch, and my post midterm work has to
include this anyway.  So I think it's better to leave it as-it-is for
now, and work on this coupling after this series is merged.

-- Ram
