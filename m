From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] document 'T' status from git-status
Date: Sat, 29 Oct 2011 23:25:50 -0700
Message-ID: <7vmxcjro5t.fsf@alter.siamese.dyndns.org>
References: <1319933204-21587-1-git-send-email-mjd@plover.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Mark Dominus <mjd@icgroup.com>
To: Mark Dominus <mjd@plover.com>
X-From: git-owner@vger.kernel.org Sun Oct 30 07:25:58 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RKOqE-0005ZR-D3
	for gcvg-git-2@lo.gmane.org; Sun, 30 Oct 2011 07:25:58 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751934Ab1J3GZx (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 30 Oct 2011 02:25:53 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:34063 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751604Ab1J3GZw (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 30 Oct 2011 02:25:52 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 5494D3E79;
	Sun, 30 Oct 2011 02:25:52 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=P98menJLZ82M0z3AYNvGmRJpfb0=; b=LITcsn
	8XkxT7Edg2QluNDDcWxZYY6kth+u2j8BH82HltfrEeKhPxA8KQ1bSHhm+NHAPfEs
	MWmcQA1qWDxWyiHBRH0XdrkPVHkiJQmyhQl7fgYLvJsnoTE36pi/6FHQlK8AmC33
	ze6GZ17kKYT3xXL1FLSnqbQDkh+R36V30r5SI=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=AwDh/D7og9nYA33Bv5rXi8gme4lNTGm+
	j3d+wctECnW74LiUfU5cGP8jbWA0hrUgDofIMKFGOSK75CukgJZXoss2GtU5EtTl
	6HzQgCfNkxih+/J2lQG263G1eSsm/QDssIdQCbKnTz19qHWv9wW4F8XypZB8fGRf
	cKN06J8Br9g=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 4C5143E72;
	Sun, 30 Oct 2011 02:25:52 -0400 (EDT)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id BDF393E6F; Sun, 30 Oct 2011
 02:25:51 -0400 (EDT)
In-Reply-To: <1319933204-21587-1-git-send-email-mjd@plover.com> (Mark
 Dominus's message of "Sat, 29 Oct 2011 20:06:44 -0400")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 03C2AB02-02C0-11E1-A8ED-9DB42E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/184463>

Mark Dominus <mjd@plover.com> writes:

> From: Mark Dominus <mjd@icgroup.com>
>
> Signed-off-by: Mark Dominus <mjd@plover.com>
> ---
>  Documentation/git-status.txt |    4 ++++
>  1 files changed, 4 insertions(+), 0 deletions(-)
>
> diff --git a/Documentation/git-status.txt b/Documentation/git-status.txt
> index 3d51717..e7fc5c3 100644
> --- a/Documentation/git-status.txt
> +++ b/Documentation/git-status.txt
> @@ -122,6 +122,8 @@ codes can be interpreted as follows:
>  * 'R' = renamed
>  * 'C' = copied
>  * 'U' = updated but unmerged
> +* 'T' = file type changed
> +  (typically from plain file to symlink, or vice versa)
>  
>  Ignored files are not listed, unless `--ignored` option is in effect,
>  in which case `XY` are `!!`.
> @@ -134,9 +136,11 @@ in which case `XY` are `!!`.
>      D         [ M]   deleted from index
>      R        [ MD]   renamed in index
>      C        [ MD]   copied in index
> +    T        [ MD]   file type changed in index
>      [MARC]           index and work tree matches
>      [ MARC]     M    work tree changed since index
>      [ MARC]     D    deleted in work tree
> +    [ MARC]     T    file type changed in work tree

The current organization of this table may need to be rethought, but if we
were to keep it, then this change is far from sufficient. For example, you
do not explain what XY = TT means.

	Side note. The reason why we do not have two independent tables,
	one of which shows "if X is M then it means updated in index, if X
	is A then..." and the other shows "if Y is ' ' then index and
	working tree matches, if Y is 'M' then ...", is because this table
	is meant to show _possible_ combinations. For example, the row
	with X = D shows that only two possible value for Y are ' ' and M
	and A or D are not possible values for Y in that case.

It may be easier to explain if you treated that 'T' is merely a variant of
'M' (this comment applies to the first hunk of your patch that starts at
line 122), i.e.

 Documentation/git-status.txt |    4 ++++
 1 files changed, 4 insertions(+), 0 deletions(-)

diff --git a/Documentation/git-status.txt b/Documentation/git-status.txt
index 3d51717..bc2552e 100644
--- a/Documentation/git-status.txt
+++ b/Documentation/git-status.txt
@@ -126,6 +126,10 @@ codes can be interpreted as follows:
 Ignored files are not listed, unless `--ignored` option is in effect,
 in which case `XY` are `!!`.
 
+Note that a change in filetype (i.e. a regular file to symbolic link or
+vice versa) is a special case of "modified" and shown as 'T' instead of
+'M'; in the table below an 'M' could be a 'T'.
+
     X          Y     Meaning
     -------------------------------------------------
               [MD]   not updated
