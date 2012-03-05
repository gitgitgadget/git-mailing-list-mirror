From: Junio C Hamano <gitster@pobox.com>
Subject: Re: What's cooking in git.git (Mar 2012, #02; Sun, 4)
Date: Mon, 05 Mar 2012 15:37:43 -0800
Message-ID: <7vd38qy5yw.fsf@alter.siamese.dyndns.org>
References: <7vk42z32jo.fsf@alter.siamese.dyndns.org>
 <CAFfmPPNWXG2iP4jg0v0EoMuGb6eNoEvFuserc7vtP9EeLFp1CA@mail.gmail.com>
 <7v1up6zmwr.fsf@alter.siamese.dyndns.org>
 <CAFfmPPPa=s8NAYDxoSa5SR91Y_tgRLUVo_bzgViE0wV5g0Ld3g@mail.gmail.com>
 <7vsjhmy6x2.fsf@alter.siamese.dyndns.org>
 <CAP2yMa+GgRV3W7FcRhVrpRTRfWrDxKhWgbkWVdzCyyN-zgcifA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: David Barr <davidbarr@google.com>, git@vger.kernel.org
To: Scott Chacon <schacon@gmail.com>
X-From: git-owner@vger.kernel.org Tue Mar 06 00:37:52 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1S4hTU-0007nJ-77
	for gcvg-git-2@plane.gmane.org; Tue, 06 Mar 2012 00:37:52 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757933Ab2CEXhq convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 5 Mar 2012 18:37:46 -0500
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:61084 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1757794Ab2CEXhp convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 5 Mar 2012 18:37:45 -0500
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 5B1A86F1B;
	Mon,  5 Mar 2012 18:37:45 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; s=sasl; bh=9jpMn2M2MJ3O
	FAOxMDiGBqgg66o=; b=URe03qNIlxESdkZIQ8gzZgtfo8k4IqF016/3Ugn7Yt+R
	gVACveidXMYI/ZJD1XPn+IHhVDa7VtEbLmFZJhcdsIXAqcygAimU1CqMeSZh2TS3
	V9NQCjLVwIMvAQ3PiwAaQfyPr1+pK4/FQ7AuCPAWUbAz3Ef0K8yFEEodJdStc8w=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; q=dns; s=sasl; b=M4WsDl
	G83TgH9oymCr4oDqXWGhDSRhi2bQ061Y5eIO5yIq7QS7a5hiNmNmW07l4OCwyy5d
	XY03hJP4xfsiRhCcNuKgp5FYtd3Xg158KqvtT9AgJfLjujjZXHlFyG6CRmA2VRKi
	MOLdxeJlag/Q2G3En1NdajRey7ShDpCl5IaAQ=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 4B6366F1A;
	Mon,  5 Mar 2012 18:37:45 -0500 (EST)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id D24186F18; Mon,  5 Mar 2012
 18:37:44 -0500 (EST)
In-Reply-To: <CAP2yMa+GgRV3W7FcRhVrpRTRfWrDxKhWgbkWVdzCyyN-zgcifA@mail.gmail.com> (Scott
 Chacon's message of "Mon, 5 Mar 2012 15:30:50 -0800")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 354BC6B6-671C-11E1-A98A-9DB42E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/192290>

Scott Chacon <schacon@gmail.com> writes:

> Hey,
>
> On Mon, Mar 5, 2012 at 3:17 PM, Junio C Hamano <gitster@pobox.com> wr=
ote:
>> David Barr <davidbarr@google.com> writes:
>>
>>> GitHub has a different mechanism for publishing project content.
>>> They expect a special named branch, gh-pages.
>>
>> Hrm, so if they add a mechanism to name what branch to show the
>> content from, I could set it from gh-pages to master and we will
>> have an online HTML pages. =C2=A0Nice.
>>
>> I wonder if they can also do historical documents (e.g. manual pages
>> for release 1.7.0) that way.
>
> So, gh-pages is how you can publish project pages for a project.  If
> you don't want to push to the gh-pages branch, you can just name the
> repository 'gitster.github.com' and push to the master branch there
> and that static content will be available at that url.

I do not mind pushing to gh-pages branch but I just wanted to avoid
an extra branch appearing in the repository where people expect to
find "master" branch full of html pages, which would surprise the
users.

> I am also working on parsing the content automatically and hosting it=
,
> including all older versions, under the git-scm.com domain. - also
> making it searchable and whatnot, FYI.  This won't be done for a
> little while, but I am working on it.

Thanks.
