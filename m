From: Stephen Bannasch <stephen.bannasch@deanbrook.org>
Subject: Re: touching a file causes it to be listed using git diff-files
Date: Thu, 14 Jan 2010 00:57:05 -0500
Message-ID: <p06240813c77462aa2cfb@[63.138.152.134]>
References: <p0624080ec7740ddc4caf@[63.138.152.134]> <20100114030204.GB1878@coredump.intra.peff.net>
 <p06240810c774498d4a2e@[63.138.152.134]> <20100114052658.GA13973@coredump.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Cc: git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Thu Jan 14 06:57:20 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NVIhr-0002vF-07
	for gcvg-git-2@lo.gmane.org; Thu, 14 Jan 2010 06:57:19 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755866Ab0ANF5O (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 14 Jan 2010 00:57:14 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755458Ab0ANF5O
	(ORCPT <rfc822;git-outgoing>); Thu, 14 Jan 2010 00:57:14 -0500
Received: from deanbrook.org ([72.52.70.192]:54740 "HELO deanbrook.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1755312Ab0ANF5N (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 14 Jan 2010 00:57:13 -0500
Received: from ::ffff:71.123.114.34 ([71.123.114.34]) by deanbrook.org for <git@vger.kernel.org>; Wed, 13 Jan 2010 21:57:12 -0800
In-Reply-To: <20100114052658.GA13973@coredump.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/136952>

At 12:26 AM -0500 1/14/10, Jeff King wrote:
>On Thu, Jan 14, 2010 at 12:01:46AM -0500, Stephen Bannasch wrote:
>
>> Do you know if there is a plumbing command that will stat all of the
>> files without listing the files that actually do need updating?
>>
>> In the case where file1 has been only touched but file2 has been
>> changed (and both are tracked) I'd like to stat both filesand then run
>> diff-files as plumbing to see that only file2 has been changed in the
>> working directory.
>
>Judging from the scripts in git itself, I think the recommended practice
>is to simply "git update-index --refresh -q >/dev/null".
>
>> 'git diff' also stats the files but strangely 'git diff --quiet' doesn't ???
>
>I can't reproduce that behavior here on the current "master". Old
>versions of git used to not do the index refresh for "diff". What
>version of git are you using?

The most recent test was on:

$ git --version
git version 1.6.6
