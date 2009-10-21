From: Douglas Campos <douglas@theros.info>
Subject: Re: Finding a commit
Date: Wed, 21 Oct 2009 11:26:36 -0200
Message-ID: <ed88cb980910210626t750b4cc2r91d1dc22df14eb8b@mail.gmail.com>
References: <4ADEF095.3020406@box.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: git@vger.kernel.org
To: Soham Mehta <soham@box.net>
X-From: git-owner@vger.kernel.org Wed Oct 21 15:27:28 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1N0bDR-0000ab-Tz
	for gcvg-git-2@lo.gmane.org; Wed, 21 Oct 2009 15:27:02 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753309AbZJUN0w (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 21 Oct 2009 09:26:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753285AbZJUN0v
	(ORCPT <rfc822;git-outgoing>); Wed, 21 Oct 2009 09:26:51 -0400
Received: from mail-px0-f179.google.com ([209.85.216.179]:55908 "EHLO
	mail-px0-f179.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753242AbZJUN0v (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 21 Oct 2009 09:26:51 -0400
Received: by pxi9 with SMTP id 9so2621048pxi.4
        for <git@vger.kernel.org>; Wed, 21 Oct 2009 06:26:56 -0700 (PDT)
Received: by 10.115.116.5 with SMTP id t5mr12050132wam.185.1256131616114; Wed, 
	21 Oct 2009 06:26:56 -0700 (PDT)
In-Reply-To: <4ADEF095.3020406@box.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/130913>

On Wed, Oct 21, 2009 at 9:29 AM, Soham Mehta <soham@box.net> wrote:
> Given a SHA1 of a commit from one repository (say x), wondering what is a
> proper way to find out if that commit (change) also exists in a different
> repository (say y).
>
> Because SHA1 can change if a commit is cherry-picked around, I cannot just
> grep for that SHA1 from git-rev-list or git-log on 'y'. I need a way to know
> if a commit with identical changes (as in 'x') is also present in 'y'.
>
> I realize that Author and Timestamp do not change when the commit is moved
> (fetched, pushed, pulled, rebased, cherry-picked etc). So my current
> solution relies on grepping for the pair of Author-Timestamp from git-log on
> 'y'.
>

Have you tried git cherry?


-- 
Douglas Campos (qmx)
+55 11 7626 5959
