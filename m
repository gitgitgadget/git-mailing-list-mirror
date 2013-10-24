From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 15/15] fetch, remote: properly convey --no-prune options to subprocesses
Date: Thu, 24 Oct 2013 14:17:11 -0700
Message-ID: <xmqqeh7amkrs.fsf@gitster.dls.corp.google.com>
References: <1382543448-2586-1-git-send-email-mhagger@alum.mit.edu>
	<1382543448-2586-16-git-send-email-mhagger@alum.mit.edu>
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
X-From: git-owner@vger.kernel.org Thu Oct 24 23:17:21 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VZSHP-0001Ni-Vh
	for gcvg-git-2@plane.gmane.org; Thu, 24 Oct 2013 23:17:20 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753833Ab3JXVRQ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 24 Oct 2013 17:17:16 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:44047 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751506Ab3JXVRP (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 24 Oct 2013 17:17:15 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 1882E4D0E9;
	Thu, 24 Oct 2013 21:17:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=fj2xINYsowo9AhVhI4YF2k7BAPI=; b=xoI33N
	YN0aNjOQAfHlTTMD+2fjEpSAcp70O75YMrJF2igqR84uxkeh7WFCFBbHqcQUT7lF
	aWKm/ecwyVrtiuJONslPM7AtOQSqz8RL0k0hGt5H1/iB427IR8GD6FDowuQKMaOd
	0VxJplk8+ZN8uEgTwVMzHDPqLU9Lqxnxe2B6U=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=eagkf4+KqufOaPZ6ezyANaJCOuZ7uOg/
	HxwwyQp25vQJ/l9IslOLN5KtGqdI7xf4cjVTcFKHTdgfHSmI6M28hWBEsubKI1R0
	bnVRcIoLTZ33YfVTs4iN3I0f1gRdJE/qGZ5a2n9hTaYOXA2Q1n/6XWvg9IlHbfWX
	NvNY5q88B44=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id F2CE24D0E4;
	Thu, 24 Oct 2013 21:17:13 +0000 (UTC)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 327074D0E1;
	Thu, 24 Oct 2013 21:17:13 +0000 (UTC)
In-Reply-To: <1382543448-2586-16-git-send-email-mhagger@alum.mit.edu> (Michael
	Haggerty's message of "Wed, 23 Oct 2013 17:50:48 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.3 (gnu/linux)
X-Pobox-Relay-ID: A6B5B4EA-3CF1-11E3-9573-8F264F2CC097-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/236624>

I finished reading thru the remainder and all looked good (again
except minor nits I sent reviews for separately).

Thanks, will queue.
