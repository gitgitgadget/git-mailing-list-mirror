From: Johannes Sixt <j6t@kdbg.org>
Subject: Re: Porting git to HP NonStop
Date: Wed, 22 Aug 2012 20:09:23 +0200
Message-ID: <50352053.609@kdbg.org>
References: <003a01cd7709$63725260$2a56f720$@schmitz-digital.de> <CAJo=hJvwih+aOMg6SKP94_1q-az1XV-1Pcf=_fGbvdDcDpC23A@mail.gmail.com> <004701cd771e$21b7cbb0$65276310$@schmitz-digital.de> <CAJo=hJsz3ooDAV-0S-BDknnbQPK9ASEYw8b7t7PyKEtJ5jgxQA@mail.gmail.com> <01a801cd7de8$b4c311a0$1e4934e0$@schmitz-digital.de> <7v628epzia.fsf@alter.siamese.dyndns.org> <000601cd7ebd$a4ef5740$eece05c0$@schmitz-digital.de> <7vy5l9lj6m.fsf@alter.siamese.dyndns.org> <001801cd7eee$24f95a50$6eec0ef0$@schmitz-digital.de> <7v4nnxld24.fsf@alter.siamese.dyndns.org> <002a01cd8083$69fb9960$3df2cc20$@schmitz-digital.de> <CA+sFfMdnixrUekh40Sde05tkap7Oj19=5D6J6aYVVD1krqPZkw@mail.gmail.com> <503519B3.1020403@kdbg.org> <003e01cd8090$55126fd0$ff374f70$@schmitz-digital.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Cc: 'Brandon Casey' <drafnel@gmail.com>,
	'Junio C Hamano' <gitster@pobox.com>,
	'Shawn Pearce' <spearce@spearce.org>, git@vger.kernel.org,
	rsbecker@nexbridge.com
To: Joachim Schmitz <jojo@schmitz-digital.de>
X-From: git-owner@vger.kernel.org Wed Aug 22 20:09:35 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1T4FN0-0007Cx-NJ
	for gcvg-git-2@plane.gmane.org; Wed, 22 Aug 2012 20:09:35 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758431Ab2HVSJ3 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 22 Aug 2012 14:09:29 -0400
Received: from bsmtp4.bon.at ([195.3.86.186]:11441 "EHLO bsmtp.bon.at"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S1758368Ab2HVSJ1 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 22 Aug 2012 14:09:27 -0400
Received: from dx.sixt.local (unknown [93.83.142.38])
	by bsmtp.bon.at (Postfix) with ESMTP id 4E14ACDF84;
	Wed, 22 Aug 2012 20:09:25 +0200 (CEST)
Received: from [IPv6:::1] (localhost [IPv6:::1])
	by dx.sixt.local (Postfix) with ESMTP id 7285D19F3C6;
	Wed, 22 Aug 2012 20:09:24 +0200 (CEST)
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:14.0) Gecko/20120713 Thunderbird/14.0
In-Reply-To: <003e01cd8090$55126fd0$ff374f70$@schmitz-digital.de>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/204056>

Am 22.08.2012 20:02, schrieb Joachim Schmitz:
>> From: Johannes Sixt [mailto:j6t@kdbg.org]
>> Don't use x* wrappers in the compat layer, at least not those that allocate
>> memory: They behave unpredictably due to try_to_free_routine and may lead
>> to recursive invocations.
> 
> I was just following orders ;-)
> What about the other proposal, xmemdupz? Same story I guess?

xmemdupz calls xmalloc, so, yes, same story.

-- Hannes
