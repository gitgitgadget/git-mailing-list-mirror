From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] gitk: add a checkbox to control the visibility of tags
Date: Tue, 01 Jan 2013 23:24:59 -0800
Message-ID: <7vwqvw3v3o.fsf@alter.siamese.dyndns.org>
References: <1354309737-4280-1-git-send-email-stlman@poczta.fm>
 <7vlidhmc5i.fsf@alter.siamese.dyndns.org>
 <20130102071701.GG20724@iris.ozlabs.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org,
	=?utf-8?Q?=C5=81ukasz?= Stelmach <stlman@poczta.fm>
To: Paul Mackerras <paulus@samba.org>
X-From: git-owner@vger.kernel.org Wed Jan 02 08:25:26 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TqIhX-00085R-91
	for gcvg-git-2@plane.gmane.org; Wed, 02 Jan 2013 08:25:23 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751361Ab3ABHZE convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 2 Jan 2013 02:25:04 -0500
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:48263 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750795Ab3ABHZC convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 2 Jan 2013 02:25:02 -0500
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id B13689F9D;
	Wed,  2 Jan 2013 02:25:01 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; s=sasl; bh=0erskN/tmoB4
	3vCbTyqXV5tOoe4=; b=j7AtxdGSg1sJbwfjUJnNKZ2SBrzr1KJbNkwqwuYJ3N4O
	eRR4vGeldijoGYBiMcO4oTrhZgRkVzv6GGoMuwFh+UD1obcYyuCgBpVIh+US61lL
	nJW59xu5ZYsqdhaq1oJ4/hXrcymBdZH9FjpTCe+YakaU+7eC5eLNXfL9BsZm8fk=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; q=dns; s=sasl; b=feGPCy
	ZQG9/qpa/wrqDZOzKN0uJhs3YJxiVNIEfs4KJKDpdVT+imd6Oc3J/iOMPsw3dYJe
	oAb2Ow7dURxC0tEL8GGKz/AgOmkJfz9rkJU2DQ4C5r245Uh+pJAgDihlhTq5GjlP
	PqhFscKy81xEWDKb4LsoKdfLpvZwg38C7ugzg=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id A396B9F9C;
	Wed,  2 Jan 2013 02:25:01 -0500 (EST)
Received: from pobox.com (unknown [98.234.214.94]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 1B9209F9B; Wed,  2 Jan 2013
 02:25:01 -0500 (EST)
In-Reply-To: <20130102071701.GG20724@iris.ozlabs.ibm.com> (Paul Mackerras's
 message of "Wed, 2 Jan 2013 18:17:01 +1100")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 84F42DE6-54AD-11E2-91D4-F0CE2E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/212498>

Paul Mackerras <paulus@samba.org> writes:

> On Sat, Dec 01, 2012 at 06:16:25PM -0800, Junio C Hamano wrote:
>> =C5=81ukasz Stelmach <stlman@poczta.fm> writes:
>>=20
>> > Enable hiding of tags displayed in the tree as yellow labels.
>> > If a repository is used together with a system like Gerrit
>> > there may be quite a lot of tags used to control building
>> > and there may be hardly any place left for commit subjects.
>> >
>> > Signed-off-by: =C5=81ukasz Stelmach <stlman@poczta.fm>
>> > ---
>> ...=20
> If the concern is the amount of screen real-estate that the tags take
> up when there are many of them (which is a reasonable concern), I'd
> rather just put a single tag icon with "tags..." inside it and arrang=
e
> to list all the tags in the diff display pane when the user clicks on
> it.  I think that would be better than not showing the tags at all.

Yeah, sounds very sensible.  Thanks.

=C5=81ukasz, what do you think?
