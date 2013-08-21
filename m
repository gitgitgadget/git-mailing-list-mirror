From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 0/3] t3404 incremental improvements
Date: Wed, 21 Aug 2013 16:25:33 -0700
Message-ID: <xmqqk3jesk2a.fsf@gitster.dls.corp.google.com>
References: <1377112378-45511-1-git-send-email-sunshine@sunshineco.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Eric Sunshine <sunshine@sunshineco.com>
X-From: git-owner@vger.kernel.org Thu Aug 22 01:25:43 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VCHmY-00014N-9v
	for gcvg-git-2@plane.gmane.org; Thu, 22 Aug 2013 01:25:42 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752670Ab3HUXZi (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 21 Aug 2013 19:25:38 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:58958 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752116Ab3HUXZh (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 21 Aug 2013 19:25:37 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 9B9623B87F;
	Wed, 21 Aug 2013 23:25:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=FCU5VQEZie5AgiBuAhF01wEWgoc=; b=hC8tL4
	sZlHacbA+CbLYfaqyFDkD2KIafw79mG81Nw5McNNa9iL+kuO3Ci8+AaPIJqB0AGL
	MwAq+FbvUaMafqhIIZYgqBGFlYc6FWejIwqI8jDRfyL6qdPgaebXMwSBJ6+n/iJm
	eqK+8c5LJZPtgw9jqw5iRbt3DGIAT8LcJXk00=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=rm5jjMA5LY/+aEL5bbbijij55dXVlb6u
	2keRcJS+azzJiYlY3ENyarqDG9uG9mxPMbb5WCYPERlFPuaT9MHU3Oubqupj5me4
	UrKoQf34404uC4ViIgmfJ/998T9ql417teEl+zkae3pJmovGohLEyFk2sElBpjZ7
	BlnEZ7UWU78=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 8D8B53B87E;
	Wed, 21 Aug 2013 23:25:36 +0000 (UTC)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id E62D53B87A;
	Wed, 21 Aug 2013 23:25:35 +0000 (UTC)
In-Reply-To: <1377112378-45511-1-git-send-email-sunshine@sunshineco.com> (Eric
	Sunshine's message of "Wed, 21 Aug 2013 15:12:55 -0400")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.3 (gnu/linux)
X-Pobox-Relay-ID: FB69A1C4-0AB8-11E3-BFB7-CA9B8506CD1E-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/232750>

Eric Sunshine <sunshine@sunshineco.com> writes:

> This set of patches was meant to be a re-roll of [1] addressing Junio's
> comments, however [1] graduated to 'next' before I found time to work on
> it further, so these are instead incremental patches atop 'next'.

Just FYI, 'next' will be rewound once the upcoming release is done,
so we have a chance to rewind and squash.
