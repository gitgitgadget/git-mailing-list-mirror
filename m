From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCHv2] branch.c: simplify chain of if statements
Date: Fri, 21 Mar 2014 09:50:58 -0700
Message-ID: <xmqq4n2rwl59.fsf@gitster.dls.corp.google.com>
References: <1395071493-31435-1-git-send-email-dragos.foianu@gmail.com>
	<CAPig+cS9QApn1T3-R8n+W+1ee9FbNftsmhrr90SJKs+gqzvC5A@mail.gmail.com>
	<CAPig+cQKHQFNBob18g9UmZuE_mOpF3UMCBPfSKJYEYQpk1Z_tw@mail.gmail.com>
	<loom.20140320T001131-702@post.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Dragos Foianu <dragos.foianu@gmail.com>
X-From: git-owner@vger.kernel.org Fri Mar 21 17:51:11 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WR2ez-0007sF-7O
	for gcvg-git-2@plane.gmane.org; Fri, 21 Mar 2014 17:51:09 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1760225AbaCUQvF (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 21 Mar 2014 12:51:05 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:45125 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754057AbaCUQvC (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 21 Mar 2014 12:51:02 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 78DDA76F6E;
	Fri, 21 Mar 2014 12:51:01 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=s6IKx3nOtpDzfDL8TvosVgiNnEo=; b=eYvaKL
	AUeA6KYRnmVO1/4mK8kSMffaBzSpXdc5Q2w0coo1rK/nbGI39DLkppH08s0fO2tw
	vZE8yZgUqHmoNevy43lXiCw6SsUtBdnem7mu5GFpP+czozmUf9LwVJHhIZqMnDBU
	Q3q+/1QYFWxeQ5HHZHoBdpdA1hkZms6RHeOzo=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=wr+GnmeBilYXnEqX5i9PXlbJnM8wnvSC
	8WIDdVy0IOrlPLmnbuwOcp4Szmk9MkTDnk92Mi20ZmeH4rUVoqZ7GdiPq1Jv+J1/
	RIn0rK/O3tGrTzyy/Rzahaf0dWYgts5bOX1qHTbRrEp7xiQ12p/5fyoTz2NwEZ+c
	j4P3kHNfAjk=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 5B64076F6C;
	Fri, 21 Mar 2014 12:51:01 -0400 (EDT)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 799D176F68;
	Fri, 21 Mar 2014 12:51:00 -0400 (EDT)
In-Reply-To: <loom.20140320T001131-702@post.gmane.org> (Dragos Foianu's
	message of "Wed, 19 Mar 2014 23:12:14 +0000 (UTC)")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.3 (gnu/linux)
X-Pobox-Relay-ID: FB553BF6-B118-11E3-B0A9-8D19802839F8-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/244699>

Dragos Foianu <dragos.foianu@gmail.com> writes:

> I'm not sure it's worth pursuing the table approach further, especially
> since a solution has already been accepted and merged into the codebase.

Yes.

I would further say that you already qualify as having finished a
microproject, if I were a part of the candidate selection panel.

The important thing is for potential candidates to learn the
process, not to have their change merged somewhere my tree, and you
and many others who did a microproject and tasted the process of
proposing a change, getting reviewed and learning what are expected
of their patch submissions have finished that part already.
