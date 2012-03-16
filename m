From: Junio C Hamano <gitster@pobox.com>
Subject: Re: Edit a rerere conflict resolution
Date: Fri, 16 Mar 2012 09:20:01 -0700
Message-ID: <7vvcm4h61a.fsf@alter.siamese.dyndns.org>
References: <4F5E4B20.5080709@lyx.org>
 <7vobs1r3kn.fsf@alter.siamese.dyndns.org> <4F636227.2060102@lyx.org>
 <7vaa3gilg7.fsf@alter.siamese.dyndns.org> <4F636700.2090105@lyx.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Vincent van Ravesteijn <vfr@lyx.org>
X-From: git-owner@vger.kernel.org Fri Mar 16 17:20:17 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1S8Zsy-00027L-Tt
	for gcvg-git-2@plane.gmane.org; Fri, 16 Mar 2012 17:20:13 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1032034Ab2CPQUG (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 16 Mar 2012 12:20:06 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:62066 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1030239Ab2CPQUF (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 16 Mar 2012 12:20:05 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 80FAD705F;
	Fri, 16 Mar 2012 12:20:04 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=3hrNsxrC8qfhu95QQAmDW6Pshlg=; b=H3PJ++
	PtHjTsc9OjrMhd83IdrTK0giD+5QnDG4HXufeEaiObdGOE6BwMHDq2VI0FzCVIki
	PBLv5mNFyhgEw5PByNbUbtpJIMH7jgYVm2F/0KMNU3fnNRPLOnEDZhcaX0/n2X3Q
	MJ5AfFofv0Ogqs1GZiAnchok5BfNmd6e2SYJk=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=cz6D7bnLZ9v6xUpo/jq5wYLiJ2g8Cmz5
	/ZenN7fHQ2TkndHXBna2puzDqaSA5agkOJsEg1LSzwjY1TRj6ron8hZQv60UF1f9
	AiPvazDLosdJaTQjLZtDI/O1hT/7Gg8FVLbQul285f6pTU8vwU+qcXtQmLjpX5VZ
	AOBLHjzEUn4=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 77362705E;
	Fri, 16 Mar 2012 12:20:04 -0400 (EDT)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id A3ED4705D; Fri, 16 Mar 2012
 12:20:02 -0400 (EDT)
In-Reply-To: <4F636700.2090105@lyx.org> (Vincent van Ravesteijn's message of
 "Fri, 16 Mar 2012 17:14:56 +0100")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: E25AC9F0-6F83-11E1-93FE-9DB42E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/193275>

Vincent van Ravesteijn <vfr@lyx.org> writes:

> No, I turned rerere.autoupdate off. Proven in the above by the line
> "Resolved... " instead of "Staged...".

Yeah, actually I just tried and the procedure works with or without
autoupdate for me.

So there is something different between our setup (or the nature of the
conflict), but I do not know what it is offhand.
