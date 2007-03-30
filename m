From: merlyn@stonehenge.com (Randal L. Schwartz)
Subject: Re: [PATCH] mergetool: Clean up description of files and prompts  for merge resolutions
Date: Fri, 30 Mar 2007 07:46:47 -0700
Message-ID: <86648ikcvc.fsf@blue.stonehenge.com>
References: <11751830653554-git-send-email-tytso@mit.edu>
	<11751830652230-git-send-email-tytso@mit.edu>
	<20070329222905.GA25347@moooo.ath.cx>
	<20070330025411.GD3198@thunk.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Matthias Lederhofer <matled@gmx.net>, git@vger.kernel.org
To: Theodore Tso <tytso@mit.edu>
X-From: git-owner@vger.kernel.org Fri Mar 30 16:47:03 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HXINa-0001Sb-4A
	for gcvg-git@gmane.org; Fri, 30 Mar 2007 16:47:02 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751597AbXC3Oqs (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 30 Mar 2007 10:46:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752625AbXC3Oqs
	(ORCPT <rfc822;git-outgoing>); Fri, 30 Mar 2007 10:46:48 -0400
Received: from blue.stonehenge.com ([209.223.236.162]:13207 "EHLO
	blue.stonehenge.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751597AbXC3Oqs (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 30 Mar 2007 10:46:48 -0400
Received: by blue.stonehenge.com (Postfix, from userid 1001)
	id 69C981DE3B1; Fri, 30 Mar 2007 07:46:47 -0700 (PDT)
x-mayan-date: Long count = 12.19.14.3.7; tzolkin = 4 Manik; haab = 0 Uayeb
In-Reply-To: <20070330025411.GD3198@thunk.org> (Theodore Tso's message of "Thu, 29 Mar 2007 22:54:11 -0400")
User-Agent: Gnus/5.1008 (Gnus v5.10.8) Emacs/21.4 (berkeley-unix)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

>>>>> "Theodore" == Theodore Tso <tytso@mit.edu> writes:

Theodore> On Fri, Mar 30, 2007 at 12:29:05AM +0200, Matthias Lederhofer wrote:
>> Theodore Ts'o <tytso@mit.edu> wrote:
>> > +    printf "  {$branch}: "
>> This should use %s too.

Theodore> It's strictly not necessary since $branch is either "local" or "remote".

... this week. :)

Best to be safe, and provide a good model for later cut-n-pasters, I've
always said.

-- 
Randal L. Schwartz - Stonehenge Consulting Services, Inc. - +1 503 777 0095
<merlyn@stonehenge.com> <URL:http://www.stonehenge.com/merlyn/>
Perl/Unix/security consulting, Technical writing, Comedy, etc. etc.
See PerlTraining.Stonehenge.com for onsite and open-enrollment Perl training!
