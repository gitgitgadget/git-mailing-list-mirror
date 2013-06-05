From: Felipe Contreras <felipe.contreras@gmail.com>
Subject: Re: [Administrivia] On ruby and contrib/
Date: Wed, 5 Jun 2013 09:30:55 -0500
Message-ID: <CAMP44s2VToROGXTz57GgT1sLuZDRhx3wpQMwQDTi-c7migTgrA@mail.gmail.com>
References: <7vtxld30f2.fsf@alter.siamese.dyndns.org>
	<7va9n52zjc.fsf@alter.siamese.dyndns.org>
	<alpine.DEB.2.02.1306041954360.2900@nftneq.ynat.uz>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org,
	Jeff King <peff@peff.net>,
	Jonathan Nieder <jrnieder@gmail.com>,
	Thomas Rast <trast@inf.ethz.ch>,
	=?UTF-8?Q?Ren=C3=A9_Scharfe?= <rene.scharfe@lsrfire.ath.cx>,
	Michael Haggerty <mhagger@alum.mit.edu>,
	Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>,
	=?UTF-8?B?Tmd1ecKtbiBUaMOhaSBOZ8O3YyBEdXk=?= <pclouds@gmail.com>,
	Ramsay Jones <ramsay@ramsay1.demon.co.uk>,
	Erik Faye-Lund <kusmabite@gmail.com>,
	Johannes Sixt <j6t@kdbg.org>,
	Johannes Schindelin <johannes.schindelin@gmx.de>
To: David Lang <david@lang.hm>
X-From: git-owner@vger.kernel.org Wed Jun 05 16:31:05 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UkEjv-0008JO-E0
	for gcvg-git-2@plane.gmane.org; Wed, 05 Jun 2013 16:31:03 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756122Ab3FEOa7 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 5 Jun 2013 10:30:59 -0400
Received: from mail-la0-f48.google.com ([209.85.215.48]:38234 "EHLO
	mail-la0-f48.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755594Ab3FEOa6 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 5 Jun 2013 10:30:58 -0400
Received: by mail-la0-f48.google.com with SMTP id lx15so488170lab.21
        for <git@vger.kernel.org>; Wed, 05 Jun 2013 07:30:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        bh=3H5zQIrTq5x5fSJNuYZF1msLjef9+AuwgQvPOga3Vv8=;
        b=DrNVp2REAIsIRbHjrZF5giU2D8YqX4ojikDTQFuA6Ch7Q/CYDq0/eYlD1j1+OXrmt9
         xV1baqXxd2oTsJtUqWVA2ckX27HRrRQ1Ns3xDl+/fksLr00L+TtMu0VAIKFveO764gzD
         X5JH7O7DPos6tHbdW9f3ubJVO6dIZkEy1p9hoAIk0NsWd8HaO2DnfyvxsS/YAUe85+WF
         oxyWhQx6dhaiBTowq09Hvy0JJknPWPpfMIHlBGZuk8+v/zqiZZYzJfr2R8KgH/MHexQk
         vLVhdP97i7/HQ41O51nOqVEct/fwb7PYotWpjweVyeofWlrmk8kNRPiN7Q1FwkW8f+qi
         klfw==
X-Received: by 10.152.9.69 with SMTP id x5mr7216215laa.57.1370442656489; Wed,
 05 Jun 2013 07:30:56 -0700 (PDT)
Received: by 10.114.59.202 with HTTP; Wed, 5 Jun 2013 07:30:55 -0700 (PDT)
In-Reply-To: <alpine.DEB.2.02.1306041954360.2900@nftneq.ynat.uz>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/226449>

On Tue, Jun 4, 2013 at 10:02 PM, David Lang <david@lang.hm> wrote:
> On Tue, 4 Jun 2013, Junio C Hamano wrote:
>
>> Junio C Hamano <gitster@pobox.com> writes:
>>
>>
>> On Ruby:
>>
>> Assuming "related" is a good idea, to make it as the proper part of
>> the system out of contrib/ when its design review phase is finished,
>> one of these things has to happen:
>>
>> 1. Find a volunteer to rewrite it in one of the languages that we
>>    know the platforms our current users use already support, which
>>    means either C (not a good match), POSIX shell (not the best
>>    match), or Perl.
>>
>> 2. Promote Ruby to the first-class citizen status, which involves
>>    making sure people on platforms that matter do not have problem
>>    adding dependency on it (I am primarily worried about MinGW
>>    folks), and also making sure core developers do not mind
>>    reviewing code written in it.
>>
>> As long as we can get as high quality reviews on changes written in
>> Ruby as we do for the current codebase, it is OK to go route #2, and
>> that may hopefully happen in the longer term as and there will be
>> some people, among competent Ruby programmers, who have understood
>> how the pieces of entire Git are designed to fit together by the
>> time it happens.
>>
>> I however do not know how much extra burden it would place to add
>> dependencies to platform folks, so obviously the safer approach is 1
>> at least in the immediate future.  My understanding is that msysgit
>> folks are already having trouble with Python, and we do not want to
>> go route #2 at least for now.  Having to ship a variant of Git with
>> NO_PYTHON is already bad enough.  And that is why the option 1 above
>> does not list Python as a possible candidate.
>
>
> As someone who builds minimalist builds (firewalls, openwrt, raspberry pi,
> etc), having to pull in a full ruby install to get git installed would not
> be something I'd like to see.

You wouldn't _have_ to, just like you don't _have_ to install Python right now.

-- 
Felipe Contreras
