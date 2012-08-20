From: Junio C Hamano <gitster@pobox.com>
Subject: Re: What's cooking in git.git (Aug 2012, #06; Sun, 19)
Date: Mon, 20 Aug 2012 09:21:50 -0700
Message-ID: <7vobm5lejl.fsf@alter.siamese.dyndns.org>
References: <7v393im4jy.fsf@alter.siamese.dyndns.org>
 <CABPQNSZ+JskSvEUFbxy78eqB5cg1npq7n_thaVhhoXxd-DK+MQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Eric Wong <normalperson@yhbt.net>,
	Pete Wyckoff <pw@padd.com>, Luke Diamand <luke@diamand.org>,
	Stefan Zager <szager@google.com>
To: kusmabite@gmail.com
X-From: git-owner@vger.kernel.org Mon Aug 20 18:22:01 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1T3Ujo-0004Ld-Cf
	for gcvg-git-2@plane.gmane.org; Mon, 20 Aug 2012 18:22:00 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752427Ab2HTQVz (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 20 Aug 2012 12:21:55 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:56000 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752243Ab2HTQVx (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 20 Aug 2012 12:21:53 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id BE81273B2;
	Mon, 20 Aug 2012 12:21:52 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=L6bVGC6xcXTQbbHVfxvmAlmBZ5g=; b=toAePv
	/KI73i/lE2qadQAkdZk5zTv+aR91zM+413u7jDQbq9w+ynX6CSzP4907C/bQZnNe
	wi+1nGP+gebWnXKntIegpru3k5TaoQfZ7cfjO+WThqHqBy0I2HdN/svIVVZ4E2kf
	Oa37FEnwI7Sks+gNANAXYWmYobIN+cnCz7RZs=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=Ta+5u90Faj9hBiqG4wznD2FMqUVb2/IU
	FfqI7xLsYO8p6W3WXfGcpha7RQyZGjWdx5huaxF6LGjf5Pl2OOrODGE1XhIBefF9
	uLNt4gUcnwBVeCayPQ27042uz6lWwj6/Llrd2XjuIUl2WL+4xumycrFCW8/s/Phc
	wjczAa45EAc=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id A9C4373AE;
	Mon, 20 Aug 2012 12:21:52 -0400 (EDT)
Received: from pobox.com (unknown [98.234.214.94]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 190CF73AD; Mon, 20 Aug 2012
 12:21:52 -0400 (EDT)
In-Reply-To: <CABPQNSZ+JskSvEUFbxy78eqB5cg1npq7n_thaVhhoXxd-DK+MQ@mail.gmail.com> (Erik
 Faye-Lund's message of "Mon, 20 Aug 2012 09:03:32 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 2673B0C2-EAE3-11E1-93A0-01B42E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/203849>

Erik Faye-Lund <kusmabite@gmail.com> writes:

> On Mon, Aug 20, 2012 at 9:00 AM, Junio C Hamano <gitster@pobox.com> wrote:
>> * ef/win32-cred-helper (2012-08-16) 1 commit
>>  - contrib: add win32 credential-helper
>>
>> Credential helper for Win32 (is this GUI???).
>
> No, and credential helpers shouldn't be either.

Hrm, doesn't it even do "the application wants to access your
keychain.  Allow it [Y/N]?" kind of thing?
