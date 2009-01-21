From: Markus Heidelberg <markus.heidelberg@web.de>
Subject: Re: [PATCH 1/2] user-manual: Simplify the user configuration.
Date: Wed, 21 Jan 2009 19:55:47 +0100
Message-ID: <200901211955.47362.markus.heidelberg@web.de>
References: <1232561365-5919-1-git-send-email-felipe.contreras@gmail.com>
Reply-To: markus.heidelberg@web.de
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Felipe Contreras <felipe.contreras@gmail.com>
X-From: git-owner@vger.kernel.org Wed Jan 21 19:57:31 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LPiGG-0005IL-Pa
	for gcvg-git-2@gmane.org; Wed, 21 Jan 2009 19:57:13 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752926AbZAUSzk (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 21 Jan 2009 13:55:40 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752789AbZAUSzk
	(ORCPT <rfc822;git-outgoing>); Wed, 21 Jan 2009 13:55:40 -0500
Received: from fmmailgate01.web.de ([217.72.192.221]:54107 "EHLO
	fmmailgate01.web.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752889AbZAUSzj (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 21 Jan 2009 13:55:39 -0500
Received: from smtp05.web.de (fmsmtp05.dlan.cinetic.de [172.20.4.166])
	by fmmailgate01.web.de (Postfix) with ESMTP id 49095FC0EA3F;
	Wed, 21 Jan 2009 19:55:38 +0100 (CET)
Received: from [89.59.73.85] (helo=pluto)
	by smtp05.web.de with asmtp (TLSv1:AES256-SHA:256)
	(WEB.DE 4.110 #277)
	id 1LPiEj-0008Bd-00; Wed, 21 Jan 2009 19:55:37 +0100
User-Agent: KMail/1.9.9
In-Reply-To: <1232561365-5919-1-git-send-email-felipe.contreras@gmail.com>
Jabber-ID: markus.heidelberg@web.de
Content-Disposition: inline
X-Sender: markus.heidelberg@web.de
X-Provags-ID: V01U2FsdGVkX19Oj/HYDckdxG+OHyMtOry3UC1tr8AXN2vIEGQs
	ambS3unhaO7sVGu9QhdMnW62p8RDuO80RmOjit6ghDIN5Qb9Mu
	uy1MakgR0cFdD8zEIZzw==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/106641>

Felipe Contreras, 21.01.2009:
> +++ b/Documentation/user-manual.txt
> @@ -981,13 +981,11 @@ Telling git your name
>  ---------------------
>  
>  Before creating any commits, you should introduce yourself to git.  The
> -easiest way to do so is to make sure the following lines appear in a
> -file named .gitconfig in your home directory:
> +easiest way is to use the linkgit:git-config[1] command:
>  
>  ------------------------------------------------
> -[user]
> -	name = Your Name Comes Here
> -	email = you@yourdomain.example.com
> +$ git config user.name "Your Name Comes Here"
> +$ git config user.email you@yourdomain.example.com

--global

Markus
