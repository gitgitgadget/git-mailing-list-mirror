From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [RFC/PATCH] t9157-*.sh: Add an svn version check
Date: Fri, 07 Jan 2011 14:32:35 -0800
Message-ID: <7vy66w4a64.fsf@alter.siamese.dyndns.org>
References: <4D260A03.90903@ramsay1.demon.co.uk>
 <20110107173114.GA31376@dcvr.yhbt.net>
 <AANLkTi=VpHtQ+x5hyfCei-=X=ry4X=+TSGg7EKa7zs4j@mail.gmail.com>
 <20110107222232.GA10624@dcvr.yhbt.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Steven Walter <stevenrwalter@gmail.com>,
	Ramsay Jones <ramsay@ramsay1.demon.co.uk>,
	GIT Mailing-list <git@vger.kernel.org>
To: Eric Wong <normalperson@yhbt.net>
X-From: git-owner@vger.kernel.org Fri Jan 07 23:32:52 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PbKrc-0008Aa-4y
	for gcvg-git-2@lo.gmane.org; Fri, 07 Jan 2011 23:32:52 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753421Ab1AGWct (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 7 Jan 2011 17:32:49 -0500
Received: from a-pb-sasl-sd.pobox.com ([64.74.157.62]:54595 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752522Ab1AGWcs (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 7 Jan 2011 17:32:48 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id C892C2C72;
	Fri,  7 Jan 2011 17:33:25 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=+eWgJyyk3PEXsDGMvgMtgcUUCAk=; b=lsDK/B
	dmrkRvBHta3JD83hf8NL/KToYhvJ2fejrYKDMZ94MIudTQOnSyUWiI1jqYPNKodp
	5vDbmqIBCK7rE7c7OSHHUNJw86qE0hEYfaYvLXGZ86rTScfc4+P1u2cJ7QsmXWX+
	iF69PPUk0EGE5DtYhsUlRTSWkapjs/takLi8Y=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=pEc+Un2K+3EGusWX2YcC3omIBeSZlmvc
	15hlQTHVfn+8nVMD4kciC3Brgb/vxecNk48RhUP+go81zfn4rzfYvOHUrcyhiP+8
	3DQIUpo3wlLGECYl5GUViQ92C4frVQHOxn94IfxxaeSU0VDKvLz5xDBPoGQyzN7L
	vKcjTxVe9Lw=
Received: from a-pb-sasl-sd.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id 844AF2C71;
	Fri,  7 Jan 2011 17:33:21 -0500 (EST)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-sd.pobox.com (Postfix) with ESMTPSA id 494B12C70; Fri,  7 Jan 2011
 17:33:16 -0500 (EST)
In-Reply-To: <20110107222232.GA10624@dcvr.yhbt.net> (Eric Wong's message of
 "Fri\, 7 Jan 2011 22\:22\:32 +0000")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: 21D03A88-1AAE-11E0-BB42-CBB45B885003-77302942!a-pb-sasl-sd.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/164778>

Thanks!
