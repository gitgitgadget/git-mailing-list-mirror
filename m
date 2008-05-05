From: "Ping Yin" <pkufranky@gmail.com>
Subject: Re: [PATCH 0/3] log --graph and rev-list --graph
Date: Mon, 5 May 2008 10:13:43 +0800
Message-ID: <46dff0320805041913t31c05a36w92be4a81a3da07af@mail.gmail.com>
References: <1209897414-10091-1-git-send-email-adam@adamsimpkins.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org, "Junio C Hamano" <gitster@pobox.com>
To: "Adam Simpkins" <adam@adamsimpkins.net>
X-From: git-owner@vger.kernel.org Mon May 05 04:14:45 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JsqE1-0006hG-0h
	for gcvg-git-2@gmane.org; Mon, 05 May 2008 04:14:45 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753998AbYEECN5 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 4 May 2008 22:13:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753975AbYEECN4
	(ORCPT <rfc822;git-outgoing>); Sun, 4 May 2008 22:13:56 -0400
Received: from yw-out-2324.google.com ([74.125.46.29]:1434 "EHLO
	yw-out-2324.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753971AbYEECN4 (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 4 May 2008 22:13:56 -0400
Received: by yw-out-2324.google.com with SMTP id 9so354484ywe.1
        for <git@vger.kernel.org>; Sun, 04 May 2008 19:13:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        bh=knB3Z8Wf1Row2aLqyhMDdqLmpTPd2gAyX+a/iknbPBM=;
        b=F9w1BXU9Y5ggqdw6oNn0uanZLEZIym58u/nAEChRSDp6Ec2uPvoMoDmtYImmYrzHCemm8qOi6tva6ALDp6ZHh1VpKlkP78Hfh+DV0K2JrMzo5PFXMyan7YY3m6uUClGhfLUUtJDWmvm+t3to9wI2vkHR8/6xBvQ1gpYTYvUoRMI=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=FKr+0bI9TK8DBOYZIW48jXkPNKwAm6hgOurUTBfhqTpOaB0JXFXlhtJ+3bvVz2pa7OZs5laoH8AB3HcIpuoCyD0z1fSDxXlSWMe8m6YdOni0zZa7+qvKJB91I6vtvu26Yl517JJ5u4GDyt25JG7RHmtZam4wLovQEXyKHdTGv5Q=
Received: by 10.150.79.42 with SMTP id c42mr5574951ybb.167.1209953623059;
        Sun, 04 May 2008 19:13:43 -0700 (PDT)
Received: by 10.151.114.1 with HTTP; Sun, 4 May 2008 19:13:43 -0700 (PDT)
In-Reply-To: <1209897414-10091-1-git-send-email-adam@adamsimpkins.net>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/81217>

On Sun, May 4, 2008 at 6:36 PM, Adam Simpkins <adam@adamsimpkins.net> wrote:
> This patch series adds a new --graph option to the log and rev-list
>  commands.  This is pretty much the same code that I sent out in early
>  April, but updated to work with the log entry termination fixes in the
>  latest master branch.
>
>  Adam Simpkins (3):
>   revision API: split parent rewriting and parent printing options
>   Add history graph API
>   log and rev-list: add --graph option
>

Is the indention between ba7f5b and 38254 intentional?

* ba7f5b log and rev-list: add --graph option
*   38254 Add history graph API
*   12918 revision API: split parent rewriting
*   c697a Cleanup xread() loops to use read_in_full()
M     47179Merge branch 'maint'

-- 
Ping Yin
