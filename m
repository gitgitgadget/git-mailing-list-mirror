From: Jon Forrest <nobozo@gmail.com>
Subject: More Beginning Git Questions
Date: Fri, 23 Sep 2011 07:41:49 -0700
Message-ID: <4E7C9AAD.7060209@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252;
	format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
To: "git@vger.kernel.org" <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Fri Sep 23 16:42:05 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1R76x1-00054G-6X
	for gcvg-git-2@lo.gmane.org; Fri, 23 Sep 2011 16:42:03 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754600Ab1IWOlw convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 23 Sep 2011 10:41:52 -0400
Received: from mail-yw0-f46.google.com ([209.85.213.46]:64913 "EHLO
	mail-yw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754140Ab1IWOlt (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 23 Sep 2011 10:41:49 -0400
Received: by ywb5 with SMTP id 5so2728403ywb.19
        for <git@vger.kernel.org>; Fri, 23 Sep 2011 07:41:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=message-id:date:from:user-agent:mime-version:to:subject
         :content-type:content-transfer-encoding;
        bh=WEv/0iPmuO88Wos6ObYe74BmGY585igaW35+JJYospk=;
        b=kAH+7jk8Ldyw1htEl1cAT3P5ckW21G4wW7dXZRqQvjIEEzIiZCuLcgN7gA7VtTutFc
         +K09ER8c90JJScG6EVz9mXC6rjM4aSplcI/QktJto9uhTIyr4yF6svA/V+VfY3HIbBic
         yB6xhIdWJxYZfJ8WnDZ+IrgNDo/XAPiwr3ICY=
Received: by 10.42.96.72 with SMTP id i8mr4395908icn.60.1316788908170;
        Fri, 23 Sep 2011 07:41:48 -0700 (PDT)
Received: from [192.168.0.104] (c-98-248-228-150.hsd1.ca.comcast.net. [98.248.228.150])
        by mx.google.com with ESMTPS id v16sm15977461ibe.0.2011.09.23.07.41.46
        (version=SSLv3 cipher=OTHER);
        Fri, 23 Sep 2011 07:41:47 -0700 (PDT)
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:6.0.2) Gecko/20110902 Thunderbird/6.0.2
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/181968>

I'm reading the git tutorial at
http://schacon.github.com/git/gittutorial.html
I'm a very literal reader so if something isn't clear
to me, I try to make the effort to understand it.

In reading about what happens when Alice pulls from Bob,
it says:

"Note that in general, Alice would want her local changes committed=20
before initiating this "pull"."

This is an interesting statement. I'll come back to it shortly.

"If Bob=92s work conflicts with what Alice did since their histories fo=
rked,"

Does this include both changes that Alice has checked in to
her repository and uncommitted changes in her working tree?

"Alice will use her working tree and the index to resolve conflicts,"

How does Alice use her working tree and index? Does this mean
she makes changes to her working tree so that the conflicts
no longer exist? How does the index play a part in this?
I thought that the index gets populated only when a
"git add" is done. Does Alice need to do "git add" as part
of the conflict resolution process?

"and existing local changes will interfere with the conflict resolution=
=20
process"

Are "local changes" the changes in the working tree, the
uncommitted changes that Alice has added to her index, or
changes that Alice has committed to her local repository?

"(git will still perform the fetch but will refuse to merge
--- Alice will have to get rid of her local changes in
some way and pull again when this happens)."

Again, I'm not clear on which local changes this is talking
about. In other words, when the merge part of the pull is
done, what is examined locally? The first sentence about
Alice committing her local changes before pulling is what
got me thinking about all this.

I'm sorry if these are too pedantic.

Jon Forrest
