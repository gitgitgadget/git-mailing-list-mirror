From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v3 1/2] t0303: immediately bail out w/o
 GIT_TEST_CREDENTIAL_HELPER
Date: Thu, 15 Mar 2012 10:51:47 -0700
Message-ID: <7vk42lkb0s.fsf@alter.siamese.dyndns.org>
References: <4F61C828.8060506@in.waw.pl>
 <1331809681-26113-1-git-send-email-zbyszek@in.waw.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Jeff King <peff@peff.net>, jrnieder@gmail.com
To: Zbigniew =?utf-8?Q?J=C4=99drzejewski-Szmek?= <zbyszek@in.waw.pl>
X-From: git-owner@vger.kernel.org Thu Mar 15 18:51:56 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1S8EqB-0002jK-1p
	for gcvg-git-2@plane.gmane.org; Thu, 15 Mar 2012 18:51:55 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161171Ab2CORvv (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 15 Mar 2012 13:51:51 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:40219 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1032047Ab2CORvu (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 15 Mar 2012 13:51:50 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id CDE216DC6;
	Thu, 15 Mar 2012 13:51:49 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=xXqHsqAlzr4+bnTyg2SgY8L0JkI=; b=WsTXn5
	LHoVOlq48GbwSOImnCSLHV11mEKr3HE0l3EUotHR/kfZ2pmXwNQskhwBpm/IUZ2L
	7FxfnaBHqIqa8f5sValrmOtZFd/vfHaNiGR+jm6y2wQgHJpz3bFBlSQTEhquJLrS
	uGkz/wcJV8c6c2aYjIsrJX4Dy0FGX3cDLxKFs=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=HV7okonWqcv2uq68qh1xVsTwAWALVxxG
	wMVt3pYlArw3bZmxODNTT6ykDwsV/tESisxietMzsGqG+ozGSaG3m2UDc7sSkhGW
	MCMDe1ZMBKJiX2PX/yoFWZbuIkFseDwo3+zRyeTOu9BR6UdL8SH8T+lp4x6TtcmT
	T54fXXshoLE=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id C444F6DC5;
	Thu, 15 Mar 2012 13:51:49 -0400 (EDT)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 439396DC4; Thu, 15 Mar 2012
 13:51:49 -0400 (EDT)
In-Reply-To: <1331809681-26113-1-git-send-email-zbyszek@in.waw.pl> ("Zbigniew
 =?utf-8?Q?J=C4=99drzejewski-Szmek=22's?= message of "Thu, 15 Mar 2012
 12:08:00 +0100")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 8A22990A-6EC7-11E1-83BB-9DB42E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/193219>

Thanks all; will queue.
