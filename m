From: David Kastrup <dak@gnu.org>
Subject: Re: [PATCH] Make the global packed_git variable static to sha1_file.c.
Date: Wed, 12 Feb 2014 19:53:12 +0100
Message-ID: <87txc488o7.fsf@fencepost.gnu.org>
References: <20140212015727.1D63A403D3@wince.sfo.corp.google.com>
	<52FB22F3.8070100@gmail.com>
	<CAHOQ7J-2BkQOr+_BF42ja4pWaUWkt8OC-YE0ETwHAYsmrubi=A@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: Chris Packham <judge.packham@gmail.com>,
	Git Mailing List <git@vger.kernel.org>
To: Stefan Zager <szager@google.com>
X-From: git-owner@vger.kernel.org Wed Feb 12 19:53:23 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WDevv-00022m-3v
	for gcvg-git-2@plane.gmane.org; Wed, 12 Feb 2014 19:53:19 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753522AbaBLSxO (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 12 Feb 2014 13:53:14 -0500
Received: from fencepost.gnu.org ([208.118.235.10]:56398 "EHLO
	fencepost.gnu.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752699AbaBLSxO (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 12 Feb 2014 13:53:14 -0500
Received: from localhost ([127.0.0.1]:55439 helo=lola)
	by fencepost.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dak@gnu.org>)
	id 1WDevp-0001y5-0J; Wed, 12 Feb 2014 13:53:13 -0500
Received: by lola (Postfix, from userid 1000)
	id 80C47E047A; Wed, 12 Feb 2014 19:53:12 +0100 (CET)
In-Reply-To: <CAHOQ7J-2BkQOr+_BF42ja4pWaUWkt8OC-YE0ETwHAYsmrubi=A@mail.gmail.com>
	(Stefan Zager's message of "Wed, 12 Feb 2014 10:26:22 -0800")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3.50 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/242010>

Stefan Zager <szager@google.com> writes:

> On Tue, Feb 11, 2014 at 11:29 PM, Chris Packham <judge.packham@gmail.com> wrote:
>> Hi,
>>
>> On 12/02/14 14:57, Stefan Zager wrote:
>>> From b4796d9d99c03b0b7cddd50808a41413e45f1129 Mon Sep 17 00:00:00 2001
>>> From: Stefan Zager <szager@chromium.org>
>>> Date: Mon, 10 Feb 2014 16:55:12 -0800
>>> Subject: [PATCH] Make the global packed_git variable static to sha1_file.c.
>>
>> I'm not really qualified to comment on substance but there are some
>> basic style issues w.r.t. whitespace namely using 4 spaces for indent
>> and mixing tabs/spaces. This might seem pedantic for the first round of
>> a patch but it does put off reviewers.
>>
>> From Documentation/CodingGuidelines:
>>
>>  - We use tabs to indent, and interpret tabs as taking up to
>>    8 spaces.
>
> My bad, I will upload a fixed patch.  In my defense: I edited the code
> in emacs and then ran "M-x tabify" over the entire file.  But that had
> the unfortunate side effect of adding a bunch of whitespace-only
> changes to the diff, illuminating the fact that there is already mixed
> whitespace in the existing code.  So I had to go back and selectively
> tabify my changes, and I clearly missed a bunch.
>
> If anyone has a recommendation for a less labor-intensive way to do
> this in emacs, I'd be very grateful.

C-c . RET linux RET before entering any changes.

-- 
David Kastrup
