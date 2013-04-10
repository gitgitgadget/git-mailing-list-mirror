From: Ramkumar Ramachandra <artagnon@gmail.com>
Subject: Re: [PATCH 2/2] add: refuse to add paths beyond repository boundaries
Date: Wed, 10 Apr 2013 18:55:44 +0530
Message-ID: <CALkWK0k9nLhr_JTDvJq=7YXX8DoqXy850zC__Ux1kJxkY0BJhA@mail.gmail.com>
References: <CALkWK0m_82ThYKxcr=YHGBnOaHr9yBpYFHxx2KrnQkWD_zjp1A@mail.gmail.com>
 <1365499297-8667-1-git-send-email-artagnon@gmail.com> <1365499297-8667-3-git-send-email-artagnon@gmail.com>
 <7v4nfftyu3.fsf@alter.siamese.dyndns.org> <7vvc7vsj4p.fsf@alter.siamese.dyndns.org>
 <CALkWK0k0YMWjhJQFWLv6b7kAHqRm8-Dq23gMVHYfatq1SLUDhQ@mail.gmail.com>
 <7vmwt7si6z.fsf@alter.siamese.dyndns.org> <CALkWK0nF0aTLDZyPXfa=4kp=BnDPm3+_ZfMvP_6ZcimeJtzxvw@mail.gmail.com>
 <7vzjx7phti.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Jeff King <peff@peff.net>, Duy Nguyen <pclouds@gmail.com>,
	Git List <git@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Apr 10 15:26:31 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UPv2j-0004S6-Qj
	for gcvg-git-2@plane.gmane.org; Wed, 10 Apr 2013 15:26:30 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752415Ab3DJN0Z (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 10 Apr 2013 09:26:25 -0400
Received: from mail-ie0-f179.google.com ([209.85.223.179]:61082 "EHLO
	mail-ie0-f179.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752142Ab3DJN0Y (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 10 Apr 2013 09:26:24 -0400
Received: by mail-ie0-f179.google.com with SMTP id k11so492872iea.24
        for <git@vger.kernel.org>; Wed, 10 Apr 2013 06:26:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=x-received:mime-version:in-reply-to:references:from:date:message-id
         :subject:to:cc:content-type;
        bh=igHjC4W8xG6TzOPWYeUSAig7FPSxCdbtIoJnmZYDjkw=;
        b=seOt1JiC0PviT72MiyVGOROmjoXRIco5qtzQEXitMYNTmfWYJqESLNEPYDm6ncUTD0
         6QMzxSpQlZs/DB+Z7k5F4s/ochJqAiaFafTUFZJfVZsWbOx1lkrRI1KMD5NZdjGWmI7u
         6IzrLn8AwiOLJ8wF1hf+Y1Ky06Ao9WrjCcsQfYaW1Q6FEURC56hPmDShWnFDZmWKlrce
         aFbofjjv73N0ZxQtw33VbeEvppVLEaUw/1z3plVpOe7HwEeXGCnDykVewViWyfutPdqB
         iogU8YLabxA53brwrm81GU6HWRBfcbdVg2GFPokMRML9OSSolY7RiSj6nItkWqlY1oVR
         j5ag==
X-Received: by 10.42.50.202 with SMTP id b10mr1297697icg.7.1365600384328; Wed,
 10 Apr 2013 06:26:24 -0700 (PDT)
Received: by 10.64.34.80 with HTTP; Wed, 10 Apr 2013 06:25:44 -0700 (PDT)
In-Reply-To: <7vzjx7phti.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/220688>

Junio C Hamano wrote:
> And I also misread "we currently don't handle" above as "but we
> really should allow adding d/f when d is at the top of the working
> tree of another project", but that was not what you meant to say.
> Instead, "We do not notice such a bad case in today's code yet" was
> what you meant.  But if we are to use "there are cases" in [1/n] and
> start [2/n] with "Now we have renamed, let's do this", then we do
> not have to bother saying anything in [1/n] about the upcoming
> change in [2/n], especially the patches come back-to-back in a
> single series.

Exactly.  Yeah, I don't think you patch makes sense as a standalone
anyway: I'll use appropriate wording when I roll the series, so it
follows nicely.
