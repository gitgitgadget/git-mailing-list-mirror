From: Michael Haggerty <mhagger@alum.mit.edu>
Subject: Re: GSoC idea: allow "git rebase --interactive" todo lines to take
 options
Date: Fri, 28 Feb 2014 15:03:52 +0100
Message-ID: <53109748.3090507@alum.mit.edu>
References: <530DA00E.4090402@alum.mit.edu> <20140226105249.GE25711@sigill.intra.peff.net> <CANUGeEY2qE2LPq=-bhaKrKrv+uJUaPRqAeW_X1sFyZH-_PRVeA@mail.gmail.com> <20140228125241.GA23448@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Cc: Brandon McCaig <bamccaig@gmail.com>,
	git discussion list <git@vger.kernel.org>,
	Martin von Zweigbergk <martin.von.zweigbergk@gmail.com>,
	Johannes Schindelin <johannes.schindelin@gmx.de>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Fri Feb 28 15:04:06 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WJO2k-0007rH-IA
	for gcvg-git-2@plane.gmane.org; Fri, 28 Feb 2014 15:04:02 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752464AbaB1OD6 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 28 Feb 2014 09:03:58 -0500
Received: from alum-mailsec-scanner-5.mit.edu ([18.7.68.17]:61525 "EHLO
	alum-mailsec-scanner-5.mit.edu" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751945AbaB1OD4 (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 28 Feb 2014 09:03:56 -0500
X-AuditID: 12074411-f79ab6d000002f0e-17-5310974bcc4d
Received: from outgoing-alum.mit.edu (OUTGOING-ALUM.MIT.EDU [18.7.68.33])
	by alum-mailsec-scanner-5.mit.edu (Symantec Messaging Gateway) with SMTP id A3.1C.12046.B4790135; Fri, 28 Feb 2014 09:03:55 -0500 (EST)
Received: from [192.168.69.148] (p57A2462E.dip0.t-ipconnect.de [87.162.70.46])
	(authenticated bits=0)
        (User authenticated as mhagger@ALUM.MIT.EDU)
	by outgoing-alum.mit.edu (8.13.8/8.12.4) with ESMTP id s1SE3qLL032249
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES128-SHA bits=128 verify=NOT);
	Fri, 28 Feb 2014 09:03:54 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:17.0) Gecko/20131103 Icedove/17.0.10
In-Reply-To: <20140228125241.GA23448@sigill.intra.peff.net>
X-Enigmail-Version: 1.6
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFtrOKsWRmVeSWpSXmKPExsUixO6iqOs9XSDYYOcZE4vjPw6zWHRd6Way
	6F/exWYx4X4Ds8WPlh5mB1aPnbPusnt8+Bjn8ax3D6PH501yASxR3DZJiSVlwZnpefp2CdwZ
	3798YC14JVlx784vxgbG7SJdjJwcEgImErN3dLJC2GISF+6tZ+ti5OIQErjMKPHk/SMmCOcc
	k8TPS89YQKp4BbQlniy9wgZiswioSrz4vocRxGYT0JVY1NPMBGKLCgRLrL78AKpeUOLkzCdg
	toiArMT3wxsZQYYyC9xglJi04zbYamGBUImey2dgtjFK3J13C2wDp4C1xKpt+4C6OYDuE5fo
	aQwCMZkF1CXWzxMCqWAWkJfY/nYO8wRGwVlI1s1CqJqFpGoBI/MqRrnEnNJc3dzEzJzi1GTd
	4uTEvLzUIl1TvdzMEr3UlNJNjJCAF9zBOOOk3CFGAQ5GJR7eCZ78wUKsiWXFlbmHGCU5mJRE
	eZVbBYKF+JLyUyozEosz4otKc1KLDzFKcDArifA+aQLK8aYkVlalFuXDpKQ5WJTEefmWqPsJ
	CaQnlqRmp6YWpBbBZGU4OJQkeOOnATUKFqWmp1akZeaUIKSZODhBhnNJiRSn5qWkFiWWlmTE
	gyI4vhgYwyApHqC9uVNB9hYXJOYCRSFaTzHqctxu+/WJUYglLz8vVUocYocASFFGaR7cClh6
	e8UoDvSxMG8RSBUPMDXCTXoFtIQJaAmnJ9iSkkSElFQDoz3PPc/FHZKR2fPWLQ1K++rHcme+
	2PPSFIYJ3ZM+tijOlv6xc1MRk4fN4qCLhVHbtE/vFVNf8W5d0JXPSqfljilzzj7s 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/242959>

On 02/28/2014 01:52 PM, Jeff King wrote:
> [...]
> Sorry, I missed an important word in my final sentence. It should have
> been "the examples you gave are NOT particularly interesting to me".
> 
> On Thu, Feb 27, 2014 at 01:10:30PM -0500, Brandon McCaig wrote:
>> Particularly all of the ideas expressed later on about
>> merge commits and resetting authors, etc. It seems like you're trying
>> to define a whole new command set (i.e., API) for Git, but within the
>> context of rebase --interactive. I think it would be hard to document
>> this, and hard to learn it, and harder still to remember it (even
>> though it would obviously try to mirror the existing Git command API).
> 
> I agree some of the examples are getting esoteric. Things like --signoff
> and --reset-author are a fairly straightforward convenience feature:
> they save you from writing "exec git commit --amend --signoff".
> 
> For others that cannot currently be done with a simple option to "git
> commit", I think a reasonable first step would be to implement them
> there. For example, you cannot currently "git commit --tree". Maybe that
> is too insane and low-level an option for "git commit". But if it is,
> then it is almost certainly too insane and low-level for a rebase
> instruction.
> 
> For others from Michael's list, I expect they may not make _sense_
> outside of a rebase. That is, they are operations whose input is not a
> single commit, but a sequence of commits (e.g., if you had some
> high-level command that allowed swapping two commits without having to
> redo the conflicts from the second commit). Those ones might make sense
> to exist as part of rebase and nowhere else (but then they are not
> necessarily just options, but rather new instructions).
> 
>> That said, I do think that this is probably a bad direction and
>> shouldn't be rushed into too fast.
> 
> I'm not sure whether it is a good idea or not. But I think it is looking
> decreasingly like a good GSoC project.

I guess I misread the sentiment of the mailing list, because I merged
this idea into the list about two hours ago.

I'm not claiming that all of the sub-ideas are good, but I do think that
some of them are, and that the general idea of allowing options on
todo-list commands would make it possible for them to be more expressive
while *avoiding* making them a lot harder to learn.  I would rather give
the user a few options that can be used consistently on multiple
commands than have to invent a new command for each new feature.  And I
think that the line-oriented nature of the todo list makes

    pick --signoff 1234abc Blah blah

easier to understand (and easier to type) than

    pick 1234abc Blah blah
    amend --signoff

let alone

    pick 1234abc Blah blah
    exec git commit --amend --signoff

I also like the idea of a non-broken "git rebase --interactive
--preserve-merges" via a todo option "-p" or something similar.

But if you think that even the proposal's simpler sub-ideas are
controversial, then let me know and I will delete the idea from the list
again.  I don't want a GSoC student to have to fight battles of my own
creation :-)

Michael

-- 
Michael Haggerty
mhagger@alum.mit.edu
http://softwareswirl.blogspot.com/
