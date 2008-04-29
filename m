From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [regression?] "git status -a" reports modified for empty
 submodule directory
Date: Tue, 29 Apr 2008 14:40:17 -0700
Message-ID: <7v4p9k7326.fsf@gitster.siamese.dyndns.org>
References: <46dff0320804220401h26d2f2ebg1748a4a310acc0f5@mail.gmail.com>
 <46dff0320804290831u7ef1a78ag2988d5d12f782bdb@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: "Git Mailing List" <git@vger.kernel.org>
To: "Ping Yin" <pkufranky@gmail.com>
X-From: git-owner@vger.kernel.org Tue Apr 29 23:41:27 2008
connect(): Connection refused
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JqxZj-0003PM-CH
	for gcvg-git-2@gmane.org; Tue, 29 Apr 2008 23:41:23 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752176AbYD2Vkg (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 29 Apr 2008 17:40:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752045AbYD2Vkf
	(ORCPT <rfc822;git-outgoing>); Tue, 29 Apr 2008 17:40:35 -0400
Received: from a-sasl-fastnet.sasl.smtp.pobox.com ([207.106.133.19]:51951 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751937AbYD2Vkf (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 29 Apr 2008 17:40:35 -0400
Received: from localhost.localdomain (localhost [127.0.0.1])
	by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with ESMTP id C09D02C4E;
	Tue, 29 Apr 2008 17:40:31 -0400 (EDT)
Received: from pobox.com (ip68-225-240-77.oc.oc.cox.net [68.225.240.77])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits)) (No client
 certificate requested) by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with
 ESMTP id 1614D2C4C; Tue, 29 Apr 2008 17:40:25 -0400 (EDT)
In-Reply-To: <46dff0320804290831u7ef1a78ag2988d5d12f782bdb@mail.gmail.com>
 (Ping Yin's message of "Tue, 29 Apr 2008 23:31:59 +0800")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
X-Pobox-Relay-ID: E47201CE-1634-11DD-A0F4-80001473D85F-77302942!a-sasl-fastnet.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/80746>

"Ping Yin" <pkufranky@gmail.com> writes:

> In the super project super with empty submodule directory sub
> $ git diff
> diff --git a/sub b/sub
> deleted file mode 160000
> index f2c0d45..0000000
> --- a/sub
> +++ /dev/null
> @@ -1 +0,0 @@
> -Subproject commit f2c0d4509a3178c...

The repository used to have a subproject and now it doesn't.  Why
shouldn't it report the removal?
