From: Tomas Carnecky <tomas.carnecky@gmail.com>
Subject: Re: [RFC] git rm -u
Date: Sat, 19 Jan 2013 21:47:17 +0000
Message-ID: <1358632037-ner-2564@calvin>
References: <50FB1196.2090309@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain
To: Eric James Michael Ritz <lobbyjones@gmail.com>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Jan 19 22:47:47 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TwgGN-0006WO-6F
	for gcvg-git-2@plane.gmane.org; Sat, 19 Jan 2013 22:47:43 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751860Ab3ASVrW (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 19 Jan 2013 16:47:22 -0500
Received: from mail-ee0-f48.google.com ([74.125.83.48]:35151 "EHLO
	mail-ee0-f48.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751677Ab3ASVrW (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 19 Jan 2013 16:47:22 -0500
Received: by mail-ee0-f48.google.com with SMTP id t10so2348068eei.21
        for <git@vger.kernel.org>; Sat, 19 Jan 2013 13:47:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=x-received:from:subject:to:references:in-reply-to:mime-version:date
         :message-id:content-type;
        bh=JxUuLStGJ3cpiQrKhjiQqFZNzNFZN3B5/HkCzVjewRI=;
        b=kK06Q11HXHncxOzu/4CM1x7StiTbWvcKm2K3/2iudEupeuzfk48L4RZAGx+d1P9MN8
         aJeQ5gFEcvCih6GqPbBQeRR6JY9Qj0mu2DOl3kQ2/+tJtZa07ZDgViiQKmZyduq7R719
         F2havP/zVh50IQjMWf1EJRhQvMbYyOfU+pw4AEN17Punr4CpZBAMuE0CjF0z2KRNCt6P
         2m3pNhPZdegKlZShncKb6Ify3MeBTu+eO0FCwmtsEuscBgCzcMRSp5pao/q1gQ3yEuC1
         gg93FRLENop9/PjH60ji1b+1puwMxzOtU7J5kY5mcKSbzvT2euwQXB20j8LgFY39yvDJ
         dn2w==
X-Received: by 10.14.174.198 with SMTP id x46mr41754917eel.23.1358632040971;
        Sat, 19 Jan 2013 13:47:20 -0800 (PST)
Received: from calvin.caurea.org (cust.static.46-14-151-191.swisscomdata.ch. [46.14.151.191])
        by mx.google.com with ESMTPS id d3sm14328905eeo.13.2013.01.19.13.47.18
        (version=TLSv1.1 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Sat, 19 Jan 2013 13:47:19 -0800 (PST)
Received: by calvin.caurea.org (Postfix, from userid 3301)
	id 326DE11BCA5; Sat, 19 Jan 2013 21:47:17 +0000 (UTC)
In-Reply-To: <50FB1196.2090309@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/213989>

On Sat, 19 Jan 2013 16:35:18 -0500, Eric James Michael Ritz <lobbyjones@gmail.com> wrote:
> Hello everyone,
> 
> I am thinking about implementing a feature but I would appreciate any
> feedback before I begin, because more experienced Git developers and
> users may see some major problem that I do not.
> 
> Earlier today I deleted a file from a repository.  I deleted it
> normally, not by using `git rm`.  So when I looked at `git status` on
> my terminal it told me about the file no longer being there.  In my
> sleepy state of mind I ran `git rm -u` without thinking about.  I did
> this because I have a habit of using `git add -u`.  I know `git rm`
> does not support that option, but I tried it anyways without thinking
> about it.
> 
> When I came to my senses and realized that does not work I began to
> wonder if `git rm -u` should exist.  If any deleted, tracked files are
> not part of the index to commit then `git rm -u` would add that change
> to the index.  This would save users the effort of having to type out
> `git rm <filename>`, and could be useful when a user is deleting
> multiple files.
> 
> Does this sound like a reasonable, useful feature to Git?  Or is there
> already a way to accomplish this which I have missed out of ignorance?
> Any thoughts and feedback would be greatly appreciated.

Does `git add -A` do what you want?
