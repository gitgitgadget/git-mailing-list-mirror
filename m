From: Chris Packham <judge.packham@gmail.com>
Subject: Re: git submodule: update=!command
Date: Wed, 18 Mar 2015 20:43:14 +1300
Message-ID: <CAFOYHZC2Af80EgNgnd7a_DyYnaivthA6vnDEdknQ4ebQfgdGmA@mail.gmail.com>
References: <1426620537.1785877.241673949.72FB3B40@webmail.messagingengine.com>
	<xmqqy4mvmjs9.fsf@gitster.dls.corp.google.com>
	<1426625989.1809668.241718517.07249CD6@webmail.messagingengine.com>
	<xmqqtwxjmj21.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Ryan Lortie <desrt@desrt.ca>, GIT <git@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Mar 18 08:43:23 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YY8dO-0004FF-22
	for gcvg-git-2@plane.gmane.org; Wed, 18 Mar 2015 08:43:22 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755243AbbCRHnS (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 18 Mar 2015 03:43:18 -0400
Received: from mail-pa0-f50.google.com ([209.85.220.50]:36435 "EHLO
	mail-pa0-f50.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755047AbbCRHnP (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 18 Mar 2015 03:43:15 -0400
Received: by padcy3 with SMTP id cy3so34778327pad.3
        for <git@vger.kernel.org>; Wed, 18 Mar 2015 00:43:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        bh=bRDTnpVxffYTz4iTh04BAjrNPZfRUkAv+BbADTo/UqA=;
        b=CaPH/ZDBUkydrGQ23TXszJYTKrfo8slwRGgswlQaHEmUwcva+868YvHLRMl1oFEDeH
         spL05dKLqGg8KQd/3BF1AeDUuaZI+0Jttf3SfFLbNkUK3RZGPXafIYzS7Te1TTAVM6QG
         2t1kO8GtENBipKxdKrs3hjNBaa/1h1ljd+/y7zPnHGSe8s0nEEqjh7x/HZUVq1h5EMcA
         KAyJlZrgd0azYakE9QYQQnrcZWf36lONw9aelEv+KSXOGR6mBsucyRGOcRUY+cOw0SNR
         +T1wL6pAiCeKqtzeuZFUCWfs1Gee0ZHhzGk8Sm/fxPLiuKOZXEo+YQ+vJz6DzR1vDDyj
         nuIg==
X-Received: by 10.70.118.134 with SMTP id km6mr155200744pdb.162.1426664594766;
 Wed, 18 Mar 2015 00:43:14 -0700 (PDT)
Received: by 10.70.0.171 with HTTP; Wed, 18 Mar 2015 00:43:14 -0700 (PDT)
In-Reply-To: <xmqqtwxjmj21.fsf@gitster.dls.corp.google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/265689>

On Wed, Mar 18, 2015 at 10:05 AM, Junio C Hamano <gitster@pobox.com> wrote:
> Ryan Lortie <desrt@desrt.ca> writes:
>
>> On Tue, Mar 17, 2015, at 16:49, Junio C Hamano wrote:
>>> With more recent versions of Git, namely, the versions after
>>> 30a52c1d (Merge branch 'ms/submodule-update-config-doc' into maint,
>>> 2015-03-13), the documentation pages already have updated
>>> descriptions around this area.
>>
>> sigh.
>>
>> That's what I get for forgetting to type 'git pull' before writing a
>> patch.
>>
>> Sorry for the noise!
>
> Nothing to apologise or sigh about.  You re-confirmed that the old
> documentation was lacking, which led to an earlier discussion which
> in turn led to Michal to update the documentation.  If you check the
> output from
>
>     git diff 30a52c1d^ 30a52c1d
>
> and find it appropriately address the problem you originally had,
> that would be wonderful, and if you can suggest further improvement,
> that is equally good.

I think 30a52c1d could be improved with the following snippet from Ryans patch.

"For security reasons, this feature is not supported from the
`.gitmodules` file"

Or something along those lines.
