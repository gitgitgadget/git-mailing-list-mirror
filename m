From: Thomas Rast <trast@student.ethz.ch>
Subject: Re: Lost association between TAGS and COMMITs when rebased a git(1) repository
Date: Sun, 4 Sep 2011 20:43:00 +0200
Message-ID: <201109042043.01159.trast@student.ethz.ch>
References: <FF0364F3D5244CA4987EDDCFE7244BF3@urbanjsPC> <CACx-yZ3tav1sJnLtJOn_YugQOsM9ERi7Cc7SowunyobxxX5YdA@mail.gmail.com> <CABNEGjyXLnSvjhBewNDsjW=rthRh0HY+KgC05vPNPu5QCaAgXQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Cc: knittl <knittl89@googlemail.com>,
	"John S. Urban" <urbanjost@comcast.net>, <git@vger.kernel.org>
To: Tor Arntsen <tor@spacetec.no>
X-From: git-owner@vger.kernel.org Sun Sep 04 20:43:16 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1R0Hf2-0007FP-9S
	for gcvg-git-2@lo.gmane.org; Sun, 04 Sep 2011 20:43:16 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752631Ab1IDSnL (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 4 Sep 2011 14:43:11 -0400
Received: from edge20.ethz.ch ([82.130.99.26]:4218 "EHLO edge20.ethz.ch"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752561Ab1IDSnJ (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 4 Sep 2011 14:43:09 -0400
Received: from CAS11.d.ethz.ch (172.31.38.211) by edge20.ethz.ch
 (82.130.99.26) with Microsoft SMTP Server (TLS) id 14.1.289.1; Sun, 4 Sep
 2011 20:43:03 +0200
Received: from thomas.inf.ethz.ch (188.155.176.28) by CAS11.d.ethz.ch
 (172.31.38.211) with Microsoft SMTP Server (TLS) id 14.1.289.1; Sun, 4 Sep
 2011 20:43:06 +0200
User-Agent: KMail/1.13.7 (Linux/3.0.3-41-desktop; KDE/4.6.5; x86_64; ; )
In-Reply-To: <CABNEGjyXLnSvjhBewNDsjW=rthRh0HY+KgC05vPNPu5QCaAgXQ@mail.gmail.com>
X-Originating-IP: [188.155.176.28]
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/180692>

Tor Arntsen wrote:
> On Sun, Sep 4, 2011 at 4:30 PM, knittl <knittl89@googlemail.com> wrote:
> >
> > On Sun, Sep 4, 2011 at 3:32 AM, John S. Urban <urbanjost@comcast.net> wrote:
> > > With my first use of git(1) I  created a small project with about 200
> > > "commits".  When this was complete, I needed to label each commit with
> > > information pointing it to a section of a document. I used tags for this.
> >
> > Use git notes[1] to attach additional info to existing commits. Git
> > notes will by default be copied when using git rebase or git commit
> > --amend (cf. notes.rewrite.<command> config)
> 
> Is that true? I've always lost the notes when rebasing. I just tried
> that again now (1.7.5.4), and after a rebase the notes attached to any
> commit that was rebased just disappeared. I've always had to hunt down
> and re-create the notes. It would indeed be much more convenient if
> the notes would tag along.

Yes, that support has been present since 1.7.1, but it's not enabled
by default: you need to configure notes.rewriteRef.

-- 
Thomas Rast
trast@{inf,student}.ethz.ch
