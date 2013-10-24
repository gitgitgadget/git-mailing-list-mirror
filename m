From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 02/15] t5510: prepare test refs more straightforwardly
Date: Thu, 24 Oct 2013 12:50:52 -0700
Message-ID: <xmqq4n86o3c3.fsf@gitster.dls.corp.google.com>
References: <1382543448-2586-1-git-send-email-mhagger@alum.mit.edu>
	<1382543448-2586-3-git-send-email-mhagger@alum.mit.edu>
	<xmqq61snrg0q.fsf@gitster.dls.corp.google.com>
	<5268C30E.4050906@alum.mit.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org,
	Carlos =?utf-8?Q?Mart=C3=ADn?= Nieto <cmn@elego.de>,
	Michael Schubert <mschub@elegosoft.com>,
	Johan Herland <johan@herland.net>, Jeff King <peff@peff.net>,
	Marc Branchaud <marcnarc@xiplink.com>,
	Nicolas Pitre <nico@fluxnic.net>,
	John Szakmeister <john@szakmeister.net>
To: Michael Haggerty <mhagger@alum.mit.edu>
X-From: git-owner@vger.kernel.org Thu Oct 24 21:51:01 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VZQvr-0001CQ-KV
	for gcvg-git-2@plane.gmane.org; Thu, 24 Oct 2013 21:50:59 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755849Ab3JXTu4 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 24 Oct 2013 15:50:56 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:55779 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753940Ab3JXTuz (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 24 Oct 2013 15:50:55 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id C65504D416;
	Thu, 24 Oct 2013 19:50:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=1gewAcLEpfRvgSHYGvCa00x5sqE=; b=yga8/W
	suUEkYRPIuYl+A33DTMYJ3i1pOvLXf3Tym4EEEni5L+Hs4B6xcxDfg1hrj5IMpis
	YsKX9/cm9JMedQReCfbhglP3uOE8UFTeMjF8WE9vTnOSZHunrZW233hIu5O91f/M
	W1yLkjiGJzn+ZjckzkAvdRbHiRJT5r7jr84yo=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=S3EPhQVc2FMmeEFnfpp6S8Ng4gc+Zkn1
	Fgpfd4jjxISjKwN7GY2s1WmOBicwXLs4+MVUGssdzjT5AvdtiH6q8AM05jkdIg63
	aQRVs9w2SshkikPb7iU7zhx9oc4mT0nqafiiJp3pUw8ZkieRmaKTNZDY3y1NrnV4
	0a22AePwOSo=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id B604A4D415;
	Thu, 24 Oct 2013 19:50:54 +0000 (UTC)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 0DD054D413;
	Thu, 24 Oct 2013 19:50:54 +0000 (UTC)
In-Reply-To: <5268C30E.4050906@alum.mit.edu> (Michael Haggerty's message of
	"Thu, 24 Oct 2013 08:49:50 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.3 (gnu/linux)
X-Pobox-Relay-ID: 97B410BA-3CE5-11E3-89E6-8F264F2CC097-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/236614>

Michael Haggerty <mhagger@alum.mit.edu> writes:

>> As long as you have checked that our local 'master' should be at the
>> same commit as the origin's 'master' at this point, I think this
>> change is OK.
>
> It doesn't matter what the reference points at; the only point of these
> tests is to check whether branches that look like stale remote-tracking
> branches are pruned or not by the later command.

OK, thanks.
