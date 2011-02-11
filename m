From: Junio C Hamano <gitster@pobox.com>
Subject: Re: recurse_submodules vs recurse-submodules
Date: Thu, 10 Feb 2011 17:54:10 -0800
Message-ID: <7vk4h71gl9.fsf@alter.siamese.dyndns.org>
References: <AANLkTimppKC_CsN6hc4xGqtMBk8p2QEFjHYRWesKK8_r@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: GIT <git@vger.kernel.org>, Jens.Lehmann@web.de
To: Chris Packham <judge.packham@gmail.com>
X-From: git-owner@vger.kernel.org Fri Feb 11 02:54:28 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PniDL-0001nI-B6
	for gcvg-git-2@lo.gmane.org; Fri, 11 Feb 2011 02:54:27 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932259Ab1BKByW (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 10 Feb 2011 20:54:22 -0500
Received: from a-pb-sasl-sd.pobox.com ([64.74.157.62]:63982 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932258Ab1BKByV (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 10 Feb 2011 20:54:21 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id 774E247ED;
	Thu, 10 Feb 2011 20:55:21 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=z/+F4GwlIIa6ORA2YaYzQvYZHas=; b=sJPf2D
	xvtl87nwpL6XQUKUba/m6Kwt3nCubWSIfoAe4aZ/J+Gg2+alJqMP/dGrL0/g5Ke1
	GMAZkyowxQVIo9H7HhK8/G1qkjY3B8weWzS7PBNTFzb2rI2e60DcGebUpwLHIFNB
	2QagdsBh9klYhRpkKEfH1WbnjHSgB2LUT6sy4=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=QFiTcX8kt0CiOpsDmVXRXVlBj69tVY/Q
	jMS3jU0rmzikll4LSyled08FfBV/gfemqncPjImC0DRfDuChzN18CKHcz7KVCO3Y
	ZtviDF3tQ2Wq3uvjYWBQGfcnTSxLPMW1WeXcbUpNJwc4nLlydMD7sfEjk9k3ajPi
	4ETGiw7qZww=
Received: from a-pb-sasl-sd.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id 44BE947EC;
	Thu, 10 Feb 2011 20:55:18 -0500 (EST)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-sd.pobox.com (Postfix) with ESMTPSA id 0DA8B47EB; Thu, 10 Feb 2011
 20:55:13 -0500 (EST)
In-Reply-To: <AANLkTimppKC_CsN6hc4xGqtMBk8p2QEFjHYRWesKK8_r@mail.gmail.com>
 (Chris Packham's message of "Fri\, 11 Feb 2011 11\:59\:31 +1300")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: F9F05AC2-3581-11E0-82CA-AF401E47CF6F-77302942!a-pb-sasl-sd.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/166533>

Sounds like a sane thing to do.  Thanks.
