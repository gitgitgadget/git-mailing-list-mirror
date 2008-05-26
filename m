From: Joshua Haberman <joshua@reverberate.org>
Subject: visualizing Git's Git repo
Date: Mon, 26 May 2008 13:47:33 -0700
Message-ID: <CA563F5A-5E12-42F7-BDFD-04FE3A882028@reverberate.org>
Mime-Version: 1.0 (Apple Message framework v919.2)
Content-Type: text/plain; charset=US-ASCII; format=flowed; delsp=yes
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon May 26 22:48:35 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1K0jcO-0003LF-8Z
	for gcvg-git-2@gmane.org; Mon, 26 May 2008 22:48:32 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752499AbYEZUrh (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 26 May 2008 16:47:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752528AbYEZUrh
	(ORCPT <rfc822;git-outgoing>); Mon, 26 May 2008 16:47:37 -0400
Received: from wa-out-1112.google.com ([209.85.146.181]:42649 "EHLO
	wa-out-1112.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752382AbYEZUrg (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 26 May 2008 16:47:36 -0400
Received: by wa-out-1112.google.com with SMTP id j37so2283520waf.23
        for <git@vger.kernel.org>; Mon, 26 May 2008 13:47:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:from:to:content-type:content-transfer-encoding:mime-version:subject:date:x-mailer:sender;
        bh=C3IYuj2YZqkIVrB/3Dnmglf1gO+6hqDdSbk/jGJmoos=;
        b=hoSzHhxvhC3GEJSslApFACwsUERUnLZjWwbrSpanbq803LLtS1rbdeo9bH0RQzmHaMlKKld0hfTZX3320R8P1ZxIQQOaaMnCM6Ln0t+tIh4coXMLSzIUX6gUMQv38AFtA1i5lBBzZ4Kcu+ITDnTQkjx2RYSV35wWBq/r+u4R5qQ=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:from:to:content-type:content-transfer-encoding:mime-version:subject:date:x-mailer:sender;
        b=eb3pogJ4f3TvaOaGV44nwNfsepkNrnnUs7frWqmWFjxL5saXW5fMiu8jmi0y0OmFoJmkQkEyrjV36kK4stuJ97W25VHdpWRGM75COfoTkAelnOMP51ingBdgeI7Nd+fHiuTSi87RVnJYUrCQZ63jXwcBWd4qLQHxZhfbdSi3Idk=
Received: by 10.114.109.1 with SMTP id h1mr487740wac.35.1211834856173;
        Mon, 26 May 2008 13:47:36 -0700 (PDT)
Received: from ?192.168.1.102? ( [24.19.134.23])
        by mx.google.com with ESMTPS id q18sm14232420pog.2.2008.05.26.13.47.34
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Mon, 26 May 2008 13:47:35 -0700 (PDT)
X-Mailer: Apple Mail (2.919.2)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/82953>

I'm a casual Git user.  One thing that's been troubling me about Git  
is that when I look at Git's own Git repository, the revision history  
is not at all easy to understand.  I like to view my own Git  
repositories with:

$ gitk --all --date-order

When I run this command, what I'm really asking is "give me a visual  
summary of what's up with my project lately."  But with Git's  
repository, there are far too many branches and merges for this view  
to make any kind of visual sense.

So my questions are:

1. what do you all do to get a high-level view of what's going on with  
Git development?  do you use gitk?  if so, what options?

2. as a project, why don't you rebase when merging long-running  
branches into master?  For example, take commit 7e83003029 from May 25  
which merged a branch that was based at 4b172de81 from May 14.  Why  
not rebase this to May 25 as part of the merge?  When you don't do  
this (ie. in the status quo) 'gitk --date-order' for the Git  
repository has >10 parallel branches most of the time, which makes it  
impossible to follow visually.

I'm sure you have reasons for doing things the way you do, I just want  
to hear what they are.  And sorry if this is a FAQ -- feel free to  
point me at any documentation that explains this.

Josh
