From: Junio C Hamano <gitster@pobox.com>
Subject: Re: How to selectively recreate merge state?
Date: Fri, 11 Dec 2009 07:35:59 -0800
Message-ID: <7vaaxp5xr4.fsf@alter.siamese.dyndns.org>
References: <76718490912101556o3e2911e8t32b48c0b735fd98c@mail.gmail.com>
 <200912111220.40844.jnareb@gmail.com> <4B223C1E.6010403@drmicha.warpmail.net>
 <200912111500.51982.jnareb@gmail.com> <4B225DC0.4020603@drmicha.warpmail.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Jakub Narebski <jnareb@gmail.com>,
	Jay Soffian <jaysoffian@gmail.com>, git <git@vger.kernel.org>
To: Michael J Gruber <git@drmicha.warpmail.net>
X-From: git-owner@vger.kernel.org Fri Dec 11 16:36:27 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NJ7XX-0004bU-Lj
	for gcvg-git-2@lo.gmane.org; Fri, 11 Dec 2009 16:36:20 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758750AbZLKPgJ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 11 Dec 2009 10:36:09 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1758635AbZLKPgG
	(ORCPT <rfc822;git-outgoing>); Fri, 11 Dec 2009 10:36:06 -0500
Received: from a-pb-sasl-sd.pobox.com ([64.74.157.62]:53499 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758568AbZLKPgG (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 11 Dec 2009 10:36:06 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id 46C9AA62EA;
	Fri, 11 Dec 2009 10:36:11 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=gBQZlU/4NEVGfeLbRM/gx5DYeYg=; b=Nw+O72
	MEoJ0ItV6yJVXw7r8T9rjr+toZr4xufJ/fk5pUUNCS6v9EWo2GkbzNWGB2Wtr0uq
	UvaEQ9itV2qnUz15MynmHO+izuJhh2MDsWZJPGoPniOpGAoiKQwiA2DhT+blv9Ig
	9XE61xDxiyBNGhhQAoZ02qruFkJgBXbT/OAKI=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=tKdeJfXv0/TixOdN6kos9aSuIuxjMPwy
	hrRv0I5Y04GEQh9D9QP+JaVaXNguK4vBwVXpOMClWBER9F84k3vHYMjauI/Wuv3f
	ecQzPw73PTUnnPhZP0PwGWQXzTqoothUAy1V2cD1dl6pq82U7hbsAspUyWAK5VT4
	WZOFl1ts1Ug=
Received: from a-pb-sasl-sd.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id 02C1DA62E9;
	Fri, 11 Dec 2009 10:36:06 -0500 (EST)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-sd.pobox.com (Postfix) with ESMTPSA id 7B756A62E8; Fri, 11 Dec 2009
 10:36:01 -0500 (EST)
In-Reply-To: <4B225DC0.4020603@drmicha.warpmail.net> (Michael J. Gruber's
 message of "Fri\, 11 Dec 2009 15\:57\:04 +0100")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: E622C1EA-E66A-11DE-8BEB-B34DBBB5EC2E-77302942!a-pb-sasl-sd.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/135091>

Michael J Gruber <git@drmicha.warpmail.net> writes:

>> The documentation of "git update-index --unresolve" lacks this info,
>> and it doesn't tell one what it is for (see commit message for commit
>> ec16779 (Add git-unresolve <paths>..., 2006-04-19)).
>
> Oh yes, one should always read the classics ;) [Really nice commit
> message, that is.]

Thanks.

This is exactly why I often give _explanation_ of the current behaviour
based on history, without defending it is good nor claiming it is bad.
Knowing how things came about gives us better perspective to decide where
to go next.
