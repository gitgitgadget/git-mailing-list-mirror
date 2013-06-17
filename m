From: Marc Branchaud <marcnarc@xiplink.com>
Subject: Re: [PATCH] Documentation/git-push.txt: explain better cases where
 --force is dangerous
Date: Mon, 17 Jun 2013 17:09:48 -0400
Message-ID: <51BF7B1C.2040703@xiplink.com>
References: <1371491561-19117-1-git-send-email-Matthieu.Moy@imag.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org, gitster@pobox.com, philipoakley@iee.org,
	artagnon@gmail.com, marcnarc@xiplink.com
To: Matthieu Moy <Matthieu.Moy@imag.fr>
X-From: git-owner@vger.kernel.org Mon Jun 17 23:16:42 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Uogn3-0003Bv-SK
	for gcvg-git-2@plane.gmane.org; Mon, 17 Jun 2013 23:16:42 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754233Ab3FQVQi (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 17 Jun 2013 17:16:38 -0400
Received: from smtp142.dfw.emailsrvr.com ([67.192.241.142]:36302 "EHLO
	smtp142.dfw.emailsrvr.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753767Ab3FQVQh (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 17 Jun 2013 17:16:37 -0400
X-Greylist: delayed 406 seconds by postgrey-1.27 at vger.kernel.org; Mon, 17 Jun 2013 17:16:37 EDT
Received: from localhost (localhost.localdomain [127.0.0.1])
	by smtp14.relay.dfw1a.emailsrvr.com (SMTP Server) with ESMTP id B06B532822C;
	Mon, 17 Jun 2013 17:09:50 -0400 (EDT)
X-Virus-Scanned: OK
Received: by smtp14.relay.dfw1a.emailsrvr.com (Authenticated sender: mbranchaud-AT-xiplink.com) with ESMTPSA id CB20A328215;
	Mon, 17 Jun 2013 17:09:49 -0400 (EDT)
User-Agent: Mozilla/5.0 (X11; Linux i686; rv:17.0) Gecko/20130510 Thunderbird/17.0.6
In-Reply-To: <1371491561-19117-1-git-send-email-Matthieu.Moy@imag.fr>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/228116>

On 13-06-17 01:52 PM, Matthieu Moy wrote:
> The behavior of "git push --force" is rather clear when it updates only
> one remote ref, but running it when pushing several branches can really
> be dangerous. Warn the users a bit more and give them the alternative to
> push only one branch.
>
> Signed-off-by: Matthieu Moy <Matthieu.Moy@imag.fr>
> ---
>   Documentation/git-push.txt | 8 ++++++++
>   1 file changed, 8 insertions(+)
>
> diff --git a/Documentation/git-push.txt b/Documentation/git-push.txt
> index 938d1ee..9b9e7d1 100644
> --- a/Documentation/git-push.txt
> +++ b/Documentation/git-push.txt
> @@ -136,6 +136,14 @@ already exists on the remote side.
>   	not an ancestor of the local ref used to overwrite it.
>   	This flag disables the check.  This can cause the
>   	remote repository to lose commits; use it with care.
> +	Note that `--force` applies to all the refs that are pushed,
> +	hence using it with `push.default` set to `matching` or with
> +	multiple push destination configured may override refs other

s/destination/destinations/

		M.
