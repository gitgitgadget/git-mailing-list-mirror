From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] pull: clarify advice for the unconfigured error case
Date: Sun, 06 Dec 2009 16:29:52 -0800
Message-ID: <7vbpibd3sv.fsf@alter.siamese.dyndns.org>
References: <48B54636-1825-48B3-BECD-4150A55B013F@dbservice.com>
 <1257965806.26362.132.camel@heerbeest>
 <D6B0AE61-6CA3-4F79-BB50-B8795415BAB7@dbservice.com>
 <1257968052.26362.155.camel@heerbeest>
 <AC99BA30-A36D-4798-8E7D-9D69EFE99D55@dbservice.com>
 <1258035449.26362.273.camel@heerbeest> <20091112155310.7836c388@perceptron>
 <20091112150626.GA24848@coredump.intra.peff.net>
 <20091112170814.1858aba4@perceptron> <20091113040754.GA3255@progeny.tock>
 <20091127141704.GA24080@progeny.tock>
 <7vk4x57z4e.fsf@alter.siamese.dyndns.org>
 <20091203115110.08dde406@perceptron>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio C Hamano <gitster@pobox.com>,
	Jonathan Nieder <jrnieder@gmail.com>,
	Jeff King <peff@peff.net>,
	Jan Nieuwenhuizen <janneke-list@xs4all.nl>,
	Tomas Carnecky <tom@dbservice.com>,
	git list <git@vger.kernel.org>
To: Jan =?utf-8?Q?Kr=C3=BCger?= <jk@jk.gs>
X-From: git-owner@vger.kernel.org Mon Dec 07 01:31:54 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NHRVx-0004Cy-Hf
	for gcvg-git-2@lo.gmane.org; Mon, 07 Dec 2009 01:31:45 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S934448AbZLGAaN convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sun, 6 Dec 2009 19:30:13 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S934424AbZLGAaL
	(ORCPT <rfc822;git-outgoing>); Sun, 6 Dec 2009 19:30:11 -0500
Received: from a-pb-sasl-sd.pobox.com ([64.74.157.62]:39828 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S934448AbZLGAaE convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 6 Dec 2009 19:30:04 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id 89B22A45F4;
	Sun,  6 Dec 2009 19:30:10 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=to:cc:subject
	:references:from:date:message-id:mime-version:content-type
	:content-transfer-encoding; s=sasl; bh=YfSjb/m13BSB+ZVneMzb5V0XR
	CY=; b=qylOTyaUSrDp3Qd3JR4LF/RkjOM2Imys4BavHaXpf0e58Qea0bnXOgggg
	FJOYoLM6UTiEDlq0MnXuRyi5QxQPcdHBBSc1WX0SXwOXLnloUz+IcuqK9crTYbcB
	BxRCHpOoQNDTcyJgYdE1IuJvCS0iEyiHpr7QY/dNSG/eD3gBlI=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=to:cc:subject
	:references:from:date:message-id:mime-version:content-type
	:content-transfer-encoding; q=dns; s=sasl; b=eTU888lEMeo8hJ9wmUp
	tyYI6j/afvcJnWZCbH0Xf0x97ji+SJOYlcTZacvqiG2HGJLv/QZs+l/YT8liCymy
	79wXxzKBI2fihh+UwveHZIwMfXMmctLqJn/T1mVrcC8T0yg/gTY68cJWLwqy4gS1
	uYpy4yvDAYCnvPYkQN8bWFgw=
Received: from a-pb-sasl-sd.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id 2C3C5A45ED;
	Sun,  6 Dec 2009 19:30:04 -0500 (EST)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-sd.pobox.com (Postfix) with ESMTPSA id AFE8EA45E6; Sun,  6 Dec 2009
 19:29:54 -0500 (EST)
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: A9B2CAD0-E2C7-11DE-B01D-EF34BBB5EC2E-77302942!a-pb-sasl-sd.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/134700>

Jan Kr=C3=BCger <jk@jk.gs> writes:

> Junio C Hamano <gitster@pobox.com> wrote:
>
>> Is this a good replacement for 31971b3 (git-pull.sh --rebase: overha=
ul
>> error handling when no candidates are found, 2009-11-12) that is on
>> 'pu' and does the lack of follow-up mean everybody involved in the
>> discussion is happy with this version?
>
> I'm not deliriously happy but I can't think of a better version, and =
I
> suppose it's better than what I suggested. In other words, I'm fine
> with the patch.

Thanks.
