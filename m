From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 0/3] git-p4: move to toplevel
Date: Mon, 09 Apr 2012 11:32:44 -0700
Message-ID: <7vfwccwyb7.fsf@alter.siamese.dyndns.org>
References: <1333930682-31670-1-git-send-email-pw@padd.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Luke Diamand <luke@diamand.org>
To: Pete Wyckoff <pw@padd.com>
X-From: git-owner@vger.kernel.org Mon Apr 09 20:32:59 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SHJOW-0006In-Ng
	for gcvg-git-2@plane.gmane.org; Mon, 09 Apr 2012 20:32:53 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757643Ab2DIScs (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 9 Apr 2012 14:32:48 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:47428 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754579Ab2DIScr (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 9 Apr 2012 14:32:47 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id D87F67506;
	Mon,  9 Apr 2012 14:32:46 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=53tgtOsVL9VM1D9tZACBOVIrgVo=; b=lDAfnH
	JJz9TNCMCr2mDtxCv+QV4ZqYPn6vOVrRI9iaVXPfB4q4vgSGp5MOKUA3dk7WHHtv
	lUXKV1w+AQc80Yonhdbk5kaCll2GRLFhpXD/CDCZvNKFVUnaiZvJAQPxb79dG+I4
	p5rJe2Wf6oTDfmDRbJqll9htOQRDJRZqu+m2k=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=oCamsGijHRZdk+JStF8la2JcJDhYT3Cw
	FDjJW7Le1H6u/CqvmgHJ6e7ptbcb9gia61Sb4ugJ+Ies08smGuu7DUG6HGBgmGuL
	l5/JQkGVjBVa48RJxubgXINjvqbQrWUpUqjQ88eQGClxbGZqiJ70SGxHBIdKCyIL
	d9LQpzEby0M=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id D07497505;
	Mon,  9 Apr 2012 14:32:46 -0400 (EDT)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 495557504; Mon,  9 Apr 2012
 14:32:46 -0400 (EDT)
In-Reply-To: <1333930682-31670-1-git-send-email-pw@padd.com> (Pete Wyckoff's
 message of "Sun, 8 Apr 2012 20:17:59 -0400")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 66F620A0-8272-11E1-8136-9DB42E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/195025>

Pete Wyckoff <pw@padd.com> writes:

> The only observation from the RFC series was that git-p4 is useful only
> in the non-open-source world.  While you can download p4 for testing, a
> production environment is not free.  No one particularly complained
> about that though.

Well, we already have things like msysgit and our Makefile supports
compilation on Solaris or MacOS, where you need to have commercial
products to make use of Git.  I do not think this project is about making
life difficult for people who use commercial product in order to promote
free software anyway, so...
