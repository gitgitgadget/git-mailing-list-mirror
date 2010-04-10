From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [WIP PATCH 0/4] Recursively checkout submodules
Date: Fri, 09 Apr 2010 22:07:48 -0700
Message-ID: <7v39z3zyhn.fsf@alter.siamese.dyndns.org>
References: <4BBF9D6F.2000006@web.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Git Mailing List <git@vger.kernel.org>
To: Jens Lehmann <Jens.Lehmann@web.de>
X-From: git-owner@vger.kernel.org Sat Apr 10 07:08:16 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1O0SvW-0004ux-Qz
	for gcvg-git-2@lo.gmane.org; Sat, 10 Apr 2010 07:08:15 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750868Ab0DJFH4 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 10 Apr 2010 01:07:56 -0400
Received: from a-pb-sasl-quonix.pobox.com ([208.72.237.25]:47844 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750811Ab0DJFHz (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 10 Apr 2010 01:07:55 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id E4480A9550;
	Sat, 10 Apr 2010 01:07:54 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=aYctYLrX51KZDalpL27Ruc0C+ps=; b=gnDFoS
	ImwJ73RPibC+ratuVgLbMBVtItrO7pbFbJd9DsEcKCQF+NRB78GMVbZE3MS2gP9n
	cpdAamoQjk+bSQx2gP3NJPeOUD9vR1wscZ9PjIJ8th+u9nW4mMmscOABoELAzV9K
	N5Dd/0FWYvvhITu0+nrYN58W6IGixp6Ty1PdM=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=wQSyHdCxeC1hnoOCQEZiDCwS/fNR37hi
	NkCu9+LLVlenTmw3/dThbNfNc9gOrLqOT3uaM6gMue8iabmaAGgal2bbZHf8nvxZ
	O4XhlV1oxWmEJEC/vqAHC6QMaX7iw/Nr24Us1EfLEz9UQvY1PeZLSb5RNFTkMR5o
	DPM2SS+ZYb8=
Received: from a-pb-sasl-quonix. (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id C2550A954F;
	Sat, 10 Apr 2010 01:07:52 -0400 (EDT)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 3BFD2A954E; Sat, 10 Apr
 2010 01:07:50 -0400 (EDT)
In-Reply-To: <4BBF9D6F.2000006@web.de> (Jens Lehmann's message of "Fri\, 09
 Apr 2010 23\:34\:39 +0200")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: 04365802-445F-11DF-8C3D-D033EE7EF46B-77302942!a-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/144507>

Jens Lehmann <Jens.Lehmann@web.de> writes:

> Having found some Git time recently i started to tackle the next
> major issue on my agenda to improve submodule experience: Check
> out the matching versions of populated submodules when doing a
> checkout in the superproject (without having to do an explicit
> "git submodule update").
> ...
> Opinions?

Forgot to say the most important thing.  I like the general direction.
