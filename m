From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 2/4] glossary: define committish (a.k.a. commit-ish)
Date: Wed, 19 Jun 2013 14:05:50 -0700
Message-ID: <7vtxktyfo1.fsf@alter.siamese.dyndns.org>
References: <1371607780-2966-1-git-send-email-rhansen@bbn.com>
	<1371607780-2966-3-git-send-email-rhansen@bbn.com>
	<7vhagu10ql.fsf@alter.siamese.dyndns.org> <51C203A1.4000404@bbn.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Richard Hansen <rhansen@bbn.com>
X-From: git-owner@vger.kernel.org Wed Jun 19 23:05:58 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UpPZl-00049g-Om
	for gcvg-git-2@plane.gmane.org; Wed, 19 Jun 2013 23:05:58 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S935204Ab3FSVFy (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 19 Jun 2013 17:05:54 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:57210 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S935060Ab3FSVFx (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 19 Jun 2013 17:05:53 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 5CD62290AA;
	Wed, 19 Jun 2013 21:05:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=uxfiRkkT7wNPCTKC+plL6QoarNA=; b=a2iSzr
	Y5iNpgcFr/tiPIniUyuMg8BqAAoF7d0dO2MmNRAcRlk0vgujHj/SsRrJ3dn+MgEm
	qfPBsokYXSXmMvghNx/03mXLlC6EAGewCJnLN/DxJ2outfmvNEpEjipKftHSmLYw
	XUzqURdzKZN6N/nfYn7BxpQRXZ+rvhNfNUQms=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=gNXLud9DFnEK6S8tVx/giXmahCANfJXH
	i6DmvKm3T9uZm4cDqrB7/8J4oh2m6sGidb9UuYoXVu1gwcUk34LDElEpmxt3Aqou
	t6tcTlU9z6CPYBDlVIbFGB1zt4U1U40GDATX563j1M68xw/VjetjGQ+kwOA3cfAm
	7xNrfSfJV7s=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 51CFD290A9;
	Wed, 19 Jun 2013 21:05:52 +0000 (UTC)
Received: from pobox.com (unknown [50.161.4.97])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id B2488290A8;
	Wed, 19 Jun 2013 21:05:51 +0000 (UTC)
In-Reply-To: <51C203A1.4000404@bbn.com> (Richard Hansen's message of "Wed, 19
	Jun 2013 15:16:49 -0400")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 06021286-D924-11E2-9822-80EC6777888E-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/228424>

Richard Hansen <rhansen@bbn.com> writes:

> On 2013-06-19 13:14, Junio C Hamano wrote:
>> <object-type>-ish does not have anything to do with a ref.  Even
>> when an object is dangling in your object store without being
>> reachable from any of your refs, it keeps its own "ish"-ness.
>
> Ah, so your personal definition of "ref" matches my personal definition
> of "ref", and this definition doesn't match gitglossary(7).  :)

Huh?  The only thing I I said was that "*-ish" does not have
anything to do with a ref.  I didn't say anything about definition
of "ref".

You are the one who brought "ref" into description of *-ish, with
this:

> +[[def_committish]]committish (also commit-ish)::
> +	A <<def_ref,ref>> pointing to an <<def_object,object>> that
> +	can be recursively dereferenced to a

All I am saying is that an object does not have to be pointed by any
ref to be any-ish.  ish-ness is an attribute of an object, not an
ref.  You do not say refs/heads/master (which is a ref) is a
commit-ish or a tree-ish.  The object pointed at by that ref is
always a commit and is a commit-ish and a tree-ish.
