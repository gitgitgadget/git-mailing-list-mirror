From: Junio C Hamano <gitster@pobox.com>
Subject: Re: Visualizing merge conflicts after the fact (using kdiff3)
Date: Fri, 19 Jun 2015 09:19:36 -0700
Message-ID: <xmqqwpyzacx3.fsf@gitster.dls.corp.google.com>
References: <557F791D.3080003@nextest.com>
	<87b840d8c73fd7e4e7597e2fd835c703@www.dscho.org>
	<5582B8EC.1060205@drmicha.warpmail.net>
	<xmqqsi9pf1q2.fsf@gitster.dls.corp.google.com>
	<5583D40F.7030300@drmicha.warpmail.net>
Mime-Version: 1.0
Content-Type: text/plain
Cc: Thomas Rast <tr@thomasrast.ch>,
	Johannes Schindelin <johannes.schindelin@gmx.de>,
	Eric Raible <raible@nextest.com>, git@vger.kernel.org
To: Michael J Gruber <git@drmicha.warpmail.net>
X-From: git-owner@vger.kernel.org Fri Jun 19 18:19:48 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Z5z16-0007G3-4i
	for gcvg-git-2@plane.gmane.org; Fri, 19 Jun 2015 18:19:44 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750880AbbFSQTj (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 19 Jun 2015 12:19:39 -0400
Received: from mail-ig0-f179.google.com ([209.85.213.179]:34591 "EHLO
	mail-ig0-f179.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752072AbbFSQTj (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 19 Jun 2015 12:19:39 -0400
Received: by igboe5 with SMTP id oe5so19753016igb.1
        for <git@vger.kernel.org>; Fri, 19 Jun 2015 09:19:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version:content-type;
        bh=06oT9kTEn7fWQ2rzK2RhW8JEEr5p/Ium8cHkbo91LDo=;
        b=rvB5RwKGVygU9M6f+YvqyHOzw8ePvQ3+PlhIAQmt/IJdfzWYvu8WV88dJSq1lnDAeP
         kCLvCc5q7bXREYF9zd7Pv9lZpQoBqvfJCxcKAAaGjt2EpJix8eITMqNss9oREzgqMRmA
         g2Rj28BlkgZdX9yM5WofzqMc8b6DyKf0WUCeIuGOZTjVhmPDFsAOvXh0ATaDhtga664S
         7/CbsoBWff8qn4332hhQ78QEZbb88mQdazyP4jcw2ggTjULcREufSJZp05xVdJZHZX6O
         TM7oZAkxIU8leiJdw0LNPzfxZdA4jXFuo+2GWFM0tIqFIuINH3RhOs3Zh+tPt/QDxBxq
         1PJw==
X-Received: by 10.50.13.98 with SMTP id g2mr5684547igc.16.1434730778493;
        Fri, 19 Jun 2015 09:19:38 -0700 (PDT)
Received: from localhost ([2620:0:10c2:1012:80a8:63af:ca7c:ab61])
        by mx.google.com with ESMTPSA id d4sm7310351iod.17.2015.06.19.09.19.37
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Fri, 19 Jun 2015 09:19:37 -0700 (PDT)
In-Reply-To: <5583D40F.7030300@drmicha.warpmail.net> (Michael J. Gruber's
	message of "Fri, 19 Jun 2015 10:34:23 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/272166>

Michael J Gruber <git@drmicha.warpmail.net> writes:

> Junio C Hamano venit, vidit, dixit 18.06.2015 17:57:
>> 
>> Perhaps 'tr/remerge-diff' (on 'pu') is of interest?
>
> I haven't reviewed remerge-diff but merged it on top of my own local
> additions and ran the full test suite successfully. Any big blocker to
> watch out for?

"What's cooking" report marks it as "Waiting for a
reroll. ($gmane/256591)."

So 

  http://thread.gmane.org/gmane.comp.version-control.git/256591

would be the first place to revisit.
