From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 1/2] grep: Add the option '--open-files-in-pager'
Date: Mon, 29 Mar 2010 11:17:12 -0700
Message-ID: <7veij356xj.fsf@alter.siamese.dyndns.org>
References: <alpine.DEB.1.00.1003261145500.7596@pacific.mpi-cbg.de>
 <alpine.DEB.1.00.1003261149040.7596@pacific.mpi-cbg.de>
 <20100328040938.GA2017@progeny.tock>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	git@vger.kernel.org
To: Jonathan Nieder <jrnieder@gmail.com>
X-From: git-owner@vger.kernel.org Mon Mar 29 20:17:34 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1NwJWl-0005IC-Lf
	for gcvg-git-2@lo.gmane.org; Mon, 29 Mar 2010 20:17:32 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754916Ab0C2SRZ convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 29 Mar 2010 14:17:25 -0400
Received: from a-pb-sasl-quonix.pobox.com ([208.72.237.25]:52106 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754816Ab0C2SRZ convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 29 Mar 2010 14:17:25 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id 2459FA6D76;
	Mon, 29 Mar 2010 14:17:22 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=to:cc:subject
	:references:from:date:message-id:mime-version:content-type
	:content-transfer-encoding; s=sasl; bh=/kUu86E4wdtL/Z+Mgl22PIwEo
	kE=; b=PXMLa+np2F5fS/CPcr9tW6l2mLBAa7jBudd4IpLAhDLwWI2qW2il4PmkS
	NkXp+Cxxkd0rvET88FEOAye49Vtk4IeSlqhBJ4zpCzxikv/VIR1wSVIHwL+9urp0
	Qp/u50kh7wyxvRTOLxvrE4Z58xrNCq7Tl+g//FzLmRIYF7mEs8=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=to:cc:subject
	:references:from:date:message-id:mime-version:content-type
	:content-transfer-encoding; q=dns; s=sasl; b=MdYVTbyRz6T9hxOwqtE
	nE0+oRL3o/0FGYyP6qVtoYtKYdg/V3egisqGPrPAJebZyLwW0z5UmlSu3/sOUvzi
	p855igB1TsyJKEZxKvrSwC8kBpLHEphK2sOe6SlbEb6rVg/GalLi9G/1NXug/3uf
	iiLPtBpfUSa2fdbiGldipSBI=
Received: from a-pb-sasl-quonix. (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id 9DC07A6D6F;
	Mon, 29 Mar 2010 14:17:18 -0400 (EDT)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 72F02A6D6C; Mon, 29 Mar
 2010 14:17:13 -0400 (EDT)
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: 4F7F7B30-3B5F-11DF-A4D7-D033EE7EF46B-77302942!a-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/143505>

Jonathan Nieder <jrnieder@gmail.com> writes:

> I couldn=E2=80=99t get this to apply to current master or maint, and =
searching for
> blob 5d83d9b to find a more suitable merge base revealed that I don=E2=
=80=99t
> actually have that object in my repo.  Is this patch available alread=
y
> applied in a public git repo somewhere?

This seems to be based on a fork with a not-very-recent forkpoint.  I
managed to create a topic branch and merged it to 'pu'.

It probably wants to be adjusted to --no-index mode, as that is also ab=
out
finding strings in files in the filesystem, but I chose not to do that
myself.  For this topic to go forward I think it needs a rebase to a mo=
re
recent 'master'.
