From: Anand Kumria <wildfire@progsoc.org>
Subject: Re: [PATCH] gitk: Display the date of a tag in a human friendly way.
Date: Sun, 3 Feb 2013 18:37:42 +0000
Message-ID: <CAM1C4G=mKzfgrfO-n_yXjyDkZ9vA7H6kQEY5Yja-5C-YRRLmyw@mail.gmail.com>
References: <1357314431-32710-1-git-send-email-wildfire@progsoc.org>
 <7vhamwse2c.fsf@alter.siamese.dyndns.org> <CAM1C4Gm_ea8DgrVhnp_MHmqaF6pyDe98EDA_BPkjvc8M5AO6FQ@mail.gmail.com>
 <7v1udzqv1v.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: Paul Mackerras <paulus@samba.org>
X-From: git-owner@vger.kernel.org Sun Feb 03 19:38:40 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1U24Sd-0005aL-B0
	for gcvg-git-2@plane.gmane.org; Sun, 03 Feb 2013 19:38:39 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753397Ab3BCSiR (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 3 Feb 2013 13:38:17 -0500
Received: from mail-oa0-f48.google.com ([209.85.219.48]:61489 "EHLO
	mail-oa0-f48.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753341Ab3BCSiP (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 3 Feb 2013 13:38:15 -0500
Received: by mail-oa0-f48.google.com with SMTP id j1so4544154oag.7
        for <git@vger.kernel.org>; Sun, 03 Feb 2013 10:38:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=x-received:mime-version:sender:in-reply-to:references:from:date
         :x-google-sender-auth:message-id:subject:to:cc:content-type;
        bh=X51goCwzcAELyFVumK4IxVkaO90v5PXeulPK6wSFS4Q=;
        b=QFajICMcC0GFCpthoNNce1l/zRjXtC48F6kHd3di0wNPmMuS68bbUy8g5tBoUT4ITd
         wlJazB+wn0fxyx2XrBe2wJhx93jq2P5f/nGXMmjrdjVclCPeg/bjQ0a3FtdIxjaCUGSy
         DR8LC6kg/qf16/RUQ30/ULMb0qSHTDpggpSpEUE1KaX1BhzIm64P/MLp6NVW1ESjPWM9
         NRy3/2X3e85kUYVZfOiOD/R+2LWDb9cUwQ6HSy7xxoClVcJkkBoz8uElLTHproriNkje
         AeZasHDG4Rh/+54M8Qk2o9DrJl0EMCMvoKSBThWoQI5I8GgCx4AYr9HmRN1RRiHt6Wos
         JZrA==
X-Received: by 10.60.28.8 with SMTP id x8mr4165504oeg.40.1359916692928; Sun,
 03 Feb 2013 10:38:12 -0800 (PST)
Received: by 10.76.5.81 with HTTP; Sun, 3 Feb 2013 10:37:42 -0800 (PST)
In-Reply-To: <7v1udzqv1v.fsf@alter.siamese.dyndns.org>
X-Google-Sender-Auth: OQ--5cK2vJwXY_xmOtQ0ucQHsZQ
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/215322>

Hi Pau,

I've not been able to find the canonical location of your gitk repository.

I've tried kernel.org, samba.org and ozlabs.org; none of them to have
it - nor does any amount of google searching I do reveal the location.

I realise you've probably had a busy month with linux.conf.au but it
would be nice to have some feedback.

Could you let me know where gitk is hosted and I'll re-roll this patch
against that (and update the docs so others don't need to go hunting).

Thanks,
Anand

On 5 January 2013 19:38, Junio C Hamano <gitster@pobox.com> wrote:
> Anand Kumria <wildfire@progsoc.org> writes:
>
>> Sorry, I didn't know that gitk had been split back out (and
>> Documentation/gitk.txt still mentions it is part of the git suite).
>
> It is not "split back" at all, and it won't be.  From "git" user's
> point of view it is part of the suite.
>
> Gitk however is still a viable freestanding project, so it would be
> selfish for me to take a patch to gitk-git/gitk directly to my tree,
> as the patch will not be able to flow back to the standalone gitk
> project. Hence we always let patches go through Paul's tree and then
> I pull from him.
>
>
