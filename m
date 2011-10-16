From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 0/7] Some patches from msysGit (round 2)
Date: Sat, 15 Oct 2011 22:17:23 -0700
Message-ID: <7vsjmtsefw.fsf@alter.siamese.dyndns.org>
References: <1318687520-19522-1-git-send-email-patthoyts@users.sourceforge.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Git <git@vger.kernel.org>, msysGit <msysgit@googlegroups.com>
To: Pat Thoyts <patthoyts@users.sourceforge.net>
X-From: git-owner@vger.kernel.org Sun Oct 16 07:17:33 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RFJ6K-00042r-UJ
	for gcvg-git-2@lo.gmane.org; Sun, 16 Oct 2011 07:17:33 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751542Ab1JPFR3 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 16 Oct 2011 01:17:29 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:53005 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750822Ab1JPFR2 (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 16 Oct 2011 01:17:28 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id BB6902C27;
	Sun, 16 Oct 2011 01:17:25 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=y+q8Fr113i79BTTM4lR6m35LkjA=; b=cn/aPn
	sKUX7dMs7HqI+SyhKZGY7/v/qbXtPLXVXmiJkAazUDzjvR+syYv7qBgQSOwCjJxz
	SUE8Mu7z22+IZJNNynXawfWuCzza5CLvN7277cLROiwtmvnIGQH1l8g6NFkohqaE
	5ggynyOHxeS9WxJcULxOEj9IMtA0qJ6Rz+Mmk=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=www9BznA9JCexH9Mfzkvm4KuPvmuxLfH
	WjJ1cNxxRfT1pXqCXJf5ydWTUZh7aAz77Zun66nnVliKcuBac4H3vjF8WFhRcZZ2
	8BQE4pG0QVTBhgc3HrEaBbGzOFVXNAHH6gEgOdgKBig1yHNRC7/oxyaRKWpU5jS2
	WItTZXqEL/I=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id B35EA2C25;
	Sun, 16 Oct 2011 01:17:25 -0400 (EDT)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 406592C24; Sun, 16 Oct 2011
 01:17:25 -0400 (EDT)
In-Reply-To: <1318687520-19522-1-git-send-email-patthoyts@users.sourceforge.net> (Pat
 Thoyts's message of "Sat, 15 Oct 2011 15:05:13 +0100")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 224DD156-F7B6-11E0-9E72-9DB42E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/183692>

Pat Thoyts <patthoyts@users.sourceforge.net> writes:

> This collects some recent patches from the msysGit tree that clear up
> test issues on Windows.
>
> This second version incorporates suggestions received from round 1 to:
>   avoid duplicating code in t9901 web-browse tests
>   drop the t1402 changes in favour of another change from J6t (on pu)
>   test for the presence of 'bcomp' in bc3 mergetool

Thanks.

Will replace the previous patches with these and advance them to 'next'
shortly.
