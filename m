From: =?ISO-8859-15?Q?Torsten_B=F6gershausen?= <tboegi@web.de>
Subject: Re: Cannot reset a repo
Date: Sat, 06 Dec 2014 13:14:36 +0100
Message-ID: <5482F32C.40709@web.de>
References: <5482DA16.4080509@wwWendt.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-15
Content-Transfer-Encoding: 7bit
To: Martin Wendt <martin17@wwWendt.de>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Dec 06 13:14:44 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XxEG4-0000px-7y
	for gcvg-git-2@plane.gmane.org; Sat, 06 Dec 2014 13:14:44 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752312AbaLFMOk (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 6 Dec 2014 07:14:40 -0500
Received: from mout.web.de ([212.227.15.14]:55594 "EHLO mout.web.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752465AbaLFMOk (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 6 Dec 2014 07:14:40 -0500
Received: from macce.local ([78.72.72.190]) by smtp.web.de (mrweb002) with
 ESMTPSA (Nemesis) id 0M5flQ-1Xm1253Nu4-00xf9l; Sat, 06 Dec 2014 13:14:37
 +0100
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.6; rv:31.0) Gecko/20100101 Thunderbird/31.2.0
In-Reply-To: <5482DA16.4080509@wwWendt.de>
X-Provags-ID: V03:K0:x2pmS91RJKYZ7vV3AgydyFAII2SMaJK7Eqej1KKpIEA7532ae29
 /P2fVvzHMUhpcyuTOxmi8oo+VAJ5yliYAx3/874ITwG1G1yRVh9ZKR2DFT2V0F5GbxCUt0g
 hd3JuS1YpOCJ+J4SD9KQytxci+HwoJllMvZKIDT6mXRfgqaOA6l7ue2/Qzm3KpWC/A6pSKd
 mTgyrMSR+/LzCf81AuBig==
X-UI-Out-Filterresults: notjunk:1;
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/260947>

On 2014-12-06 11.27, Martin Wendt wrote:
> Hi,
> 
> I am facing this problem:
> 
>   - Using git version 1.9.3 (Apple Git-50)
>   - cloned a fork from GitHub to my local machine:
> https://github.com/mar10/cdnjs/
>   - This repo seems to be broken in some way.
>     At least it is not clean from the beginning and I am not able to reset
>     `git reset --hard` only toggles the modified file from
> ".../sortable" to ".../Sortable" and back
>     (see attached screenshot)
> 
> Is this a known problem (with case sensitivity)? 
I think so
>Any suggestions how to  fix it?

Try to rename Sortable into Sortable.u:
git mv Sortable Sortable.upper
(When that does not work)
git mv sortable sortable.lower

If this is not an option, use a USB Stick, format it with HFS+ "case sensitive"
and clone the repo to the stick
