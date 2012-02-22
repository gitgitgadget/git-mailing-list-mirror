From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 4/4] Only re-encode certain parts in commit object, not
 the whole
Date: Tue, 21 Feb 2012 19:14:52 -0800
Message-ID: <7v39a3eez7.fsf@alter.siamese.dyndns.org>
References: <1329834292-2511-1-git-send-email-pclouds@gmail.com>
 <1329834292-2511-4-git-send-email-pclouds@gmail.com>
 <20120221182559.GB32668@sigill.intra.peff.net>
 <CACsJy8BZixyzf73TGPdf+_=rz59J4GWUq8B8WXuf+n97-OF=sQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Jeff King <peff@peff.net>, git@vger.kernel.org
To: Nguyen Thai Ngoc Duy <pclouds@gmail.com>
X-From: git-owner@vger.kernel.org Wed Feb 22 04:15:01 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1S02fU-0005vZ-RW
	for gcvg-git-2@plane.gmane.org; Wed, 22 Feb 2012 04:15:01 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753850Ab2BVDO4 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 21 Feb 2012 22:14:56 -0500
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:54082 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751830Ab2BVDOz (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 21 Feb 2012 22:14:55 -0500
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id AD539632F;
	Tue, 21 Feb 2012 22:14:54 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=im8GK4TuH1nIxA8KwkWYJ36QMXI=; b=VE/sL4
	bxbhX7fsgHeXS5Jhmd6sprpzWtDrE7nEeT2gs+FdHx/iOyonuyLymMaVTZcCNNF5
	gWHVjZMR2oMeSbNeedrL01naTfD7oXsFn8dBNQqMif/BVgfc9j+yv33gz4HUfXRi
	nYx04l0YzKDNuDOXDC2JqUV0Txio4jSELGAq0=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=NTuXgOs2PodExY2SAZ7qjVhqRTbtbEyQ
	4HqwKf65givDTy1/4Lsg98DN1x6i0ZiS5OBI0vT/VJz8UAU/rUQ0fxXerJ4AaDnb
	a7P2rMpkyMjW6x+SSNeolNCo0nxEMDANfaU4NOdl+xdY6Lj4MaGrY5IqS1fv7tfP
	noQOW2qCars=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id A3C69632E;
	Tue, 21 Feb 2012 22:14:54 -0500 (EST)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 3BC8E632D; Tue, 21 Feb 2012
 22:14:54 -0500 (EST)
In-Reply-To: <CACsJy8BZixyzf73TGPdf+_=rz59J4GWUq8B8WXuf+n97-OF=sQ@mail.gmail.com> (Nguyen
 Thai Ngoc Duy's message of "Wed, 22 Feb 2012 09:01:20 +0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 640B0EC6-5D03-11E1-826A-9DB42E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

By the way, zj/term-columns topic has already graduated to 'master', so if
you are still interested in your earlier nd/columns topic, it would be a
good time to re-roll it.

No hurries, but pointing it out just in case you forgot.
