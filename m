From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 00/15] Change semantics of "fetch --tags"
Date: Wed, 23 Oct 2013 09:59:12 -0700
Message-ID: <xmqqr4bbrkin.fsf@gitster.dls.corp.google.com>
References: <52327E62.2040301@alum.mit.edu>
	<1382543448-2586-1-git-send-email-mhagger@alum.mit.edu>
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
X-From: git-owner@vger.kernel.org Wed Oct 23 18:59:21 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VZ1mC-0005OY-MY
	for gcvg-git-2@plane.gmane.org; Wed, 23 Oct 2013 18:59:21 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752519Ab3JWQ7Q (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 23 Oct 2013 12:59:16 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:42289 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751531Ab3JWQ7Q (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 23 Oct 2013 12:59:16 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 498544C2B4;
	Wed, 23 Oct 2013 16:59:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=xU1h/KfcGNPpIaX+8GLKGOFolaI=; b=ZDfYjh
	haYScZLJlI4d/UB/XmJFNONbrcKpaEIx/SKSLCpEQ/P+5Cnvxf16rgusO3YmzHd7
	N6SkK+DNEKi4UpZ8t+64Y6D8rWQJc5ryPu1V6vvy2LMoxp+xz4FoktAwWqNRfuB+
	JM8zaq+2boGoNl8KTuWQM6QeGtXpId8VdNINk=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=JZndjE5Qbs8IVIWWwBlNgig8lu2A6UJ/
	xa7nbigpuVs+p0mklTosKrkYZ9SQ+hLGRAGtk/oLuz9LF3hc5iTbaqzmnxGyZcDz
	t7z6eEuRAaco2YdsRfPG2A6/2mgf455VGpAwZPctM6otO+wxXP/n3cdM2y5T3W1o
	bQlnUJpwkm8=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 34E5C4C2B3;
	Wed, 23 Oct 2013 16:59:15 +0000 (UTC)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 7D6E44C2A8;
	Wed, 23 Oct 2013 16:59:14 +0000 (UTC)
In-Reply-To: <1382543448-2586-1-git-send-email-mhagger@alum.mit.edu> (Michael
	Haggerty's message of "Wed, 23 Oct 2013 17:50:33 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.3 (gnu/linux)
X-Pobox-Relay-ID: 72460B58-3C04-11E3-86F2-8F264F2CC097-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/236535>

Michael Haggerty <mhagger@alum.mit.edu> writes:

> This is my proposed fix for the "local tag killer" problem that I
> reported recently [1].
>
> There are three main things changed by this patch series:
> ...

Haven't looked at any of the 1-15 messages, but the basic design to
demote "--tags" from being an explicit "refs/tags/*:refs/tags/*"
given from the command line to a more special case option sounds
very sane and solid.

With the auto-following of tags, I think it is a _mistake_ to have
"--tags" anywhere on the command line (and "tagopt" config) these
days, and I do not expect a huge fallout from incompatibility that
arises from the change in behaviour.

Thanks---looking forward to reading it through.
