From: "Dr. Jennifer Nussbaum" <bg271828@yahoo.com>
Subject: Newbie: Branch management
Date: Wed, 22 Jul 2009 13:41:04 -0700 (PDT)
Message-ID: <446739.83600.qm@web53410.mail.re2.yahoo.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Jul 22 22:47:52 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MTij7-00046e-Rw
	for gcvg-git-2@gmane.org; Wed, 22 Jul 2009 22:47:50 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753618AbZGVUrq (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 22 Jul 2009 16:47:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753582AbZGVUrq
	(ORCPT <rfc822;git-outgoing>); Wed, 22 Jul 2009 16:47:46 -0400
Received: from web53410.mail.re2.yahoo.com ([206.190.37.57]:39737 "HELO
	web53410.mail.re2.yahoo.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with SMTP id S1751128AbZGVUrp (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 22 Jul 2009 16:47:45 -0400
X-Greylist: delayed 401 seconds by postgrey-1.27 at vger.kernel.org; Wed, 22 Jul 2009 16:47:45 EDT
Received: (qmail 83781 invoked by uid 60001); 22 Jul 2009 20:41:04 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s1024; t=1248295264; bh=5XXl12hmPUrC/vxRxOAWTS5QYQHpypc5/9vrjOpi6PU=; h=Message-ID:X-YMail-OSG:Received:X-Mailer:Date:From:Subject:To:MIME-Version:Content-Type; b=22lRnZH3e6OJSu9Maqh2uCnnRqaWg66vnj3KyR1krBqZfI8keBG5BMvSAGh548qXGdNYZdz10OTSZBbdiriCD4alufpxo01ZWGnsyJNB9HqGgIxBJIvSJVXOgmDu3J5wSCvsNYbH/IHaILU8aBNzKn889S527szP0aDPnbmJvsk=
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
  s=s1024; d=yahoo.com;
  h=Message-ID:X-YMail-OSG:Received:X-Mailer:Date:From:Subject:To:MIME-Version:Content-Type;
  b=LQ/6feO8FZDBT0b7MRqAyXyj87hRCUfmzxgh/++Yezl1wb020nWX8kXcpxl7ZzihtvsePgn4X9Ax2YT5Tb+1rUaLi4NVwa68O5IXiIYf6k/g8ADyzTPx7XqlWhwKdTnZTOtecl938XFqcqaJKDFo2jX/q1+1Id6DB1vinsheSGk=;
X-YMail-OSG: 4bKMmosVM1kiNBh8YQxqYVklFnYKgK0YioIvvxRQ_R1Mj1YUMNiN6MQgPR3yu7_yHmOiN9kEqwS.MTwiblq4WXSs83nyAWOlUuyJCc8q6rMLDi_ZwzGQoW8JEn__vTeQ8HySxA01dANP_bG_Sc7IJOI6CPBtfO6VykwkYyv0TPxwZNxQbEBHxzsQZlsIJT5kqnltCZudIhaS2clP5psEHeRc4AMstndJb1QpmxsWaMnzVD5S_zvc2lRwDvcrGugDs21m44SS2qCsat_cxMWEVJcHqySbtKEygel2jMyt7EjdEccIy0TF
Received: from [12.182.77.130] by web53410.mail.re2.yahoo.com via HTTP; Wed, 22 Jul 2009 13:41:04 PDT
X-Mailer: YahooMailClassic/5.4.17 YahooMailWebService/0.7.289.15
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/123772>


Hi,

I hope its OK to ask basic questions on this list.

Im a recent convert to git and having trouble with branches. I mostly work on projects by myself, and what I want is that all branches of everything Im doing are in sync everywhere.

I have a remote repository on my production server that serves as the "main" repository. Then i work on projects on a number of different computers--my main home computer, my main work machine, several non-main computers :-) ... 

I've found it very confusing dealing with branches in this environment. If I have my "master" branch, and decide that i want a "refactoring-templates" branch, what Id *like* to do is create that branch, work on it, commit it, and when I say "git push" I want everything that's new on that computer to be synced to the "main" repository. And then when I get to the next computer, I want to be able to say "git pull" and have everything on that computer by synced *from* the "main" repository.

Instead I get confused by having to push branches separately, and it's confusing that when I do a pull it doesnt necessarily get other branches unless I specify them directly, and so on.

I've looked at the docs on branches and there's something i guess Im missing because this still seems very difficult. Can someone giving me advice on the best way to keep this kind of thing organized?

Thanks!

Jen


      
