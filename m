From: Jason Holden <jason.k.holden.swdev@gmail.com>
Subject: Re: [PATCH 2/3] SubmittingPatches: mention subsystems with dedicated
 repositories
Date: Tue, 1 Jan 2013 20:52:34 -0500
Message-ID: <20130102015233.GA25288@gmail.com>
References: <1357082695-29713-1-git-send-email-gitster@pobox.com>
 <1357082695-29713-3-git-send-email-gitster@pobox.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Jan 02 03:05:35 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TqDhz-0001J7-91
	for gcvg-git-2@plane.gmane.org; Wed, 02 Jan 2013 03:05:31 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752297Ab3ABBwj (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 1 Jan 2013 20:52:39 -0500
Received: from mail-vc0-f178.google.com ([209.85.220.178]:57949 "EHLO
	mail-vc0-f178.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751794Ab3ABBwh (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 1 Jan 2013 20:52:37 -0500
Received: by mail-vc0-f178.google.com with SMTP id x16so13725017vcq.23
        for <git@vger.kernel.org>; Tue, 01 Jan 2013 17:52:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=x-received:date:from:to:cc:subject:message-id:references
         :mime-version:content-type:content-disposition:in-reply-to
         :user-agent;
        bh=iEjuXOJ86o+5zslGbdd3VxLU948vGCS1jwIxaDXBHJc=;
        b=ecD/3Wn8fXWkon/+2GYTHHd26TQ728QxZ/GzgJylyFX9GWlDqCLn+L6qO1C7eOBHwR
         GMTS016D+LgAfnpLdnzymhsk+u3sCE4Gu4J+TPJ2ER0QzpfAmrYwVgwu2ouWt/LglO7v
         FLexSWEBHNZyTk4Ejxt56Uiam5g/3thlJffAy4qJBRnjOw2Eo/WGt6/0FW7S8yHhtLLv
         lFYzMO/lvfnLT7MRrCQt++RcKU3T/a7B+KUn7TailJvDK0F/ZkFoDsXRG10nP/VScuhZ
         ur9q5SzirlQvdb2Y2WAEjcPJCAiWlENVISIScgVw0H/dKgWI67Nn5alJTfzyUfY2+ukv
         a3Jg==
X-Received: by 10.220.151.72 with SMTP id b8mr68762653vcw.38.1357091555571;
        Tue, 01 Jan 2013 17:52:35 -0800 (PST)
Received: from gmail.com (c-75-69-185-21.hsd1.nh.comcast.net. [75.69.185.21])
        by mx.google.com with ESMTPS id z20sm42456295vds.12.2013.01.01.17.52.34
        (version=TLSv1/SSLv3 cipher=OTHER);
        Tue, 01 Jan 2013 17:52:35 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <1357082695-29713-3-git-send-email-gitster@pobox.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/212485>

On Tue, Jan 01, 2013 at 03:24:54PM -0800, Junio C Hamano wrote:
>  
>  ------------------------------------------------
> +Subsystems with dedicated maintainers
> +
> +Some parts of the system have dedicated maintainers with their own
> +repositories.
> +
> + - git-gui/ comes from git-gui project, maintained by Pat Thoyts:
> +
> +        git://repo.or.cz/git-gui.git
> +
> + - gitk-git/ comes from Paul Mackerras's gitk project:
> +
> +        git://ozlabs.org/~paulus/gitk
> +
> + - po/ comes from the localization coordinator, Jiang Xin:
> +
> +	https://github.com/git-l10n/git-po/
> +
> +Patches to these parts should be based on their trees.
> +
> +------------------------------------------------
>  An ideal patch flow
>  

Any reason to leave out the maintainers email addresses? If we add that, all
the content of the MAINTAINERS file we had been discussing would then be in
this file.

My only other suggestion for this series might be to augment the file with 
a patch submittal example(s).  I found the best example to be in 
git-send-email's man page, but maybe enumerate the example out for the 
most common workflows.  Maybe something like:

-----------------------------------------------------------
Example of sending patches for a new feature:

Create the patches:
 $ git format-patch --cover-letter -M origin/master -o outgoing/
 $ edit outgoing/0000-*

To send your completed patches for initial consideration:
 $ git send-email outgoing/* -to git@vger.kernel.org -cc gitster@pobox.com

To send your reviewed patches for inclusion:
 $ git send-email outgoing/* -to gitster@pobox.com -cc git@vger.kernel.org

-Jason
