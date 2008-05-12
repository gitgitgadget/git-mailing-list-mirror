From: "Shawn O. Pearce" <spearce@spearce.org>
Subject: Re: [JGIT PATCH v2 04/24] Added path related constats to Constats class.
Date: Mon, 12 May 2008 19:54:31 -0400
Message-ID: <20080512235431.GY29038@spearce.org>
References: <1210623222-24908-1-git-send-email-florianskarten@web.de> <1210623222-24908-5-git-send-email-florianskarten@web.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org
To: Florian Koeberle <florianskarten@web.de>
X-From: git-owner@vger.kernel.org Tue May 13 01:55:25 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JvhrY-0000YX-8a
	for gcvg-git-2@gmane.org; Tue, 13 May 2008 01:55:24 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755719AbYELXyf (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 12 May 2008 19:54:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755625AbYELXyf
	(ORCPT <rfc822;git-outgoing>); Mon, 12 May 2008 19:54:35 -0400
Received: from corvette.plexpod.net ([64.38.20.226]:56660 "EHLO
	corvette.plexpod.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755538AbYELXye (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 12 May 2008 19:54:34 -0400
Received: from cpe-74-70-48-173.nycap.res.rr.com ([74.70.48.173] helo=asimov.home.spearce.org)
	by corvette.plexpod.net with esmtpa (Exim 4.68)
	(envelope-from <spearce@spearce.org>)
	id 1JvhqY-000519-SH; Mon, 12 May 2008 19:54:22 -0400
Received: by asimov.home.spearce.org (Postfix, from userid 1000)
	id D432A20FBAE; Mon, 12 May 2008 19:54:31 -0400 (EDT)
Content-Disposition: inline
In-Reply-To: <1210623222-24908-5-git-send-email-florianskarten@web.de>
User-Agent: Mutt/1.5.11
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - corvette.plexpod.net
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - spearce.org
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/81969>

Florian Koeberle <florianskarten@web.de> wrote:
> @@ -171,6 +171,26 @@ public final class Constants {
>  	public static String REMOTES_PREFIX = "refs/remotes";
>  
>  	/**
> +	 * The name of the repository directory in the project directory.
> +	 */
> +	public static final String REPOSITORY_DIRECTORY_NAME = ".git";

What is a project directory?

> +	/**
> +	 * Contains the name of the HEAD file in the repository directory.
> +	 */
> +	public static final String HEAD_FILE_NAME = "HEAD";

Isn't this already declared as just HEAD?  Lets not duplicate
constants if we can avoid it, especially when they are in the
same class.

-- 
Shawn.
