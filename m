From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCHv2 00/10] Cleaning up --help-all inconsistencies
Date: Wed, 16 Feb 2011 13:34:09 -0800
Message-ID: <7vbp2birzi.fsf@alter.siamese.dyndns.org>
References: <cover.1297695910.git.git@drmicha.warpmail.net>
 <cover.1297774306.git.git@drmicha.warpmail.net>
 <7v1v39p1cv.fsf@alter.siamese.dyndns.org>
 <4D5B80E9.90606@drmicha.warpmail.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Jeff King <peff@peff.net>,
	Johannes Sixt <j6t@kdbg.org>,
	Sverre Rabbelier <srabbelier@gmail.com>
To: Michael J Gruber <git@drmicha.warpmail.net>
X-From: git-owner@vger.kernel.org Wed Feb 16 22:34:30 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Ppp13-0005A8-2o
	for gcvg-git-2@lo.gmane.org; Wed, 16 Feb 2011 22:34:29 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754618Ab1BPVeZ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 16 Feb 2011 16:34:25 -0500
Received: from a-pb-sasl-sd.pobox.com ([64.74.157.62]:64650 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754388Ab1BPVeX (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 16 Feb 2011 16:34:23 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id 7615F445F;
	Wed, 16 Feb 2011 16:35:28 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=19dtcREQjGBjvvjuOD4tWAzBJmM=; b=j8gSRB
	j7Y34COn6itGpFcjE8Dr3DZ59+PZZTx7p/4pFiORwO/EUlkuLXpNG5gfvsOdzpjh
	Ji/j0eEDyg6MzF7SV2S38HqDAEYgiOSDwiR+dwiUb7kgWIIDFLpxbBrduhVe0WLS
	YZ84cTYRXXu9mkkI0ewWr2OOLvWr+yuwUp2bI=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=UWb3FblmNs+b9ZVib5kGBJeuQK2DXsvD
	ksJjCQCh+SoAz2Lid42iKwWCddXNnCX4U+ocJV3BG4uXCyOboXLsmAUGfaWwUuu5
	obJjrZn67OEq/szi/yoaxgtM3bYrDG1ipCCrzdE3rLUD8LJCNvrJT6snUA4HK+tw
	XwuWbCq0gWM=
Received: from a-pb-sasl-sd.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id 24A5C445E;
	Wed, 16 Feb 2011 16:35:23 -0500 (EST)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-sd.pobox.com (Postfix) with ESMTPSA id 43E124459; Wed, 16 Feb 2011
 16:35:15 -0500 (EST)
In-Reply-To: <4D5B80E9.90606@drmicha.warpmail.net> (Michael J. Gruber's
 message of "Wed\, 16 Feb 2011 08\:46\:49 +0100")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: A90C5326-3A14-11E0-AB21-AF401E47CF6F-77302942!a-pb-sasl-sd.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/167005>

Michael J Gruber <git@drmicha.warpmail.net> writes:

> Having a second look at documentation, there aren't many changes to do -
> I would tend to leave things like <URL>, <FQDN>, possibly <UUID> (since
> they are abbreviations) uppercase; unsure about <CVSROOT> (like the env
> var). What do you think?

The only ones in my "git grep '<[A-Z]*>' Documentation/" that look
offending are:

 - "option verbosity <N>" (git-remote-helpers)
 - "-r/--revision <ARG>" (git-svn)

and everything else looks like they should be left as they are.
