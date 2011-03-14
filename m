From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] object.h: Remove obsolete struct object_refs
Date: Mon, 14 Mar 2011 10:48:41 -0700
Message-ID: <7voc5degp2.fsf@alter.siamese.dyndns.org>
References: <4D7E4118.6060802@elegosoft.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Jakob Pfender <jpfender@elegosoft.com>
X-From: git-owner@vger.kernel.org Mon Mar 14 18:48:56 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PzBt2-0007iO-0p
	for gcvg-git-2@lo.gmane.org; Mon, 14 Mar 2011 18:48:56 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752757Ab1CNRsu (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 14 Mar 2011 13:48:50 -0400
Received: from a-pb-sasl-sd.pobox.com ([64.74.157.62]:63866 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751249Ab1CNRst (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 14 Mar 2011 13:48:49 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id 8F86C3397;
	Mon, 14 Mar 2011 13:50:19 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=0+uIdnS9PIrSeXhLLaQk59+azwQ=; b=uXqgqH
	fYKJb4sQP/IYL1jbVGztenj9X3a1I5e3jvnYsMiJnWnemm/+qyX8TTpGDJEBynMV
	/WirA3fjb2kYEPdnq5H5vJHc6IrnCu3q+ywQ/+yAMMpCYGXbi4bR5MAcBqKohlLe
	/hRz8sV1lXgx89zIiRN8xGv9ivXEbWxuhbe/M=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=SaH1vU+L6pP0Ce2q0JEtruarnajt6AXi
	UNBugkLm4aDMSLsVsxsffOac+JHP1A4ovQYwqYjGTQDJ6aVBTFF2ZgM1Dl2rz0W3
	Skq72sFN9TunoRJ06QnvAY0ct57HrPMd4v4yz/5NMPhreSwm0e8/AXRHYMskvrdp
	/qwe6mybHdg=
Received: from a-pb-sasl-sd.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id 6DC073395;
	Mon, 14 Mar 2011 13:50:16 -0400 (EDT)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-sd.pobox.com (Postfix) with ESMTPSA id 981BF3394; Mon, 14 Mar 2011
 13:50:13 -0400 (EDT)
In-Reply-To: <4D7E4118.6060802@elegosoft.com> (Jakob Pfender's message of
 "Mon, 14 Mar 2011 17:23:52 +0100")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 85248AC4-4E63-11E0-9CB0-E8AB60295C12-77302942!a-pb-sasl-sd.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/169003>

Jakob Pfender <jpfender@elegosoft.com> writes:

> The struct object_refs in object.h is never used anywhere, so remove it.
>
> Signed-off-by: Jakob Pfender <jpfender@elegosoft.com>

Thanks; I'd rephrase the above like this (no need to resend):

	7914053 (Remove unused object-ref code, 2008-02-25) removed
        all uses of the structure from the code, but forgot to remove
        the type definition itself.

Thanks.



	
