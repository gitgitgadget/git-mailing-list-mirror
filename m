From: Felipe Contreras <felipe.contreras@gmail.com>
Subject: Re: [PATCH v2 00/14] Officially start moving to the term 'staging area'
Date: Fri, 18 Oct 2013 05:36:54 -0500
Message-ID: <CAMP44s0pA3hKRMbXDx0ddi4RdrUZyMY0yAd5GbQutMqRSj_4Rg@mail.gmail.com>
References: <1381789769-9893-1-git-send-email-felipe.contreras@gmail.com>
	<1381789769-9893-4-git-send-email-felipe.contreras@gmail.com>
	<CAMP44s3u_SMyZOe5jxkvoGn5MBJ_g70iHRT5v_3u1rZwFoqiVA@mail.gmail.com>
	<xmqqwqlbznfp.fsf@gitster.dls.corp.google.com>
	<vpqbo2m7vyz.fsf@anie.imag.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org,
	Piotr Krukowiecki <piotr.krukowiecki.news@gmail.com>,
	Jay Soffian <jaysoffian@gmail.com>,
	Jonathan Nieder <jrnieder@gmail.com>,
	Philip Oakley <philipoakley@iee.org>,
	William Swanson <swansontec@gmail.com>,
	Ping Yin <pkufranky@gmail.com>,
	Hilco Wijbenga <hilco.wijbenga@gmail.com>
To: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
X-From: git-owner@vger.kernel.org Fri Oct 18 12:37:19 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VX7Qj-0001U9-CN
	for gcvg-git-2@plane.gmane.org; Fri, 18 Oct 2013 12:37:17 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752810Ab3JRKg4 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 18 Oct 2013 06:36:56 -0400
Received: from mail-wg0-f42.google.com ([74.125.82.42]:35812 "EHLO
	mail-wg0-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752476Ab3JRKg4 (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 18 Oct 2013 06:36:56 -0400
Received: by mail-wg0-f42.google.com with SMTP id n12so1885479wgh.5
        for <git@vger.kernel.org>; Fri, 18 Oct 2013 03:36:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        bh=2KlRPs6/H5Fma/HW46dJmthrO40aFIZWs9DluO5Qi64=;
        b=Yg6+BQ/z0Im74O734wVxXymthxumSTwyWose1omER4eYktN2BaqjwWRgL9EuYiMdSE
         Q0mUn6aGsHMjLDtK9DYuRfz8G2jFIaOEuWC9G0tfZGm3tbVXcpon57cuASr1eG/mqcqu
         ABZQIpXurkLSJA0vDvuvtUBcyHNW8zzCDmdM9ObxH/oiH7PuCpZ+q6eZfDcEtTky9aVf
         EM1vLyhyQM0NRxECHfuU1U0Rv/rM5w0S7OgQ0wLmiyItSqEIAe8w9+3b3GjgIh6ZOkUH
         eYN7YSVkUi36eiZLhPxTI0hYFUdymxIyX9ik77aklSNf1DE7JE3Qm2h5o3yoCvwTjRWG
         7fnw==
X-Received: by 10.180.73.239 with SMTP id o15mr2327814wiv.36.1382092614551;
 Fri, 18 Oct 2013 03:36:54 -0700 (PDT)
Received: by 10.194.242.167 with HTTP; Fri, 18 Oct 2013 03:36:54 -0700 (PDT)
In-Reply-To: <vpqbo2m7vyz.fsf@anie.imag.fr>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/236343>

On Fri, Oct 18, 2013 at 4:46 AM, Matthieu Moy
<Matthieu.Moy@grenoble-inp.fr> wrote:
> I'm lacking time to read and answer in detail, sorry.
>
> Junio C Hamano <gitster@pobox.com> writes:
>
>> "It must be done" is different from "any change is good, as long as
>> it introduces more instances of word 'stage'".
>
> I agree. Something must be done, at least to remove the cache Vs index
> confusion. I'm not sure exactly what's best, and we should agree where
> to go before going there.

I thought we already agreed "staging area" is the best term. Some
people don't, but that's expected.

>> The phrase "staging area" is not an everyday phrase or common CS
>> lingo, and that unfortunately makes it a suboptimal choice of words
>> especially to those of us, to whom a large portion of their exposure
>> to the English language is through the command words we use when we
>> talk to our computers.
>
> I do not think being understandable immediately by non-native is so
> important actually. To me as a french, "commit" makes no sense as an
> english word to describe what "git commit" does, but it's OK as I never
> really translate it. Even fr.po translates "a commit" by "un commit".

Indeed. Let's hope this red herring is not brought again.

> That said, having something that immediately makes sense to a non-native
> is obviously a good point.

Most non-native speakers, as most native speakers, already agreed the
term "staging area" is best.

> Another proposal which I liked BTW was to use the word "precommit".
> Short, and easily understood as the place where the next commit is
> prepared.

And that proposal has been argued against already[1][2].

To summarize:

1) It's not even an English word
2) Unlike "staging area", it's not widely used in external documentation already
3) There's no sensible verb: "to precommit"?

Moreover, in my mind a true precommit would have author, committer,
date; all the things you expect in a commit, except that it's not
permanent. A natural command that would derive from this concept is
'git commit --prepare', which would create an actual precommit.

But we are not looking to introduce yet another concept, we are
looking for a name of a concept we already have, and the majority of
users have already given it a name; the staging area.

[1] http://article.gmane.org/gmane.comp.version-control.git/197215
[2] http://article.gmane.org/gmane.comp.version-control.git/168201
-- 
Felipe Contreras
