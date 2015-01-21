From: Johannes Schindelin <johannes.schindelin@gmx.de>
Subject: Re: [PATCH v2 11/18] fsck: Add a simple test for receive.fsck.*
Date: Wed, 21 Jan 2015 19:14:58 +0100
Organization: gmx
Message-ID: <8ddc1de7858a4bd79f5a945b8eb7b84c@www.dscho.org>
References: <xmqqr3w7gxr4.fsf@gitster.dls.corp.google.com>
 <cover.1421682369.git.johannes.schindelin@gmx.de>
 <ba5b133ec7dfad799107f041489f693022f0fcc8.1421682369.git.johannes.schindelin@gmx.de>
 <xmqqd268y0f2.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Jan 21 19:15:12 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YDzo7-0004E7-89
	for gcvg-git-2@plane.gmane.org; Wed, 21 Jan 2015 19:15:11 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752055AbbAUSPG (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 21 Jan 2015 13:15:06 -0500
Received: from mout.gmx.net ([212.227.17.22]:51606 "EHLO mout.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750917AbbAUSPE (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 21 Jan 2015 13:15:04 -0500
Received: from www.dscho.org ([87.106.4.80]) by mail.gmx.com (mrgmx103) with
 ESMTPSA (Nemesis) id 0LcBPV-1XURq22DAL-00jc9o; Wed, 21 Jan 2015 19:14:59
 +0100
In-Reply-To: <xmqqd268y0f2.fsf@gitster.dls.corp.google.com>
X-Sender: johannes.schindelin@gmx.de
User-Agent: Roundcube Webmail/1.1-git
X-Provags-ID: V03:K0:MW4qeXWdC6uVsXsrT3W7kx1CSbUrfS+NywhHhcSlQisIOBQyD0D
 UjsouIzKkmC/7Hfwd0LP07x88FHXRMcfxFxMa9CIgcQWNWikkeVqzCtYLqjs+sdHHQLKjUS
 r2oQ1oe488rGE2MPcUvUTizlRB8+5nTLuphR8Hhuj60U3itp4DhJEtH0pWVOFnNhpyM+vYq
 wBjBVqmkbW6ESkzSUqr6A==
X-UI-Out-Filterresults: notjunk:1;
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/262737>

Hi Junio,

On 2015-01-21 09:59, Junio C Hamano wrote:
> Johannes Schindelin <johannes.schindelin@gmx.de> writes:
> 
>> Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
>> ---
>>  t/t5504-fetch-receive-strict.sh | 20 ++++++++++++++++++++
>>  1 file changed, 20 insertions(+)
>>
>> diff --git a/t/t5504-fetch-receive-strict.sh b/t/t5504-fetch-receive-strict.sh
>> index 69ee13c..d491172 100755
>> --- a/t/t5504-fetch-receive-strict.sh
>> +++ b/t/t5504-fetch-receive-strict.sh
>> @@ -115,4 +115,24 @@ test_expect_success 'push with transfer.fsckobjects' '
>>  	test_cmp exp act
>>  '
>>
>> +cat >bogus-commit << EOF
> 
> "cat >bogus-commit <<\EOF", to reduce the mental burden of readers.

Certainly!
Dscho
