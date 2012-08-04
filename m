From: =?ISO-8859-15?Q?Torsten_B=F6gershausen?= <tboegi@web.de>
Subject: Re: [PATCHv2 5/5] t3910: use the UTF8_NFD_TO_NFC test prereq
Date: Sat, 04 Aug 2012 07:37:49 +0200
Message-ID: <501CB52D.6080208@web.de>
References: <7vboj115as.fsf@alter.siamese.dyndns.org> <de831564718b0d52d6ba6e9cb13020defdbfa359.1343641675.git.git@drmicha.warpmail.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15; format=flowed
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
	Jeff King <peff@peff.net>, tboegi@web.de
To: Michael J Gruber <git@drmicha.warpmail.net>
X-From: git-owner@vger.kernel.org Sat Aug 04 07:38:42 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SxX4S-0006CL-9r
	for gcvg-git-2@plane.gmane.org; Sat, 04 Aug 2012 07:38:40 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751205Ab2HDFhy (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 4 Aug 2012 01:37:54 -0400
Received: from mout.web.de ([212.227.15.3]:55005 "EHLO mout.web.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751234Ab2HDFhx (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 4 Aug 2012 01:37:53 -0400
Received: from [192.168.1.37] ([193.213.18.4]) by smtp.web.de (mrweb103) with
 ESMTPSA (Nemesis) id 0MI63m-1Sumxu2ACE-0048IK; Sat, 04 Aug 2012 07:37:50
 +0200
User-Agent: Mozilla/5.0 (Windows NT 5.1; rv:14.0) Gecko/20120713 Thunderbird/14.0
In-Reply-To: <de831564718b0d52d6ba6e9cb13020defdbfa359.1343641675.git.git@drmicha.warpmail.net>
X-Provags-ID: V02:K0:s9aJ7nxL00/kaokfTcotoXEqZeZBdhKF+4/fIrRb+PQ
 B5qm89eaDE2flyuGOvU0LZ10u+6GNZQNbF3AaK5Nc3FcjP8r57
 gTYHyA3OEUm/JfrVo62J+LRjJPYpEmOcPScSgOznLyHsYjl0Fs
 Msgtvvuy0DZ0g2U1rmcHm7nC+E6HtzxD7eafYZVLZdcD2p38/u
 459KTUQo4AsUytvj5sm3A==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/202871>

Am 2012-07-30 11:57, schrieb Michael J Gruber:
(Sorry being late)

That line:
>skip_all="filesystem does not convert utf-8 nfd to nfc"

shouldn't it be the other way around?
skip_all="filesystem does not convert utf-8 nfc to nfd"

(and may be the following may be more easy to read:)
skip_all="filesystem does not decompose unicode"


Side note: t0050 uses another term:
"will test on a unicode corrupting filesystem"

/Torsten
