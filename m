From: =?ISO-8859-1?Q?Torsten_B=F6gershausen?= <tboegi@web.de>
Subject: Re: [PATCH] cleanup precompose_utf8
Date: Sun, 19 Aug 2012 19:10:03 +0200
Message-ID: <50311DEB.4050700@web.de>
References: <7v393mxkpk.fsf@alter.siamese.dyndns.org> <1345215190-95976-1-git-send-email-robin.rosenberg@dewire.com> <7vobm9v32e.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: Robin Rosenberg <robin.rosenberg@dewire.com>, tboegi@web.de,
	git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sun Aug 19 19:10:17 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1T390x-0006m4-FJ
	for gcvg-git-2@plane.gmane.org; Sun, 19 Aug 2012 19:10:15 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751979Ab2HSRKK (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 19 Aug 2012 13:10:10 -0400
Received: from mout.web.de ([212.227.17.12]:59790 "EHLO mout.web.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750824Ab2HSRKI (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 19 Aug 2012 13:10:08 -0400
Received: from birne.lan ([195.67.191.22]) by smtp.web.de (mrweb001) with
 ESMTPA (Nemesis) id 0M2Mq4-1TvF4C1IdI-00sHFO; Sun, 19 Aug 2012 19:10:04 +0200
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.6; rv:14.0) Gecko/20120713 Thunderbird/14.0
In-Reply-To: <7vobm9v32e.fsf@alter.siamese.dyndns.org>
X-Provags-ID: V02:K0:GvRzmDGUToFRiYJhdFtvevyGQ5Vt+j9l0xIlSNscjXY
 UzW3jLyb6Yg5Dg8XiV8uxCgXLAxNZjKmnrrjtj6hVXXLMSfqgi
 swFfRmLxLW8aSkSia62ZaVOsVn4nqv5KZpJ83CmWg8t4/XnY9D
 tAN9HePr+X0BIfzUryxl2+k+U/nwh50MK6KJDVCluMuAyBMSl5
 PZXfjF0rN2c3FKc1DJEAQ==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/203725>

On 17.08.12 19:30, Junio C Hamano wrote:
> Robin Rosenberg <robin.rosenberg@dewire.com> writes:
>
>> Remove extraneous parentheses and braces
>> Remove redundant NUL-termination
>> Check result of unlink when probing for decomposed file names
>>
>> Signed-off-by: Robin Rosenberg <robin.rosenberg@dewire.com>
>> ---
> Thanks.  I've found and fixed a bit more style violations while we
> are at it.

(I was offline for a couple of days)

Thanks to all, and ACK from my side.
/Torsten
