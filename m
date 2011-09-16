From: Sverre Rabbelier <srabbelier@gmail.com>
Subject: Re: [PATCH] ls-remote: a lone "-h" is asking for help
Date: Fri, 16 Sep 2011 22:34:24 +0200
Message-ID: <CAGdFq_jc4YDaD+NL6_+buCrOt2yAK+-_MDOJQU5qnS13P65CzQ@mail.gmail.com>
References: <7vobykfj7g.fsf@alter.siamese.dyndns.org> <CAGdFq_h474OrLzP+CHj_eSdSp53n8x7jz1ORT16dOhvRdQMP+g@mail.gmail.com>
 <7vehzgfffw.fsf@alter.siamese.dyndns.org> <CAGdFq_hug3zNwvDZ3c8iG-F8jJSuxsuFghMWtWTmUTdfTrWiqg@mail.gmail.com>
 <7v1uvgfcur.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri Sep 16 22:35:14 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1R4f7w-0003jg-Qo
	for gcvg-git-2@lo.gmane.org; Fri, 16 Sep 2011 22:35:13 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755284Ab1IPUfH (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 16 Sep 2011 16:35:07 -0400
Received: from mail-gw0-f42.google.com ([74.125.83.42]:45716 "EHLO
	mail-gw0-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755256Ab1IPUfG (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 16 Sep 2011 16:35:06 -0400
Received: by gwb17 with SMTP id 17so4928116gwb.1
        for <git@vger.kernel.org>; Fri, 16 Sep 2011 13:35:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        bh=gpARS+TywcYMor9K13w0FRyJYZV3i+zFTCS4Roo4N2s=;
        b=tvKRSXXsaxjmqz41lCf5vMg335OxqxjAut3ARjBsZN1tdECb/r+dD/3mU0OuM9GDl6
         bUxhUDJxRntdcipdGZepmJpC/nZhftNaC+eu5iRNmgYWfjZEQw+m0X4Oyk/WDetU57k5
         2+CE6vFpBsqPaEULQJpailkn1gtoQIwpowsE0=
Received: by 10.68.23.97 with SMTP id l1mr3315612pbf.232.1316205304088; Fri,
 16 Sep 2011 13:35:04 -0700 (PDT)
Received: by 10.68.59.39 with HTTP; Fri, 16 Sep 2011 13:34:24 -0700 (PDT)
In-Reply-To: <7v1uvgfcur.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/181552>

Heya,

On Fri, Sep 16, 2011 at 22:31, Junio C Hamano <gitster@pobox.com> wrote:
> I am not opposed to. We should do the usual "start from warning and then
> deprecate" dance, but I do not think we would want to have a "I want the
> old behaviour, please keep it" configuration, especially if we are talking
> about a big version bump like 2.0.
>
> The first step would look something like this, on top of the previous
> patch.

Makes sense.

I remember some sort of "this is for post 1.7.x" section in what's
cooking at some point. Should we have some way to queue patches like
this, or would someone have to resend after the appropriate release?

-- 
Cheers,

Sverre Rabbelier
