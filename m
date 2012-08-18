From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 1/2] git-gui: Fix a loose/lose mistake
Date: Sat, 18 Aug 2012 13:24:00 -0700
Message-ID: <7vsjbkrlsv.fsf@alter.siamese.dyndns.org>
References: <1345280851-6626-1-git-send-email-bbolli@ewanet.ch>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Beat Bolli <bbolli@ewanet.ch>
To: Pat Thoyts <patthoyts@users.sourceforge.net>
X-From: git-owner@vger.kernel.org Sat Aug 18 22:24:55 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1T2pZm-00089X-J6
	for gcvg-git-2@plane.gmane.org; Sat, 18 Aug 2012 22:24:54 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751444Ab2HRUYG (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 18 Aug 2012 16:24:06 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:35659 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751108Ab2HRUYE (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 18 Aug 2012 16:24:04 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 7A0F79500;
	Sat, 18 Aug 2012 16:24:03 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=hajC7n3LRmb9g/LApy8lsY7HAw0=; b=JC+1l1
	J2h+P9l0G9ys74UjJR9jq6fW4orVKasouq0TGpgBFwXfKqRCqYVMpUt2vLYAMBZc
	oDwSlSQCbyO8DTxxbsLSeA9dNbe6zPpxQV9xLQvX7PgGUN+4XW++3Ys44APQVLPy
	+gr885xv206kLDZpUmqhpR6fNtwv7+IVVyB6E=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=fKMl8j6l3gnhH2QhiO34Igo173bwMja6
	oZJrp5jb3qpkaSQLsL6vcf5l40FOA/RsQXwtNjm8CAl4DGmFbIidukgN1xNIgJ/E
	MJJInwogP3q99tKmKDcUS2JG6/HG408I8UPNXUZ/KBox3fLhxsmzTvhXJeLieZh8
	4dysEuISbPc=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 65D5794FF;
	Sat, 18 Aug 2012 16:24:03 -0400 (EDT)
Received: from pobox.com (unknown [98.234.214.94]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 8B6DD94FE; Sat, 18 Aug 2012
 16:24:02 -0400 (EDT)
In-Reply-To: <1345280851-6626-1-git-send-email-bbolli@ewanet.ch> (Beat
 Bolli's message of "Sat, 18 Aug 2012 11:07:30 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: A670F34C-E972-11E1-8C07-01B42E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/203693>

Beat Bolli <bbolli@ewanet.ch> writes:

> No po update needed, as this string is untranslated.
>
> Signed-off-by: Beat Bolli <bbolli@ewanet.ch>
> ---
>  git-gui/lib/commit.tcl |    2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/git-gui/lib/commit.tcl b/git-gui/lib/commit.tcl
> index 0d81432..78c5eeb 100644
> --- a/git-gui/lib/commit.tcl
> +++ b/git-gui/lib/commit.tcl
> @@ -268,7 +268,7 @@ proc commit_commitmsg {curHEAD msg_p} {
>  	    && 	[is_config_true gui.warndetachedcommit]} {
>  		set msg [mc "You are about to commit on a detached head.\
>  This is a potentially dangerous thing to do because if you switch\
> -to another branch you will loose your changes and it can be difficult\
> +to another branch you will lose your changes and it can be difficult\
>  to retrieve them later from the reflog. You should probably cancel this\
>  commit and create a new branch to continue.\n\
>  \n\

Looks obviously correct; Pat?
