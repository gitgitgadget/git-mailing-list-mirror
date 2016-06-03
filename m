From: Michael Haggerty <mhagger@alum.mit.edu>
Subject: Re: [PATCH v2 00/13] Reference iterators
Date: Fri, 3 Jun 2016 23:55:11 +0200
Message-ID: <5751FCBF.3070507@alum.mit.edu>
References: <cover.1464957077.git.mhagger@alum.mit.edu>
 <xmqqporyneik.fsf@gitster.mtv.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
Cc: David Turner <dturner@twopensource.com>,
	Ramsay Jones <ramsay@ramsayjones.plus.com>,
	Eric Sunshine <sunshine@sunshineco.com>,
	Jeff King <peff@peff.net>,
	=?UTF-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41jIER1eQ==?= 
	<pclouds@gmail.com>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sat Jun 04 00:02:34 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1b8x3w-0008Ds-N6
	for gcvg-git-2@plane.gmane.org; Fri, 03 Jun 2016 23:55:29 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752096AbcFCVzV (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 3 Jun 2016 17:55:21 -0400
Received: from alum-mailsec-scanner-6.mit.edu ([18.7.68.18]:54321 "EHLO
	alum-mailsec-scanner-6.mit.edu" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751814AbcFCVzU (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 3 Jun 2016 17:55:20 -0400
X-AuditID: 12074412-52fff700000009f7-21-5751fcc38652
Received: from outgoing-alum.mit.edu (OUTGOING-ALUM.MIT.EDU [18.7.68.33])
	by  (Symantec Messaging Gateway) with SMTP id E0.57.02551.3CCF1575; Fri,  3 Jun 2016 17:55:15 -0400 (EDT)
Received: from [192.168.69.130] (p548D60E2.dip0.t-ipconnect.de [84.141.96.226])
	(authenticated bits=0)
        (User authenticated as mhagger@ALUM.MIT.EDU)
	by outgoing-alum.mit.edu (8.13.8/8.12.4) with ESMTP id u53LtCEY005981
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES128-SHA bits=128 verify=NOT);
	Fri, 3 Jun 2016 17:55:13 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:38.0) Gecko/20100101
 Icedove/38.8.0
In-Reply-To: <xmqqporyneik.fsf@gitster.mtv.corp.google.com>
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFtrKKsWRmVeSWpSXmKPExsUixO6iqHv4T2C4wbdmHYv5m04wWnRd6Way
	aOi9wmzRPeUto8WPlh5mi5lXrS3OvGlkdGD32DnrLrvHs949jB4XLyl77F+6jc1j8QMvjwXP
	77N7fN4kF8AexW2TlFhSFpyZnqdvl8CdcWPuQpaCLawVc39MZGpgXMHSxcjJISFgItH05jgT
	iC0ksJVR4uf9Kgj7HJPEghlhILawgKHE5itLwWpEBNQkJrYdYoGoyZC4s/ELWxcjFwezwCwm
	iY6tFxlBEmwCuhKLepqBGjg4eAW0JV5PcAQJswioSPx4944VxBYVCJE4v24rmM0rIChxcuYT
	sJmcAtYSV3ffYAOxmQX0JHZc/8UKYctLbH87h3kCI/8sJC2zkJTNQlK2gJF5FaNcYk5prm5u
	YmZOcWqybnFyYl5eapGumV5uZoleakrpJkZIsAvtYFx/Uu4QowAHoxIPb8GzwHAh1sSy4src
	Q4ySHExKorx77wCF+JLyUyozEosz4otKc1KLDzFKcDArifC2/ATK8aYkVlalFuXDpKQ5WJTE
	eX8uVvcTEkhPLEnNTk0tSC2CycpwcChJ8Br8BmoULEpNT61Iy8wpQUgzcXCCDOeSEilOzUtJ
	LUosLcmIB8VjfDEwIkFSPEB7b/0C2VtckJgLFIVoPcWoy7Hgx+21TEIsefl5qVLivDdAigRA
	ijJK8+BWwFLbK0ZxoI+FefNALuEBpkW4Sa+AljABLSl45A+ypCQRISXVwGiqanpm397vT++/
	aZGo4f2X8nyBtXHpUbuYg/pbLJaZbThWtMz5jnzmPTtzmXYjJn17NX8TR9/Frfd4 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/296414>

On 06/03/2016 11:33 PM, Junio C Hamano wrote:
> Michael Haggerty <mhagger@alum.mit.edu> writes:
> 
>> This patch series applies on top of mh/split-under-lock. It can also
>> be obtained from my GitHub repo [2] as branch "ref-iterators".
> 
> Ah, that reminds me.  What's the doneness of the dependent topic?

If you mean the vtable implementation, check your inbox :-) I already
submitted it (38 patches, but most of them are straightforward). I've
been iterating on that patch series for quite a while so I'm pretty
confident that it's solid.

> The patches in this series looked all good to me.

Thanks for the review (and your patience), both David and Junio!

Michael
