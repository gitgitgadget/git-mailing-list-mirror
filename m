From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v2 0/6] git send-email suppress-cc=self fixes
Date: Mon, 03 Jun 2013 09:18:56 -0700
Message-ID: <7vy5ari2vj.fsf@alter.siamese.dyndns.org>
References: <1369897638-27299-1-git-send-email-mst@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: "Michael S. Tsirkin" <mst@redhat.com>
X-From: git-owner@vger.kernel.org Mon Jun 03 18:19:06 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UjXTO-0007Pt-FU
	for gcvg-git-2@plane.gmane.org; Mon, 03 Jun 2013 18:19:06 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1759347Ab3FCQTC (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 3 Jun 2013 12:19:02 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:55148 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1759251Ab3FCQTB (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 3 Jun 2013 12:19:01 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id C82BF2424B;
	Mon,  3 Jun 2013 16:18:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=AwYMHn/eTOv/g6+wOdAMGAZMNhU=; b=HlFozV
	DoFRSUZp9i2wAw7kJudqqVGKyrcmJ5C55Fxf/qeaLwZtv39j8Hlpl/ZwngOkE9Xm
	qvY/70QM1aAmPhAV4adeeX6BlVM2aWKtujpqcFNMXGUrekBeG1F+unGTlDD+fIbQ
	XUwlkoeZTbUarq9QDf07LaKhPZXDHu8yLnwgw=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=eRvmYJH3RzC7wxA+uVH7/tNN6jkgn14A
	RoQA94qGwv4IqpPGbDDN+8UeGI2dldCEsrjSO//ZrwPCHDEgjZagisOL1CtwfgDK
	lXWLYfpYbjPBKDea2I0oVMkp89xiMH+Dxwpj06pqvkIpmw6dcqVv+kMRG0vzusm0
	o4JZ8p5qzyw=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 6251924248;
	Mon,  3 Jun 2013 16:18:59 +0000 (UTC)
Received: from pobox.com (unknown [50.161.4.97])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 472DD24240;
	Mon,  3 Jun 2013 16:18:58 +0000 (UTC)
In-Reply-To: <1369897638-27299-1-git-send-email-mst@redhat.com> (Michael
	S. Tsirkin's message of "Thu, 30 May 2013 10:11:08 +0300")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 4B655382-CC69-11E2-822D-E56BAAC0D69C-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/226230>

"Michael S. Tsirkin" <mst@redhat.com> writes:

> This includes bugfixes related to handling of --suppress-cc=self
> flag. Tests are also included.

Thanks, will queue.
