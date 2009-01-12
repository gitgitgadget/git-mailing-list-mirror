From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: What's cooking in git.git (Jan 2009, #02; Sun, 11)
Date: Mon, 12 Jan 2009 02:25:29 +0100
Message-ID: <200901120225.30175.jnareb@gmail.com>
References: <7v63kmtbk6.fsf@gitster.siamese.dyndns.org> <m3ljthzzdq.fsf@localhost.localdomain> <7vwsd1pjst.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org, Sebastien Cevey <seb@cine7.net>,
	Giuseppe Bilotta <giuseppe.bilotta@gmail.com>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon Jan 12 02:27:07 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LMBa1-0005oH-AK
	for gcvg-git-2@gmane.org; Mon, 12 Jan 2009 02:27:01 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751707AbZALBZi (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 11 Jan 2009 20:25:38 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751424AbZALBZh
	(ORCPT <rfc822;git-outgoing>); Sun, 11 Jan 2009 20:25:37 -0500
Received: from mail-ew0-f17.google.com ([209.85.219.17]:61267 "EHLO
	mail-ew0-f17.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751315AbZALBZg (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 11 Jan 2009 20:25:36 -0500
Received: by ewy10 with SMTP id 10so11263996ewy.13
        for <git@vger.kernel.org>; Sun, 11 Jan 2009 17:25:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:subject:date
         :user-agent:cc:references:in-reply-to:mime-version:content-type
         :content-transfer-encoding:content-disposition:message-id;
        bh=wCcBDi1KClodtbJ0UPOcHGsfoxJd9RJ2xVwnOmlBWVI=;
        b=gxhEOQQJ904fc6BzYxbxqLfmywlz5Q1UVwji2suLC6onJSHimwveT0AhMK4M7XhDYd
         cmPL/D4ekswpmFzBwc5AJzn0iyIOGEBlP08o/OHaEKhbCrJHU0PO92S7WPcQ8paMxMMb
         JozaPR/ggcb3LVAPZWcFGO5yWruc4w599r4UA=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:subject:date:user-agent:cc:references:in-reply-to
         :mime-version:content-type:content-transfer-encoding
         :content-disposition:message-id;
        b=T1Z2Zj1WEaHxVHqO9OICuet2j9PQMdSCewrkflQlS72wsT4y3lmFOJ0NnTz1N6UqEF
         pFA21/EOQfpddNaiuCIGx0/5LvKV1TSnxZwF/gceVxsxbanr82Xqvm0FTiumxQXTUtkH
         65ReDYrVFehsafqWa6ddOEspOLQx6X8KE3bDo=
Received: by 10.210.76.19 with SMTP id y19mr33450855eba.52.1231723534811;
        Sun, 11 Jan 2009 17:25:34 -0800 (PST)
Received: from ?192.168.1.11? (abwj90.neoplus.adsl.tpnet.pl [83.8.233.90])
        by mx.google.com with ESMTPS id 31sm90638083nfu.22.2009.01.11.17.25.33
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Sun, 11 Jan 2009 17:25:33 -0800 (PST)
User-Agent: KMail/1.9.3
In-Reply-To: <7vwsd1pjst.fsf@gitster.siamese.dyndns.org>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/105266>

On Sun, 11 Jan 2009, Junio C Hamano wrote:
> Jakub Narebski <jnareb@gmail.com> writes:
> 
>>> ----------------------------------------------------------------
>>> [Actively cooking]
>>>
>>> * sc/gitweb-category (Fri Dec 12 00:45:12 2008 +0100) 3 commits
>>>  - gitweb: Optional grouping of projects by category
>>>  - gitweb: Split git_project_list_body in two functions
>>>  - gitweb: Modularized git_get_project_description to be more generic
>>
>> This I think needs some further cooking.  I guess with addition of one
>> more patch to series categories could be sorted together with projects
>> they contain, and not always have to be in fixed ordering.
> 
> These should be moved to the Stalled category; nobody seems to be
> discussing improvements and sending updates to the series as far as I
> recall.

I think it is just the author being slow moving; there was quite
a bit of time between subsequent versions of this patch series.
But if Sebastien would not resend this series in about a week,
I'll try to clean it up, add fourth patch, and resend it.

As to lack of discussion: I think it is cause bu two issues. First,
there is support for tags already implemented which somewhat reduces
need for categories support. Second, hosting sites which have large
number of projects for which categories support might be a nice thing,
use I guess modified gitweb with caching, don't they?

>>> * gb/gitweb-patch (Thu Dec 18 08:13:19 2008 +0100) 4 commits
>>>  - gitweb: link to patch(es) view in commit(diff) and (short)log view
>>>  - gitweb: add patches view
>>>  - gitweb: change call pattern for git_commitdiff
>>>  - gitweb: add patch view
>>
>> If I remember correctly the only point of discussion is calling
>> convention for git_commitdiff, and whether 'patches' view should
>> (re)use git_commitdiff or use its own subroutine.
> 
> Thanks; I take it that it is basically usable, useful and can be
> incrementally improved in 'next'?

Yes, I think so. The changes are cosmetic in nature, and I think
the feature this patch adds is quite useful: you can now get patches
and [short] patch series from gitweb which you can apply using git-am.
Nice, isn't it?

-- 
Jakub Narebski
Poland
