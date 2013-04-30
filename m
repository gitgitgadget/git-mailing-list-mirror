From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] Add new @ shortcut for HEAD
Date: Tue, 30 Apr 2013 10:54:25 -0700
Message-ID: <7v8v3zewfi.fsf@alter.siamese.dyndns.org>
References: <1367264106-2351-1-git-send-email-felipe.contreras@gmail.com>
	<7v61z5hzqg.fsf@alter.siamese.dyndns.org>
	<CAMP44s0rT1097=481aSH=Gy465zb2Bd_xLv=Xvte-GHcamWLyA@mail.gmail.com>
	<CAMP44s0mHxv24GtpY2KzmrKQjZo+97FNN_T7tQk_peyWmusMWA@mail.gmail.com>
	<7vsj29eysv.fsf@alter.siamese.dyndns.org>
	<20130430005304.GG24467@google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Felipe Contreras <felipe.contreras@gmail.com>, git@vger.kernel.org,
	Ramkumar Ramachandra <artagnon@gmail.com>,
	Michael J Gruber <git@drmicha.warpmail.net>,
	Jon Seymour <jon.seymour@gmail.com>,
	=?utf-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41j?= <pclouds@gmail.com>
To: Jonathan Nieder <jrnieder@gmail.com>
X-From: git-owner@vger.kernel.org Tue Apr 30 19:54:35 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UXEl7-0008C0-UD
	for gcvg-git-2@plane.gmane.org; Tue, 30 Apr 2013 19:54:34 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932559Ab3D3Ry3 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 30 Apr 2013 13:54:29 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:62883 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932489Ab3D3Ry2 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 30 Apr 2013 13:54:28 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 98BE618636;
	Tue, 30 Apr 2013 17:54:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=OPB6lPnLSBukXqMxz7BkxU4947I=; b=n/tm5u
	rOIAZWTA+vEuEiTlRW6G15mbcOkmDb5O7kwlQCu/T9YaafCUweUMQlj2ChwVbqEP
	aQnV/M8WA0U4742TaaV8Qf1VtinD33h+R7U/IROjdtwpf9iujsG9T2tNzIJlm8AR
	g3wducXyk06y/6IwhSa8EyNVzrOfeVm6qmGic=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=dAoAjhy/Brir9rh4opPNWAKRd+ZDXRCS
	giau4jzROvx4l8dfrohBo40seiE9qJRDy5Umppgl3qpQrJ96B5eVydFN1G7JKlKQ
	KrHO3X+biCYUGh0z/Qlr+Px72pRzGnzRb16mhiOPZmap/XgQJECMoNTznOIQugGF
	d3cZd/qBCyQ=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 8E8B218635;
	Tue, 30 Apr 2013 17:54:27 +0000 (UTC)
Received: from pobox.com (unknown [24.4.35.13])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 0FFBC18634;
	Tue, 30 Apr 2013 17:54:26 +0000 (UTC)
In-Reply-To: <20130430005304.GG24467@google.com> (Jonathan Nieder's message of
	"Mon, 29 Apr 2013 17:53:04 -0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: FFF5E3AE-B1BE-11E2-854A-A3355732AFBB-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/222973>

Jonathan Nieder <jrnieder@gmail.com> writes:

> Junio C Hamano wrote:
>> Felipe Contreras <felipe.contreras@gmail.com> writes:
>
>>> Never-mind, now I see the difference, still, I don't think it's
>>> relevant for this patch.
>>
>> I don't either. With the precedence of @{u}, @ does not need to have
>> anything to do with a reflog. It is just a random letter that casts
>> a magic spell.
>
> I thought the convention was "^{...} is for operators that act on
> objects, @{...} for operators that act on refs or symrefs".

Almost.  You can ask "git rev-parse --symbolic-full-name" to see
that @{-1} is still a ref, but @{1} is _not_ a ref (it is a concrete
revision that you cannot run 'update-ref' on).
