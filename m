From: "J. Bruce Fields" <bfields@fieldses.org>
Subject: Re: [RFC/PATCH 7/8] user-manual: add global config section
Date: Tue, 24 Mar 2009 17:52:23 -0400
Message-ID: <20090324215223.GL19389@fieldses.org>
References: <1237745121-6325-1-git-send-email-felipe.contreras@gmail.com> <1237745121-6325-2-git-send-email-felipe.contreras@gmail.com> <1237745121-6325-3-git-send-email-felipe.contreras@gmail.com> <1237745121-6325-4-git-send-email-felipe.contreras@gmail.com> <1237745121-6325-5-git-send-email-felipe.contreras@gmail.com> <1237745121-6325-6-git-send-email-felipe.contreras@gmail.com> <1237745121-6325-7-git-send-email-felipe.contreras@gmail.com> <1237745121-6325-8-git-send-email-felipe.contreras@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Felipe Contreras <felipe.contreras@gmail.com>
X-From: git-owner@vger.kernel.org Tue Mar 24 22:54:05 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LmEZJ-0003xn-F4
	for gcvg-git-2@gmane.org; Tue, 24 Mar 2009 22:53:57 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752367AbZCXVw1 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 24 Mar 2009 17:52:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752074AbZCXVw0
	(ORCPT <rfc822;git-outgoing>); Tue, 24 Mar 2009 17:52:26 -0400
Received: from mail.fieldses.org ([141.211.133.115]:50898 "EHLO
	pickle.fieldses.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751534AbZCXVwZ (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 24 Mar 2009 17:52:25 -0400
Received: from bfields by pickle.fieldses.org with local (Exim 4.69)
	(envelope-from <bfields@fieldses.org>)
	id 1LmEXn-0006Gz-Ub; Tue, 24 Mar 2009 17:52:23 -0400
Content-Disposition: inline
In-Reply-To: <1237745121-6325-8-git-send-email-felipe.contreras@gmail.com>
User-Agent: Mutt/1.5.18 (2008-05-17)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/114496>

On Sun, Mar 22, 2009 at 08:05:20PM +0200, Felipe Contreras wrote:
> Signed-off-by: Felipe Contreras <felipe.contreras@gmail.com>
> ---
>  Documentation/user-manual.txt |   34 ++++++++++++++++++++++++++++++++++
>  1 files changed, 34 insertions(+), 0 deletions(-)
> 
> diff --git a/Documentation/user-manual.txt b/Documentation/user-manual.txt
> index 3278aa7..b7678aa 100644
> --- a/Documentation/user-manual.txt
> +++ b/Documentation/user-manual.txt
> @@ -40,6 +40,40 @@ without any explanation.
>  Finally, see <<todo>> for ways that you can help make this manual more
>  complete.
>  
> +[[getting-started]]
> +Getting started
> +=============
> +
> +You can skip this section safely, however, configuring git at an early stage
> +would probably make your overall experience with it more pleasant. Also many
> +parts on this manual would be easier to grasp.

I'd skip this first paragraph.

> +
> +Git's configuration is distributed on different locations: 'system', 'global', and
> +'repository'. Variables are stored in the form of 'foo.bar', and the precedence
> +order is 'repository' > 'global' > 'system'.

"distributed on" isn't right ("among" instead of "on" might work).  It's
not obvious to me what ">" means in terms of precedence.  And I'm not
sure the comment about the form conveys any useful information.  Also, I
think the systemwide configuration is less important, and could be left
to the man page.

> +
> +You would probably want to start setting up something useful:
> +------------------------------------------------
> +$ git config --global color.ui auto
> +------------------------------------------------
> +
> +This will make prettier the output of certain commands such as `git diff`, but
> +that's not important; what is important here is that `color.ui` has been
> +stored in the 'global' (for the user) configuration.
> +
> +You can take a look and manually modify the configuration with the `--edit`

"take a look and" isn't really necessary; either eliminate it or replace
it by "view and" or just "also".

> +option (will use '$EDITOR'):

s/will/which will/.

--b.

> +------------------------------------------------
> +$ git config --global --edit
> +[color]
> +        ui = auto
> +------------------------------------------------
> +
> +Or you can manually edit the file which is located in `~/.gitconfig`. Other
> +locations are `/etc/gitconfig` (system), and `.git/config` (repository).
> +
> +Other git configurations will be covered in the rest of the manual, if you
> +want to learn more look at linkgit:git-config[1] for details.
>  
>  [[repositories-and-branches]]
>  Repositories and Branches
> -- 
> 1.6.2.1.352.gae594
> 
> --
> To unsubscribe from this list: send the line "unsubscribe git" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
