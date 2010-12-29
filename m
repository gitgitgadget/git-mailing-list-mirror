From: Jens Lehmann <Jens.Lehmann@web.de>
Subject: Re: Re* [RFC/PATCH] Re: git submodule -b ... of current HEAD fails
Date: Wed, 29 Dec 2010 23:23:25 +0100
Message-ID: <4D1BB4DD.2000800@web.de>
References: <20101201171814.GC6439@ikki.ethgen.de> <20101201185046.GB27024@burratino> <7vipydwp50.fsf@alter.siamese.dyndns.org> <4D1A7B42.1050907@web.de> <7vlj39to1t.fsf@alter.siamese.dyndns.org> <4D1AF989.3000105@web.de> <7voc84s3ks.fsf_-_@alter.siamese.dyndns.org> <4D1BB26D.1010502@web.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: Jonathan Nieder <jrnieder@gmail.com>, git@vger.kernel.org,
	Klaus Ethgen <Klaus@Ethgen.de>,
	Sven Verdoolaege <skimo@kotnet.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Dec 29 23:23:42 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PY4Qn-0001SR-Uy
	for gcvg-git-2@lo.gmane.org; Wed, 29 Dec 2010 23:23:42 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753821Ab0L2WXh (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 29 Dec 2010 17:23:37 -0500
Received: from fmmailgate02.web.de ([217.72.192.227]:48485 "EHLO
	fmmailgate02.web.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753535Ab0L2WXh (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 29 Dec 2010 17:23:37 -0500
Received: from smtp07.web.de  ( [172.20.5.215])
	by fmmailgate02.web.de (Postfix) with ESMTP id 69CB5192D1E45;
	Wed, 29 Dec 2010 23:23:28 +0100 (CET)
Received: from [93.240.121.95] (helo=[192.168.178.53])
	by smtp07.web.de with asmtp (WEB.DE 4.110 #2)
	id 1PY4Qa-0002eo-00; Wed, 29 Dec 2010 23:23:28 +0100
User-Agent: Mozilla/5.0 (X11; U; Linux i686; de; rv:1.9.2.13) Gecko/20101207 Thunderbird/3.1.7
In-Reply-To: <4D1BB26D.1010502@web.de>
X-Sender: Jens.Lehmann@web.de
X-Provags-ID: V01U2FsdGVkX18XHEyQBDcx9ZdOX9gbdJBw35oLAAFeLhERvOHu
	8hCFqTzxFVLMk/0dLP5yX8JK621rv19tKJviUv+VfWdVHJQfzl
	Sc7q7maUR8Jj89Ny8qng==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/164336>

Am 29.12.2010 23:13, schrieb Jens Lehmann:
> Am 29.12.2010 21:53, schrieb Junio C Hamano:
>> Jens Lehmann <Jens.Lehmann@web.de> writes:
>>> So we maybe want to fix this issue in "git checkout"? Then the patch
>>> will start working (and the test for it can be added in a later patch).
>>
>> So in conclusion, here is a patch that is not even compile tested ;-)

Just for the record: It does compile (at least for me ;-) and together
with Jonathan's patch referenced in the the subject passes all tests,
including the new 'submodule add --branch succeeds even when branch is
at HEAD' test I came up with to verify this issue.
