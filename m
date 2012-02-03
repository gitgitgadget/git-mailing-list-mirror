From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v2] Use correct grammar in diffstat summary line
Date: Thu, 02 Feb 2012 17:18:58 -0800
Message-ID: <7vmx90u325.fsf@alter.siamese.dyndns.org>
References: <1328019840-6168-1-git-send-email-pclouds@gmail.com>
 <1328100907-20397-1-git-send-email-pclouds@gmail.com>
 <7vhaza2qjw.fsf@alter.siamese.dyndns.org> <20120202142255.GA25871@do>
 <7v8vklxfe4.fsf@alter.siamese.dyndns.org>
 <CACsJy8CcBB9OF=8a1hQEpDFzqsrkbpFKnVAcU65h_5Cnym90SQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Jonathan Nieder <jrnieder@gmail.com>,
	=?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= <avarab@gmail.com>,
	Frederik Schwarzer <schwarzerf@gmail.com>,
	Brandon Casey <drafnel@gmail.com>
To: Nguyen Thai Ngoc Duy <pclouds@gmail.com>
X-From: git-owner@vger.kernel.org Fri Feb 03 02:19:11 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Rt7nx-0000s0-VG
	for gcvg-git-2@plane.gmane.org; Fri, 03 Feb 2012 02:19:10 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756122Ab2BCBTF (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 2 Feb 2012 20:19:05 -0500
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:58311 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754329Ab2BCBTD (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 2 Feb 2012 20:19:03 -0500
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id CBF1F6A95;
	Thu,  2 Feb 2012 20:19:00 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=YiI8+Y0edqBx3+c4pnRFitQtagE=; b=NNPZVH
	IaoAaky+BCFiuSPHVeH2o6zWvKxVmf1pRAA0VS3UhCbJr+gJAMR6gQCigiLpyjcC
	ZrporcP5j1emiswmIE18GAbsoss4Y/2fdTYG8Yh1CP++p2xl7HmmODlRrlB0H42c
	mb+vnUS1mnf8+VA7RvCOwo2W+aaxpgIcnFL14=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=cw/5pGKN90c59dFHdIfzERKx0WNeAlf1
	Lz2QhsoaMIQshmQ+R0/my/fWNLU6J/CMcCe+Dz1D0WRugUVXgpt9uuAK+RIHkhKE
	I+96QockPPWHrfEqpdU2/roOmuP108TyRrU/ZfrFhExW6hLEWEHuojQ+zoFromd6
	NhfspYolCTQ=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id C2F8B6A94;
	Thu,  2 Feb 2012 20:19:00 -0500 (EST)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 527686A93; Thu,  2 Feb 2012
 20:19:00 -0500 (EST)
In-Reply-To: <CACsJy8CcBB9OF=8a1hQEpDFzqsrkbpFKnVAcU65h_5Cnym90SQ@mail.gmail.com> (Nguyen
 Thai Ngoc Duy's message of "Fri, 3 Feb 2012 08:11:23 +0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 0D57FEDE-4E05-11E1-808D-9DB42E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/189729>

Nguyen Thai Ngoc Duy <pclouds@gmail.com> writes:

> On Fri, Feb 3, 2012 at 1:24 AM, Junio C Hamano <gitster@pobox.com> wrote:
>> Nguyen Thai Ngoc Duy <pclouds@gmail.com> writes:
>>
>>> I take it --summary is un-i18n-able,...
>>
>> ... because?
>
> .. of scripts? We have --numstat for scripts, but I see no alternative
> to --summary.

Ahh, you meant that --summary.  I somehow mixed that up with the "N files
added, M insersion(s),...".

I've always thought that "--summary" lines belong to the same category as
"new file mode M", "rename from A" and "similarity X%" that come at the
beginning of individual patches, and it probably would not make sense to
localize them.
