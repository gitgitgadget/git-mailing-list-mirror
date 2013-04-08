From: Junio C Hamano <gitster@pobox.com>
Subject: Re: --simplify-merges breakage
Date: Mon, 08 Apr 2013 12:54:11 -0700
Message-ID: <7vfvz0x0gs.fsf@alter.siamese.dyndns.org>
References: <516313D3.2050309@bracey.fi>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Kevin Bracey <kevin@bracey.fi>
X-From: git-owner@vger.kernel.org Mon Apr 08 21:54:27 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UPI93-0007Qq-Et
	for gcvg-git-2@plane.gmane.org; Mon, 08 Apr 2013 21:54:25 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S935871Ab3DHTyQ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 8 Apr 2013 15:54:16 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:45061 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S935858Ab3DHTyO (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 8 Apr 2013 15:54:14 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 7EA281495D;
	Mon,  8 Apr 2013 19:54:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=ikuM9BlMUo2t5U2d66KaR9UJk0I=; b=Rz/EoA
	HZHOriYlm4MYpr0CMpASkpRtVLaRQ+kNnTP1uMBn3XXwdrIE71h4/N2pHfnVuaFl
	r4Nj2a/h8Zuf/AgBboxGKOBcEqobJ4Gck1YyeLl67ueUYHhtfhLvT1diXpohYRxn
	gS25lnekTqwXny+tQcGB7xQo4gPST/62AWFxk=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=slvw7U1l/lwFg88Mds2AJgRQnJvOkUMn
	JlBrKwD32EUEt0z9pMZEtoiZpvXIFtJvvwbxhJVWckO365/WZ9NDvVPyyLtTJTGN
	yy5Q5gf7vqBC7azv95+Q16Zci6QFpRRZ69arG6aIVJpr6cURb7mZQNlo+RezBdSN
	OWNkv3hdDXU=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 71B151495C;
	Mon,  8 Apr 2013 19:54:13 +0000 (UTC)
Received: from pobox.com (unknown [24.4.35.13]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id D744E14952; Mon,  8 Apr
 2013 19:54:12 +0000 (UTC)
In-Reply-To: <516313D3.2050309@bracey.fi> (Kevin Bracey's message of "Mon, 08
 Apr 2013 22:00:35 +0300")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 15F3D3F4-A086-11E2-89E5-8341C8FBB9E7-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/220504>

Kevin Bracey <kevin@bracey.fi> writes:

> Commit 4b7f53d ("simplify-merges: drop merge from irrelevant side
> branch") appears to have broken simplify-merges.
>
> ... now I see the "report problems
> immediately" message on the recent merge of that change.

I hope more people now see why we would like to see more people try
'next' regularly.

Will revert it for now, but that would mean side histories like gitk's
will keep showing up in the simplified view.
