From: Jens Lehmann <Jens.Lehmann@web.de>
Subject: Re: [PATCH] Make 'git submodule update --force' always check out
 submodules.
Date: Thu, 23 Aug 2012 20:51:52 +0200
Message-ID: <50367BC8.3090902@web.de>
References: <20120822233610.710C01C2DAF@stefro.sfo.corp.google.com> <7v8vd65qob.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: Stefan Zager <szager@google.com>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Aug 23 20:52:23 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1T4cVy-0005Ra-Bh
	for gcvg-git-2@plane.gmane.org; Thu, 23 Aug 2012 20:52:22 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S934204Ab2HWSwO (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 23 Aug 2012 14:52:14 -0400
Received: from mout.web.de ([212.227.17.11]:55190 "EHLO mout.web.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S934199Ab2HWSwL (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 23 Aug 2012 14:52:11 -0400
Received: from [192.168.178.41] ([79.193.90.245]) by smtp.web.de (mrweb001)
 with ESMTPA (Nemesis) id 0MFtKQ-1Spiob1lAM-00FI9N; Thu, 23 Aug 2012 20:52:01
 +0200
User-Agent: Mozilla/5.0 (X11; Linux i686 on x86_64; rv:14.0) Gecko/20120713 Thunderbird/14.0
In-Reply-To: <7v8vd65qob.fsf@alter.siamese.dyndns.org>
X-Provags-ID: V02:K0:qOlqzjR1OuwmsCHWF/88XEbANk/JywQoYyCgDLvJzlD
 vXZsfY31N4mZpU3Hh/YSBbwzBwU70q3bLlrrSv0+eghx9kf+mS
 IKpzhMgiu+J9ew0+kmo0LLc0YR5bGBUtQpc47WX2tGEm3FZb/o
 Wd5rgo0d0D2NHuNIeWz6jMpdtlpKIqG7MBn/ezhpOy/o6XoNBb
 WuuWv6np4GFFTu9cDuM0Q==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/204164>

Am 23.08.2012 03:43, schrieb Junio C Hamano:
> Stefan Zager <szager@google.com> writes:
> 
>> Currently, it will only do a checkout if the sha1 registered in the containing
>> repository doesn't match the HEAD of the submodule, regardless of whether the
>> submodule is dirty.  As discussed on the mailing list, the '--force' flag is a
>> strong indicator that the state of the submodule is suspect, and should be reset
>> to HEAD.
>>
>> Signed-off-by: Stefan Zager <szager@google.com>
>> ---
> 
> Thanks for a reroll.  Will queue; looking good ;-)

Yup, nicely done!
