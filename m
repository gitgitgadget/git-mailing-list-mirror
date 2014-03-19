From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 0/3] Make git more user-friendly during a merge conflict
Date: Wed, 19 Mar 2014 15:30:26 -0700
Message-ID: <xmqqd2hh254t.fsf@gitster.dls.corp.google.com>
References: <1394771872-25940-1-git-send-email-andrew.kw.w@gmail.com>
	<xmqqha6wa0ln.fsf@gitster.dls.corp.google.com>
	<CADgNjakRSw-S4VbKnLC9PpmAcEi7iO=r0SBEy2XO3XhtDq=uJg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: "git\@vger.kernel.org" <git@vger.kernel.org>
To: Andrew Wong <andrew.kw.w@gmail.com>
X-From: git-owner@vger.kernel.org Wed Mar 19 23:30:47 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WQP0U-0006Cx-1Q
	for gcvg-git-2@plane.gmane.org; Wed, 19 Mar 2014 23:30:42 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757704AbaCSWae (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 19 Mar 2014 18:30:34 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:54349 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1757627AbaCSWaa (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 19 Mar 2014 18:30:30 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 69B8A7403A;
	Wed, 19 Mar 2014 18:30:29 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=MfMexdw58vTWXysAlXMD4IjANX4=; b=GOcXkM
	UyAhQvUupNBOUV7hAiI5ckz2vSyOKnM/QWVFQ6PRsnEM06Mil+REUihcQiCPsP+m
	lOnfA9/uv8HTt5JYUlSh998wI+GcUz48sxlRikryH8lyQ5iyVflbzqbdPMEy0jLy
	SLESuJ5Qagl53SvyZLloa0TcUs/AiaW4/13H8=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=kB5sNa71m1fk+AgBJSUy+7fEgKCMPmTy
	w2e6ps3dgjKUA7Havbi6ofxVDMadifa96kPN0ib77mmRUzJmXaecGQHjcM8aiQ6c
	ku5hgj2HQBk2/ulUr0MkYBVFoUXFVRPt+gR0vZ/LDaudIt1eCKc45gufqF9Ig4Lr
	T3rjkzWbWrU=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 542C174038;
	Wed, 19 Mar 2014 18:30:29 -0400 (EDT)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 7F4FF74035;
	Wed, 19 Mar 2014 18:30:28 -0400 (EDT)
In-Reply-To: <CADgNjakRSw-S4VbKnLC9PpmAcEi7iO=r0SBEy2XO3XhtDq=uJg@mail.gmail.com>
	(Andrew Wong's message of "Mon, 17 Mar 2014 19:25:00 -0400")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.3 (gnu/linux)
X-Pobox-Relay-ID: 12C89350-AFB6-11E3-826F-8D19802839F8-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/244503>

Andrew Wong <andrew.kw.w@gmail.com> writes:

> On Mon, Mar 17, 2014 at 7:04 PM, Junio C Hamano <gitster@pobox.com> wrote:
>> Has this series been tested with existing test suite? ...
> I tested it during RFC, but missed it when I sent it as patch.
> ...
> I'll fix the problem. Sorry about that.

Thanks.  Will hold onto the topic branch lest I forget, but will
keep it out of 'pu' in the meantime.
