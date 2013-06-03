From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v9 0/4] New git-related helper
Date: Mon, 03 Jun 2013 12:13:47 -0700
Message-ID: <7v4ndfdn2s.fsf@alter.siamese.dyndns.org>
References: <1369986380-412-1-git-send-email-felipe.contreras@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Duy Nguyen <pclouds@gmail.com>
To: Felipe Contreras <felipe.contreras@gmail.com>
X-From: git-owner@vger.kernel.org Mon Jun 03 21:14:01 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UjaCa-0004FY-UG
	for gcvg-git-2@plane.gmane.org; Mon, 03 Jun 2013 21:13:57 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756091Ab3FCTNx (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 3 Jun 2013 15:13:53 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:57220 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751239Ab3FCTNw (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 3 Jun 2013 15:13:52 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 0F70F25269;
	Mon,  3 Jun 2013 19:13:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=6mEZnAhwU0GD8C5Obgs/CC+4ln4=; b=dcdc3h
	3kDdI/hSmkkB6QrEPNcwPCI3NKWULb0iP1THA5ZJGGodJ8wXNPoBeYW7/7LO9RHL
	A0Am+jSGHvyPiBd3YlpMeN9ZOCFmmqR6P25JCiBwrms8nBjeM0r57eGEU9xWzt0y
	jTcqPU+qgMeBPyDkuQrPD1/IsK44RoYTRAP7M=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=NNU8gX0n4LWSGovJZjAcC82ZmwpYKVKv
	o9m+jSnoaYz/+Qkf3rdZtd2HjRiLIXX2c0NDtAgc9Ild82R6TwukpfZQ67uiTOs1
	qLqQQdA0hS2fvfIVnr+fwXjClAuem+skRTrRq5rSAMVdwOB3aOyuiU0h6CloSoJo
	xyaGFwPeViw=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 86BFD25267;
	Mon,  3 Jun 2013 19:13:50 +0000 (UTC)
Received: from pobox.com (unknown [50.161.4.97])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id DED4F25265;
	Mon,  3 Jun 2013 19:13:49 +0000 (UTC)
In-Reply-To: <1369986380-412-1-git-send-email-felipe.contreras@gmail.com>
	(Felipe Contreras's message of "Fri, 31 May 2013 02:46:16 -0500")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: B8F588FA-CC81-11E2-B8DF-E56BAAC0D69C-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/226270>

Felipe Contreras <felipe.contreras@gmail.com> writes:

> I changed my mind, this is the same as v9 but minus some potentially
> controversial changes.
>
> Felipe Contreras (4):
>   Add new git-related helper to contrib
>   contrib: related: add support for multiple patches
>   contrib: related: add option to parse from committish
>   contrib: related: parse committish like format-patch
>
>  contrib/related/git-related | 172 ++++++++++++++++++++++++++++++++++++++++++++
>  1 file changed, 172 insertions(+)
>  create mode 100755 contrib/related/git-related

Replaced what was parked on 'pu' with this.
