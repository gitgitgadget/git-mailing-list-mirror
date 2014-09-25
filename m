From: Junio C Hamano <gitster@pobox.com>
Subject: Re: project wide: git config entry for [diff] renames=true
Date: Thu, 25 Sep 2014 11:55:32 -0700
Message-ID: <xmqqtx3va5sr.fsf@gitster.dls.corp.google.com>
References: <Pine.LNX.4.44L0.1409241106100.1580-100000@iolanthe.rowland.org>
	<1411591401-5874-1-git-send-email-sojka@merica.cz>
	<1411591401-5874-4-git-send-email-sojka@merica.cz>
	<20140925150353.GA15325@kroah.com>
	<1411660111.4026.24.camel@joe-AO725> <20140925180005.GA11755@peff.net>
	<xmqqy4t7a5vx.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: Joe Perches <public-joe-6d6DIl74uiNBDgjK7y7TUQ@plane.gmane.org>,
	git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Thu Sep 25 20:55:48 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XXECY-0004cg-Sk
	for gcvg-git-2@plane.gmane.org; Thu, 25 Sep 2014 20:55:39 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751532AbaIYSzf (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 25 Sep 2014 14:55:35 -0400
Received: from smtp.pobox.com ([208.72.237.35]:60584 "EHLO smtp.pobox.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751001AbaIYSze (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 25 Sep 2014 14:55:34 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id C9C193C2F5;
	Thu, 25 Sep 2014 14:55:33 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=lYZ9Rv6kUSz2rObm+ZQSsluPqi0=; b=s6+UxK
	o6uPU7hEGXQzpWalCg4HUfiQTSlMn28BJYSEKf33FodSZirpboMX3dKcMhS5OVqk
	jOUwYofS2l7HeZshiuLawRUMA/ILcQlUHpjm65rcBgaZ2r0qaRw2pqhGZtw+nDX0
	mXMpwyqqDMfxGavrlKG4/LaiEHmTXUpQFjnBE=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=IqRBLPY5l5JYprO80p2hQ+++U1fQ+DYZ
	A6eMGCtFSlfUylHSnK1DdiV2bjGdoGfxWJxlFpj+gZdnO3guWTrDcd62Buh25AcC
	gq2vaLJO10BDr4VYhRBayeMok/caJZ5epCDvb4yrmlECRmNV+mwO97M4PQQvlj/h
	xRbnX1crWGQ=
Received: from pb-smtp0. (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id C04043C2F4;
	Thu, 25 Sep 2014 14:55:33 -0400 (EDT)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp0.pobox.com (Postfix) with ESMTPSA id 4324E3C2F2;
	Thu, 25 Sep 2014 14:55:33 -0400 (EDT)
In-Reply-To: <xmqqy4t7a5vx.fsf@gitster.dls.corp.google.com> (Junio C. Hamano's
	message of "Thu, 25 Sep 2014 11:53:38 -0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: 871ADF46-44E5-11E4-9767-D931C4D60FE0-77302942!pb-smtp0.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/257493>

Junio C Hamano <gitster-e+AXbWqSrlAAvxtiuMwx3w@public.gmane.org>
writes:

> or even
>
>     [config]
>     	safe = !*
> ...

Gaah, I meant [include] in all places I spelled [config] in the
previous message.
