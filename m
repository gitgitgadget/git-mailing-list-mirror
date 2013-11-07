From: Ramkumar Ramachandra <artagnon@gmail.com>
Subject: Re: [PATCH 1/3] for-each-ref: introduce %C(...) for color
Date: Thu, 7 Nov 2013 14:36:13 +0800
Message-ID: <CALkWK0k0wxoK-MZk-KXiUiUgxVBKQGROFJBZbRs2LjNLA9iopA@mail.gmail.com>
References: <1383212774-5232-1-git-send-email-artagnon@gmail.com>
 <1383212774-5232-2-git-send-email-artagnon@gmail.com> <xmqq38nh411p.fsf@gitster.dls.corp.google.com>
 <CALkWK0nEMpVUkzafjDkVV-uaLTYzHYUTsZkmwRPkLFa=8NEkPA@mail.gmail.com>
 <xmqqli182mde.fsf@gitster.dls.corp.google.com> <CALkWK0k-8noAJbgzPx3NEx-ucUdZoS4VmqNCKjm3R_5eqFnR7w@mail.gmail.com>
 <xmqqzjpkyqtf.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Git List <git@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Nov 07 07:37:48 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VeJDV-0004jw-6h
	for gcvg-git-2@plane.gmane.org; Thu, 07 Nov 2013 07:37:21 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756145Ab3KGGg6 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 7 Nov 2013 01:36:58 -0500
Received: from mail-ie0-f175.google.com ([209.85.223.175]:54067 "EHLO
	mail-ie0-f175.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756129Ab3KGGg4 (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 7 Nov 2013 01:36:56 -0500
Received: by mail-ie0-f175.google.com with SMTP id aq17so163338iec.34
        for <git@vger.kernel.org>; Wed, 06 Nov 2013 22:36:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        bh=VfAZ2UiwGvJym8l7MfCZVNBLC7KDcNUgOgEtbgfD2Dg=;
        b=duy2YNshp/xZUOJvoKsFtXKwy27+olTLYlCTMAGgSsYTyaCp0GSjDTdVGNS0Epv8qy
         igL9aTmy9+ydzg0XIfdTGRqAH3LHgFLNId2kn3g9ybi8MSNKTajmVv7Y3U81bBDmgIlf
         kie0MwLto9qrgud3VbLBIHUg4Mt8D5Rr0gOSbEo0xsd+NYpJoEwI81W0HKWOJZU490qG
         OqNQ6NvMf2x4G7wN/wJKfdAcaBYEAXdmmRhkTvxhT+RblDk6uTFHdu432jyI5BXDUvfs
         78HqpjeJjYPEi5nfWbZYktVB15UNXJw8evJsAu7Rr9EUnhI4q/3DTYxk1VtTLqkP6R/B
         fjfw==
X-Received: by 10.42.250.148 with SMTP id mo20mr4398714icb.34.1383806214846;
 Wed, 06 Nov 2013 22:36:54 -0800 (PST)
Received: by 10.64.73.36 with HTTP; Wed, 6 Nov 2013 22:36:13 -0800 (PST)
In-Reply-To: <xmqqzjpkyqtf.fsf@gitster.dls.corp.google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/237391>

Junio C Hamano wrote:
> ... users of for-each-ref format will be _more_ familiar with
> formats used by for-each-ref, and it would make a lot more sense to
> keep the syntactic resemblance between existing features to show
> magic things in for-each-ref and the new feature to show color
> (which is merely one new "magic" to the vocabulary in the context of
> for-each-ref), no?

Okay, so what do you suggest in place of %C(...)?
