From: Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: [PATCH 0/2] git-candidate: git based patch tracking and review
Date: Tue, 1 Dec 2015 12:55:27 -0800
Message-ID: <20151201205527.GF18255@google.com>
References: <1447160198-23296-1-git-send-email-richard.ipsum@codethink.co.uk>
 <5643107B.20501@alum.mit.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Richard Ipsum <richard.ipsum@codethink.co.uk>, git@vger.kernel.org,
	dborowitz@google.com
To: Michael Haggerty <mhagger@alum.mit.edu>
X-From: git-owner@vger.kernel.org Tue Dec 01 21:55:37 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1a3rxX-0002nd-5A
	for gcvg-git-2@plane.gmane.org; Tue, 01 Dec 2015 21:55:35 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755826AbbLAUzb (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 1 Dec 2015 15:55:31 -0500
Received: from mail-pa0-f44.google.com ([209.85.220.44]:35748 "EHLO
	mail-pa0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755131AbbLAUza (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 1 Dec 2015 15:55:30 -0500
Received: by pacej9 with SMTP id ej9so16380136pac.2
        for <git@vger.kernel.org>; Tue, 01 Dec 2015 12:55:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        bh=rEWgEI5QCUW45VTZUny0PabMYH388Uwc9bR2E1lQ8AE=;
        b=yF6nTE49PKiArGU42UFEokuGWoxgvwgED18BhtUDa4cvZuadtCt8VZr+D1FK5zlUW/
         Nyk0Pci4j8PqL4I1gxG0U/a70gLOYwCA0g90qQcz4mO+V7OlweNYRjwROZ9kspJJvQTl
         JE+groxLd5b9+5sfw/dCjmNkEJ4wKpjGNToMLQF6Qt8jOs50vIIxdm+98Igcjgo7e+4S
         jNxztoGVV/e9w4J6pvEUNZXuwrjEaFTwyAKpxAZVaQ/lx9biKl+l9QUj7JVEqlqVehVz
         33ew5Re0Jc0zhkIicKVT/3RV/wuYDmVLG4xTegz+d1wSTrNBQkFTGfmxEV+djhsj3NqJ
         AedQ==
X-Received: by 10.66.153.198 with SMTP id vi6mr102982362pab.37.1449003329753;
        Tue, 01 Dec 2015 12:55:29 -0800 (PST)
Received: from google.com ([2620:0:1000:5b00:5d66:f78a:ca3a:530b])
        by smtp.gmail.com with ESMTPSA id 25sm23299312pfp.62.2015.12.01.12.55.29
        (version=TLSv1/SSLv3 cipher=OTHER);
        Tue, 01 Dec 2015 12:55:29 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <5643107B.20501@alum.mit.edu>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/281854>

Michael Haggerty wrote:
> On 11/10/2015 01:56 PM, Richard Ipsum wrote:

>> I've continued my work[1] to add patch tracking and candidate review capability
>> to git.
>>
>> git-candidate now has a more git-like user interface, so remote candidates
>> can now be specified in a similar way to remote refs (e.g. origin/candidate)
>> as well as various other improvements, such as versioned metadata.
>
> This is a really interesting project. I've seen a blog post or two
> proposing to store bug tracker information in Git in a distributed way,
> but I don't recall anything about doing the same for code review
> information.

Cc-ing dborowitz, who has been working on storing Gerrit's code review
information in Git instead of a separate database (e.g., see [1]).

Thanks,
Jonathan

[1] https://storage.googleapis.com/gerrit-talks/summit/2015/NoteDB.pdf
