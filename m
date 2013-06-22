From: Ramkumar Ramachandra <artagnon@gmail.com>
Subject: Re: [PATCH 01/16] t/t5505-remote: modernize subshell-style of one test
Date: Sat, 22 Jun 2013 11:54:17 +0530
Message-ID: <CALkWK0=F1=8HyeJ=v=nUuHBAm0me6rdC0U+KYP4fXmhELV6xhQ@mail.gmail.com>
References: <1371813160-4200-1-git-send-email-artagnon@gmail.com>
 <1371813160-4200-2-git-send-email-artagnon@gmail.com> <7vehbvktmz.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Git List <git@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sat Jun 22 08:25:32 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UqHGL-0003OZ-MR
	for gcvg-git-2@plane.gmane.org; Sat, 22 Jun 2013 08:25:30 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750803Ab3FVGY7 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 22 Jun 2013 02:24:59 -0400
Received: from mail-ie0-f176.google.com ([209.85.223.176]:48618 "EHLO
	mail-ie0-f176.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750768Ab3FVGY6 (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 22 Jun 2013 02:24:58 -0400
Received: by mail-ie0-f176.google.com with SMTP id ar20so21073005iec.21
        for <git@vger.kernel.org>; Fri, 21 Jun 2013 23:24:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        bh=45iyRy5fCMhBAxVC8hflzlyijTBcENgt4ePa1TV+KNQ=;
        b=WFHcVA5ANZE+YCZ+3EfShazhE9PnfaCWvwhrGGvTmse2ex046CMjQnYL8Yr9SgCUSo
         kvptObwsCikGBA4cqVSjngfi4oRqYt82t/Bgj1flRITpgiXo3sXC3eD0jsth/E+i5Onk
         ebQ4Kjsz1wrPXFKGgnhPyUsFlWXC1rnCDCAYlHAQNdO2JiHgaKp69jLoZNi5+UpFXmEZ
         eFGvxEtOfGxjbqlPGqDwea6pli6tKrbKcYvLcJ7DiwcZLPpJYW0QG4/3ZR+orb9ZfAfw
         0awmxXSC4id66aIs5uxmLVWOjXCJec7Q+RDHkSYYfB7VG8BqJKOuQoj8QTKKUFH7Bz3z
         Dt/A==
X-Received: by 10.50.66.130 with SMTP id f2mr735626igt.55.1371882297910; Fri,
 21 Jun 2013 23:24:57 -0700 (PDT)
Received: by 10.64.129.97 with HTTP; Fri, 21 Jun 2013 23:24:17 -0700 (PDT)
In-Reply-To: <7vehbvktmz.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/228671>

Junio C Hamano wrote:
> Good, but a "style only" patch like this should consider taking
> advantage of the occasion to clean up the entire file, as we do not
> often get enough chance to do so without conflicting with in-flight
> topics.  Is there something else that would conflict if this step
> did so?

No, but the problem is that the file contains mixed-style which
prevents me from automating my work with regular-expressions and
macros easily.  I have to break it up into regions and operate
regexps/macros on specific regions, multiplying the number of errors I
can possibly commit.  Nevertheless, I'll do it: I don't want this to
be a maintenance burden for us.
