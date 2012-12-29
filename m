From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v3 18/19] setup.c: document get_pathspec()
Date: Fri, 28 Dec 2012 17:36:41 -0800
Message-ID: <7v623lhc5y.fsf@alter.siamese.dyndns.org>
References: <1356575558-2674-1-git-send-email-git@adamspiers.org>
 <1356575558-2674-19-git-send-email-git@adamspiers.org>
 <7v7go1j4ml.fsf@alter.siamese.dyndns.org>
 <CAOkDyE-UXGhe1aiWy_1_y7cvrmfvivSBxY9LHudOmeZD=M-12A@mail.gmail.com>
 <CAOkDyE89fm5_z2V=VW5n+8XAvB6tE+DqciXttbhX29X8mWjXTQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git list <git@vger.kernel.org>
To: Adam Spiers <git@adamspiers.org>
X-From: git-owner@vger.kernel.org Sat Dec 29 02:39:39 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TolOj-0004Et-7Q
	for gcvg-git-2@plane.gmane.org; Sat, 29 Dec 2012 02:39:37 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755162Ab2L2Bgp (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 28 Dec 2012 20:36:45 -0500
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:44087 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755112Ab2L2Bgo (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 28 Dec 2012 20:36:44 -0500
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 7199DA3A3;
	Fri, 28 Dec 2012 20:36:43 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=5t208zvNKCbsoX+5PuaQoTnBy4Y=; b=qHFsoP
	xOt5p8tSOkgw3qQGah1UmDnQJhIn155ixylt3DdSm7IGSFW+Eu6AbhEa1NpEvtN7
	JGrtteQdSbSNkYYcpr0738NEQOaHc3adH9KDmkDWwsxaQ6yXDoGWr5rPNmzM94EJ
	HKKmXCCH21SG3M6tiEA3zzVdDmWN0F5zYeQk4=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=eSqY5LZfah2OGFXhiQ1JlH9CDunda4vu
	nwIHkRTt7kGl0jkUgP9UHKziwXyLsR5id7jllxY5kdu3ClsRRPmeDLxhFrQDJvcV
	jw7EJx+ay+o7D/GlS68DONMLnnRRhXwiUFsMt2dHugy1yPpEkBht6w9RO0vksZiD
	auO2nuj9JVE=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 5FBA5A3A2;
	Fri, 28 Dec 2012 20:36:43 -0500 (EST)
Received: from pobox.com (unknown [98.234.214.94]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id D3492A3A1; Fri, 28 Dec 2012
 20:36:42 -0500 (EST)
In-Reply-To: <CAOkDyE89fm5_z2V=VW5n+8XAvB6tE+DqciXttbhX29X8mWjXTQ@mail.gmail.com> (Adam
 Spiers's message of "Sat, 29 Dec 2012 00:52:25 +0000")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 32F9AB2C-5158-11E2-AE86-F0CE2E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/212282>

Adam Spiers <git@adamspiers.org> writes:

> I've added this sentence to the top of the comments above
> get_pathspec():
>
>     /*
>      * N.B. get_pathspec() is deprecated in favor of the "struct pathspec"
>      * based interface - see pathspec_magic above.
>      *
>     [...]
>
> That should be sufficient to discourage people from adding new users
> of get_pathspec().

Yeah, that sounds sensible.

Thanks, and happy new year to you ;-)
