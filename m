From: Tim Visher <tim.visher@gmail.com>
Subject: Re: With feature branches, what is ever committed directly to master
Date: Wed, 11 Aug 2010 10:48:42 -0400
Message-ID: <AANLkTik0kvKbe8xQksOrVVs6BygoPF7K_sZJA6BXwRVK@mail.gmail.com>
References: <AANLkTin0VgH8CvnUn_tCJPTkhh7Ce-tYWo52qouoVvRN@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: git@vger.kernel.org
To: Bradley Wagner <bradley.wagner@hannonhill.com>
X-From: git-owner@vger.kernel.org Wed Aug 11 16:49:14 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OjCcC-0003jE-Lt
	for gcvg-git-2@lo.gmane.org; Wed, 11 Aug 2010 16:49:12 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753072Ab0HKOtE (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 11 Aug 2010 10:49:04 -0400
Received: from mail-pz0-f46.google.com ([209.85.210.46]:43626 "EHLO
	mail-pz0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752793Ab0HKOtD (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 11 Aug 2010 10:49:03 -0400
Received: by pzk26 with SMTP id 26so65860pzk.19
        for <git@vger.kernel.org>; Wed, 11 Aug 2010 07:49:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:mime-version:received:in-reply-to
         :references:from:date:message-id:subject:to:cc:content-type;
        bh=Z06yyUCn8+igdq6ADrUFwvaW1CtADGGUj1Hc1aAaPMs=;
        b=EF5+q6N0zNQQL3dzjKt7LD5QYE8sIUAigo4XorGQntYC1JotS6lmh+g8VUltyUMzK1
         8Ki1jbBOqnI4748j78k1nxlR0cwwNdg4n7USchzzOf92hlLcvQdfDBMJm/V3Pe7D6HaT
         FBSd5SXgpg0O5GYuCQS2E3iwm2heI2axGDQs0=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        b=Oe8GwyWtjcYLuJLmxIankjTcSodaK3valSrbMSwmyPibXCHJ1R563BazyCcMUsC3uT
         18Gk8Uadjl9DxcvZ0VtRhhn/9fg8FUHlKX6ENUeCgF05mylM/ELRQxm8oBqFzE8yH1WP
         gh/gPcPSrwz7zJc+RPEp352WiSCHDxYUvqZtQ=
Received: by 10.142.51.13 with SMTP id y13mr16387738wfy.8.1281538142596; Wed, 
	11 Aug 2010 07:49:02 -0700 (PDT)
Received: by 10.220.109.6 with HTTP; Wed, 11 Aug 2010 07:48:42 -0700 (PDT)
In-Reply-To: <AANLkTin0VgH8CvnUn_tCJPTkhh7Ce-tYWo52qouoVvRN@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/153236>

On Tue, Aug 10, 2010 at 3:02 PM, Bradley Wagner
<bradley.wagner@hannonhill.com> wrote:
> I realize there are a lot of different Git workflows but I'm wondering
> how others in this community do it.
>
> We're using our "master" branch from our central repo (Beanstalk) as a
> dev branch and we have stable branches for various release versions of
> our software.
>
> We've not made as heavy use of feature branches yet as we should have.
> Once we do start using them more regularly, what kind of stuff is ever
> committed directly to "master" or is master typically the place where
> things are merged into from other stable/features branches?
>
> Is "master" really even unstable at that point?
>
> Thanks in advance! I realize this question is pretty open-ended.

Since no one mentioned it yet, I found this [paper][] to be an
incredible resource and it's the workflow my team has adopted.

[paper]: http://nvie.com/git-model

-- 

In Christ,

Timmy V.

http://blog.twonegatives.com/
http://five.sentenc.es/ - Spend less time on e-mail
