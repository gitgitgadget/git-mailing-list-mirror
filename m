From: Max Horn <max@quendi.de>
Subject: Re: rebase: strange failures to apply patc 3-way
Date: Fri, 8 Mar 2013 19:47:15 +0100
Message-ID: <B21B6CEC-7507-47A1-9BBB-FB95EA6B831F@quendi.de>
References: <7A483B92-D671-46CA-9EFD-83C6F4C97B5E@quendi.de> <494292C5-EBD9-487B-8846-9D9DD23ACB83@quendi.de> <CADeaMWp_R0HLwEYn7O3oX4-0OoSeqLfzz_2AYXT-Po88nM4HkQ@mail.gmail.com> <205D17C4-F737-46E9-BC48-D16D5948C707@quendi.de> <CADgNjan9v++__TSPE55j7+=BBZrVEkMD52O+9kXAm-C8SRV+Ww@mail.gmail.com>
Mime-Version: 1.0 (1.0)
Content-Type: text/plain;
	charset=us-ascii
Content-Transfer-Encoding: 7bit
Cc: "git@vger.kernel.org" <git@vger.kernel.org>
To: Andrew Wong <andrew.kw.w@gmail.com>
X-From: git-owner@vger.kernel.org Fri Mar 08 19:47:46 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UE2KX-0001x1-50
	for gcvg-git-2@plane.gmane.org; Fri, 08 Mar 2013 19:47:45 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1760014Ab3CHSrT (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 8 Mar 2013 13:47:19 -0500
Received: from wp256.webpack.hosteurope.de ([80.237.133.25]:49546 "EHLO
	wp256.webpack.hosteurope.de" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1759575Ab3CHSrS (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 8 Mar 2013 13:47:18 -0500
Received: from [82.113.98.172] (helo=[10.55.203.172]); authenticated
	by wp256.webpack.hosteurope.de running ExIM with esmtpsa (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	id 1UE2K4-00086c-QU; Fri, 08 Mar 2013 19:47:16 +0100
In-Reply-To: <CADgNjan9v++__TSPE55j7+=BBZrVEkMD52O+9kXAm-C8SRV+Ww@mail.gmail.com>
X-Mailer: iPhone Mail (10B146)
X-bounce-key: webpack.hosteurope.de;max@quendi.de;1362768438;eb9375e0;
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/217677>



Am 08.03.2013 um 19:02 schrieb Andrew Wong <andrew.kw.w@gmail.com>:

> On 3/8/13, Max Horn <max@quendi.de> wrote:
>> I tried this a dozen times, but 'git apply' failed to fail even once. No
>> surprise there, given that the patch that throws off rebase every time is
>> clean and simple. I am flabbergasted :-(
> 
> Hm, what if you add in the "--index" flag? i.e.
>    git apply --index .git/rebase-apply/patch
> 
> Wonder if that makes any difference...

Same result, it works fine.
