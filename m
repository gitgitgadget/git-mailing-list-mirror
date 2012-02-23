From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v2 0/4] Making an elephant out of a getline() bug
Date: Thu, 23 Feb 2012 11:04:25 -0800
Message-ID: <7vobsp4bie.fsf@alter.siamese.dyndns.org>
References: <7vty2i5ie2.fsf@alter.siamese.dyndns.org>
 <cover.1329988335.git.trast@student.ethz.ch>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Johannes Sixt <j6t@kdbg.org>, Jeff King <peff@peff.net>,
	Jannis Pohlmann <jannis.pohlmann@codethink.co.uk>,
	<git@vger.kernel.org>
To: Thomas Rast <trast@student.ethz.ch>
X-From: git-owner@vger.kernel.org Thu Feb 23 20:05:06 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1S0dyO-0001hg-5v
	for gcvg-git-2@plane.gmane.org; Thu, 23 Feb 2012 20:05:00 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753018Ab2BWTEz (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 23 Feb 2012 14:04:55 -0500
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:36699 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752524Ab2BWTEy (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 23 Feb 2012 14:04:54 -0500
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 06C95696E;
	Thu, 23 Feb 2012 14:04:50 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=jC6G7HrhE9Z/3nuE0EgmFEbPfBc=; b=IodO6h
	rEsqOz55wDIKDKsWhGlZqd1wOvJx82qV1JU1/ei6asXXYs8qHnjjUtO7hFd065ac
	2r1qjHQ237YWvDnIOWeIW3Zd2mGegHOtTS/PQCzEeEF5kmngMRvdbT92r9X6j42f
	9jgktve7MsEXGQjXil9pYlwjW8qrR/kBOPGW8=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=dqNXOfL2Dtp6MEfApt3uJNdNmHWOlBKR
	YEaIlTP3l8KQG28zgWlbkQ1gIBKVOWIbc82huJUwiv1s3X4e4FJ3SoRTSMmtqwPr
	6PiULqbJQq2X1SO6HKypaEeW1ICjecU89mD0JCaSlwc5RTbwIQOlhnMTPbo/v24B
	X0VGzOx6ols=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 852466958;
	Thu, 23 Feb 2012 14:04:47 -0500 (EST)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 1995D6887; Thu, 23 Feb 2012
 14:04:26 -0500 (EST)
In-Reply-To: <cover.1329988335.git.trast@student.ethz.ch> (Thomas Rast's
 message of "Thu, 23 Feb 2012 10:42:20 +0100")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 34EF5C38-5E51-11E1-A476-9DB42E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/191384>

Thomas Rast <trast@student.ethz.ch> writes:

> So you all made very good points, and I don't want to repeat them.

I really wish you did not make an elephant out of this, or if you must,
kept the minimum bugfix part that must apply to older codebase and making
an elephant part clearly separable.

Anyway, I've reordered so that the bugfix part would apply to an older
maintenance release, and then the remainder applied on top would merge
cleanly to the bleeding edge, so there is no need to resend.

Thanks for working on this, everybody.
