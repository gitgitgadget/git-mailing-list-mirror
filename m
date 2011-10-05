From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [RFC/PATCH] git checkout $tree path
Date: Tue, 04 Oct 2011 19:07:04 -0700
Message-ID: <7v1uusb393.fsf@alter.siamese.dyndns.org>
References: <7vk48rq854.fsf@alter.siamese.dyndns.org>
 <20111003102647.GD16078@sigill.intra.peff.net>
 <CAG+J_Dy7gnDEK-9KAJT4M_wumS_QpzLNMVzAiOHCyEbFBU65=w@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Jeff King <peff@peff.net>, git@vger.kernel.org
To: Jay Soffian <jaysoffian@gmail.com>
X-From: git-owner@vger.kernel.org Wed Oct 05 04:07:18 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RBGtA-0006vT-Hb
	for gcvg-git-2@lo.gmane.org; Wed, 05 Oct 2011 04:07:16 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933974Ab1JECHJ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 4 Oct 2011 22:07:09 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:59402 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753297Ab1JECHI (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 4 Oct 2011 22:07:08 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 02A316659;
	Tue,  4 Oct 2011 22:07:07 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=64SzwhK95gCZ4WtWY2oMfRPBXn8=; b=CR19BA
	Ee5RHHjH4TsFSD1j/yi2BLr/Ge/7cTkLSvdgyYXTBOH3CXMNZL44CnsuiFaclU+o
	BxbPEaEnXXgjl1r63o7/bPKYcJxGqpRomLDyeGwib6tL9K43FuArPf3+wUFxq2vT
	u3I4eesd4elELrf5y1IcVzGWh3pIZEoY6G2iE=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=mNyTXIru5VkdsGcEOoo+ZTjUIcp4seBR
	ib2t03Nq3ypnYUvqnqPck7nySi2yX5emsIyMywwHATmtDpR6rS1EKfrLZaIUykQW
	tIbQDdlK8X4UMUrt3bjUjrxlhUQ+Yvz0yH4ykdVJ+2u7+A9+XwYyCFjGVKNgr8kK
	vhcIj1m7OOs=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id EF86B6658;
	Tue,  4 Oct 2011 22:07:06 -0400 (EDT)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 879D56657; Tue,  4 Oct 2011
 22:07:06 -0400 (EDT)
In-Reply-To: <CAG+J_Dy7gnDEK-9KAJT4M_wumS_QpzLNMVzAiOHCyEbFBU65=w@mail.gmail.com> (Jay
 Soffian's message of "Tue, 4 Oct 2011 11:05:11 -0400")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: B9AE0994-EEF6-11E0-8736-9DB42E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/182817>

Jay Soffian <jaysoffian@gmail.com> writes:

> I think I'd expect the first behavior with:
>
> $ git checkout master -- dir/*

If we did not have to worry about "dir/.gitignore", this proposal does
have certain attractiveness.
