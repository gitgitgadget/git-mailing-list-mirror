From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: Pack several linear commits into one
Date: Mon, 03 Dec 2007 01:32:39 -0800 (PST)
Message-ID: <m3y7ccunrh.fsf@roke.D-201>
References: <c0d4c9e90712030106u40b871ecjd5f7b8d078c8be36@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: "Jacob Kroon" <jacob.kroon@gmail.com>
X-From: git-owner@vger.kernel.org Mon Dec 03 10:33:07 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Iz7fj-0000Hv-Pl
	for gcvg-git-2@gmane.org; Mon, 03 Dec 2007 10:33:04 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751515AbXLCJco (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 3 Dec 2007 04:32:44 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750908AbXLCJcn
	(ORCPT <rfc822;git-outgoing>); Mon, 3 Dec 2007 04:32:43 -0500
Received: from mu-out-0910.google.com ([209.85.134.191]:59315 "EHLO
	mu-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751250AbXLCJcm (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 3 Dec 2007 04:32:42 -0500
Received: by mu-out-0910.google.com with SMTP id i10so874838mue
        for <git@vger.kernel.org>; Mon, 03 Dec 2007 01:32:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:received:received:x-authentication-warning:to:cc:subject:references:in-reply-to:message-id:lines:user-agent:mime-version:content-type:from:date;
        bh=PjyG7CRpBj+AkNtBdq7mvDhx4T1hqOx70FHlGkZlzwQ=;
        b=q7TfjgPY0vVvlkbKnoqY3l+OOM1jMRKhS1fbd6Y3CTF7EArU8t2tYzXSKquTa92Y+A8ipRDXVGRlfx12ZIvt7cGD0nGwlMvGsMziNHBaSjz1TxuYV62kI2iTSdEdDdkU5URNpjSwRKpskm+elfOxOk3ojab+7miXHzI0linWCEc=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=received:x-authentication-warning:to:cc:subject:references:in-reply-to:message-id:lines:user-agent:mime-version:content-type:from:date;
        b=L4EWrr8coeqY7hzz54r5/cuybyFH5RblT7c0DSTv3NYMd2OayKR08262l3yioZWQfn4OoUH8bqHJo4GJsk9uEXn2GB3bAoXdO9MWoq50BcBR/qQekf8x7WQNUnHdteTZXGXMhw7m4uZJeIRAK+QeDP8RzF1uF1M6N1cuRxoCuxM=
Received: by 10.86.30.9 with SMTP id d9mr66409fgd.1196674360420;
        Mon, 03 Dec 2007 01:32:40 -0800 (PST)
Received: from roke.D-201 ( [83.8.225.86])
        by mx.google.com with ESMTPS id d4sm5982244fga.2007.12.03.01.32.38
        (version=TLSv1/SSLv3 cipher=OTHER);
        Mon, 03 Dec 2007 01:32:39 -0800 (PST)
Received: from roke (localhost.localdomain [127.0.0.1])
	by roke.D-201 (8.13.4/8.13.4) with ESMTP id lB39WZWv005495;
	Mon, 3 Dec 2007 10:32:36 +0100
Received: (from jnareb@localhost)
	by roke (8.13.4/8.13.4/Submit) id lB39WYqB005492;
	Mon, 3 Dec 2007 10:32:34 +0100
X-Authentication-Warning: roke: jnareb set sender to jnareb@fuw.edu.pl using -f
In-Reply-To: <c0d4c9e90712030106u40b871ecjd5f7b8d078c8be36@mail.gmail.com>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.4
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/66894>

"Jacob Kroon" <jacob.kroon@gmail.com> writes:

> Is there a tool for repacking several linear commits into one single ?

You can use either "git rebase --interactive" and replace 'pick' with
'squash', or (simpler for replacing all the commits by one big commit)
"git merge --squash". See documentation for details.

Note that if you want remove those 'several linear commits', you
better not have them published yet.

> Please CC me since I'm not a subscriber to the list.

You can read this list via archives, or using NNTP interface (in news
reader):

  nntp://news.gmane.org/gmane.comp.version-control.git

-- 
Jakub Narebski
ShadeHawk on #git
Poland
