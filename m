From: "John S. Urban" <urbanjost@comcast.net>
Subject: Re: Lost association between TAGS and COMMITs when rebased a git(1) repository
Date: Sun, 4 Sep 2011 12:40:56 -0400
Message-ID: <E06C306119F84928B8D84D5DEC7A024C@urbanjsPC>
References: <FF0364F3D5244CA4987EDDCFE7244BF3@urbanjsPC> <CACx-yZ1Ce3x=ZSdm5iY3JqYjVGVs5uPnb12-tMJP7zWsGuMK_Q@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain;
	format=flowed;
	charset="iso-8859-1";
	reply-type=original
Content-Transfer-Encoding: 7bit
To: <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Sun Sep 04 18:41:59 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1R0Fle-0007jn-HR
	for gcvg-git-2@lo.gmane.org; Sun, 04 Sep 2011 18:41:58 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751545Ab1IDQly (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 4 Sep 2011 12:41:54 -0400
Received: from qmta14.westchester.pa.mail.comcast.net ([76.96.59.212]:52548
	"EHLO qmta14.westchester.pa.mail.comcast.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751320Ab1IDQlx (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 4 Sep 2011 12:41:53 -0400
Received: from omta18.westchester.pa.mail.comcast.net ([76.96.62.90])
	by qmta14.westchester.pa.mail.comcast.net with comcast
	id Ug291h0041wpRvQ5EghtF6; Sun, 04 Sep 2011 16:41:53 +0000
Received: from urbanjsPC ([71.236.72.62])
	by omta18.westchester.pa.mail.comcast.net with comcast
	id Ughr1h00b1LdoTr3eghs2m; Sun, 04 Sep 2011 16:41:52 +0000
In-Reply-To: <CACx-yZ1Ce3x=ZSdm5iY3JqYjVGVs5uPnb12-tMJP7zWsGuMK_Q@mail.gmail.com>
X-Priority: 3
X-MSMail-Priority: Normal
X-Mailer: Microsoft Windows Mail 6.0.6001.18416
X-MimeOLE: Produced By Microsoft MimeOLE V6.0.6001.18645
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/180688>

Thanks to all for the replies. Perhaps the tutorials should mention notes 
more often. I used several introductory
manuals; all of which mentioned tags and none of which mentioned notes. The 
tags seem (in retrospect) useful when
I want additional sign-off capabilities. If the tags are seen only as a 
sign-off mechanism I understand why they do not
retain their associations when you "rewrite history"; but I really would 
like to see a --tags option on the rebase option
that lets tags keep their associations when they are not signed, as one 
reply suggested.

Notes are definitely more appropriate for my purpose than tags, however. I 
haven't tried them yet but will shortly.
 I hope to see that
they show up in gitk(1) as nicely as the tags do. I've been using the line 
mode but the reviewers are very happy with
gitk(1) as an efficient way to review and sign changes (especially simple 
ones).

Now that I've used the basics enough to find git(1) useful I guess it's time 
to read the complete manual before I shoot
myself in the foot again (yeehh, like that will happen!).

Much appreciated!

----- Original Message ----- 
From: "knittl" <knittl89@googlemail.com>
To: "John S. Urban" <urbanjost@comcast.net>
Sent: Sunday, September 04, 2011 3:55 AM
Subject: Re: Lost association between TAGS and COMMITs when rebased a git(1) 
repository


On Sun, Sep 4, 2011 at 3:32 AM, John S. Urban <urbanjost@comcast.net> wrote:
> With my first use of git(1) I created a small project with about 200
> "commits". When this was complete, I needed to label each commit with
> information pointing it to a section of a document. I used tags for this.

Use git notes[1] to attach additional info to existing commits. Git
notes will by default be copied when using git rebase or git commit
--amend (cf. notes.rewrite.<command> config)

> So far, everything was fine. I was then asked to merge two commits
> into one. I then did a "rebase" (for the first time). I then appear to 
> have
> lost all association between the tags and the effected commits; as all
> commits after
> the ones I modified no longer see "their" tags. Was there a way to have 
> kept
> the tags associated with the original commits as they were "rebased"?

"Rebase" takes commits and creates new commits from those. The new
commits are not the same as the old, although they might have
associated the same tree or changeset.

> Also, I have some commits with multiple tags pointing to them. It has come
> to my attention that might not be an intentional feature. I could find
> nothing in the documentation explicitly stating multiple tags were allowed
> to point to a commit; but the tags seem to be unique "objects" so I
> see no reason this should not be an expected feature?

Tags can point to any git object (commits, trees, blobs, notes, even
to other annotated tags).  There's nothing wrong with that.

[1]: http://www.kernel.org/pub/software/scm/git/docs/git-notes.html

-- 
typed with http://neo-layout.org
myFtPhp -- visit http://myftphp.sf.net -- v. 0.4.7 released!
