From: Michael J Gruber <git@drmicha.warpmail.net>
Subject: Re: [PATCH 1/3] Better document the original repository layout.
Date: Fri, 04 Dec 2009 15:52:00 +0100
Message-ID: <4B192210.908@drmicha.warpmail.net>
References: <cover.1259934977.git.mhagger@alum.mit.edu> <91462ec5e4409e558ec5158b7dea33ebf0081d3e.1259934977.git.mhagger@alum.mit.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org, gitster@pobox.com, Johannes.Schindelin@gmx.de
To: Michael Haggerty <mhagger@alum.mit.edu>
X-From: git-owner@vger.kernel.org Fri Dec 04 15:53:47 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NGZXV-0004dI-7u
	for gcvg-git-2@lo.gmane.org; Fri, 04 Dec 2009 15:53:45 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756958AbZLDOxN (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 4 Dec 2009 09:53:13 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756843AbZLDOxM
	(ORCPT <rfc822;git-outgoing>); Fri, 4 Dec 2009 09:53:12 -0500
Received: from out1.smtp.messagingengine.com ([66.111.4.25]:54228 "EHLO
	out1.smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1756963AbZLDOxJ (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 4 Dec 2009 09:53:09 -0500
Received: from compute1.internal (compute1.internal [10.202.2.41])
	by gateway1.messagingengine.com (Postfix) with ESMTP id 77AE4C5951;
	Fri,  4 Dec 2009 09:53:15 -0500 (EST)
Received: from heartbeat1.messagingengine.com ([10.202.2.160])
  by compute1.internal (MEProxy); Fri, 04 Dec 2009 09:53:15 -0500
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed/relaxed; d=messagingengine.com; h=message-id:date:from:mime-version:to:cc:subject:references:in-reply-to:content-type:content-transfer-encoding; s=smtpout; bh=WUZ++2XKuDGVKHciI0l6Nx6NBrY=; b=N7Hr+F+wkiTa8AQi8hkMwZrMgVqqGd/HNmi74EA3ro08t0KKMR3RHZPdZx5aiTNBdUESjRA8vh6sbdWJdNdw8zokhsXOKxeNQ8XjY+eRXVZbwd3ejYkO8GCTBoy1ZllDhq/jglfXUGxt1Mli6WNVfdpD/W9kQk0UQqC3tvZZw6Y=
X-Sasl-enc: pUjrfyYTzvi2n8gUA3zkZGxvkVOcVspIlsReZkb1rjmm 1259938395
Received: from localhost.localdomain (whitehead.math.tu-clausthal.de [139.174.44.12])
	by mail.messagingengine.com (Postfix) with ESMTPSA id 9173D4D337;
	Fri,  4 Dec 2009 09:53:14 -0500 (EST)
User-Agent: Mozilla/5.0 (X11; U; Linux x86_64; en-US; rv:1.9.1.7pre) Gecko/20091204 Lightning/1.0b1pre Shredder/3.0.1pre
In-Reply-To: <91462ec5e4409e558ec5158b7dea33ebf0081d3e.1259934977.git.mhagger@alum.mit.edu>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/134514>

Michael Haggerty venit, vidit, dixit 04.12.2009 15:36:
> Signed-off-by: Michael Haggerty <mhagger@alum.mit.edu>
> ---
>  t/t3404-rebase-interactive.sh |    9 +++++----
>  1 files changed, 5 insertions(+), 4 deletions(-)
> 
> diff --git a/t/t3404-rebase-interactive.sh b/t/t3404-rebase-interactive.sh
> index 3a37793..073674f 100755
> --- a/t/t3404-rebase-interactive.sh
> +++ b/t/t3404-rebase-interactive.sh
> @@ -16,13 +16,14 @@ set_fake_editor
>  
>  # set up two branches like this:
>  #
> -# A - B - C - D - E
> +# A - B - C - D - E     (master)
>  #   \
> -#     F - G - H
> +#     F - G - H         (branch1)
>  #       \
> -#         I
> +#         I             (branch2)
>  #
> -# where B, D and G touch the same file.
> +# where B, D and G touch the same file.  In addition, set tags at
> +# points A, F, and I.
>  
>  test_expect_success 'setup' '
>  	: > file1 &&

My first reaction to the subject was "Huh? What repository?". So I
suggest something like

t3404: Better document the original repository layout

as a more descriptive subject.

Michael
