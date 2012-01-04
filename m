From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] write first for-merge ref to FETCH_HEAD first
Date: Tue, 03 Jan 2012 16:12:39 -0800
Message-ID: <7vty4cqqa0.fsf@alter.siamese.dyndns.org>
References: <20111225173901.GA668@gnu.kitenet.net>
 <7vd3bb929n.fsf@alter.siamese.dyndns.org>
 <20111226161656.GB29582@gnu.kitenet.net>
 <7v1urp97mp.fsf@alter.siamese.dyndns.org>
 <7v7h18s5kg.fsf@alter.siamese.dyndns.org>
 <20120104000339.GA22662@gnu.kitenet.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: Joey Hess <joey@kitenet.net>
X-From: git-owner@vger.kernel.org Wed Jan 04 01:12:48 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RiETG-0003Gr-RP
	for gcvg-git-2@lo.gmane.org; Wed, 04 Jan 2012 01:12:47 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755266Ab2ADAMn (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 3 Jan 2012 19:12:43 -0500
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:37428 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754975Ab2ADAMl (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 3 Jan 2012 19:12:41 -0500
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 4F97572B3;
	Tue,  3 Jan 2012 19:12:41 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=IoD1tYtC4fKsqbExqNkZ/vE9Csc=; b=TK/LgN
	y84MaNZpOEE36cKJdLM33UnyWx+tDZc3XSIY8E60XV+ga0xvlLM87UtVuDPa2cK9
	QkheBtROZ12LQtH2QeenBR/0tNU0RC3EQG6DoPx/LbxXNvliH5l69ZJo9Av3+b/t
	yGQImSEN7Djom+Ywitqu/Qp6XQgSAiC3rcUCo=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=jIsJo4Xk5FnLm99dJ871Eri6wbXfwiVZ
	9mCgnV0Uz+1BGi0dr3Fnc3ssK96QsRz7CwfOSUwjY2+d8t9UTY5uLrXPj1dc9Lxo
	hAVLT3itJwgL6Wy7jnsCAxEbmT2817ZWQmMoRUqtyAq486zVRRb4FYmLiZ4pVBm6
	EKjkKL1OH5Q=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 4795872B2;
	Tue,  3 Jan 2012 19:12:41 -0500 (EST)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id CD97B72B1; Tue,  3 Jan 2012
 19:12:40 -0500 (EST)
In-Reply-To: <20120104000339.GA22662@gnu.kitenet.net> (Joey Hess's message of
 "Tue, 3 Jan 2012 20:03:39 -0400")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: D0FC6AC8-3668-11E1-9A49-9DB42E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/187909>

Joey Hess <joey@kitenet.net> writes:

> Junio C Hamano wrote:
>> Ping? I think this is a good change to go in before 1.7.9.
>> 
>> The change broke quite a lot of tests, and I think I've fixed them all.
>
> Signed-off-by: Joey Hess <joey@kitenet.net>
>
> (Hope that's enough!)

Yes. Thanks.
