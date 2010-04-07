From: Junio C Hamano <gitster@pobox.com>
Subject: Re: (resend v2) Re: [RFC PATCH 1/4] Document the HTTP transport
 protocol
Date: Wed, 07 Apr 2010 12:51:50 -0700
Message-ID: <7v1verca7d.fsf@alter.siamese.dyndns.org>
References: <1255065768-10428-1-git-send-email-spearce@spearce.org>
 <1255065768-10428-2-git-send-email-spearce@spearce.org>
 <7vskdss3ei.fsf@alter.siamese.dyndns.org> <20100408031159.00006ec7@unknown>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: "Shawn O. Pearce" <spearce@spearce.org>, git@vger.kernel.org
To: Tay Ray Chuan <rctay89@gmail.com>
X-From: git-owner@vger.kernel.org Wed Apr 07 21:52:13 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1NzbIK-0008SZ-GQ
	for gcvg-git-2@lo.gmane.org; Wed, 07 Apr 2010 21:52:12 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751050Ab0DGTwB (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 7 Apr 2010 15:52:01 -0400
Received: from a-pb-sasl-quonix.pobox.com ([208.72.237.25]:41532 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750763Ab0DGTwA (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 7 Apr 2010 15:52:00 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id 6BDFBA8F79;
	Wed,  7 Apr 2010 15:51:59 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=m3Ok3+XkkWhwLNCKwIQ28qP3C4o=; b=PwhRRr
	vptGq2Kk1NyX/5hASq0aXJmKvfXpvQ0MRY65wHny9eqTIyJKM63p/Lo+AEKXRiIR
	1MC4C8tc3E31dhGZK+Cge/TkQngsY9Nxp3WBq2dlrpLh5lS5vSMLWiKUnyZHdwEa
	1rPKAGC2p7zv4M75RhnPtIayljVxKg/dk9BTE=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=NJDp2WwBd6TMDAKukrcvQBUucc116AWm
	CJhiO2na7tbN69zq+lUtRwqLCycwzLtr24t73E+yBygPFD1OvaiF+xnqvHcCWMCP
	2RCOH+Ygf3XI0FRFFPnAHSkNvvsvegdtguCwd2sMmnaGlh14kHModDsL/uynL2Pg
	gN/uyUfQ2p0=
Received: from a-pb-sasl-quonix. (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id 32122A8F76;
	Wed,  7 Apr 2010 15:51:56 -0400 (EDT)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 740E2A8F70; Wed,  7 Apr
 2010 15:51:52 -0400 (EDT)
In-Reply-To: <20100408031159.00006ec7@unknown> (Tay Ray Chuan's message of
 "Thu\, 8 Apr 2010 03\:11\:59 +0800")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: 054E721A-427F-11DF-8E04-D033EE7EF46B-77302942!a-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/144278>

Tay Ray Chuan <rctay89@gmail.com> writes:

> (I'm reviving this thread to complete the document. What I have right
> now is available at my github repo; you can see it at
>
>   http://github.com/rctay/git/compare/git/next...feature/http-doc#files_bucket

I looked at the above page; it was quite readable.  You seem to have
picked up Shawn's non-patch responses to reviews quite well.

By the way, aren't there a better way than visiting:

    http://github.com/rctay/git/commits/feature/http-doc/Documentation/technical/http-protocol.txt

and then repeat (click each commit, go back)

to get a moral equivalent of "git log -p feature/http-doc -- $that_path"?
