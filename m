From: Junio C Hamano <gitster@pobox.com>
Subject: Re: git pull suggestion
Date: Fri, 09 Apr 2010 21:40:59 -0700
Message-ID: <7vochrzzqc.fsf@alter.siamese.dyndns.org>
References: <r2x3abd05a91004071617z9ffd6e02v83d825405bb6ef1@mail.gmail.com>
 <201004081754.24954.trast@student.ethz.ch>
 <p2x3abd05a91004081233j77b7177bm5928913a64de0e57@mail.gmail.com>
 <20100408231154.GB13704@vidovic>
 <v2r3abd05a91004082006v74e243f2x33b500f2f6dadc9f@mail.gmail.com>
 <20100409034911.GA4020@coredump.intra.peff.net>
 <i2y3abd05a91004091233nc11ee5f8m4f40e7451e02518a@mail.gmail.com>
 <20100410043535.GA22481@coredump.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Aghiles <aghilesk@gmail.com>, Matthieu Moy <Matthieu.Moy@imag.fr>,
	Nicolas Sebrecht <nicolas.s.dev@gmx.fr>,
	Thomas Rast <trast@student.ethz.ch>,
	git list <git@vger.kernel.org>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Sat Apr 10 06:41:32 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1O0SVg-000585-1m
	for gcvg-git-2@lo.gmane.org; Sat, 10 Apr 2010 06:41:32 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751244Ab0DJEl1 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 10 Apr 2010 00:41:27 -0400
Received: from a-pb-sasl-quonix.pobox.com ([208.72.237.25]:56287 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750907Ab0DJEl1 (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 10 Apr 2010 00:41:27 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id 5F584A925A;
	Sat, 10 Apr 2010 00:41:26 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=g5HzgmVsmgaMzV0Yaa3VAEGZz7g=; b=xIf4FQ
	wf58+zPaLS4bq5KeC0HjyVPcgugAM2l+gxVjNFon3PE3NVMjvmUjYxemt2B55pML
	6H5dq2w7Xg+xEOHKhGXzZvkf/F2/VGnIffHoMk5aSnBZMCyY2ZhssyWfDt5Ljusk
	oDcmPNyNMrPPquCcSnpQv0dLhKiMByoYf7+eo=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=k2yMZpKkyM2DE0US1GphfXBZgErgLlQC
	slhdEBdbgwvql729PWLqkmWQILD6Cx1poOPabk/DL+gxlSa4OS6pQUV6D8vggMws
	oVoixI7t8KnGXHZWcQA/UUpyBvtqiA3H0EQiB+NJdaGVpjKVQt9XD0cHeZKTApqT
	5xKD4ArJ5ms=
Received: from a-pb-sasl-quonix. (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id 13816A9257;
	Sat, 10 Apr 2010 00:41:15 -0400 (EDT)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 473F4A9255; Sat, 10 Apr
 2010 00:41:00 -0400 (EDT)
In-Reply-To: <20100410043535.GA22481@coredump.intra.peff.net> (Jeff King's
 message of "Sat\, 10 Apr 2010 00\:35\:35 -0400")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: 4C1220D8-445B-11DF-B81A-D033EE7EF46B-77302942!a-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/144504>

Jeff King <peff@peff.net> writes:

>   Your local changes to '%s' would be overwritten by merge.  Aborting.
>   Please, commit your changes or stash them before you can merge.
>
> What version of git are you using? If you (or others you are helping)
> saw that message and it wasn't helpful, do you have any suggestions for
> how to improve it?

I use 1.7.1-rc0 myself, but dropping comma after "Please" may make it a
bit easier to read IMHO ;-).
