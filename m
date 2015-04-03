From: "Kyle J. McKay" <mackyle@gmail.com>
Subject: Re: What's cooking in git.git (Apr 2015, #01; Thu, 2)
Date: Thu, 2 Apr 2015 17:55:55 -0700
Message-ID: <155011F7-1806-4226-B085-F1F4206062C6@gmail.com>
References: <xmqqbnj6gp20.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0 (Apple Message framework v936)
Content-Type: text/plain; charset=US-ASCII; format=flowed; delsp=yes
Content-Transfer-Encoding: 7bit
Cc: "git@vger.kernel.org list" <git@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri Apr 03 02:56:06 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Ydpu1-0004u5-3J
	for gcvg-git-2@plane.gmane.org; Fri, 03 Apr 2015 02:56:05 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753017AbbDCAz7 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 2 Apr 2015 20:55:59 -0400
Received: from mail-pd0-f172.google.com ([209.85.192.172]:35876 "EHLO
	mail-pd0-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751751AbbDCAz7 (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 2 Apr 2015 20:55:59 -0400
Received: by pdea3 with SMTP id a3so54265625pde.3
        for <git@vger.kernel.org>; Thu, 02 Apr 2015 17:55:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:in-reply-to:subject:references:message-id:content-type
         :content-transfer-encoding:mime-version:date:cc;
        bh=6B3AcZSzs+ICaQeKprimtLRext9Qm7flBDBDYnRZHi0=;
        b=D3itAXp235GwD0w3aArrig4QyMJcrAO+xbTz4YE/DErmrrx99OhVH+8aRA6i8T5Ixj
         utfSYL3Mb6ZCuWn6dm4+w5G0bY73cxLEkDYq+VcFoSv38xStUM9eqO9Y5itwjrdGRWU6
         0IMDjnfM9tYihrFlhdXzMv2RBcFqOYoQdtZfqx97qTDKL7UaerxyGZSrkH9rae3pctif
         w6lh987eRuuauIVz2tQTSe2n20SDtGVBu1tCgiTcaj0Jps4q1rq9+Jw3zKY3y7o8Ulvo
         45AfT95fMkuQxQiXxdLj638WB7yasGKB104dmJt15D3PEiP5c/oJxtodKsNizkstrDV7
         zU4A==
X-Received: by 10.68.203.66 with SMTP id ko2mr78708570pbc.156.1428022558436;
        Thu, 02 Apr 2015 17:55:58 -0700 (PDT)
Received: from ?IPv6:2002:48c0:ad8d::223:12ff:fe05:eebd? ([2002:48c0:ad8d:0:223:12ff:fe05:eebd])
        by mx.google.com with ESMTPSA id fm3sm6386989pdb.73.2015.04.02.17.55.57
        (version=TLSv1 cipher=RC4-SHA bits=128/128);
        Thu, 02 Apr 2015 17:55:57 -0700 (PDT)
In-Reply-To: <xmqqbnj6gp20.fsf@gitster.dls.corp.google.com>
X-Mauler: Craptastic (2.936)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/266696>

On Apr 2, 2015, at 15:09, Junio C Hamano wrote:

> * jc/show-branch (2014-03-24) 5 commits
> - show-branch: use commit slab to represent bitflags of arbitrary  
> width
> - show-branch.c: remove "all_mask"
> - show-branch.c: abstract out "flags" operation
> - show-branch.c: lift all_mask/all_revs to a global static
> - show-branch.c: update comment style
>
> Waiting for the final step to lift the hard-limit before sending it  
> out.


May I ask, now that this topic is over 1-year old, please, what is the  
final step?

Perhaps someone might submit a patch... ;)

-Kyle
