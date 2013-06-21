From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] web--browse: support /usr/bin/cygstart on Cygwin
Date: Fri, 21 Jun 2013 09:06:18 -0700
Message-ID: <7vbo6zo3d1.fsf@alter.siamese.dyndns.org>
References: <1371799472-11564-1-git-send-email-yselkowitz@users.sourceforge.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: "Yaakov \(Cygwin\/X\)" <yselkowitz@users.sourceforge.net>
X-From: git-owner@vger.kernel.org Fri Jun 21 18:06:29 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Uq3r2-00053r-9U
	for gcvg-git-2@plane.gmane.org; Fri, 21 Jun 2013 18:06:28 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161581Ab3FUQGW (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 21 Jun 2013 12:06:22 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:59288 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1161419Ab3FUQGV (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 21 Jun 2013 12:06:21 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 7CB4E29AD3;
	Fri, 21 Jun 2013 16:06:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=MotpwTb5A//UZhatmVdRDVXO4Qc=; b=BFEMWk
	iXKgHLOWjj+BRBRG/1D6hbKsgcuPxKRZX9U8kQp58KrQtiN5wWcJp6hMOYBITB33
	Z2D65fMuWvPbnEoFos4Bx/D9hUbqyn1BL6PJj+5fr3JSo6RKq6vR54n8laJiBcV4
	RgtghUl2GLPLtqfvoe4T7hFQ03tNNf0B6ZITc=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=mTiDRC+gIk8ohAxh1E1ValecfbIdKhDN
	VFwuPWXKc9YKEu/AbRfiTZztyA04avFoV00tjule0asBjHuTc8KRHEYUOEcx4/kB
	MaNK4lPkaGku2Mf7NXJf4XZGnP2ovOoFZzjKEsf1A5dcTFywoDacCQ6Iq7SIayFr
	PXap4HOaddg=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 7130A29AD2;
	Fri, 21 Jun 2013 16:06:20 +0000 (UTC)
Received: from pobox.com (unknown [50.161.4.97])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id E9F0929AD0;
	Fri, 21 Jun 2013 16:06:19 +0000 (UTC)
In-Reply-To: <1371799472-11564-1-git-send-email-yselkowitz@users.sourceforge.net>
	(Yaakov's message of "Fri, 21 Jun 2013 02:24:32 -0500")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 82D2E560-DA8C-11E2-95BD-80EC6777888E-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/228623>

"Yaakov (Cygwin/X)" <yselkowitz@users.sourceforge.net> writes:

> From: Yaakov Selkowitz <yselkowitz@users.sourceforge.net>
>
> While both GUI and console Cygwin browsers do exist, anecdotal evidence
> suggests most users rely on their native Windows browser.  cygstart,
> which is a long-standing part of the base Cygwin installation, will
> cause the page to be opened in the default Windows browser (the one
> registered to open .html files).
>
> Signed-off-by: Yaakov Selkowitz <yselkowitz@users.sourceforge.net>

Will queue and wait for somebody from Cygwin land to comment.

Thanks.
