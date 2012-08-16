From: Junio C Hamano <gitster@pobox.com>
Subject: Re: Can't track untracked file
Date: Wed, 15 Aug 2012 19:04:36 -0700
Message-ID: <7vr4r7383v.fsf@alter.siamese.dyndns.org>
References: <A32BFCAF-114F-4A65-B802-8DD2A795B96E@snafu.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Marco S Hyman <marc@snafu.org>
X-From: git-owner@vger.kernel.org Thu Aug 16 04:04:54 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1T1pS2-0006FS-VR
	for gcvg-git-2@plane.gmane.org; Thu, 16 Aug 2012 04:04:47 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752428Ab2HPCEl (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 15 Aug 2012 22:04:41 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:63064 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751235Ab2HPCEk (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 15 Aug 2012 22:04:40 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 08D1597B0;
	Wed, 15 Aug 2012 22:04:40 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=S6rFsKekx3C/r8eVY1WLN6usH08=; b=E78euz
	tyPkXQ3YqLpIYOMWGTvS36kaO9w/B1EH8ixUfQMCOEDNhfagZ1S5ieAgbF2lNZEt
	KaC6/2o4ap1IeHukjOG3oCeONZbDzAg4MMjsKP8MLOT1jt1PLp1hDOSksaB6aMgK
	UJmbD1iUfZQIZ9lkw84tpKvvPpZJyAYg9aBY0=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=bmbskaLOAShfZeWwvYcuOtA75tLbLK3b
	BUP+UDzhsIwtpK5t5Wx2wVHtE0PzI4VJaTQxX871/fzwxo1lXjgMvjSxW+AhFA2T
	JPRxxTo60mLvG5D5qkNSx0SWw4lsJPmNQAwcGRD3IiWT7DN1HDkAdlbfTxaCJVdV
	MAmRZVnEYvY=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id E948D97AF;
	Wed, 15 Aug 2012 22:04:39 -0400 (EDT)
Received: from pobox.com (unknown [98.234.214.94]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 30F9197AE; Wed, 15 Aug 2012
 22:04:39 -0400 (EDT)
In-Reply-To: <A32BFCAF-114F-4A65-B802-8DD2A795B96E@snafu.org> (Marco S.
 Hyman's message of "Wed, 15 Aug 2012 16:58:41 -0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: BC61C02E-E746-11E1-86E4-01B42E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Marco S Hyman <marc@snafu.org> writes:

> And there is NOTHING I can do to get that directory into git.
>
>   $ git add 2010
>   $ git commit -m 'will it work?'
>   # On branch master
>   # Untracked files:
>   #   (use "git add <file>..." to include in what will be committed)
>   #
>   #	2010/
>   nothing added to commit but untracked files present (use "git add" to track)
>
> The directory is not empty.

Perhaps "2010" or everything in it is ignored in .gitignore in
higher directories?
