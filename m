From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v2 2/2] Update documentation for http.continue option
Date: Wed, 23 Oct 2013 08:47:57 -0700
Message-ID: <xmqq61sornte.fsf@gitster.dls.corp.google.com>
References: <1381530945-90590-1-git-send-email-sandals@crustytoothpaste.net>
	<1381530945-90590-3-git-send-email-sandals@crustytoothpaste.net>
	<20131011235052.GV9464@google.com>
	<20131012002639.GE79408@vauxhall.crustytoothpaste.net>
	<20131018221535.GM865149@vauxhall.crustytoothpaste.net>
	<xmqqeh7csygy.fsf@gitster.dls.corp.google.com>
	<20131022233257.GA9464@google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: "brian m. carlson" <sandals@crustytoothpaste.net>,
	git@vger.kernel.org,
	=?utf-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41j?= Duy <pclouds@gmail.com>,
	Jeff King <peff@peff.net>, Shawn Pearce <spearce@spearce.org>
To: Jonathan Nieder <jrnieder@gmail.com>
X-From: git-owner@vger.kernel.org Wed Oct 23 17:48:07 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VZ0fF-0007W7-8X
	for gcvg-git-2@plane.gmane.org; Wed, 23 Oct 2013 17:48:05 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751708Ab3JWPsA (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 23 Oct 2013 11:48:00 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:57496 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751392Ab3JWPr7 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 23 Oct 2013 11:47:59 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 5AA114D8C7;
	Wed, 23 Oct 2013 15:47:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=PychOCsl+R9bR+j1ZLF8wH7IO24=; b=IAZVNI
	IYt9Ta/zdmpBeFxeYkvRLr/P2ABMjBsLB2XjMXEXHOQtGf30fSdGS1YTB0M97F2m
	XA6VrzJV+BQ59RWlXb78K1Bp/AhyWuPUikYgBY5eRdnFX90Wjhe+29lD8hW4/fIG
	5oRpDIVYS/f6iSqeCYXpM38G4bjA3+0tXj5d0=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=jY7oFyA0f5w+PizpQG4T288o2CotbLRD
	i9TWcbHqzH5HboeVULr082HUwgWRy2MLnzMdlWTY4QmhU1N67/9w4s1B2bmFSPiz
	YIMfoCYDq2CSxB/PddpnSmet1xyDbXJpcwxjjMJI8jFyurx2NMDkeAfV6xE+YLuX
	5YAYlIBsws4=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 49BCD4D8C5;
	Wed, 23 Oct 2013 15:47:59 +0000 (UTC)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 809024D8C1;
	Wed, 23 Oct 2013 15:47:58 +0000 (UTC)
In-Reply-To: <20131022233257.GA9464@google.com> (Jonathan Nieder's message of
	"Tue, 22 Oct 2013 16:32:58 -0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.3 (gnu/linux)
X-Pobox-Relay-ID: 7D95C12E-3BFA-11E3-A3C3-8F264F2CC097-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/236513>

Jonathan Nieder <jrnieder@gmail.com> writes:

> Wouldn't a natural fix be to *always* use "Expect: 100-continue" when
> and only when the probe_rpc() revealed a server supporting
> GSS-Negotiate authentication?

A stupid question. Is GSS-Negotiate the only special case?
