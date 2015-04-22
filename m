From: Stefan Beller <sbeller@google.com>
Subject: Re: About my git workflow; maybe it's useful for others
Date: Wed, 22 Apr 2015 12:50:17 -0700
Message-ID: <CAGZ79ka1U8SP-7b_Jbm--1j1sz0iHKd+v-WNCASAXH+kystefA@mail.gmail.com>
References: <CAGZ79kaK-uRAE9-rH=-5t8djAw5e9rwkPjZuw=+XWEq+V6R5Yg@mail.gmail.com>
	<CACnwZYf6-Fh0JZeJZ4j3QOyqRF_2-NKJB06Wh20ipsRmrRN+qw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: "git@vger.kernel.org" <git@vger.kernel.org>,
	Michael Haggerty <mhagger@alum.mit.edu>
To: Thiago Farina <tfransosi@gmail.com>
X-From: git-owner@vger.kernel.org Wed Apr 22 21:50:31 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Yl0fC-0002RS-Ku
	for gcvg-git-2@plane.gmane.org; Wed, 22 Apr 2015 21:50:27 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757427AbbDVTuU (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 22 Apr 2015 15:50:20 -0400
Received: from mail-ie0-f174.google.com ([209.85.223.174]:36214 "EHLO
	mail-ie0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752314AbbDVTuS (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 22 Apr 2015 15:50:18 -0400
Received: by iebrs15 with SMTP id rs15so45897353ieb.3
        for <git@vger.kernel.org>; Wed, 22 Apr 2015 12:50:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        bh=MtxaBbgY6OH1LsLMfb55H0cvAFkC3PfCpBAMK3+wQZ0=;
        b=L7aHH6hPGRH51L/I4UlKAD5OjFiNK4sUc3p83BPi/KaCAfNxVZxlOyOT/mNIgrWYWK
         Y2aOck/QQ1nP8nBKh82Gswgs6zDX+5KQZiFbtv+UVRFcN7aGVL2EOrUgiwGBmADSRb5h
         N8khWliNNzLO66C+fsU9pD4h7EIx+uofojQOIZtYOmR4ucimFWYRckC1uKFmM6KAept1
         NLKK3m5TeM2TlJ2TmduErQAG0/YW8rjFCxK5qvdrWXSao+ISZ6svq0M3Lbfp2GvUn4qt
         4fUAuE+jo2r7gFbx/bhkR61uFKyCTJhn6KLohZr0N0VcDC5vDGphBhZre4Vczmmkk0wp
         +OAw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:date
         :message-id:subject:from:to:cc:content-type;
        bh=MtxaBbgY6OH1LsLMfb55H0cvAFkC3PfCpBAMK3+wQZ0=;
        b=D/doFc0XXWNQj1Gab8KJXbJuBZ3b564ITuasFFinewg4LPfkvWw7rQr4jsJKeWVdzj
         Wk6q4TrBpzobBBU9n0zI9IJCTQIMyiyozOHEToWedhz1eWRkDDaRTRvJTsQMd/Glx5Bo
         RNh58ZYfRcuMeODnhBqu9FJxO2baTWoO6abfv3JKle/W8PWjydIWEDfMC4QmvBKCF8sW
         6x3SQcz2nr3eB/3ianbeefWniXGKk04N//ckNIb03vfpQbQ54oLFGs0XpAdA4umSow+E
         Xbvb0eCoaEk14J9MsrC87z0wtweRrfHcLq5gMNb/hWs+Nn+dXvOkgIEhq8eb8UP+sHqU
         1r3w==
X-Gm-Message-State: ALoCoQmXXanBjwLJ6kR/LXSVdc3sh/AkCUfeCprzpgzX+wrHXlMiaZkO2yYzQ957dOav6Y6DDRsg
X-Received: by 10.42.30.141 with SMTP id v13mr12028894icc.76.1429732217356;
 Wed, 22 Apr 2015 12:50:17 -0700 (PDT)
Received: by 10.107.46.22 with HTTP; Wed, 22 Apr 2015 12:50:17 -0700 (PDT)
In-Reply-To: <CACnwZYf6-Fh0JZeJZ4j3QOyqRF_2-NKJB06Wh20ipsRmrRN+qw@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/267626>

On Wed, Apr 22, 2015 at 12:38 PM, Thiago Farina <tfransosi@gmail.com> wrote:
>>
> IMO, sending email is the easiest part.
>
> The hard begins when you have to edit your patch and resend with the
> reviewers' feedback incorporated. For me that is the most tricky and
> hard part to get right, specially when using GMail as an email client.
>
> How do you handle that part of the process?

I try to have as much in git as possible.

So when the reviews trickle in, I change my commits (in git) accordingly
via rebase and edit and lots of fixup commits. I use git notes
to keep track of changes from one version to another.

Having the "changes of the changes" in the git notes, I am (in theory)
always able to kick out a new version of the patch series with

   rm 00* # delete old patches
   git format-patch --notes --coverletter somebranch...HEAD
   edit 0000-cover-letter.patch
   git send-email 00* --to=mailing list --to=John@doe.org --cc=Max@Mustermann.de

which is only a few steps, so there is not much to go wrong here.

For me the biggest thing is to know when to send out new patches.
(Do I sleep over it and review it again myself,
or do I just gun it, believing my patches are good this time?)


>
> --
> Thiago Farina
