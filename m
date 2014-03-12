From: Junio C Hamano <gitster@pobox.com>
Subject: Re: What's cooking in git.git (Mar 2014, #02; Tue, 11)
Date: Wed, 12 Mar 2014 11:31:36 -0700
Message-ID: <xmqqiorjmfp3.fsf@gitster.dls.corp.google.com>
References: <xmqq7g80o05g.fsf@gitster.dls.corp.google.com>
	<CACsJy8D7TbjK+E5-1A4KktZF4M=1HqZ8gXGi6Eu0jNYdQ+qxvw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Git Mailing List <git@vger.kernel.org>
To: Duy Nguyen <pclouds@gmail.com>
X-From: git-owner@vger.kernel.org Wed Mar 12 19:31:50 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WNnwT-0005Go-97
	for gcvg-git-2@plane.gmane.org; Wed, 12 Mar 2014 19:31:49 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755128AbaCLSbp (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 12 Mar 2014 14:31:45 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:51129 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751766AbaCLSbo (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 12 Mar 2014 14:31:44 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 3EBE971CB9;
	Wed, 12 Mar 2014 14:31:44 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=/4263L1YBvHFymDZmCrDXnRHw+k=; b=kbSj5o
	5/n40MAW4jgn6bJFUQ2pnQfuhN+rz1lzCfO/ZmWvAuc22nHPGsj/8NbOKLutJk4Z
	z7o6MRq73L2cvIisQFgb+urCubeN1t+Hz4aa6bUfn2+X6tJSIUGQ77cmAtBAMGUa
	+ROgYk+y8FC9/x/vZKfEpg9bJFnF1+HFYmGdw=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=xDKra8ycO507efAl8BkXJYCgStdQpwhn
	HMBGh9ZntWNbMmdWQqg2TRuLhsf/2rw8jQ6oC6sWXsbqZIAEeL6g5ILZk2mTkmdl
	R0ey7JJ5T6B6niS/yrF8IFwlOGiuB/uFp1gj+PiOVa77HaRI3HPugzfu5HWsmI5r
	/+hRIPf0qG0=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 27D4C71CB8;
	Wed, 12 Mar 2014 14:31:44 -0400 (EDT)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 72F9471CB6;
	Wed, 12 Mar 2014 14:31:43 -0400 (EDT)
In-Reply-To: <CACsJy8D7TbjK+E5-1A4KktZF4M=1HqZ8gXGi6Eu0jNYdQ+qxvw@mail.gmail.com>
	(Duy Nguyen's message of "Wed, 12 Mar 2014 06:22:51 +0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.3 (gnu/linux)
X-Pobox-Relay-ID: 8F7F08CC-AA14-11E3-BE0C-8D19802839F8-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/243957>

Duy Nguyen <pclouds@gmail.com> writes:

> On Wed, Mar 12, 2014 at 5:12 AM, Junio C Hamano <gitster@pobox.com> wrote:
>> * nd/log-show-linear-break (2014-02-10) 1 commit
>>  - log: add --show-linear-break to help see non-linear history
>>
>>  Attempts to show where a single-strand-of-pearls break in "git log"
>>  output.
>>
>>  Will merge to 'next'.
>
> Hold this one. I haven't found time to check again if any rev-list
> combincation may break it. The option name is coule use some
> improvement too.

OK.
