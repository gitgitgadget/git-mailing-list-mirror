From: David Kastrup <dak@gnu.org>
Subject: Re: [PATCH v1 04/25] contrib: remove 'buildsystems'
Date: Fri, 09 May 2014 11:17:38 +0200
Message-ID: <8761lfnwel.fsf@fencepost.gnu.org>
References: <1399597116-1851-1-git-send-email-felipe.contreras@gmail.com>
	<1399597116-1851-5-git-send-email-felipe.contreras@gmail.com>
	<CABPQNSYZ4eWS_9_omZGK5wCD7ap_siEkC10e4ayT8Jp9w1bOSw@mail.gmail.com>
	<536c8e63448c2_25d198d30c55@nysa.notmuch>
	<CABPQNSYgfUdtfT0sYCwGsWQgW3QFOZvSZSyG76dmF6+ZSMaByw@mail.gmail.com>
	<536c966cf0e9c_2bf0e952f079@nysa.notmuch>
Mime-Version: 1.0
Content-Type: text/plain
Cc: Erik Faye-Lund <kusmabite@gmail.com>,
	GIT Mailing-list <git@vger.kernel.org>,
	Junio C Hamano <gitster@pobox.com>,
	Marius Storm-Olsen <mstormo@gmail.com>
To: Felipe Contreras <felipe.contreras@gmail.com>
X-From: git-owner@vger.kernel.org Fri May 09 11:17:48 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Wigw7-0005Y0-Mq
	for gcvg-git-2@plane.gmane.org; Fri, 09 May 2014 11:17:48 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756616AbaEIJRm (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 9 May 2014 05:17:42 -0400
Received: from fencepost.gnu.org ([208.118.235.10]:52839 "EHLO
	fencepost.gnu.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756338AbaEIJRj (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 9 May 2014 05:17:39 -0400
Received: from localhost ([127.0.0.1]:51881 helo=lola)
	by fencepost.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dak@gnu.org>)
	id 1Wigvy-0001WI-DM; Fri, 09 May 2014 05:17:38 -0400
Received: by lola (Postfix, from userid 1000)
	id 135BDE07B8; Fri,  9 May 2014 11:17:38 +0200 (CEST)
In-Reply-To: <536c966cf0e9c_2bf0e952f079@nysa.notmuch> (Felipe Contreras's
	message of "Fri, 09 May 2014 03:48:44 -0500")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.4.50 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/248540>

Felipe Contreras <felipe.contreras@gmail.com> writes:

> Erik Faye-Lund wrote:
>> On Fri, May 9, 2014 at 10:14 AM, Felipe Contreras
>> <felipe.contreras@gmail.com> wrote:
>> > If you want this script to remain in contrib, please:
>> >
>> >  a) Write at least a few tests
>> >  b) Write some documentation
>> >  c) Explain why it cannot live outside the git.git repository like other
>> >     tools. [1][2][3]
>> 
>> (Adding Marius, the original author to the CC-list)
>> 
>> Uh, why is such a burden required all of a sudden? contrib/README
>> mentions no such requirements, and the scripts have been accepted (and
>> maintained) since.
>
> contrib/README mentions clearly the expectation that these scripts
> eventually move to the core once they mature. This is never going to
> happen for these.
>
> It also mentions that inactive ones would be proposed for removal, and
> this one is clearly inactive. It has 9 commits (if you count the one
> that changes the execution bit).
>
>> Besides, you say "No activity since 2010" - this is not the case,
>> bc380fc is from November 2013.
>
> You think changing the execution bit of a file is considered "activity"?

For an indication of "this software has actual users", it definitely
would count as such, yes.  Why would someone change the executable bit
if it did not impact his usage of the software?

The idea of removing software from distribution is to get rid of stuff
without a user base rather than punishing lazy developers.

If it were the latter, then you could argue that anybody not willing to
host his own repository should get thrown off Git's.  That would solve
the whole contrib "problem" in one fell swoop.

-- 
David Kastrup
