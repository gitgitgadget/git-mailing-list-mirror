From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] add: introduce add.ignoreerrors synonym for
 add.ignore-errors
Date: Thu, 02 Dec 2010 18:18:08 -0800
Message-ID: <7voc93ppjz.fsf@alter.siamese.dyndns.org>
References: <cover.1291207768.git.git@drmicha.warpmail.net>
 <7vd3pmw9n5.fsf@alter.siamese.dyndns.org>
 <b61288036e756c78709438491416d573459a732e.1291207768.git.git@drmicha.warpmail.net> <AANLkTi=cb0i28oGi9vrYfEyU_fPHhQGhNNtramtCpCHy@mail.gmail.com> <20101201160503.GB26120@burratino> <m3aakp4g5o.fsf@localhost.localdomain> <20101201163406.GD26120@burratino> <20101201175517.GA7774@sigill.intra.peff.net> <20101201183615.GA27024@burratino> <20101201184659.GA9147@sigill.intra.peff.net> <20101201185711.GD27024@burratino> <7vipzduufr.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Jonathan Nieder <jrnieder@gmail.com>, Jeff King <peff@peff.net>,
	Jakub Narebski <jnareb@gmail.com>,
	Martin Langhoff <martin.langhoff@gmail.com>,
	Michael J Gruber <git@drmicha.warpmail.net>,
	git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri Dec 03 03:18:36 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1POLEJ-0001k4-Ep
	for gcvg-git-2@lo.gmane.org; Fri, 03 Dec 2010 03:18:35 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758407Ab0LCCS3 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 2 Dec 2010 21:18:29 -0500
Received: from a-pb-sasl-sd.pobox.com ([64.74.157.62]:46415 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758370Ab0LCCS2 (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 2 Dec 2010 21:18:28 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id 0A4543D10;
	Thu,  2 Dec 2010 21:18:47 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=MvxV2doZjTvoIbGt/z/xiY4Kf1M=; b=Qov1bO
	kh5pjJ9KlbE4VU3Isa2YFD7L0eN0nZdBi0h+olk44zQLM5YllO9hWqu3EZqMS09M
	jM/lrYsOZYxPjGjX2zN7Y3yiMWOuEpdEFEub+Rk0X1Ghac7MDld4s2+I0ZAAbyiM
	XyU1kN9Gatj5osT4Ee+QQIR45X4vfWNKVhzEI=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=fxsQqXcEUMFMlkGCSq4Wn2DMsxC8VEhx
	+0jLN7oCuVtIwYIsYvFv5GubQteLybH2T3K/O82WabkpRdiViRof8UW3yfWRst3K
	/wgxwlhgFQujuf8o0QDHovOUIO9YIQHC872v9JZ9hLvWH8SaS9qUb2MUcHaF6Ds6
	oT1X7lQGRCM=
Received: from a-pb-sasl-sd.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id 9FF413D0F;
	Thu,  2 Dec 2010 21:18:40 -0500 (EST)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-sd.pobox.com (Postfix) with ESMTPSA id 9B4BE3D04; Thu,  2 Dec 2010
 21:18:31 -0500 (EST)
In-Reply-To: <7vipzduufr.fsf@alter.siamese.dyndns.org> (Junio C. Hamano's
 message of "Wed\, 01 Dec 2010 12\:09\:12 -0800")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: A4F614EC-FE83-11DF-A9A9-CDEAE6EC64FC-77302942!a-pb-sasl-sd.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/162759>

Junio C Hamano <gitster@pobox.com> writes:

> Perhaps phrasing it like this, and then issue v1.7.{0,1,2,3}.X maintenance
> release to reduce the chance of inconveniencing the users?

I ended up cutting the maintenance releases for 1.7.[012].X series, which
costed a few more hours than I planned to spend on this X-<.
