From: Junio C Hamano <gitster@pobox.com>
Subject: Re: Git GSoC 2014
Date: Thu, 13 Feb 2014 14:50:36 -0800
Message-ID: <xmqqk3cyk4oz.fsf@gitster.dls.corp.google.com>
References: <20140213091037.GA28927@sigill.intra.peff.net>
	<87bnya8z6q.fsf@thomasrast.ch>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Jeff King <peff@peff.net>, git@vger.kernel.org,
	Shawn Pearce <spearce@spearce.org>
To: Thomas Rast <tr@thomasrast.ch>
X-From: git-owner@vger.kernel.org Thu Feb 13 23:50:47 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WE57H-0004sX-7J
	for gcvg-git-2@plane.gmane.org; Thu, 13 Feb 2014 23:50:47 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752133AbaBMWum (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 13 Feb 2014 17:50:42 -0500
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:37527 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751993AbaBMWum (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 13 Feb 2014 17:50:42 -0500
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 69F806CF20;
	Thu, 13 Feb 2014 17:50:41 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=oJ+swUrP3VilsABxOhczEvLN9pQ=; b=gqQaqi
	LkBr5aGBdsa1rhQ0txNtue6IT2cs2i07HEm7KvWANyHRziBKvmjBMeZjncU/bM6G
	8FSEbKwOx5vlSK80q7WOS0TLrwM2XuXboNtISEIWMYxtxc8JnMluZHeT5kZb7kua
	sCezmO4BojvFwaT/6HhvQjbK2vQ1DZX4bNyQ0=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=QDfbom6yKzdcSBse+d7ye3wCmqB1/P8s
	rXN7P4n+/5xt65FOlj0oi4C482Ge4snEJRbkiXs86wvXoYoqDFD+gI01ye7EOlFq
	SbyD8LMUrwlJHsSDJbEDW2Vg5qBTplERbDhhF/q1vccQwhUyxGk/Oe0M3go1l4J2
	NfV3J3PpP2Y=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 536236CF1F;
	Thu, 13 Feb 2014 17:50:41 -0500 (EST)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 733156CF1D;
	Thu, 13 Feb 2014 17:50:40 -0500 (EST)
In-Reply-To: <87bnya8z6q.fsf@thomasrast.ch> (Thomas Rast's message of "Thu, 13
	Feb 2014 22:45:01 +0100")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.3 (gnu/linux)
X-Pobox-Relay-ID: 431E2BCA-9501-11E3-B9C9-1B26802839F8-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/242082>

Thomas Rast <tr@thomasrast.ch> writes:

> Downside: not listing "code merged" as a goal may not make the project
> as shiny, neither for Git nor for the student.

I'd actually view that as an upside. This sounds like a good first
step for a feasibility study that is really necessary.

I wonder why the handling of storage corruption and replacement
could be left broken, though. Is that because libgit2 has known
breakages in these areas, or is there some other reason?
