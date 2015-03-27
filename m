From: "Kyle J. McKay" <mackyle@gmail.com>
Subject: Re: What's cooking in git.git (Mar 2015, #09; Thu, 26)
Date: Fri, 27 Mar 2015 13:27:59 -0700
Message-ID: <2A1683A1-9E52-4286-B7CC-FF33209BC953@gmail.com>
References: <xmqqk2y3xy77.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0 (Apple Message framework v936)
Content-Type: text/plain; charset=US-ASCII; format=flowed; delsp=yes
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri Mar 27 21:28:10 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YbarQ-0002b0-VC
	for gcvg-git-2@plane.gmane.org; Fri, 27 Mar 2015 21:28:09 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752220AbbC0U2E (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 27 Mar 2015 16:28:04 -0400
Received: from mail-pa0-f52.google.com ([209.85.220.52]:33858 "EHLO
	mail-pa0-f52.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752013AbbC0U2D (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 27 Mar 2015 16:28:03 -0400
Received: by pacwe9 with SMTP id we9so105442694pac.1
        for <git@vger.kernel.org>; Fri, 27 Mar 2015 13:28:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:in-reply-to:subject:references:message-id:content-type
         :content-transfer-encoding:mime-version:date:cc;
        bh=+KnHZqJVicbRQTGGvDqmLsn2aVpsFhBwY/34N5Yk7o4=;
        b=ACbaU3FxH863fU9sSwS8ar1xW+u0PUEvobPojd9H/XTycwjKEGg9SQFRilzsfSD7jh
         JC+MFtQeSXXPGxo1y9F8hXx3Z8n8qCvUElpN5QdZMiVPWcgyQnp5K447jlGGRooa1nEQ
         9/bZU1I5ihZyrd7eBLP64tLqHI86Lmp8conC9xmP1tSqN2Ezb9xJmhtxfLjmu2RUH/bj
         lyPKJuNPfBeYBq0Tkdp2tbiPID0/eQe2sUyZlPut3YywJF3GQP+cYYtCsR7Dg7GNUAsI
         qG5jVrvNFOIXZrLcPA1Kbr967OEhWZxj4p5Dwxyld5oavwWZGHwLHxvPkkonVC0crvo3
         e+Cg==
X-Received: by 10.66.65.195 with SMTP id z3mr35983753pas.81.1427488082500;
        Fri, 27 Mar 2015 13:28:02 -0700 (PDT)
Received: from ?IPv6:2002:48c0:ad8d::223:12ff:fe05:eebd? ([2002:48c0:ad8d:0:223:12ff:fe05:eebd])
        by mx.google.com with ESMTPSA id yc2sm2998752pbb.87.2015.03.27.13.28.01
        (version=TLSv1 cipher=RC4-SHA bits=128/128);
        Fri, 27 Mar 2015 13:28:01 -0700 (PDT)
In-Reply-To: <xmqqk2y3xy77.fsf@gitster.dls.corp.google.com>
X-Mauler: Craptastic (2.936)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/266380>

On Mar 26, 2015, at 14:09, Junio C Hamano wrote:

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

May I ask, on the 1-year anniversary of this topic, please, what is  
the final step?

Perhaps someone might submit a patch...  ;)

-Kyle
