From: Kevin Ballard <kevin@sb.org>
Subject: Re: Dump differing files
Date: Fri, 12 Nov 2010 14:39:15 -0800
Message-ID: <151B15B7-F43E-40E6-B025-028B07C00C2C@sb.org>
References: <loom.20101112T183755-430@post.gmane.org>
Mime-Version: 1.0 (Apple Message framework v1081)
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 8BIT
Cc: git@vger.kernel.org
To: Maaartin <grajcar1@seznam.cz>
X-From: git-owner@vger.kernel.org Fri Nov 12 23:39:26 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PH2HG-0000uW-Dw
	for gcvg-git-2@lo.gmane.org; Fri, 12 Nov 2010 23:39:26 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932815Ab0KLWjT (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 12 Nov 2010 17:39:19 -0500
Received: from mail-pw0-f46.google.com ([209.85.160.46]:39428 "EHLO
	mail-pw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757445Ab0KLWjT convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 12 Nov 2010 17:39:19 -0500
Received: by pwi9 with SMTP id 9so456165pwi.19
        for <git@vger.kernel.org>; Fri, 12 Nov 2010 14:39:18 -0800 (PST)
Received: by 10.142.239.21 with SMTP id m21mr2309454wfh.198.1289601558552;
        Fri, 12 Nov 2010 14:39:18 -0800 (PST)
Received: from [10.8.0.89] ([69.170.160.74])
        by mx.google.com with ESMTPS id p8sm4460796wff.4.2010.11.12.14.39.16
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Fri, 12 Nov 2010 14:39:17 -0800 (PST)
In-Reply-To: <loom.20101112T183755-430@post.gmane.org>
X-Mailer: Apple Mail (2.1081)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/161365>

A user-friendly version might be `git diff --stat $COMMIT1 $COMMIT2`. This will
give you a diffstat showing what's different between the two commits.

If you really just want the changed files, you can use something like

     git diff-tree --name-only -r $COMMIT1 $COMMIT2

-Kevin Ballard

On Nov 12, 2010, at 9:44 AM, Maaartin wrote:

> Some time ago, I saw a command allowing to dump all files which differ in the 
> given two commits (or something like that). It may have been an option to git 
> diff or whatever, but I can't find it anymore. I'm quite sure, somebody knows... 
> thanks.
> 
> --
> To unsubscribe from this list: send the line "unsubscribe git" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
