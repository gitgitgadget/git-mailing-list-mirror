From: Stefan Beller <sbeller@google.com>
Subject: Re: [BUG?] HEAD detached at HEAD
Date: Fri, 18 Sep 2015 10:32:09 -0700
Message-ID: <CAGZ79kZxAwMvv6UoZLBd2wTOdj1DFWKQqSPBYL449KSokA8DQQ@mail.gmail.com>
References: <vpqk2rnirz0.fsf@anie.imag.fr>
	<CA+P7+xoeXiZd=WU460Xfjthe0U5BnAV69_KNKW39p10ZGLHx7g@mail.gmail.com>
	<vpqeghviqu1.fsf@anie.imag.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Jacob Keller <jacob.keller@gmail.com>, git <git@vger.kernel.org>
To: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>,
	Michael J Gruber <git@drmicha.warpmail.net>
X-From: git-owner@vger.kernel.org Fri Sep 18 19:32:22 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZczWH-0002yC-Mj
	for gcvg-git-2@plane.gmane.org; Fri, 18 Sep 2015 19:32:22 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752200AbbIRRcM (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 18 Sep 2015 13:32:12 -0400
Received: from mail-yk0-f175.google.com ([209.85.160.175]:34319 "EHLO
	mail-yk0-f175.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751888AbbIRRcK (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 18 Sep 2015 13:32:10 -0400
Received: by ykdg206 with SMTP id g206so52965187ykd.1
        for <git@vger.kernel.org>; Fri, 18 Sep 2015 10:32:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        bh=bc9BbwTLNYy1JZwXKl4Lam9wA5v6ok2onuy7uYODkUk=;
        b=ERPb7Wu5NSwoHsNP52ngnSjV0owE03mWvGYwM3YtxYhmMfJjpA9rSyzNRukcRXNE06
         JMHpprdM1TJR/V3Qfy50N1+ZbJB3XZ+a9Jjm2Ud/pNsbKPr545RBJPrIG0ajRjQuuY9p
         du1pU3Kut4rkViw0vPK9ICTkaHBbO+rQoaXd0woYcKx/fo9olWYmZY3NOaS2IUV2LU4/
         ZzUuPg1ljUJOD9uQjW2jswwusI6HAaFPR9Om3aTfLwm/yauNjbcL87VRxSNj4XpnCvdi
         ybOTSdK89UDssZyM9BUOyiVkzvk6ONVC6ubsqyzfeHiliDTXA6fLM/JIggjPg9uPwSnZ
         m7Dg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:date
         :message-id:subject:from:to:cc:content-type;
        bh=bc9BbwTLNYy1JZwXKl4Lam9wA5v6ok2onuy7uYODkUk=;
        b=hVVvKjUOw3EsW6xbPIa/brVs1x82M5r/UH6G1gqZJzUsQEk8khflDq6vAaSQSf+iFa
         9v84Iv3f/hWvjGISZEL96qZaAJfhBD1JN3i3ZJoiTXRL41UrOuJ2E2FxTPAJPmAl8Gq2
         0M1m7dFCG2YQ1cnX/pTvUUswxmcfdXA0BjRnITNlmg+MxYGL+Ke6NXqRAEnU/Cl/N0eQ
         XZ0tloX9mYBIB/1Yqn5T5egP7ycRCR2tQJXuzFqR14WQKiTJf/xlKpvqGNwWYKa6Z7Jv
         7szYGz0yd5btTIDQqZeSwOPVdKwI17/pSMILCQY74Ra7BdA5oPEBnl8FORK6RIx2HBCW
         Vh3w==
X-Gm-Message-State: ALoCoQmmdPcrhjy9Ru9VVvq8oweNtFZE0OWRXNBtw9de3a8tYJOo/EuW/bUrbcgdzzxcu0SYEoT6
X-Received: by 10.170.196.201 with SMTP id n192mr5424716yke.16.1442597529344;
 Fri, 18 Sep 2015 10:32:09 -0700 (PDT)
Received: by 10.37.29.213 with HTTP; Fri, 18 Sep 2015 10:32:09 -0700 (PDT)
In-Reply-To: <vpqeghviqu1.fsf@anie.imag.fr>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/278211>

On Fri, Sep 18, 2015 at 10:23 AM, Matthieu Moy
<Matthieu.Moy@grenoble-inp.fr> wrote:
> Jacob Keller <jacob.keller@gmail.com> writes:
>
>> On Fri, Sep 18, 2015 at 9:59 AM, Matthieu Moy
>> <Matthieu.Moy@grenoble-inp.fr> wrote:
>>> I'm getting it even if there's a tag and/or a branch pointing to the
>>> same commit.
>>>
>>> Any idea what's going on?
>>
>> Any chance you accidentally made a branch or tag named HEAD?
>
> Nice try ;-), but no:

I was playing around with origin/master and origin/pu and
I cannot reproduce this bug.

However maybe Michael as the author of 4b063186
(2015-03-03 branch: name detached HEAD analogous to status)
can help here ?

>
> $ git status
> HEAD detached at HEAD
> nothing to commit, working directory clean
>
> $ git for-each-ref
> 16aa1796fb487fc7178ceef0525fed80284a4c52 commit refs/heads/master
> 16aa1796fb487fc7178ceef0525fed80284a4c52 commit refs/tags/foo
>
> $ git rev-parse HEAD
> 16aa1796fb487fc7178ceef0525fed80284a4c52
>
> --
> Matthieu Moy
> http://www-verimag.imag.fr/~moy/
> --
> To unsubscribe from this list: send the line "unsubscribe git" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
