From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 1/2] Documentation: Update 'linux-2.6.git' -> 'linux.git'
Date: Wed, 19 Jun 2013 10:07:24 -0700
Message-ID: <7vtxku112r.fsf@alter.siamese.dyndns.org>
References: <cover.1371606791.git.wking@tremily.us>
	<cover.1371606791.git.wking@tremily.us>
	<3286ddfe2dd6cbf9c435bd7f9eb579782eb32e1f.1371606791.git.wking@tremily.us>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Git <git@vger.kernel.org>
To: "W. Trevor King" <wking@tremily.us>
X-From: git-owner@vger.kernel.org Wed Jun 19 19:07:33 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UpLr2-0000uU-7X
	for gcvg-git-2@plane.gmane.org; Wed, 19 Jun 2013 19:07:32 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757251Ab3FSRH2 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 19 Jun 2013 13:07:28 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:44982 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1757238Ab3FSRH1 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 19 Jun 2013 13:07:27 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id B73D629FF8;
	Wed, 19 Jun 2013 17:07:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=tmT6oEUyguibo9gic/QFSiHdRWA=; b=XSFoDs
	yVC1V73/W23qJ5kwzW/DPORMC5HWvIPY9o1OZ5WPD8TUXZNBevpLWYlQwrSWwtgh
	svttBp/9NlrhJJjmOMdtelKEJgRx70mnzr09QgOj8FgeBq3eNQUXry+lGVUqsttm
	zBBWmGRAikd7IedX9hTAVM9Nj7Y+fKIuxlwUs=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=uO3J4hPliu729VERZriX1gIiIhqP4xH+
	Z+zcwNqbQgthfMSZgTv/f9vPi0u6oa1+ynKLtT6RasdjklJ8k/7ahss9dJLqNP4V
	cOlFwzo477lufXJP11GfX8xN6GM/pHq9WsibbU4+yL6n++jjyYVJbvXlxRiOs9S9
	YkS+zzh3Nfw=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id ABB1429FF7;
	Wed, 19 Jun 2013 17:07:26 +0000 (UTC)
Received: from pobox.com (unknown [50.161.4.97])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 2B3FE29FF6;
	Wed, 19 Jun 2013 17:07:26 +0000 (UTC)
In-Reply-To: <3286ddfe2dd6cbf9c435bd7f9eb579782eb32e1f.1371606791.git.wking@tremily.us>
	(W. Trevor King's message of "Tue, 18 Jun 2013 21:55:21 -0400")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: B73BD590-D902-11E2-B251-E56BAAC0D69C-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/228400>

"W. Trevor King" <wking@tremily.us> writes:

> diff --git a/Documentation/git-clone.txt b/Documentation/git-clone.txt
> index a0727d7..8e5260f 100644
> --- a/Documentation/git-clone.txt
> +++ b/Documentation/git-clone.txt
> @@ -274,7 +274,7 @@ $ git clone --bare -l /home/proj/.git /pub/scm/proj.git
>  * Create a repository on the kernel.org machine that borrows from Linus:
>  +
>  ------------
> -$ git clone --bare -l -s /pub/scm/.../torvalds/linux-2.6.git \
> +$ git clone --bare -l -s /pub/scm/.../torvalds/linux.git \
>      /pub/scm/.../me/subsys-2.6.git
>  ------------

Aside from s|subsys-2.6|subsys| David already mentioned, I think
it is a lot saner to remove this particular example.  Nobody runs
shell on k.org machines these days, and local borrowing "-l -s" is
already shown in another example.

Also you seem to have missed another "linux-2.6 my2.6" clone in the
first example.

Will not apply in this form; expecting a reroll.

Thanks.
