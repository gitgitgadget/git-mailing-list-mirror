From: Tomas Carnecky <tomas.carnecky@gmail.com>
Subject: Re: Git Log and History Simplification
Date: Mon, 17 Dec 2012 12:34:20 +0000
Message-ID: <1355747660-ner-9463@calvin>
References: <CAE116wxTY0sFh5nZwGEYRz=gJwXgFEj8Nvwh41RCYH4vgYCqSQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain
To: Dinesh Subramani <dinesh.subramani@gmail.com>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Dec 17 13:34:45 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TkZu8-0007Rr-Bq
	for gcvg-git-2@plane.gmane.org; Mon, 17 Dec 2012 13:34:44 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752260Ab2LQMeY (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 17 Dec 2012 07:34:24 -0500
Received: from mail-wi0-f174.google.com ([209.85.212.174]:32769 "EHLO
	mail-wi0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752179Ab2LQMeX (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 17 Dec 2012 07:34:23 -0500
Received: by mail-wi0-f174.google.com with SMTP id hm9so1953180wib.1
        for <git@vger.kernel.org>; Mon, 17 Dec 2012 04:34:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:subject:to:references:in-reply-to:mime-version:date:message-id
         :content-type;
        bh=15AsazdMlpQfoWbiGIal/prF54hQHm1iXJM1bhOmMBs=;
        b=fkjmjx+MCpehIaW/hhjIBZXr5x1jR1UxOQ3AMf91N2in2AyvHIZR0EO0ikD2MLP8zS
         ShSkESXRVoeiQteiTgTTFGAnVL6uqp9ZUYxNCVBcnacwSPxWPxWZ90yDwjWb3YH5VYyu
         wiS77NAsbCa5LxygbMFA0g7sNHxKn2F1kppbemTtbFox0JxYUhVeSKpBy71RD8aTbXc4
         YlAMGqDmHBjuhCmptUO17XTsxwQSn8X2SvuM6POLqahuA0hvNps4a5vuW0HCSGAIcBIV
         an0/K3HtOW6HztQK4rFQYkKfDtECgv4bgd6JTUSxbvFrlkfL1JXMT2lR8j5mVwYyMhzP
         alhg==
Received: by 10.180.81.39 with SMTP id w7mr15401247wix.15.1355747662194;
        Mon, 17 Dec 2012 04:34:22 -0800 (PST)
Received: from calvin.caurea.org (pub082136067238.dh-hfc.datazug.ch. [82.136.67.238])
        by mx.google.com with ESMTPS id g2sm12276258wiy.0.2012.12.17.04.34.21
        (version=TLSv1/SSLv3 cipher=OTHER);
        Mon, 17 Dec 2012 04:34:21 -0800 (PST)
Received: by calvin.caurea.org (Postfix, from userid 3301)
	id 5A2EB1295DA; Mon, 17 Dec 2012 12:34:20 +0000 (UTC)
In-Reply-To: <CAE116wxTY0sFh5nZwGEYRz=gJwXgFEj8Nvwh41RCYH4vgYCqSQ@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/211682>

On Mon, 17 Dec 2012 17:03:09 +0530, Dinesh Subramani <dinesh.subramani@gmail.com> wrote:
> I am using the below command :
> 
> git log --stat --decorate=full --since=<date>
> 
> Can you please let me know if the above command will list all the
> commits and would not skip any of the commits due to History
> Simplification. Any help would be very useful.

The way I understand the man page, to disable history simplification you have
to use --full-history --sparse.
