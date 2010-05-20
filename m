From: Matthias Moeller <matthias.moeller@math.tu-dortmund.de>
Subject: Re: Git, Mac OS X and German special characters
Date: Thu, 20 May 2010 11:16:09 +0200
Message-ID: <4BF4FDD9.9090500@math.tu-dortmund.de>
References: <4BF4E40B.30205@math.tu-dortmund.de> <AANLkTimYgkv6q6fTXqNOCq1ZbodxgCZ18Fum_NryyiO8@mail.gmail.com> <4BF4F7D7.60002@drmicha.warpmail.net>
Reply-To: matthias.moeller@math.tu-dortmund.de
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Cc: =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>,
	git@vger.kernel.org
To: Michael J Gruber <git@drmicha.warpmail.net>
X-From: git-owner@vger.kernel.org Thu May 20 11:16:22 2010
connect(): No such file or directory
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OF1ra-00053B-0w
	for gcvg-git-2@lo.gmane.org; Thu, 20 May 2010 11:16:22 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754813Ab0ETJQQ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 20 May 2010 05:16:16 -0400
Received: from nx5.HRZ.Uni-Dortmund.DE ([129.217.131.21]:29947 "EHLO
	nx5.hrz.uni-dortmund.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754639Ab0ETJQQ (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 20 May 2010 05:16:16 -0400
Received: from mathematik.uni-dortmund.de (Hermes.mathematik.uni-dortmund.de [129.217.151.250])
	by nx5.hrz.uni-dortmund.de (Postfix) with ESMTP id E68B812D80;
	Thu, 20 May 2010 11:16:14 +0200 (MET DST)
Received: from [129.217.151.146] (starbuck [129.217.151.146])
	by mathematik.uni-dortmund.de (8.13.8+Sun/8.13.8) with ESMTP id o4K9GEPZ001443;
	Thu, 20 May 2010 11:16:14 +0200 (CEST)
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.9.1.9) Gecko/20100317 SUSE/3.0.4-2.3 Lightning/1.0b1 Thunderbird/3.0.4
In-Reply-To: <4BF4F7D7.60002@drmicha.warpmail.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/147369>

On 05/20/2010 10:50 AM, Michael J Gruber wrote:
>
>> Is this problem particular to Git, or do you also get it if you
>> e.g. rsync from the Linux box to the Mac OS X box?
>>     
> No, the problem with git status is not the display. Matthias' problem is
> that git status reports a tracked file as untracked. The reason is that
> on HFS+, you create a file with name A and get a file with name B, where
> A and B are different representations of the same name. There seems to
> be no way to reliably detect which one HFS+ uses.
>   

Yes, the problem is not the display but the filesystem. I had similar
problems with unison some time ago.
But there was a special fix for utf-8 and Mac OS X in one of the newer
unison versions.

Matthias
