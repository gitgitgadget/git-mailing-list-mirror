From: Adrian May <adrian.alexander.may@gmail.com>
Subject: Android needs repo, Chrome needs gclient. Neither work. What does 
	that say about git?
Date: Fri, 20 Nov 2009 18:51:32 +0800
Message-ID: <65e170e70911200251q2ec5ec87rc37577dddfd3317d@mail.gmail.com>
References: <2d707e8c-2561-470c-beba-c81e16ac441c@k17g2000yqh.googlegroups.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Nov 20 11:52:42 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NBR5W-0001z7-4y
	for gcvg-git-2@lo.gmane.org; Fri, 20 Nov 2009 11:51:38 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752532AbZKTKv1 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 20 Nov 2009 05:51:27 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752286AbZKTKv1
	(ORCPT <rfc822;git-outgoing>); Fri, 20 Nov 2009 05:51:27 -0500
Received: from mail-iw0-f178.google.com ([209.85.223.178]:49562 "EHLO
	mail-iw0-f178.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752015AbZKTKv0 (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 20 Nov 2009 05:51:26 -0500
Received: by iwn8 with SMTP id 8so2453814iwn.33
        for <git@vger.kernel.org>; Fri, 20 Nov 2009 02:51:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :date:message-id:subject:from:to:content-type;
        bh=yiKkQ4kMP2IHLzDbhU4ax0+blSE2Ymu4F22Xla3Hs2g=;
        b=PIEiA7ZBDQ0Qdk+v6owN3G6NqHBti4VyhS+JtpAppb4BI+gJpnB7w5QISSHgQUXp1Y
         0Mhr5pFcuIOpVFgN/wh2E0ooe2IvoGqpNp6kfuzw/B3vfUDTtGBtKkXL2IQlzH5Cy08g
         XVVTpwN7a9Vdw7c+VsvK/X+VYmVZknE7TBOjg=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :content-type;
        b=JmDlO4Q9IyWlhJ5Y8FYg5CMsO0pAvKT1sNRnITtXnNsoG3guxBbfYBKL14T+87NkT8
         qV9zwxMDOCb002q7InUfwqwqQEPuGkZbO+bIc1FN0qcJ+5s9Orhl9ow4+PnjdNpW4ACe
         IUMQlTzm7zUgWcj8nWdnrL1+9jfNx6M0+LEqM=
Received: by 10.231.125.28 with SMTP id w28mr2348559ibr.50.1258714292446; Fri, 
	20 Nov 2009 02:51:32 -0800 (PST)
In-Reply-To: <2d707e8c-2561-470c-beba-c81e16ac441c@k17g2000yqh.googlegroups.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/133330>

Git is just plain wrong, because you can't split or merge repositories
or pull subtrees of them. It doesn't have the kind of triggers you
need to assert change control either, and these bolt-on scripts are
just making life messy. Will somebody please finish git itself instead
of working around it, or use a source control system that's up to the
job.

Adrian.

PS: In both cases, I had problems pulling the code.
