From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v2] git-commit.txt: clarify -t requires editing message
Date: Fri, 30 Mar 2012 11:17:17 -0700
Message-ID: <7vaa2ylzrm.fsf@alter.siamese.dyndns.org>
References: <CAF_oF=xGHdbkYw-ytvcZvJnqZ_jdckUCBiuUDzkqGDk=66+yMQ@mail.gmail.com>
 <1333062296-27823-1-git-send-email-haircut@gmail.com>
 <7vboneq1vs.fsf@alter.siamese.dyndns.org> <4F75236C.4050703@gmail.com>
 <7vr4waoics.fsf@alter.siamese.dyndns.org> <4F753C3F.7010805@gmail.com>
 <7vehsaoev5.fsf@alter.siamese.dyndns.org> <4F7547EA.9050609@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Ivan Heffner <iheffner@gmail.com>, git@vger.kernel.org
To: Adam Monsen <haircut@gmail.com>
X-From: git-owner@vger.kernel.org Fri Mar 30 20:17:57 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SDgOa-0006c3-Rc
	for gcvg-git-2@plane.gmane.org; Fri, 30 Mar 2012 20:17:57 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756490Ab2C3SRW (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 30 Mar 2012 14:17:22 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:40505 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753236Ab2C3SRU (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 30 Mar 2012 14:17:20 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id B08A67033;
	Fri, 30 Mar 2012 14:17:19 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=ZlS3dRLhKsku1cKZ4FJqNzPh8JQ=; b=dPxMKH
	R3jAtKlSkt8lgvX3KfyxgFQdN3OUAcmwUKhN0QdmqzSTGbF9dL/cI73X9WEFwsCZ
	GIgRj7gyU9MIH2WgK1gzFT+hCAkHMBeLZAPDV14Mkf6O4DFiooFX4D9FaV22fgnD
	NJ3Nje589GuMBOC6gUj1eMjvph+Kxt3nSURVQ=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=r2uMKqK+m48lXh2pKtJCxcCLwF17kbna
	PaHhBJsBs8mZJwzRDOPAAnHQH+TLD3v4Moa1NZ+mI8FFlwLNSza3wRuLrHQ1Kljy
	Wkja+jCk4fhX1H6uFLPD8IdxM8hm/HcS4Fx5Mk5GMtgtti1FvJ3E8leZ7Lce93jG
	ngBCgNjC0R4=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id A7C477032;
	Fri, 30 Mar 2012 14:17:19 -0400 (EDT)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 3EA3A702F; Fri, 30 Mar 2012
 14:17:19 -0400 (EDT)
In-Reply-To: <4F7547EA.9050609@gmail.com> (Adam Monsen's message of "Thu, 29
 Mar 2012 22:43:06 -0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 964537FA-7A94-11E1-B087-9DB42E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/194383>

Adam Monsen <haircut@gmail.com> writes:

> Junio C Hamano wrote:
>> I think that is something that needs fixing the broken code to behave
>> less confusingly, not documenting its wrong behaviour.
>
> Excellent! I concur.
>
> I wish I wanted to do this enough to make time to work on it. Ivan, how
> are your C chops? :)

Don't worry.  While looking around the vicinity of the codepath, I noticed
a few more bugs there, so I'll post something today.
