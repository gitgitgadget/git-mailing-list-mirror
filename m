From: Marc Branchaud <marcnarc@xiplink.com>
Subject: Re: [PATCH/RFC] Documentation/git-gc.txt: add reference to githooks
Date: Mon, 28 Jun 2010 14:43:21 -0400
Message-ID: <4C28ED49.90906@xiplink.com>
References: <AANLkTikjbu_q6QToVUeNAAL0Fls9eQ5BZkzZ1-8L93zh@mail.gmail.com> <1277744834-7546-1-git-send-email-judge.packham@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: spearce@spearce.org, git@vger.kernel.org
To: Chris Packham <judge.packham@gmail.com>
X-From: git-owner@vger.kernel.org Mon Jun 28 20:43:38 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OTJIo-0006eb-IY
	for gcvg-git-2@lo.gmane.org; Mon, 28 Jun 2010 20:43:30 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751476Ab0F1SnZ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 28 Jun 2010 14:43:25 -0400
Received: from smtp152.iad.emailsrvr.com ([207.97.245.152]:45577 "EHLO
	smtp152.iad.emailsrvr.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750808Ab0F1SnY (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 28 Jun 2010 14:43:24 -0400
Received: from relay25.relay.iad.mlsrvr.com (localhost [127.0.0.1])
	by relay25.relay.iad.mlsrvr.com (SMTP Server) with ESMTP id 0D7461B400F;
	Mon, 28 Jun 2010 14:43:22 -0400 (EDT)
Received: by relay25.relay.iad.mlsrvr.com (Authenticated sender: mbranchaud-AT-xiplink.com) with ESMTPSA id D2CB41B401F;
	Mon, 28 Jun 2010 14:43:21 -0400 (EDT)
User-Agent: Mozilla/5.0 (X11; U; Linux x86_64; en-US; rv:1.9.1.9) Gecko/20100423 Thunderbird/3.0.4
In-Reply-To: <1277744834-7546-1-git-send-email-judge.packham@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/149847>

How about also adding a templates/hooks--pre-auto-gc.sample file?

		M.


On 10-06-28 01:07 PM, Chris Packham wrote:
> This advertises the existence of the 'pre-auto-gc' hook and adds a cross
> reference to where the hook is documented.
> 
> Signed-off-by: Chris Packham <judge.packham@gmail.com>
> ---
> I had to go fishing in the code to find out about the pre-auto-gc hook. From
> reading the git-gc man page it wasn't obvious to me that there would be a hook
> for 'git gc --auto'. The relevant config variables are mentioned so it seems
> logical to mention the hooks also. The only precedent I found for this was in
> the git-commit man page which has a section listing the hooks that are
> available.
> 
>  Documentation/git-gc.txt |    5 +++++
>  1 files changed, 5 insertions(+), 0 deletions(-)
> 
> diff --git a/Documentation/git-gc.txt b/Documentation/git-gc.txt
> index a9e0882..a514c52 100644
> --- a/Documentation/git-gc.txt
> +++ b/Documentation/git-gc.txt
> @@ -137,6 +137,11 @@ If you are expecting some objects to be collected and they aren't, check
>  all of those locations and decide whether it makes sense in your case to
>  remove those references.
>  
> +HOOKS
> +-----
> +This command can run `pre-auto-gc` hook.  See linkgit:githooks[5] for more
> +information.
> +
>  SEE ALSO
>  --------
>  linkgit:git-prune[1]
