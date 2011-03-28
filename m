From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] grep: Add the option '--line-number'
Date: Mon, 28 Mar 2011 14:02:24 -0700
Message-ID: <7voc4vvtzz.fsf@alter.siamese.dyndns.org>
References: <1301335915-5782-1-git-send-email-jratt0@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Joe Ratterman <jratt0@gmail.com>
X-From: git-owner@vger.kernel.org Mon Mar 28 23:02:40 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Q4JaA-0003LY-S5
	for gcvg-git-2@lo.gmane.org; Mon, 28 Mar 2011 23:02:39 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753779Ab1C1VCf (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 28 Mar 2011 17:02:35 -0400
Received: from a-pb-sasl-sd.pobox.com ([64.74.157.62]:52147 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751754Ab1C1VCe (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 28 Mar 2011 17:02:34 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id 8D0C347EE;
	Mon, 28 Mar 2011 17:04:18 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=d8SN2ftBLo8S+nEqUgWPPSiFfoY=; b=sjlwsu
	4e8q1v9pbuKVRggAparNe5zEFX7dbvabu5OITYU+3/lfHWIP/4UiDw7J6bMjfuuU
	XdN+c4gs74B5tmyL9wROComhar9V9FNt8gI/GT/n6UEh92cBrtR6B2C4sAw2kRZd
	q1JoDG22VlR4IEVYTle1e8V6BVVnRLTA5MVVU=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=N5IOvI/P1jpptC+6x85kjX+6bQpjV9i4
	lmvjHJ/LatSPoNSd5wJaAs9+GZR44+14OXM8nNHCw/Af0QMPhaWNpdPVfaFBnV1D
	kl/uiDIHWaYAxue0Pf1cX1PeDZwz6qyrif0semCg0jfCYNH9UIF+nRwiXS4vQSNo
	9eba3QuZM94=
Received: from a-pb-sasl-sd.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id 6A24447EA;
	Mon, 28 Mar 2011 17:04:15 -0400 (EDT)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-sd.pobox.com (Postfix) with ESMTPSA id 9412847E9; Mon, 28 Mar 2011
 17:04:12 -0400 (EDT)
In-Reply-To: <1301335915-5782-1-git-send-email-jratt0@gmail.com> (Joe
 Ratterman's message of "Mon, 28 Mar 2011 13:11:55 -0500")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: F04EBA7E-597E-11E0-B29B-E8AB60295C12-77302942!a-pb-sasl-sd.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/170191>

Thanks, will queue.
