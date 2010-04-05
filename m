From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v7 1/2] Documentation/remote-helpers: Rewrite description
Date: Mon, 05 Apr 2010 14:55:40 -0700
Message-ID: <7vtyrpmun7.fsf@alter.siamese.dyndns.org>
References: <f3271551003281103x68812b3cj806d6235965f0a32@mail.gmail.com>
 <l2pf3271551004050705o20379311j9862bd9ab46cbb11@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Git Mailing List <git@vger.kernel.org>,
	Sverre Rabbelier <srabbelier@gmail.com>,
	Michael J Gruber <git@drmicha.warpmail.net>,
	Jonathan Nieder <jrnieder@gmail.com>,
	Daniel Barkalow <barkalow@iabervon.org>,
	Ilari Liusvaara <ilari.liusvaara@elisanet.fi>
To: Ramkumar Ramachandra <artagnon@gmail.com>
X-From: git-owner@vger.kernel.org Mon Apr 05 23:56:11 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1NyuHB-00053T-NU
	for gcvg-git-2@lo.gmane.org; Mon, 05 Apr 2010 23:56:10 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756615Ab0DEV4F (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 5 Apr 2010 17:56:05 -0400
Received: from a-pb-sasl-quonix.pobox.com ([208.72.237.25]:36778 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756450Ab0DEV4D (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 5 Apr 2010 17:56:03 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id B434FA861D;
	Mon,  5 Apr 2010 17:56:00 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=sUI9H66jZq731EKneSi8pGrClrY=; b=O3RlLY
	gu6iHF+sz0HOCcarxmikloL9vHZpAB/SOjUCMIFdFqyStPlL7BNM2GbaLkPhi8Oc
	VmttZJtUAONv7oi/G6zOJ5EiVs1SMnVHaGJHffOooDlyYejoD65nFUcFIoz1ic9i
	vV2MDcaI70UZPyryg+s4kyoeq6bFcZ+F1i/Ws=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=aeuuhMn7YUYSlR0goj7pdCI3d2k7kD/r
	4aTQPer51V54odLMXWyjTmJi1TtrduRDYewHYAwM1ltDOPvh4fhdwVe3JhcPUzDa
	y4JPCwtKKHvAfwi3rFVYrOzTQK09FVvZNuU+/CztokhQxL0PFzxXW95N+5KNCUjY
	H48+yOPXYBo=
Received: from a-pb-sasl-quonix. (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id AD924A861A;
	Mon,  5 Apr 2010 17:55:52 -0400 (EDT)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 72A41A8618; Mon,  5 Apr
 2010 17:55:42 -0400 (EDT)
In-Reply-To: <l2pf3271551004050705o20379311j9862bd9ab46cbb11@mail.gmail.com>
 (Ramkumar Ramachandra's message of "Mon\, 5 Apr 2010 19\:35\:42 +0530")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: 00D9F290-40FE-11DF-B7E3-D033EE7EF46B-77302942!a-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/144067>

Ramkumar Ramachandra <artagnon@gmail.com> writes:

> On Sun, Mar 28, 2010 at 11:33 PM, Ramkumar Ramachandra
> <artagnon@gmail.com> wrote:
>> Rewrite the description section to describe what exactly remote
>> helpers are and the need for them. Also mention the curl family of
>> remote helpers as an example.
>
> In accordance with Junio's 4th April "What's Cooking" report, could
> some remote helper experts kindly Ack this patch?
>
> Signed-off-by: Ramkumar Ramachandra <artagnon@gmail.com>

I'll copy and paste this, but please make it a habit to sign off your
patch when committing if you plan to be a regular contributor to the
project.

I've re-read all the discussions that led to v7 patch and then re-read
the patch [1/2].  I'll queue it with a minor tweak.

Thanks.
