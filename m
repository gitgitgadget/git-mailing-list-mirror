From: Johannes Sixt <j6t@kdbg.org>
Subject: Re: What's cooking in git.git (Apr 2014, #01; Fri, 4)
Date: Mon, 07 Apr 2014 20:35:00 +0200
Message-ID: <5342EFD4.6020007@kdbg.org>
References: <xmqq4n28q0ad.fsf@gitster.dls.corp.google.com> <533FCA92.8060006@kdbg.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org,
	=?UTF-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41jIER1eQ==?= 
	<pclouds@gmail.com>, Stefan Zager <szager@chromium.org>,
	=?UTF-8?B?VG9ycw==?= =?UTF-8?B?dGVuIELDtmdlcnNoYXVzZW4=?= 
	<tboegi@web.de>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon Apr 07 20:35:17 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WXEO3-0005eO-ND
	for gcvg-git-2@plane.gmane.org; Mon, 07 Apr 2014 20:35:16 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755561AbaDGSfI (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 7 Apr 2014 14:35:08 -0400
Received: from bsmtp3.bon.at ([213.33.87.17]:35503 "EHLO bsmtp.bon.at"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S1755161AbaDGSfH (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 7 Apr 2014 14:35:07 -0400
Received: from dx.sixt.local (unknown [93.83.142.38])
	by bsmtp.bon.at (Postfix) with ESMTP id CE8AECDF8E;
	Mon,  7 Apr 2014 20:35:02 +0200 (CEST)
Received: from dx.sixt.local (localhost [IPv6:::1])
	by dx.sixt.local (Postfix) with ESMTP id BD5E019F40F;
	Mon,  7 Apr 2014 20:35:01 +0200 (CEST)
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:24.0) Gecko/20100101 Thunderbird/24.3.0
In-Reply-To: <533FCA92.8060006@kdbg.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/245872>

Am 05.04.2014 11:19, schrieb Johannes Sixt:
> Am 04.04.2014 22:58, schrieb Junio C Hamano:
>> * sz/mingw-index-pack-threaded (2014-03-19) 1 commit
>>  - Enable index-pack threading in msysgit.
>>
>>  What is the status of this topic?  A failure report exists
>>  ($gmane/245170), and I am aware of Duy's $gmane/245034 but that was
>>  where the discussion stalled.  Is everybody waiting for everybody
>>  else to get the discussion unstuck?
> 
> I still have to cross-check Duy's patch. I'll hopefully get to it in the
> next days and report back.

The test suite passes with Duy's patch ($gmane/245034), but t5302 fails
with this patch with a MinGW build. The patches touch the Cygwin
configuration, but I cannot test a Cygwin build.

I have, however, lost track of what the objective of these patches is.
Is the threaded version significantly faster, and these patches are
worth it?

-- Hannes
