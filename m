From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [RFC PATCH 0/3] git-p4: move to toplevel
Date: Sun, 12 Feb 2012 22:17:11 -0800
Message-ID: <7vwr7rgsuw.fsf@alter.siamese.dyndns.org>
References: <1329070423-23761-1-git-send-email-pw@padd.com>
 <4F380ADB.4090304@diamand.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Pete Wyckoff <pw@padd.com>, git@vger.kernel.org,
	Vitor Antunes <vitor.hda@gmail.com>
To: Luke Diamand <luke@diamand.org>
X-From: git-owner@vger.kernel.org Mon Feb 13 07:17:51 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RwpEP-0007Ie-8p
	for gcvg-git-2@plane.gmane.org; Mon, 13 Feb 2012 07:17:45 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751104Ab2BMGRP (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 13 Feb 2012 01:17:15 -0500
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:35589 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750837Ab2BMGRP (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 13 Feb 2012 01:17:15 -0500
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 28F9F4647;
	Mon, 13 Feb 2012 01:17:14 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=ItZpA/SyGQ+d/ZJvGkvaiV2aV8M=; b=L7jVIZ
	J4Rn/tCY5MIaq5uEMBMf4UNey04pzo3SwwMOBqsTQRgH5LdI8y33LQTj8n+YCbd0
	qpO83T0Agv/FajMZrRS+NbA8WZB+m7BNsj2JGDgoYermfTiJBGPwdqRi53xGjjoY
	WrnGP21LLmWbtVM672gHbZbaiaXCsyOeerrOU=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=VFlC/NDPzGSC5nnORQyEkePV39kqRKLI
	h9MtxFsD6pijgd/sEwwZwHyw4gK0Omf5BQX+8zKe0cKWcW2hSgeiFqge0ay5Gzig
	3PKcMr0LzkQ2MyKUiYPXl91weGE5hmi3qWWlPpzEs1S619WevYhwKi2XVH6YvUrW
	hnwSHkmqsAY=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 1FDBA4646;
	Mon, 13 Feb 2012 01:17:14 -0500 (EST)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id A73464643; Mon, 13 Feb 2012
 01:17:12 -0500 (EST)
In-Reply-To: <4F380ADB.4090304@diamand.org> (Luke Diamand's message of "Sun,
 12 Feb 2012 18:54:19 +0000")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 5E24E176-560A-11E1-8D8F-9DB42E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/190609>

Luke Diamand <luke@diamand.org> writes:

> On 12/02/12 18:13, Pete Wyckoff wrote:
>> The git-p4 code is in a single python script down in
>> contrib/fast-import now.  I'd like to move it up to the top-level
>> source directory of git to make it easier to build and
>> distribute.  Git-p4 already takes advantage of the git
>> infrastructure for documentation and testing, as well as the
>> community support (Junio, many reviewers).
>
> About time this was done. There's still a few oddities around but far
> fewer than there used to be. I don't know if Junio has some rules on
> what a command needs before it graduates from contrib though.

I try not to play a dictator around here. The primary thing I hesitated so
far about git-p4 is that it is useless if you live in the open source only
world, iow without proprietary software.
