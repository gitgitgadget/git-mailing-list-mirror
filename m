From: Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: [PATCHv6 15/16] Add missing &&'s throughout the testsuite
Date: Sun, 3 Oct 2010 15:59:50 -0500
Message-ID: <20101003205950.GC22743@burratino>
References: <1286136014-7728-1-git-send-email-newren@gmail.com>
 <1286136014-7728-16-git-send-email-newren@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, gitster@pobox.com, avarab@gmail.com
To: Elijah Newren <newren@gmail.com>
X-From: git-owner@vger.kernel.org Sun Oct 03 23:03:19 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1P2ViI-000708-OM
	for gcvg-git-2@lo.gmane.org; Sun, 03 Oct 2010 23:03:19 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755096Ab0JCVDF (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 3 Oct 2010 17:03:05 -0400
Received: from mail-iw0-f174.google.com ([209.85.214.174]:37810 "EHLO
	mail-iw0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754894Ab0JCVDE (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 3 Oct 2010 17:03:04 -0400
Received: by iwn5 with SMTP id 5so6082317iwn.19
        for <git@vger.kernel.org>; Sun, 03 Oct 2010 14:03:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:date:from:to:cc:subject
         :message-id:references:mime-version:content-type:content-disposition
         :in-reply-to:user-agent;
        bh=NlWO6kJ8Q23NoUd3J5OmalB9uTG5vOw+GVt3D/UPsXM=;
        b=l76QupuDUhTUeDjpN/3/s4424ADMlKI6PsbSItHLWGxuVOS76MbqACda2LIez2k6z6
         0e6vKP5KqR35fTn3Hm8xGArgdTNG0YLG/JB3+eUrjJCJm5jueTugd0ZNii2xNd+ioTLN
         42dL4GMX3fc5AFPoH5l7vdi14F97RSdj59vkc=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        b=foHY2hjQHLE4CqjuAYf7es7QkGJ8Pe5sGRcVFnp/a0ICYG68jWOfOlJQXentzcbFD8
         /2871dz8NZAgIkvtr+/XWdljbSxD2IiaFV+Mfdz4J/1MqRq+zkFe2w8eReHKzHQ28piD
         +uCH9ogI/lgM5IHpFf/eD1GXTBEveZKbBM1QM=
Received: by 10.231.146.129 with SMTP id h1mr9023918ibv.181.1286139782745;
        Sun, 03 Oct 2010 14:03:02 -0700 (PDT)
Received: from burratino (adsl-68-255-106-176.dsl.chcgil.ameritech.net [68.255.106.176])
        by mx.google.com with ESMTPS id n20sm4065747ibe.17.2010.10.03.14.03.02
        (version=SSLv3 cipher=RC4-MD5);
        Sun, 03 Oct 2010 14:03:02 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <1286136014-7728-16-git-send-email-newren@gmail.com>
User-Agent: Mutt/1.5.20 (2009-06-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/157923>

Elijah Newren wrote:
>> On Sun, Oct 3, 2010 at 8:46 AM, Jonathan Nieder <jrnieder@gmail.com> wrote:

>>>> --- a/t/t1509-root-worktree.sh
>>>> +++ b/t/t1509-root-worktree.sh
>>>> @@ -232,8 +232,8 @@ say "auto bare gitdir"
>>>>
>>>>  # DESTROYYYYY!!!!!
>>>>  test_expect_success 'setup' '
>>>> -     rm -rf /refs /objects /info /hooks
>>>> -     rm /*
>>>> +     rm -rf /refs /objects /info /hooks &&
>>>> +     rm /* &&
[...]
>> How about replacing the two rm commands with a simple 'rm -rf /*'?

Umm, won't that delete _everything_, including git?

I would suggest just leaving the test alone and contacting the test
author or adding a comment unless you can test the change.
