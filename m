From: Rich Pixley <rich.pixley@palm.com>
Subject: Re: Newbie grief
Date: Fri, 04 May 2012 10:57:59 -0700
Message-ID: <4FA418A7.2050100@palm.com>
References: <4F9F128C.5020304@palm.com>            <201204302331.q3UNVo7o032303@no.baka.org>            <4F9F28F5.2020403@palm.com>            <201205010137.q411bxaU002449@no.baka.org>            <4F9F52B9.9060508@palm.com>            <08704bd2e32343a4b9def80e4fa1efa2-mfwitten@gmail.com>            <4FA2D8EA.7030809@palm.com>            <87obq5ggpu.fsf@an-dro.info.enstb.org>            <7vehr1dl2z.fsf@alter.siamese.dyndns.org>            <4FA307C5.102@palm.com>            <4FA3090D.5080406@palm.com>            <4FA32A6A.4070007@blizzard.com>            <CA+7g9Jxp859st6SrViizwOMrU9vsnmfy6P64SK9y_-ZEzEB6Mw@mail.gmail.com> <1167779eee7d442b9db0eecb347d5516-mfwitten@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Cc: Nathan Gray <n8gray@n8gray.org>,
	Junio C Hamano <gitster@pobox.com>,
	Illia Bobyr <ibobyr@blizzard.com>,
	Ronan Keryell <Ronan.Keryell@hpc-project.com>,
	"git@vger.kernel.org" <git@vger.kernel.org>
To: Michael Witten <mfwitten@gmail.com>
X-From: git-owner@vger.kernel.org Fri May 04 20:07:41 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SQMuq-0006HR-DX
	for gcvg-git-2@plane.gmane.org; Fri, 04 May 2012 20:07:40 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753490Ab2EDSHg (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 4 May 2012 14:07:36 -0400
Received: from smtp-relay2.palm.com ([64.28.152.243]:36085 "EHLO
	smtp-relay2.palm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752693Ab2EDSHf (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 4 May 2012 14:07:35 -0400
X-Greylist: delayed 562 seconds by postgrey-1.27 at vger.kernel.org; Fri, 04 May 2012 14:07:35 EDT
X-IronPort-AV: E=Sophos;i="4.75,532,1330934400"; 
   d="scan'208";a="13315903"
Received: from unknown (HELO ushqusdns3.palm.com) ([148.92.223.90])
  by smtp-relay2.palm.com with ESMTP; 04 May 2012 10:58:13 -0700
Received: from fuji.noir.com ([10.100.2.1])
	by ushqusdns3.palm.com (8.14.4/8.14.4) with ESMTP id q44Hvwc1029542;
	Fri, 4 May 2012 10:57:59 -0700
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.7; rv:12.0) Gecko/20120428 Thunderbird/12.0.1
In-Reply-To: <1167779eee7d442b9db0eecb347d5516-mfwitten@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/197042>

On 5/3/12 21:35 , Michael Witten wrote:
> On Thu, 3 May 2012 20:13:01 -0700, Nathan Gray wrote:
>
>> On Thu, May 3, 2012 at 6:01 PM, Illia Bobyr<ibobyr@blizzard.com>  wrote:
>>> It is just a "non-fast forward" move of a branch tip.  This term
>>> describes what happens precisely :)
>>>
>>> It is true, that the term is non obvious to the new comers.
>>> One may google and get an explanation of the error pretty quickly.
>>> First hit for "git non fast forward error" gives an explanation from a
>>> new comer point of view for the simplest case.
>> I just led a team of reasonably bright people through a transition
>> from SVN to git.  Not one of them understood this message.  Every one
>> of them thought something was broken.  This is a very common
>> occurrence, so a short, simple message without jargon for this error
>> would be a big, big win.
> Well, what is your suggestion?
>
> Nobody in this thread has yet provided an explicit improvement because
> the actual complaint is that the vast majority of people (including
> supposed "professionals") don't RTFM; it never even occurs to them!
>
> Let's look at the message in question:
>
>    To $uri_for_central_repo
>     ! [rejected]        HEAD ->  feature_0 (non-fast-forward)
>    error: failed to push some refs to '$uri_for_central_repo'
>    To prevent you from losing history, non-fast-forward updates were rejected
>    Merge the remote changes (e.g. 'git pull') before pushing again.  See the
>    'Note about fast-forwards' section of 'git push --help' for details.
>
> Not only does this already spoonfeed the reader with a suggested
> command for getting back on track (i.e., 'git pull'), but it also
> explicitly points out the relevant documentation and HOW to gain
> immediate access to that information from the command line!
Let's take it line by line.

"Rejected - mumble" - the tool did not do what you asked.
"error: failed to mumble"  - your data is corrupt.
"To prevent you mumble mumble" - you're not allowed to do what you want

I stopped reading there.

I'm not saying this is a correct interpretation.  I'm offering it as a 
data point from a sophisticated, although new, user.

I've already offered a suggestion for rewording.

--rich
