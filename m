From: =?ISO-8859-1?Q?Santi_B=E9jar?= <santi@agolina.net>
Subject: Re: Finding the name of the parent branch?
Date: Fri, 30 Jan 2009 12:18:39 +0100
Message-ID: <adf1fd3d0901300318s5a0e4c94gab5f31342643ea52@mail.gmail.com>
References: <a2633edd0901300256k2ad7530elcaca5cdc30c17534@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: Git Mailing List <git@vger.kernel.org>
To: Pascal Obry <pascal@obry.net>
X-From: git-owner@vger.kernel.org Fri Jan 30 12:20:08 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LSrPs-0001JQ-2a
	for gcvg-git-2@gmane.org; Fri, 30 Jan 2009 12:20:08 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752173AbZA3LSm (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 30 Jan 2009 06:18:42 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752048AbZA3LSm
	(ORCPT <rfc822;git-outgoing>); Fri, 30 Jan 2009 06:18:42 -0500
Received: from ey-out-2122.google.com ([74.125.78.24]:64191 "EHLO
	ey-out-2122.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751947AbZA3LSm (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 30 Jan 2009 06:18:42 -0500
Received: by ey-out-2122.google.com with SMTP id 25so109643eya.37
        for <git@vger.kernel.org>; Fri, 30 Jan 2009 03:18:40 -0800 (PST)
Received: by 10.103.172.7 with SMTP id z7mr514198muo.129.1233314319876; Fri, 
	30 Jan 2009 03:18:39 -0800 (PST)
In-Reply-To: <a2633edd0901300256k2ad7530elcaca5cdc30c17534@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/107797>

2009/1/30 Pascal Obry <pascal@obry.net>:
> I want to find the name of the parent branch in a script. What is the best way?
>
>                         o---o---o---C
>                         /
>                    o---o---o---B
>                   /
>           ---o---o---o---o---o---A
>
> For B I want to get A and for C I want to get B.

I think your definition is not well defined. A, B and C are just
branches of you project, technically they are equivalent. Maybe you
are thinking that the common commits of, say A and B, really belongs
to A, but this is not the case they belong to both branches. In git a
branch is really just a pointer to a commit and by extension the
history, it is not a series of commits.

Just a counterexample, just rearranging you graph:

                        o---B
                        /
                   o---o---o---o---o---C
                  /
          ---o---o---o---o---o---A

>From you description: For B I would get C and for C I would get A.

HTH,
Santi
