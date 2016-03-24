From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [RFD] minor frustration in 'git add' pathname completion
Date: Thu, 24 Mar 2016 15:29:18 -0700
Message-ID: <xmqq37rf7bnl.fsf@gitster.mtv.corp.google.com>
References: <xmqqr3ez7dqw.fsf@gitster.mtv.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Mar 24 23:29:26 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ajDkr-0002d1-Kn
	for gcvg-git-2@plane.gmane.org; Thu, 24 Mar 2016 23:29:25 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751588AbcCXW3W (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 24 Mar 2016 18:29:22 -0400
Received: from pb-smtp0.pobox.com ([208.72.237.35]:56353 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1750984AbcCXW3V (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 24 Mar 2016 18:29:21 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id DBC954DBAF;
	Thu, 24 Mar 2016 18:29:19 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=zwniSF13qe2oWv+7C+nNw7k9l6g=; b=ajzKjF
	l/9Y5Og044A0e+Wt/Yk5TmuS/lQj1QAVLDnI6Bn5Fw3wW0Gr6aau1R0l8aRfhhVX
	GQo+3Bw6fbk9LhIcyn3iPy605zMfsTfcSHwDV1TSVXaa85CkNnPvQpyIHs+52j9W
	JggaJcoQAWnHSj7nvm/cZ7t+01jl6LoJdqQxo=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:subject
	:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=Vx6J4bARrBLrdiSnLuUqY6v8DjRBeAVK
	0txZl2gdfpNPRdWAIsA1Qz/S7C/Q67XlodcT0lQqvYTfn5Vy81PyDn1ub2ZLNeiD
	Aven51aPSdDS2s+F+EV0z3DGc8ZkQLSflzZHol1OHTW5K8LxS5KTFDtQ99ZFnNDc
	rKU2pQwueBw=
Received: from pb-smtp0.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id D32504DBAE;
	Thu, 24 Mar 2016 18:29:19 -0400 (EDT)
Received: from pobox.com (unknown [104.132.1.64])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp0.pobox.com (Postfix) with ESMTPSA id 400AE4DBAD;
	Thu, 24 Mar 2016 18:29:19 -0400 (EDT)
In-Reply-To: <xmqqr3ez7dqw.fsf@gitster.mtv.corp.google.com> (Junio C. Hamano's
	message of "Thu, 24 Mar 2016 14:44:07 -0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: D989CC0A-F20F-11E5-A8A2-E95C6BB36C07-77302942!pb-smtp0.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/289815>

Junio C Hamano <gitster@pobox.com> writes:

> I am wondering if there is a downside to removing (3) from the
> completion logic.
>
> Discuss.

Eh, please don't.  Somehow this no longer reproduces for me.
