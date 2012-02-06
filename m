From: demerphq <demerphq@gmail.com>
Subject: Re: Bug: "git checkout -b" should be allowed in empty repo
Date: Mon, 6 Feb 2012 19:39:15 +0100
Message-ID: <CANgJU+Xz1adaungdOnosYwvYOXYf1F=PTub2nJYn=-1BiRAFeg@mail.gmail.com>
References: <4F24E287.3040302@alum.mit.edu>
	<7vwr8bvvxj.fsf@alter.siamese.dyndns.org>
	<4F263AEE.4080409@alum.mit.edu>
	<7v39axc9gp.fsf@alter.siamese.dyndns.org>
	<7vaa55ar4v.fsf@alter.siamese.dyndns.org>
	<20120130215043.GB16149@sigill.intra.peff.net>
	<7vobtcbtqa.fsf@alter.siamese.dyndns.org>
	<20120206043012.GD29365@sigill.intra.peff.net>
	<CAH5451ndjozo8-Cx3+Vc84TCjKJvCnSuOUsQS5cnqXsdc=8fMQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Cc: Jeff King <peff@peff.net>, Junio C Hamano <gitster@pobox.com>,
	git@vger.kernel.org, Michael Haggerty <mhagger@alum.mit.edu>
To: Andrew Ardill <andrew.ardill@gmail.com>
X-From: git-owner@vger.kernel.org Mon Feb 06 19:39:26 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RuTTG-00088j-7o
	for gcvg-git-2@plane.gmane.org; Mon, 06 Feb 2012 19:39:22 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755523Ab2BFSjR (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 6 Feb 2012 13:39:17 -0500
Received: from mail-yw0-f46.google.com ([209.85.213.46]:33674 "EHLO
	mail-yw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755492Ab2BFSjQ (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 6 Feb 2012 13:39:16 -0500
Received: by yhoo21 with SMTP id o21so2632515yho.19
        for <git@vger.kernel.org>; Mon, 06 Feb 2012 10:39:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        bh=dKVkxLb7WvgoHwGNWaTdwn4DXbCGe4nlRACBQrujpGM=;
        b=VS4ReBLfO7i8PljRav6k5qgoJNwlxns2YQ6UvPyPomo+hglRghC6CF/7JDb1zr4Vb/
         ik1z8s6xE7oW/Ka0qQI1JxYjLFM5XqKu6sG0mD+DzgsB57WPOW+JSPHgZsyqVCEzc5mm
         ldS8Ty5uNNDFFzCYhou99Ow8HEG/zKLQgHoZY=
Received: by 10.236.126.168 with SMTP id b28mr24396445yhi.88.1328553556042;
 Mon, 06 Feb 2012 10:39:16 -0800 (PST)
Received: by 10.236.177.103 with HTTP; Mon, 6 Feb 2012 10:39:15 -0800 (PST)
In-Reply-To: <CAH5451ndjozo8-Cx3+Vc84TCjKJvCnSuOUsQS5cnqXsdc=8fMQ@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/190088>

On 6 February 2012 05:42, Andrew Ardill <andrew.ardill@gmail.com> wrote:
> On 6 February 2012 15:30, Jeff King <peff@peff.net> wrote:
>
>> And perhaps in that case we should be discouraging them from calling it
>> something besides master (because while master is mostly convention,
>> there are a few magic spots in the code where it is treated specially,
>> and departing from the convention for no good reason should be
>> discouraged).
>
> What exactly are the areas where 'master' is treated specially? I
> agree that people should be discouraged from needlessly abandoning
> convention, however I think users should have the ability to name
> their branches as they see fit.

FWIW, we at $work have used a repo without a master branch at all
since the very beginning and never noticed a problem with it.

Although we *did* rename the original master to "trunk".

We did this because we felt that in a scenario where there is a
designated central "master repo" that the use of "master branch" would
get really confusing, so we have a master repo, whos main branch is
"trunk".

Yves

-- 
perl -Mre=debug -e "/just|another|perl|hacker/"
