From: =?UTF-8?B?VG9yc3RlbiBCw7ZnZXJzaGF1c2Vu?= <tboegi@web.de>
Subject: Re: [RFC]  test-lib.sh: preprocess to use PERL_PATH
Date: Sat, 23 Jun 2012 07:26:10 +0200
Message-ID: <4FE55372.3080008@web.de>
References: <201206230704.38648.tboegi@web.de> <7vsjdmli06.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org,
	=?UTF-8?B?VG9yc3RlbiBCw7ZnZXJzaGF1c2Vu?= <tboegi@web.de>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sat Jun 23 07:26:19 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SiIrR-0006qw-Ex
	for gcvg-git-2@plane.gmane.org; Sat, 23 Jun 2012 07:26:17 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757058Ab2FWF0N convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sat, 23 Jun 2012 01:26:13 -0400
Received: from mout.web.de ([212.227.17.11]:63577 "EHLO mout.web.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751587Ab2FWF0M (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 23 Jun 2012 01:26:12 -0400
Received: from birne.lan ([194.22.188.61]) by smtp.web.de (mrweb003) with
 ESMTPA (Nemesis) id 0LpO8D-1SCFpE3ymT-00fbKp; Sat, 23 Jun 2012 07:26:10 +0200
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.6; rv:13.0) Gecko/20120614 Thunderbird/13.0.1
In-Reply-To: <7vsjdmli06.fsf@alter.siamese.dyndns.org>
X-Provags-ID: V02:K0:0s6/KEgZMYkp7zLqpfeddM6buc5iej0LHEhNYpBCwWt
 Mbe+OalUJZesSyh3j/yBFCJLkPJ7AAXs+nosGwgR1sgq3/n6kd
 OdLYb5j867rgbejXaon4FQnYG+Wbnhlobe4AlApKz3bAcnNsr0
 DWyekXABmarGCcNHwlSEm1l1MFxLdw8slN9kAc6I75R44hz3Gu
 mJ7Kuk0XCRxHVJJm3oRvQ==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/200492>

On 23.06.12 07:22, Junio C Hamano wrote:
> Torsten B=C3=B6gershausen <tboegi@web.de> writes:
>
>> All test cases found in t/*.sh must include test-lib instead of test=
-lib.sh
> Please don't.  That is too much churning for too little gain, I am af=
raid.
Ok, would it be better to rename

t/test-lib.sh -> t/test-lib.sh.sh

and let the Makefile generate t/test-lib.sh?
