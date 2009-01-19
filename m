From: Junio C Hamano <gitster@pobox.com>
Subject: Re: how to omit rename file when commit
Date: Mon, 19 Jan 2009 01:16:23 -0800
Message-ID: <7v63kbr6zc.fsf@gitster.siamese.dyndns.org>
References: <1976ea660901190113l5407f108lff8f37d9a8331f58@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: "Frank Li" <lznuaa@gmail.com>
X-From: git-owner@vger.kernel.org Mon Jan 19 10:17:54 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LOqGX-0001ve-U8
	for gcvg-git-2@gmane.org; Mon, 19 Jan 2009 10:17:54 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755041AbZASJQb (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 19 Jan 2009 04:16:31 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755005AbZASJQa
	(ORCPT <rfc822;git-outgoing>); Mon, 19 Jan 2009 04:16:30 -0500
Received: from a-sasl-fastnet.sasl.smtp.pobox.com ([207.106.133.19]:65159 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754697AbZASJQ3 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 19 Jan 2009 04:16:29 -0500
Received: from localhost.localdomain (unknown [127.0.0.1])
	by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with ESMTP id 81FF491AFA;
	Mon, 19 Jan 2009 04:16:28 -0500 (EST)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES256-SHA (256/256 bits)) (No client certificate requested) by
 a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with ESMTPSA id C8BAA91AF9; Mon,
 19 Jan 2009 04:16:25 -0500 (EST)
In-Reply-To: <1976ea660901190113l5407f108lff8f37d9a8331f58@mail.gmail.com>
 (Frank Li's message of "Mon, 19 Jan 2009 17:13:57 +0800")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
X-Pobox-Relay-ID: DA752052-E609-11DD-98FB-5720C92D7133-77302942!a-sasl-fastnet.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/106338>

"Frank Li" <lznuaa@gmail.com> writes:

> For example there are a file a.c at git repository.
> use
> git mv a.c b.c
>
> git status:
> # On branch master
> # Changes to be committed:
> #   (use "git reset HEAD <file>..." to unstage)
> #
> #       renamed:    a.c -> b.c
>
> If we don't want to stage this change at this commit,  what can I do?

I may be misunderstanding what you want to do, but wouldn't "git mv b.c
a.c" undo whatever you did?
