From: Max Horn <max@quendi.de>
Subject: Re: rebase: strange failures to apply patc 3-way
Date: Fri, 8 Mar 2013 18:35:46 +0100
Message-ID: <205D17C4-F737-46E9-BC48-D16D5948C707@quendi.de>
References: <7A483B92-D671-46CA-9EFD-83C6F4C97B5E@quendi.de> <494292C5-EBD9-487B-8846-9D9DD23ACB83@quendi.de> <CADeaMWp_R0HLwEYn7O3oX4-0OoSeqLfzz_2AYXT-Po88nM4HkQ@mail.gmail.com>
Mime-Version: 1.0 (1.0)
Content-Type: text/plain;
	charset=us-ascii
Content-Transfer-Encoding: 8BIT
Cc: "git@vger.kernel.org" <git@vger.kernel.org>
To: Andrew Wong <andrew.kw.w@gmail.com>
X-From: git-owner@vger.kernel.org Fri Mar 08 18:36:25 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UE1DS-0004xV-Mj
	for gcvg-git-2@plane.gmane.org; Fri, 08 Mar 2013 18:36:23 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S934452Ab3CHRf5 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 8 Mar 2013 12:35:57 -0500
Received: from wp256.webpack.hosteurope.de ([80.237.133.25]:56794 "EHLO
	wp256.webpack.hosteurope.de" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S933140Ab3CHRf4 convert rfc822-to-8bit
	(ORCPT <rfc822;git@vger.kernel.org>); Fri, 8 Mar 2013 12:35:56 -0500
Received: from [82.113.106.151] (helo=[10.52.145.151]); authenticated
	by wp256.webpack.hosteurope.de running ExIM with esmtpsa (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	id 1UE1Cy-00009c-He; Fri, 08 Mar 2013 18:35:53 +0100
In-Reply-To: <CADeaMWp_R0HLwEYn7O3oX4-0OoSeqLfzz_2AYXT-Po88nM4HkQ@mail.gmail.com>
X-Mailer: iPhone Mail (10B146)
X-bounce-key: webpack.hosteurope.de;max@quendi.de;1362764156;871bb092;
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/217671>



Am 08.03.2013 um 16:32 schrieb Andrew Wong <andrew.kw.w@gmail.com>:

> On 3/8/13, Max Horn <max@quendi.de> wrote:
>> All in all, I suspect that Mac OS X and/or the filesystem (HFS+ with
>> journaling, not case sensitive (the default)) might be at fault. Still, this
>> is quite puzzling and annoying, and so I still wonder if anybody has any
>> insights on this.
> 
> When "rebase" errors out at COMMIT A, try manually running "git apply"
> on the patch file (rebase-apply/patch) a couple times, and see if the
> error occurs randomly. You'd have to do a "reset --hard" to revert the
> changes done by "git apply" every time before you run it again. The
> error from "git apply" might shed more light on the issue.

I tried this a dozen times, but 'git apply' failed to fail even once. No surprise there, given that the patch that throws off rebase every time is clean and simple. I am flabbergasted :-(
