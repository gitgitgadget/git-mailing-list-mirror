From: =?ISO-8859-1?Q?Santi_B=E9jar?= <santi@agolina.net>
Subject: Re: Git log can not show history before rename
Date: Fri, 30 Jan 2009 12:29:47 +0100
Message-ID: <adf1fd3d0901300329y53e46d91xda75799ce1244ddd@mail.gmail.com>
References: <1976ea660901300323n384d3650s3bb5a575accb65d1@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Frank Li <lznuaa@gmail.com>
X-From: git-owner@vger.kernel.org Fri Jan 30 12:31:21 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LSrad-0005B9-Ur
	for gcvg-git-2@gmane.org; Fri, 30 Jan 2009 12:31:16 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752497AbZA3L3u (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 30 Jan 2009 06:29:50 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752425AbZA3L3u
	(ORCPT <rfc822;git-outgoing>); Fri, 30 Jan 2009 06:29:50 -0500
Received: from mail-ew0-f21.google.com ([209.85.219.21]:36969 "EHLO
	mail-ew0-f21.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752050AbZA3L3u (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 30 Jan 2009 06:29:50 -0500
Received: by ewy14 with SMTP id 14so688934ewy.13
        for <git@vger.kernel.org>; Fri, 30 Jan 2009 03:29:48 -0800 (PST)
Received: by 10.103.240.15 with SMTP id s15mr526472mur.82.1233314987866; Fri, 
	30 Jan 2009 03:29:47 -0800 (PST)
In-Reply-To: <1976ea660901300323n384d3650s3bb5a575accb65d1@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/107799>

2009/1/30 Frank Li <lznuaa@gmail.com>:
> mkdir tt3
> cd tt3
> git init-db

"git init"

> touch a.c
> git add a.c
> git commit -a -m "test1"
>
> git mv a.c b.c
> git commit -a -m "rename"
>
> modify b.c
> git commit -a -m "test2"
>
> git log -C -M -- b.c
[...]
> I can't get history before rename.

You asked to restrict the search to the b.c path.

You want:

git log --follow -- b.c

Man git-log:
       --follow
           Continue listing the history of a file beyond renames.

HTH,
Santi
> --
> To unsubscribe from this list: send the line "unsubscribe git" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>
