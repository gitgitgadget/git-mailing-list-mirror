From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] git-archive documentation: .gitattributes must be
 committed
Date: Wed, 10 Feb 2010 12:18:17 -0800
Message-ID: <7vr5os7sl2.fsf@alter.siamese.dyndns.org>
References: <1265770284-14830-1-git-send-email-fmarier@gmail.com>
 <4B7303FC.6070701@lsrfire.ath.cx> <7v1vgsao21.fsf@alter.siamese.dyndns.org>
 <4B731043.6010108@lsrfire.ath.cx>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Francois Marier <fmarier@gmail.com>, git@vger.kernel.org,
	Nguyen Thai Ngoc Duy <pclouds@gmail.com>
To: =?utf-8?Q?Ren=C3=A9?= Scharfe <rene.scharfe@lsrfire.ath.cx>
X-From: git-owner@vger.kernel.org Wed Feb 10 21:18:47 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1NfJ1G-0004pQ-11
	for gcvg-git-2@lo.gmane.org; Wed, 10 Feb 2010 21:18:42 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755486Ab0BJUSa convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 10 Feb 2010 15:18:30 -0500
Received: from a-pb-sasl-quonix.pobox.com ([208.72.237.25]:40447 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753911Ab0BJUS3 convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 10 Feb 2010 15:18:29 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id 6081F9852A;
	Wed, 10 Feb 2010 15:18:28 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; s=sasl; bh=kaKqV1/6bx7f
	E8BXCf5w2iL8aks=; b=dfyJqKfH1QE2aiCSJ+XEa4krgJv645bmBUiEpr1oSk+S
	uZmbCCP8vW0v1g1r4u+O58ftSAMm1GDHFSxciiddtnVGAQCB2+fZolizjqMJsZhX
	9Xz+SJO6mIQx78n4Rv7URN1xF6Eukw45HWZ6zmWbEkEsBd2nCkIb4UesFy9f4D4=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; q=dns; s=sasl; b=B+iKNO
	+dNi7vO2cY46ilj+5nQvo9Ca6f4RwmGuyNjHQma43yUJSFedpiBPf95DwpIkksR5
	rATJjlg77UipboKuspq2vJxPZ/rEZDm+ykeuo8Q0QH2DdL/E4DLZmt5Br2kHtBZy
	yX060Lz+ILPtZHuYUHQRAdA+yCjG56HaqtsrY=
Received: from a-pb-sasl-quonix. (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id 1DBB798529;
	Wed, 10 Feb 2010 15:18:24 -0500 (EST)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 4456B98523; Wed, 10 Feb
 2010 15:18:19 -0500 (EST)
In-Reply-To: <4B731043.6010108@lsrfire.ath.cx> (=?utf-8?Q?=22Ren=C3=A9?=
 Scharfe"'s message of "Wed\, 10 Feb 2010 21\:00\:03 +0100")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: 70A61948-1681-11DF-9CCD-6AF7ED7EF46B-77302942!a-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/139543>

Ren=C3=A9 Scharfe <rene.scharfe@lsrfire.ath.cx> writes:

> ...  I think that the current
> behaviour makes sense because it provides a repeatable default.

I wouldn't insist on changing the default again too strongly, but I thi=
nk
the --worktree-attributes option should be advertised better in the
documentation, as that mode of operation seems to match what the users
expect better, and I think that is how this thread started.
