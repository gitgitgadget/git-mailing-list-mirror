From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCHv2 0/9] --left/right-only and --cherry-mark
Date: Fri, 11 Mar 2011 00:02:15 -0800
Message-ID: <7v1v2e13w8.fsf@alter.siamese.dyndns.org>
References: <cover.1299499429.git.git@drmicha.warpmail.net>
 <7vtyfc7ymk.fsf@alter.siamese.dyndns.org>
 <4D7886FD.60109@drmicha.warpmail.net>
 <7vd3lz5me5.fsf@alter.siamese.dyndns.org>
 <4D78AC8B.7010308@drmicha.warpmail.net>
 <7v4o7a6dj3.fsf@alter.siamese.dyndns.org>
 <4D79D4CC.7020806@drmicha.warpmail.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: Michael J Gruber <git@drmicha.warpmail.net>
X-From: git-owner@vger.kernel.org Fri Mar 11 09:02:32 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PxxIt-0000Oy-TY
	for gcvg-git-2@lo.gmane.org; Fri, 11 Mar 2011 09:02:32 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752032Ab1CKIC1 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 11 Mar 2011 03:02:27 -0500
Received: from a-pb-sasl-sd.pobox.com ([64.74.157.62]:44934 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751489Ab1CKIC0 (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 11 Mar 2011 03:02:26 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id 324352786;
	Fri, 11 Mar 2011 03:03:53 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=qtdVQqTE/3HUlb6Fq6iJw2MF5OM=; b=PLeFWe
	/hOvXxiEASTy+QaB+XdAcDJidfguhGs2SbDfuhnMGdgD0779VGFzb5F2TUS0bLjq
	Ljel8gKuhh+Oq8LsNP/i/08pdf7HDuon1bO2Yqfd6k3+u4aTfeXdlVF4p5cV5CZC
	iUIW3GefkpwQPMj3B5e7A7g38NdZKeunBCDeE=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=Tq5eUvn/X/VM9pEMAda6NEvjoIC/BJ6R
	jjtTyVsmJoqQkBosVPxyGF9dW5+KKIF3VLbDtInBIOHHx/4DWOq/yPKGmu8Yz0gi
	bwyfj9eSwQW0rPqQCev0ibOg65vZH6KQs1/dfU52Sp8TZrn3ZBVJGd7RnsOAnKYB
	YlFLTM6aeW8=
Received: from a-pb-sasl-sd.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id 0F6C12784;
	Fri, 11 Mar 2011 03:03:50 -0500 (EST)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-sd.pobox.com (Postfix) with ESMTPSA id F41E02783; Fri, 11 Mar 2011
 03:03:45 -0500 (EST)
In-Reply-To: <4D79D4CC.7020806@drmicha.warpmail.net> (Michael J. Gruber's
 message of "Fri, 11 Mar 2011 08:52:44 +0100")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 192C8826-4BB6-11E0-9A86-E8AB60295C12-77302942!a-pb-sasl-sd.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/168888>

Michael J Gruber <git@drmicha.warpmail.net> writes:

> I see, thanks for the background!
> ...
> So maybe we should have another flag revs->cherry_process which is set
> automatically when needed, after processing all options (same with
> limited), and leave cherry_pick to keep track of --cherry-pick?

I actually read the two series again and decided that we can worry about
it when somebody actually wants to add the third one. The "cherry_process"
flag modeled after "limited" would be the right approach when we do so.

So I've kept your v2 as-is (the one you saw in 'pu' last night) and added
the 10th patch from v3.

Thanks.
