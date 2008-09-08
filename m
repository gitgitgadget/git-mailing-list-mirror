From: "Santi Bejar" <santi@agolina.net>
Subject: Re: Gitk and --no-walk don't play together
Date: Mon, 8 Sep 2008 18:34:49 +0200
Message-ID: <adf1fd3d0809080934s67b2a8b1w19aeb3d8e5f8b4ab@mail.gmail.com>
References: <alpine.LNX.1.10.0809081223360.1621@fbirervta.pbzchgretzou.qr>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: "Jan Engelhardt" <jengelh@medozas.de>
X-From: git-owner@vger.kernel.org Mon Sep 08 18:36:09 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Kcjia-0004yO-Mj
	for gcvg-git-2@gmane.org; Mon, 08 Sep 2008 18:36:01 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752624AbYIHQey (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 8 Sep 2008 12:34:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751713AbYIHQex
	(ORCPT <rfc822;git-outgoing>); Mon, 8 Sep 2008 12:34:53 -0400
Received: from rn-out-0910.google.com ([64.233.170.187]:14796 "EHLO
	rn-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751458AbYIHQex (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 8 Sep 2008 12:34:53 -0400
Received: by rn-out-0910.google.com with SMTP id k40so140871rnd.17
        for <git@vger.kernel.org>; Mon, 08 Sep 2008 09:34:52 -0700 (PDT)
Received: by 10.103.137.19 with SMTP id p19mr10355746mun.108.1220891689313;
        Mon, 08 Sep 2008 09:34:49 -0700 (PDT)
Received: by 10.102.247.10 with HTTP; Mon, 8 Sep 2008 09:34:49 -0700 (PDT)
In-Reply-To: <alpine.LNX.1.10.0809081223360.1621@fbirervta.pbzchgretzou.qr>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/95271>

On Mon, Sep 8, 2008 at 6:25 PM, Jan Engelhardt <jengelh@medozas.de> wrote:
>
> Hi,
>
>
> in an attempt to only show only the tags in the graph, gitk barfs:

Use the "List references" in the file menu.

>
> $ gitk --no-walk v2.6.25 v2.6.26
> [ Error reading commits: child killed: segmentation violation ]

At least, you should say the git version, the OS and platform.

It is the child process that segfaults, you could try "git rev-list
--no-walk v2.6.25 v2.6.26" directly and even try to debug it?

Santi


> --
> To unsubscribe from this list: send the line "unsubscribe git" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>
