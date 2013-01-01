From: Chris Packham <judge.packham@gmail.com>
Subject: Re: [PATCH] Remove the suggestion to use parsecvs, which is currently
 broken.
Date: Tue, 01 Jan 2013 23:05:00 +1300
Message-ID: <50E2B4CC.7050503@gmail.com>
References: <20121228162025.8565E4413A@snark.thyrsus.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: "Eric S. Raymond" <esr@thyrsus.com>
X-From: git-owner@vger.kernel.org Tue Jan 01 11:04:34 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Tpyhx-0007DI-UM
	for gcvg-git-2@plane.gmane.org; Tue, 01 Jan 2013 11:04:30 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752109Ab3AAKEI (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 1 Jan 2013 05:04:08 -0500
Received: from mail-da0-f46.google.com ([209.85.210.46]:61641 "EHLO
	mail-da0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752044Ab3AAKEH (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 1 Jan 2013 05:04:07 -0500
Received: by mail-da0-f46.google.com with SMTP id p5so6021485dak.5
        for <git@vger.kernel.org>; Tue, 01 Jan 2013 02:04:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=x-received:message-id:date:from:user-agent:mime-version:to:cc
         :subject:references:in-reply-to:content-type
         :content-transfer-encoding;
        bh=pjZ9nh/+JXLqTzvtKHnrDTY2OsvX7qj5BHSxTXFkXZc=;
        b=JsRlOsGhY5d2ymR9b+LsuuvRMgd0Dwx9sqlnSuJ0k7NWIvIXIETVW+8G4pCBnZGe8Q
         6sOzwVKiPrSNeUXLpFapvtALyEDSDTnKrZpPQZWn9dv5z6wizPVjw2QxCWDgcr69H5SM
         pHuUKdWBwOk1hSlICsiOckQ9wJZj7mjlrRnko0GRymuLmyXMcXgsxB5PS7p/JxEt5qqB
         8pHweIkdq0jRktWgwx4ig84/Rsmzd2XaB9M3qeopAYVZOglTXajLjn9/r6GJuReydqCo
         Bx9JiGq/8W7L/W9TXDvmYZyH0hALCLMI1RyyGhMx1Ns6YjolunxAXKkwf/HAAVAorwj2
         hqvg==
X-Received: by 10.66.87.8 with SMTP id t8mr127908739paz.28.1357034647083;
        Tue, 01 Jan 2013 02:04:07 -0800 (PST)
Received: from [192.168.1.103] (115-188-15-163.jetstream.xtra.co.nz. [115.188.15.163])
        by mx.google.com with ESMTPS id na7sm26428611pbc.48.2013.01.01.02.04.05
        (version=SSLv3 cipher=OTHER);
        Tue, 01 Jan 2013 02:04:06 -0800 (PST)
User-Agent: Mozilla/5.0 (X11; Linux i686; rv:17.0) Gecko/17.0 Thunderbird/17.0
In-Reply-To: <20121228162025.8565E4413A@snark.thyrsus.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/212420>

Minor typo

On 12/29/2012 05:20 AM, Eric S. Raymond wrote:
> The parsecvs code has been neglected for a long time, and the only
> public version does not even build correctly.  I have been handed
> control of the project and intend to fix this, but until I do it
> cannot be recommended.
> 
> Also, the project URL given for Subversion needed to be updated
> to follow their site move.
> ---
>  Documentation/git-cvsimport.txt | 6 ++----
>  1 file changed, 2 insertions(+), 4 deletions(-)
> 
> diff --git a/Documentation/git-cvsimport.txt b/Documentation/git-cvsimport.txt
> index 98d9881..9d5353e 100644
> --- a/Documentation/git-cvsimport.txt
> +++ b/Documentation/git-cvsimport.txt
> @@ -213,11 +213,9 @@ Problems related to tags:
>  * Multiple tags on the same revision are not imported.
>  
>  If you suspect that any of these issues may apply to the repository you
> -want to import consider using these alternative tools which proved to be
> -more stable in practice:
> +want to imort, consider using cvs2git:

s/imort/import/

>  
> -* cvs2git (part of cvs2svn), `http://cvs2svn.tigris.org`
> -* parsecvs, `http://cgit.freedesktop.org/~keithp/parsecvs`
> +* cvs2git (part of cvs2svn), `http://subversion.apache.org/`
>  
>  GIT
>  ---
> 
