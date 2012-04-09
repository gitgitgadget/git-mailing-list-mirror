From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 02/12] completion: simplify __gitcomp
Date: Mon, 09 Apr 2012 11:22:46 -0700
Message-ID: <7vsjgcwyrt.fsf@alter.siamese.dyndns.org>
References: <1333854479-23260-1-git-send-email-felipe.contreras@gmail.com>
 <1333854479-23260-3-git-send-email-felipe.contreras@gmail.com>
 <20120408124652.GN2289@goldbirke>
 <CAMP44s0nSH7ZjC4T=7pXS2MyAkZ133hOXa_tn3q4er+FbcOc_w@mail.gmail.com>
 <20120408132704.GB4103@burratino>
 <CAMP44s2vdEzn8_N=sauq-6OvqA+4tDtM9+yYYWuiQHgkZ2DyYA@mail.gmail.com>
 <20120408143912.GB2631@burratino>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Felipe Contreras <felipe.contreras@gmail.com>,
	SZEDER =?utf-8?Q?G?= =?utf-8?Q?=C3=A1bor?= <szeder@ira.uka.de>,
	git@vger.kernel.org, Thomas Rast <trast@student.ethz.ch>
To: Jonathan Nieder <jrnieder@gmail.com>
X-From: git-owner@vger.kernel.org Mon Apr 09 20:22:56 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SHJEs-0001ot-At
	for gcvg-git-2@plane.gmane.org; Mon, 09 Apr 2012 20:22:54 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757520Ab2DISWt (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 9 Apr 2012 14:22:49 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:41843 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753041Ab2DISWs (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 9 Apr 2012 14:22:48 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 12CD671A0;
	Mon,  9 Apr 2012 14:22:48 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=rI8b4NevidQVgEat6J+TgZlLY8k=; b=KTbdYD
	VfWp4xHdbEqOcGjJW9O5tU+U/Quh2hNjqauGfxvupTrT7JxSzOlOaQ5nEPP6MFP5
	4aYfjqx4XpH0EDJ1FwZXlGbYu2WrlQhY9fixRm0/NSIPf5QQfpFhubdPqkVtKEE+
	flYQ2Z0rIyl+QdNWa62N4rKVmJk0WKdA3hZoI=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=wS7nIRvEFtGqrWyZSntCkYoYpLmquGSl
	DIkl5MuGh/HYxcNcWTvnHKF6FeY54cCFJAhv8Mr9DfV4fPIIDzAJyMST2XxeR883
	cPLC4udTjFA1ZINclH3Gi7SrCP3WVbLUDNNKuLOiGaaOCz/w+UkLbx+WXuI0mPnI
	HflWN20NL84=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 09CAC719F;
	Mon,  9 Apr 2012 14:22:48 -0400 (EDT)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 91264719E; Mon,  9 Apr 2012
 14:22:47 -0400 (EDT)
In-Reply-To: <20120408143912.GB2631@burratino> (Jonathan Nieder's message of
 "Sun, 8 Apr 2012 09:39:12 -0500")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 021AF4AE-8271-11E1-9142-9DB42E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/195021>

Jonathan Nieder <jrnieder@gmail.com> writes:

> (-cc: Shawn)
> Felipe Contreras wrote:
>
>> I've looked at the history of __gitcomp and __gitcomp_nl, now I think
>> it makes sense to keep their arguments similar, at least for the time
>> being.
>>
>> So I suggest this patch to be dropped.
>
> Thanks for looking into it, and sorry I responded to a heated response
> instead of waiting for a calmer one.

Good to see a civilized discussion of patches on technical merits.

Thanks.
