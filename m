From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v2 4/4] mergetools/meld: Use '--output' when available
Date: Fri, 19 Aug 2011 15:58:39 -0700
Message-ID: <7vd3g1100w.fsf@alter.siamese.dyndns.org>
References: <1313652227-48545-1-git-send-email-davvid@gmail.com>
 <1313652227-48545-5-git-send-email-davvid@gmail.com>
 <20110819091444.GB18054@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Jonathan Nieder <jrnieder@gmail.com>,
	Tanguy Ortolo <tanguy+debian@ortolo.eu>,
	Charles Bailey <charles@hashpling.org>,
	Sebastian Schuberth <sschuberth@gmail.com>
To: David Aguilar <davvid@gmail.com>
X-From: git-owner@vger.kernel.org Sat Aug 20 00:58:47 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QuY1X-00006a-EL
	for gcvg-git-2@lo.gmane.org; Sat, 20 Aug 2011 00:58:47 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756375Ab1HSW6n (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 19 Aug 2011 18:58:43 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:53825 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756225Ab1HSW6m (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 19 Aug 2011 18:58:42 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id E86554F26;
	Fri, 19 Aug 2011 18:58:41 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=3EggJ6kQuLMpysVT3J44iYxf93g=; b=p36Zjv
	MX03wcpuIbUd1h9O5SVTGGyHVcm2IpsJ+d0ct4fMYGwy8zLp1i1UxglEjRQsP6kc
	j/U7t2Ok0Ugotcr+13nab/Jt6BeIbz9R3YwtX4c/GaoZfdkWSppqqBRt3Btb+JrD
	UTgR5XoHjKyeVrSdncQADLnbUf7TNIN29yamM=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=tTYM2tXQ/yO1KIu5q/XXtWCnVWZgDpWx
	bmlH5ZlZrjc+sbdWEEVF4Bx5ux89Z3QR98areuMFqeAhoL8DTmrcOJJikVVlG5DD
	K98jm22Q8JPJPBvhcVaygCnvC/QT+j83RnmaouwO1DS+jC0vhdaxXiDXSWdWysDL
	S/WC/IDZa68=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id DF45F4F25;
	Fri, 19 Aug 2011 18:58:41 -0400 (EDT)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 5BFC54F24; Fri, 19 Aug 2011
 18:58:41 -0400 (EDT)
In-Reply-To: <20110819091444.GB18054@gmail.com> (David Aguilar's message of
 "Fri, 19 Aug 2011 02:14:45 -0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: C8444522-CAB6-11E0-8511-1DC62E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/179741>

David Aguilar <davvid@gmail.com> writes:

> meld 1.5.0 and newer allow the output file to be specified
> when merging multiple files.  Check whether the meld command
> supports '--output' and use it when available.
>
> Signed-off-by: David Aguilar <davvid@gmail.com>
> ---
>  mergetools/meld |   25 ++++++++++++++++++++++++-
>  1 files changed, 24 insertions(+), 1 deletions(-)
>
> Changes since v1 with help from Jonathan Nieder:

Thanks, both of you. Queued all patches in the series.
