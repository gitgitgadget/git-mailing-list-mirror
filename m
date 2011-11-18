From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 8/8] Enable GIT_DEBUG_MEMCHECK on git_pathname()
Date: Thu, 17 Nov 2011 23:35:44 -0800
Message-ID: <7vobw9lw6n.fsf@alter.siamese.dyndns.org>
References: <1321522335-24193-1-git-send-email-pclouds@gmail.com>
 <1321522335-24193-9-git-send-email-pclouds@gmail.com>
 <CALkWK0ndE1Q_jNSV7CBB5W2NyVhcy7kgNO5woWWOw6CXx3cxcA@mail.gmail.com>
 <20111117134201.GA30718@sigill.intra.peff.net>
 <CACsJy8A25SyLVKv8GwkYaHBJwU5tHqgdJK6L-upF9HWseFzCtQ@mail.gmail.com>
 <20111118012746.GA22485@elie.hsd1.il.comcast.net>
 <CALKQrgfTKmSd8se3n3xq89SXRmNPm3qz3Ckv2mUghot8kStKxA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Jonathan Nieder <jrnieder@gmail.com>,
	Nguyen Thai Ngoc Duy <pclouds@gmail.com>,
	Jeff King <peff@peff.net>,
	Ramkumar Ramachandra <artagnon@gmail.com>, git@vger.kernel.org,
	Junio C Hamano <gitster@pobox.com>,
	Michael Haggerty <mhagger@alum.mit.edu>
To: Johan Herland <johan@herland.net>
X-From: git-owner@vger.kernel.org Fri Nov 18 08:35:53 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RRIzI-0006mS-Fc
	for gcvg-git-2@lo.gmane.org; Fri, 18 Nov 2011 08:35:52 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751843Ab1KRHfr (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 18 Nov 2011 02:35:47 -0500
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:34242 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751365Ab1KRHfq (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 18 Nov 2011 02:35:46 -0500
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 4245F287F;
	Fri, 18 Nov 2011 02:35:46 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=8Qdmo/WcyVFd0bXoj4hjipY42Xo=; b=yU0tnZ
	vU+SjPeFhZBDE9gsr6uS5dwENmZ3tmbu42fAVTNIx9oeGWDU5/jX5CNjVbp+C1bv
	yAxr/9AhkuNLcIFm92pgWz7AaVWZFkXoEqf37026nI5db4uKjH7ucOO4Mv3yl9lA
	SBHCJnbqYlRjLRTtmppd/vPgcCrX9Uh6WibYE=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=ioTmiZC6YDrZ35ZBzeiJXWAqJ6nmHtNr
	6YiIwQ1hw+yK72TuQEoj3OPBHzyNCbTtAR7gu5H7GO7vz6m36GiRaJpa5784SUdk
	StpmReFQTXb+MBtwUGGq2NHC8rehaasRk7NRGdfRTqT9gQMoIZo4QjlOGGFvmT8Z
	F58JmvPV0uc=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 375A4287E;
	Fri, 18 Nov 2011 02:35:46 -0500 (EST)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 8AE32287D; Fri, 18 Nov 2011
 02:35:45 -0500 (EST)
In-Reply-To: <CALKQrgfTKmSd8se3n3xq89SXRmNPm3qz3Ckv2mUghot8kStKxA@mail.gmail.com> (Johan
 Herland's message of "Fri, 18 Nov 2011 07:16:13 +0100")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: ED526E46-11B7-11E1-AF18-9DB42E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/185643>

Thanks, both. Will queue.
