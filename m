From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] diff-highlight: Work for multiline changes too
Date: Mon, 13 Feb 2012 17:19:33 -0800
Message-ID: <7vk43q9pp6.fsf@alter.siamese.dyndns.org>
References: <20120210213209.GA7582@sigill.intra.peff.net>
 <1328910433-2539-1-git-send-email-michal.kiedrowicz@gmail.com>
 <20120213222702.GA19393@sigill.intra.peff.net>
 <7v8vk6b7pq.fsf@alter.siamese.dyndns.org>
 <20120214002209.GA23171@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: =?utf-8?Q?Micha=C5=82?= Kiedrowicz <michal.kiedrowicz@gmail.com>,
	git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Tue Feb 14 02:19:41 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Rx73U-0003kh-CB
	for gcvg-git-2@plane.gmane.org; Tue, 14 Feb 2012 02:19:40 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758431Ab2BNBTg (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 13 Feb 2012 20:19:36 -0500
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:37949 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754057Ab2BNBTf (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 13 Feb 2012 20:19:35 -0500
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 229C171D3;
	Mon, 13 Feb 2012 20:19:35 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=Q1kK1DNbxRxiLN+SXed4a1/YBxQ=; b=w83cLH
	EkXCTDGMCSLF4mwm9k0BeGglUWeTCSHk4uploH1uS0INQBKonBIXs20grFa6p+zW
	VpIadbxOPq3a7tX9h0yMKGfdthHtC5/KX+ny8ictQdx8CWmBYZY9dazXau4kqCtN
	iOv4OjreC7t0Kraaq9v3cIZkRPnbQDxHqzgb4=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=Lqhe4j1UnoHUgzR+Dwd/TEnuRo5GyhQr
	WTjXTiqCwJZ+suaoTWRfR/nGOu7GLh+L3S+dZwXRmVOMrHjQHTtbdYno/MKCiXT6
	TcPGqGQTNrXzNHwBh3c5P6zydCiVnQLJgwtOLK7GhroY6e6/KHO96ez60LZ+SnkQ
	4y0PzHDq1WY=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 197E871D2;
	Mon, 13 Feb 2012 20:19:35 -0500 (EST)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 927A571D1; Mon, 13 Feb 2012
 20:19:34 -0500 (EST)
In-Reply-To: <20120214002209.GA23171@sigill.intra.peff.net> (Jeff King's
 message of "Mon, 13 Feb 2012 19:22:09 -0500")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: F44F16F4-56A9-11E1-8F8C-9DB42E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/190696>

Jeff King <peff@peff.net> writes:

> I chose reverse because I like the way it looks, and because it should
> Just Work if people have selected alternate colors (I never dreamed
> somebody would use "reverse" all the time, as I find it horribly ugly.
> But to each his own).

I also find it ugly, but I am on black-letters on white background window,
and I do not see my terminal's red very well, so it is hard to tell the
old from the context if I use the "diff.color.old=red" default; that is
the primary reason for my setting.
