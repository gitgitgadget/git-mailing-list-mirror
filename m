From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 0/3] Add a "fix" command to "rebase --interactive"
Date: Mon, 07 Dec 2009 23:43:31 -0800
Message-ID: <7vr5r5lxlo.fsf@alter.siamese.dyndns.org>
References: <cover.1259934977.git.mhagger@alum.mit.edu>
 <4B192701.4000308@drmicha.warpmail.net> <vpqfx7qocwl.fsf@bauges.imag.fr>
 <7vws12r5v2.fsf@alter.siamese.dyndns.org>
 <alpine.DEB.1.00.0912041945161.21557@intel-tinevez-2-302>
 <20091205062708.6117@nanako3.lavabit.com>
 <7vd42t6f9i.fsf@alter.siamese.dyndns.org>
 <20091208121314.6117@nanako3.lavabit.com>
 <7vtyw2p2ju.fsf@alter.siamese.dyndns.org>
 <20091208150102.6117@nanako3.lavabit.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Junio C Hamano <gitster@pobox.com>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>,
	Michael J Gruber <git@drmicha.warpmail.net>,
	Michael Haggerty <mhagger@alum.mit.edu>, git@vger.kernel.org
To: Nanako Shiraishi <nanako3@lavabit.com>
X-From: git-owner@vger.kernel.org Tue Dec 08 08:44:06 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NHujr-0002wY-HQ
	for gcvg-git-2@lo.gmane.org; Tue, 08 Dec 2009 08:44:03 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754699AbZLHHnv (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 8 Dec 2009 02:43:51 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754592AbZLHHnv
	(ORCPT <rfc822;git-outgoing>); Tue, 8 Dec 2009 02:43:51 -0500
Received: from a-pb-sasl-quonix.pobox.com ([208.72.237.25]:53994 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753849AbZLHHnq (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 8 Dec 2009 02:43:46 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id C078886A9B;
	Tue,  8 Dec 2009 02:43:51 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=lCPoxPsOvk+X8v8sFen5r0k0Wgs=; b=iKvQwr
	x4rZBAoOm6YlouOU91bkhiCVwHggwC9FyYVXj5k8NgrkQnPN1/HDJDiM21MCKEFz
	VZD0XZBqLAYZNR2MGA1A3hb9+ilIYBsvGKkmw8cT/Lm8gjdFGN3+T5WP4R60JhKp
	f40ADahTsGVuetAOfVo6uFEpNh8MXw6AfUaSQ=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=ZkWOVwV0SEyLKvGjbdh1nvqZ4KCXLOZE
	4HK07ZzjKT2upHWFMI/wwLsL4NE7SM/ZXxBLCMlqe6xIvm0E6BO5yY3jxtQka4bD
	iX5U215mGMfiyoyRtnU0me0C1RVfp2csXynf48eEd5F/JA+NEXJLx6KPR/XieZTf
	Pt5bVdO+2rs=
Received: from a-pb-sasl-quonix. (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id 606A586A99;
	Tue,  8 Dec 2009 02:43:45 -0500 (EST)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 8309286A97; Tue,  8 Dec
 2009 02:43:33 -0500 (EST)
In-Reply-To: <20091208150102.6117@nanako3.lavabit.com> (Nanako Shiraishi's
 message of "Tue\, 08 Dec 2009 15\:01\:02 +0900")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: 69FBB8BE-E3CD-11DE-BDCC-9F3FEE7EF46B-77302942!a-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/134831>

Nanako Shiraishi <nanako3@lavabit.com> writes:

>> Hmph, did you forget to retitle the message, or keep in-body "Subject:"?
>
> Sorry. Yes I did. Please amend it to -
>
>  Subject: rebase -i --autosquash: auto-squash commits

Ok.
