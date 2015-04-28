From: Paul Tan <pyokagan@gmail.com>
Subject: Re: GSoC 2015: 2 accepted proposals
Date: Tue, 28 Apr 2015 16:58:26 +0800
Message-ID: <CACRoPnQ5_r-26J4gBHc27KZt3X9KAU7eFkA3vz_GE6_dP-Uyug@mail.gmail.com>
References: <vpqoam9mjuo.fsf@anie.imag.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: git <git@vger.kernel.org>, karthik.188@gmail.com,
	Jeff King <peff@peff.net>,
	Christian Couder <christian.couder@gmail.com>,
	Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Stefan Beller <sbeller@google.com>
X-From: git-owner@vger.kernel.org Tue Apr 28 10:58:49 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Yn1Lo-00018l-Fq
	for gcvg-git-2@plane.gmane.org; Tue, 28 Apr 2015 10:58:44 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933157AbbD1I63 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 28 Apr 2015 04:58:29 -0400
Received: from mail-la0-f54.google.com ([209.85.215.54]:34010 "EHLO
	mail-la0-f54.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S933121AbbD1I61 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 28 Apr 2015 04:58:27 -0400
Received: by laat2 with SMTP id t2so99103450laa.1
        for <git@vger.kernel.org>; Tue, 28 Apr 2015 01:58:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        bh=3PLSnsEbNTfuFkl3kepQ26fdtozsDJDhjYQVVzLaSmY=;
        b=f9NpStGTLREITdiA6cFGtR8SgB8Xdj6SzAmO+LTgZrANVjdwmv1dc829f3KsaBI2Br
         stEmUIdZ1Hj74mufjSZ9S9GfRorvH4U/Xzc2cSSgplvFTfp/hJD4PSLba+Jgg3VOmL4B
         K4wqV8wmhsB6edERH+EXeMVba5jhPNmnMxEc6V9m383sp9kCjvUQUfkaq2R6/tjNZEza
         7RbFFxt5R8bqrmGk71PrX2zNxTTnSqmfz2MfxyBMVhENLqkKr8sgHiLKs5/+pD6skmaU
         kSs91NjuPYAFBZxVx7smFjoY8TpD4QGk3tMKNeSP4GzMo9Mnqxt+JQlY5F5H2GP+tla6
         QFmw==
X-Received: by 10.112.167.166 with SMTP id zp6mr13827322lbb.80.1430211506077;
 Tue, 28 Apr 2015 01:58:26 -0700 (PDT)
Received: by 10.112.74.133 with HTTP; Tue, 28 Apr 2015 01:58:26 -0700 (PDT)
In-Reply-To: <vpqoam9mjuo.fsf@anie.imag.fr>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/267914>

Hi all,

On Tue, Apr 28, 2015 at 3:50 AM, Matthieu Moy
<Matthieu.Moy@grenoble-inp.fr> wrote:
> Hi,
>
> The results just got offical: the Git organization has 2 students
> accepted for the summer of code 2015.
>
> Karthik Nayak will work on "Unifying git branch -l, git tag -l, and git
> for-each-ref" mentored by Christian Couder and yours truly.
>
> Paul Tan will work on "Make git-pull and git-am builtins", mentored by
> Johannes Schindelin and Stefan Beller.

Thanks for accepting me, and it is my pleasure to work with everyone.
For reference, information on the proposed project can be found at
[1].

As stated in the proposal, I will be starting work on the project
immediately. The first step would be to review the test coverage of
git-pull and git-am in order to make sure that nothing breaks during
the rewriting. I am currently reviewing all related code in order to
get a better perspective on the issues involved. I am also aware of
the recent issues with git-pull[2], which I will look into.

All patches that I'm working on but are not ready to be published to
the mailing list will be cooked in their corresponding branches in my
personal git repo[3], which I will push at least once a working day.
Everyone is welcome to have a look :-).

Again, thanks all for your support and guidance, and I look forward to
working with everyone to make this project a success.

Regards,
Paul

[1] https://gist.github.com/pyokagan/1b7b0d1f4dab6ba3cef1
[2] http://thread.gmane.org/gmane.comp.version-control.git/267432
[3] https://github.com/pyokagan/git
