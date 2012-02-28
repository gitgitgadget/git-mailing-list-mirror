From: Luke Diamand <luke@diamand.org>
Subject: Tilde spec - befuzzled
Date: Tue, 28 Feb 2012 09:07:41 +0000
Message-ID: <4F4C995D.9000504@diamand.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
To: Git List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Tue Feb 28 10:07:45 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1S2J28-0003aS-Qy
	for gcvg-git-2@plane.gmane.org; Tue, 28 Feb 2012 10:07:45 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932571Ab2B1JHj (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 28 Feb 2012 04:07:39 -0500
Received: from mail-bk0-f46.google.com ([209.85.214.46]:36845 "EHLO
	mail-bk0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932551Ab2B1JHg (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 28 Feb 2012 04:07:36 -0500
Received: by bkcik5 with SMTP id ik5so1018220bkc.19
        for <git@vger.kernel.org>; Tue, 28 Feb 2012 01:07:35 -0800 (PST)
Received-SPF: pass (google.com: domain of luke@diamand.org designates 10.204.129.203 as permitted sender) client-ip=10.204.129.203;
Authentication-Results: mr.google.com; spf=pass (google.com: domain of luke@diamand.org designates 10.204.129.203 as permitted sender) smtp.mail=luke@diamand.org
Received: from mr.google.com ([10.204.129.203])
        by 10.204.129.203 with SMTP id p11mr9181936bks.58.1330420055294 (num_hops = 1);
        Tue, 28 Feb 2012 01:07:35 -0800 (PST)
Received: by 10.204.129.203 with SMTP id p11mr7369915bks.58.1330420055013;
        Tue, 28 Feb 2012 01:07:35 -0800 (PST)
Received: from [86.6.30.7] (cpc19-cmbg14-2-0-cust6.5-4.cable.virginmedia.com. [86.6.30.7])
        by mx.google.com with ESMTPS id ut6sm29655303bkb.14.2012.02.28.01.07.33
        (version=SSLv3 cipher=OTHER);
        Tue, 28 Feb 2012 01:07:33 -0800 (PST)
User-Agent: Mozilla/5.0 (X11; Linux i686 on x86_64; rv:7.0.1) Gecko/20110929 Thunderbird/7.0.1
X-Gm-Message-State: ALoCoQkANpXppmFhHhO8aplsI7FFU6Kbb6UeC+oqBtdHxIoKnhGbp9IbUfJ5Scds55VxOgzN3SQc
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/191703>

The documentation for caret and tilde specs is making my head hurt, even 
though they always _do_ exactly what I want. And I thought I understood 
them until I read more carefully.

   A suffix '{caret}' to a revision parameter means the first parent of
   that commit object.  '{caret}<n>' means the <n>th parent (i.e.
   '<rev>{caret}'

So far, so good.

'<rev>{tilde}<n>', e.g. 'master{tilde}3'::
   A suffix '{tilde}<n>' to a revision parameter means the commit
   object that is the <n>th generation grand-parent of the named
   commit object, following only the first parents.

Hang on, *grand*-parents?

So HEAD~1 won't give me the *parent* commit of HEAD, but the 
*grandparent* commit of HEAD (following only the first parents) ?

How do I get to the *parent* commit of HEAD?
Does that mean that HEAD~ != HEAD^
And why does HEAD~1 always look exactly what I would naively call the 
'parent' of HEAD?

I'm pretty sure I'm missing something very obvious. I think it must 
confuse other people as well though, as it's quite easy to find webpages 
around that claim that tildes give the _parent_ commit.

Thanks
Luke
