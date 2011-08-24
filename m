From: Michael Witten <mfwitten@gmail.com>
Subject: Re: How to check out the repository at a particular point in time
Date: Wed, 24 Aug 2011 16:18:55 +0000
Message-ID: <CAMOZ1Bs59Hqoi3d0uxg1bey=_6cYu5+U5gWmz14V97_YFteSuA@mail.gmail.com>
References: <201108221525.32982.trast@student.ethz.ch> <1314026326.37332.YahooMailClassic@web25408.mail.ukl.yahoo.com>
 <CAMOZ1Bti3ZtAEOtLiUYSkWE+rO_VQd09NAn58Cn4hZBu8f-aFQ@mail.gmail.com>
 <4E551BC3.8080701@op5.se> <86vctm24le.fsf@red.stonehenge.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Andreas Ericsson <ae@op5.se>, rdiezmail-temp2@yahoo.de,
	Thomas Rast <trast@student.ethz.ch>, in-git-vger@baka.org,
	Michael J Gruber <git@drmicha.warpmail.net>,
	Jonathan Nieder <jrnieder@gmail.com>,
	Hilco Wijbenga <hilco.wijbenga@gmail.com>, git@vger.kernel.org
To: "Randal L. Schwartz" <merlyn@stonehenge.com>
X-From: git-owner@vger.kernel.org Wed Aug 24 18:19:31 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QwGAt-0005ae-78
	for gcvg-git-2@lo.gmane.org; Wed, 24 Aug 2011 18:19:31 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752318Ab1HXQT1 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 24 Aug 2011 12:19:27 -0400
Received: from mail-gw0-f46.google.com ([74.125.83.46]:62523 "EHLO
	mail-gw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751993Ab1HXQT0 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 24 Aug 2011 12:19:26 -0400
Received: by gwaa12 with SMTP id a12so988657gwa.19
        for <git@vger.kernel.org>; Wed, 24 Aug 2011 09:19:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        bh=AbO6TsOJk2Rx66mBU+jQ8AI1Mbj7trgYRBbFrxN6YJ8=;
        b=cavqBiEeo7lKJW695UW7sJDXi9RBYEdigizFX9pf+UkA5x4a8H0+PO/ji6867JpTeX
         wFjb7bMGkMsHmsVPFSak7KAv5f/keA+hQsiy5aNYpTQAqs82JiN3Yuq9xupjLWLPF73t
         FsbPL7PzoV2qjXZcZM0hY9Wg31nnv0q1lTbfI=
Received: by 10.43.52.1 with SMTP id vk1mr4648815icb.129.1314202765159; Wed,
 24 Aug 2011 09:19:25 -0700 (PDT)
Received: by 10.42.138.66 with HTTP; Wed, 24 Aug 2011 09:18:55 -0700 (PDT)
In-Reply-To: <86vctm24le.fsf@red.stonehenge.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/180015>

On Wed, Aug 24, 2011 at 15:48, Randal L. Schwartz <merlyn@stonehenge.com> wrote:
>>>>>> "Andreas" == Andreas Ericsson <ae@op5.se> writes:
>
> Andreas> Whatever, really. The fact that pretty much everyone seems to know
> Andreas> what a branch is and how it works in git after a (very) brief intro
> Andreas> to it means it's either right on target or that people are so used to
> Andreas> the fact that branch means something different in every scm that they
> Andreas> don't even bother loading the word with some preconceived notion that
> Andreas> used to be right in cvs.
>
> It does lead to confusion though, and once you *really* understand that
> a branch is a point, not a line, you can do a lot more cool things with
> git, and rebase and stash make a lot more sense.

Indeed. I don't think Andreas is correct in the assertion that
"everyone seems to know what a branch is and how it works in git after
a (very) brief intro". Rather, I think it is just the case that
everyone seems to know how to use the basic public interface for
branches after a (very) brief intro, and that many tasks allow
everyone to get away with having wrongheaded ideas.
