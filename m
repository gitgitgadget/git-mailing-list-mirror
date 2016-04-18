From: Ramsay Jones <ramsay@ramsayjones.plus.com>
Subject: Re: Binary grep t7008 known breakage vanished on Cygwin
Date: Mon, 18 Apr 2016 18:08:15 +0100
Message-ID: <5715147F.7020609@ramsayjones.plus.com>
References: <20160418152149.GD2345@dinwoodie.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
Cc: Jonathan Nieder <jrnieder@gmail.com>,
	=?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>
To: Adam Dinwoodie <adam@dinwoodie.org>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Apr 18 19:08:28 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1asCew-0006xm-DU
	for gcvg-git-2@plane.gmane.org; Mon, 18 Apr 2016 19:08:26 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751741AbcDRRIW (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 18 Apr 2016 13:08:22 -0400
Received: from avasout08.plus.net ([212.159.14.20]:36088 "EHLO
	avasout08.plus.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751420AbcDRRIV (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 18 Apr 2016 13:08:21 -0400
Received: from [10.0.2.15] ([91.125.197.102])
	by avasout08 with smtp
	id jt8J1s0032D2Veb01t8KVh; Mon, 18 Apr 2016 18:08:19 +0100
X-CM-Score: 0.00
X-CNFS-Analysis: v=2.1 cv=O6PEx0JW c=1 sm=1 tr=0
 a=mTUfFwB0nGOO66Ym8a+i3w==:117 a=mTUfFwB0nGOO66Ym8a+i3w==:17
 a=L9H7d07YOLsA:10 a=9cW_t1CCXrUA:10 a=s5jvgZ67dGcA:10 a=N659UExz7-8A:10
 a=M-5hsdbU3hdTB7H6msAA:9 a=pILNOxqGKmIA:10
X-AUTH: ramsayjones@:2500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:38.0) Gecko/20100101
 Thunderbird/38.6.0
In-Reply-To: <20160418152149.GD2345@dinwoodie.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/291811>



On 18/04/16 16:21, Adam Dinwoodie wrote:
> t7008.12 is marked as an expected failure, but building Git on Cygwin
> including a `make configure && ./configure` step has the test
> unexpectedly passing.  Building without the configure step has the test
> failing as expected.
> 
> This appears to be behaviour specific to Cygwin; at least I get that
> test failing on my CentOS box regardless of whether I perform the
> configure step.

Yes, the configure sets NO_REGEX= whereas the config.mak.uname sets
NO_REGEX=UnfortunatelyYes.

[Note that the regex bug (see t0070-fundamental.sh test #5) now seems to
pass with the 'native' regex library]

ATB,
Ramsay Jones
