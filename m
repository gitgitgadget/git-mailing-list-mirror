From: Ramsay Jones <ramsay@ramsayjones.plus.com>
Subject: Re: [PATCH v4 3/4] Provide a dirname() function when
 NO_LIBGEN_H=YesPlease
Date: Wed, 13 Jan 2016 16:44:37 +0000
Message-ID: <56967EF5.60202@ramsayjones.plus.com>
References: <cover.1452536924.git.johannes.schindelin@gmx.de>
 <cover.1452585382.git.johannes.schindelin@gmx.de>
 <04a7a497f9a5771d4dbf5fd605f138607b2bae0a.1452585382.git.johannes.schindelin@gmx.de>
 <5695A077.7070606@ramsayjones.plus.com>
 <alpine.DEB.2.20.1601130838430.2964@virtualbox>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org,
	Eric Sunshine <sunshine@sunshineco.com>
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Wed Jan 13 17:45:05 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aJOXf-0007r8-JB
	for gcvg-git-2@plane.gmane.org; Wed, 13 Jan 2016 17:45:03 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754333AbcAMQo6 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 13 Jan 2016 11:44:58 -0500
Received: from avasout04.plus.net ([212.159.14.19]:35729 "EHLO
	avasout04.plus.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754235AbcAMQos (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 13 Jan 2016 11:44:48 -0500
Received: from [10.0.2.15] ([46.208.159.221])
	by avasout04 with smtp
	id 5Ukj1s0074mu3xa01UkkJ1; Wed, 13 Jan 2016 16:44:46 +0000
X-CM-Score: 0.00
X-CNFS-Analysis: v=2.1 cv=CvRCCSMD c=1 sm=1 tr=0
 a=Sp5fw55EgyGSOjouSGNDoQ==:117 a=Sp5fw55EgyGSOjouSGNDoQ==:17 a=0Bzu9jTXAAAA:8
 a=L9H7d07YOLsA:10 a=9cW_t1CCXrUA:10 a=s5jvgZ67dGcA:10 a=EBOSESyhAAAA:8
 a=N659UExz7-8A:10 a=16BUaPhH4yHWLPlnF70A:9 a=pILNOxqGKmIA:10
X-AUTH: ramsayjones@:2500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:38.0) Gecko/20100101
 Thunderbird/38.4.0
In-Reply-To: <alpine.DEB.2.20.1601130838430.2964@virtualbox>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/283930>



On 13/01/16 07:40, Johannes Schindelin wrote:
> Hi Ramsay,
> 
> On Wed, 13 Jan 2016, Ramsay Jones wrote:
> 
>> Also, when compiling on Cygwin with NO_LIBGEN_H, I need to
>> include the following here:
>>
>> #undef basename
>>
>> in order to suppress approx 230 warnings about the redefinition
>> of the basename macro.
>>
>> (I suppose that should go in the previous commit. dunno)
> 
> I think this is an incorrect use of NO_LIBGEN_H (because Cygwin obviously
> has it), but in any case, it is a completely independent issue from
> fixing/testing basename()/dirname(), so your #undef basename should be in
> a completely separate commit, methinks.

OK. I think this worked fine on 32-bit cygwin, but the system headers
have changed quite a bit on 64-bit cygwin and I only tried it for the
first time yesterday. (It was helpful in the debugging process at one
point to be able to build with NO_LIBGEN_H on all platforms ...)

ATB,
Ramsay Jones
