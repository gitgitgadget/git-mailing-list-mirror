From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] added a built-in alias for 'stage' to the 'add' command
Date: Mon, 01 Dec 2008 17:38:20 -0800
Message-ID: <7vbpvvqrub.fsf@gitster.siamese.dyndns.org>
References: <20081201172902.GA41963@agadorsparticus>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, gitster@pobox.com
To: Scott Chacon <schacon@gmail.com>
X-From: git-owner@vger.kernel.org Tue Dec 02 02:40:09 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1L7KFF-0001iY-6n
	for gcvg-git-2@gmane.org; Tue, 02 Dec 2008 02:40:09 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752613AbYLBBix (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 1 Dec 2008 20:38:53 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752614AbYLBBix
	(ORCPT <rfc822;git-outgoing>); Mon, 1 Dec 2008 20:38:53 -0500
Received: from a-sasl-fastnet.sasl.smtp.pobox.com ([207.106.133.19]:41056 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752309AbYLBBiw (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 1 Dec 2008 20:38:52 -0500
Received: from localhost.localdomain (unknown [127.0.0.1])
	by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with ESMTP id 091BF83988;
	Mon,  1 Dec 2008 20:38:52 -0500 (EST)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES256-SHA (256/256 bits)) (No client certificate requested) by
 a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with ESMTPSA id 139FC83984; Mon,
  1 Dec 2008 20:38:21 -0500 (EST)
In-Reply-To: <20081201172902.GA41963@agadorsparticus> (Scott Chacon's message
 of "Mon, 1 Dec 2008 09:29:02 -0800")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
X-Pobox-Relay-ID: F948ABF2-C011-11DD-9247-465CC92D7133-77302942!a-sasl-fastnet.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/102092>

Scott Chacon <schacon@gmail.com> writes:

> Subject: Re: [PATCH] added a built-in alias for 'stage' to the 'add' command

s/added/Add/;

Write your commit log message in present tense (recall David Brown's talk
at GitTogether '08? ;-)

> this comes from conversation at the GitTogether where we thought it would

s/this/This/;

> be helpful to be able to teach people to 'stage' files because it tends
> to cause confusion when told that they have to keep 'add'ing them.
>
> This continues the movement to start referring to the index as a
> staging area (eg: the --staged alias to 'git diff'). Also added a
> doc file for 'git stage' that basically points to the docs for
> 'git add'.
>
> Signed-off-by: Scott Chacon <schacon@gmail.com>

I think this is fine but I'd rather not risk the documentation getting
stale over time, so...

> +SYNOPSIS
> +--------
> +[verse]
> +'git stage' [-n] [-v] [--force | -f] [--interactive | -i] [--patch | -p]
> +	  [--all | [--update | -u]] [--intent-to-add | -N]
> +	  [--refresh] [--ignore-errors] [--] <filepattern>...

...I think this should read something like

	'git stage' args...
