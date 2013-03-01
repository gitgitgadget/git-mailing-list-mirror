From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] Make !pattern in .gitattributes non-fatal
Date: Fri, 01 Mar 2013 12:24:16 -0800
Message-ID: <7vk3pqg973.fsf@alter.siamese.dyndns.org>
References: <a1679159dbe67c34675bbe016e131260310db189.1362168366.git.trast@student.ethz.ch>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: =?utf-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41j?= Duy <pclouds@gmail.com>,
	<git@vger.kernel.org>
To: Thomas Rast <trast@student.ethz.ch>
X-From: git-owner@vger.kernel.org Fri Mar 01 21:27:39 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UBWYM-0000DG-IE
	for gcvg-git-2@plane.gmane.org; Fri, 01 Mar 2013 21:27:38 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752558Ab3CAUYW (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 1 Mar 2013 15:24:22 -0500
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:56436 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752441Ab3CAUYT (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 1 Mar 2013 15:24:19 -0500
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 9A973A63A;
	Fri,  1 Mar 2013 15:24:18 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=GapuEs0iWPwIEcHLoYkmjGr1/+E=; b=MpAIss
	HkrnxkJKttYgb9wF+oB0dd3y9tk01wBEropbvlaLMbAj/cd3TF3i0co9C8qCy+Wf
	mAKzhfBGjtxtzC8R3y15ts0rELOSjjHmMgPbSAGrNMpcJSNQKdGvOUaHDJ9EfPPM
	GWyZYvC+n69/+RK2xbijxQXFlZVcT4ixTmhlI=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=d302tDVrw7x/ofTvLTM421SHM6ZrKvkL
	EdrBGKNWHgV33PcDT7YbMNc9WH4d1cD1gPNbevenom7IpGlgsRQ6Ufm6WFcxAxfu
	LGW0N46N8Zk1HZdcAXenpj0e8XfnMNyQhVIPZMts9RQdY/y7F3PmyxPnIJzYtQxN
	AKXrcYe7QlE=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 8CE77A639;
	Fri,  1 Mar 2013 15:24:18 -0500 (EST)
Received: from pobox.com (unknown [98.234.214.94]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 0EF21A638; Fri,  1 Mar 2013
 15:24:17 -0500 (EST)
In-Reply-To: <a1679159dbe67c34675bbe016e131260310db189.1362168366.git.trast@student.ethz.ch> (Thomas Rast's message of "Fri, 1 Mar 2013 21:06:17 +0100")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: FE39DE8E-82AD-11E2-83FB-7FA22E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/217290>

Makes sense.  Duy?
