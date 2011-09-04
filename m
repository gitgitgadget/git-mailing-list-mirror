From: "John S. Urban" <urbanjost@comcast.net>
Subject: Re: Lost association between TAGS and COMMITs when rebased a git(1) repository
Date: Sun, 4 Sep 2011 16:18:30 -0400
Message-ID: <E8AFFECA8E294A55B0E2918B205113A6@urbanjsPC>
References: <FF0364F3D5244CA4987EDDCFE7244BF3@urbanjsPC><CACx-yZ3tav1sJnLtJOn_YugQOsM9ERi7Cc7SowunyobxxX5YdA@mail.gmail.com><CABNEGjyXLnSvjhBewNDsjW=rthRh0HY+KgC05vPNPu5QCaAgXQ@mail.gmail.com><201109042043.01159.trast@student.ethz.ch> <CABNEGjy8M-pFTOs504Q1+G_DtocJwvzDyOAsJp9cn4BOSkv1TQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain;
	format=flowed;
	charset="iso-8859-1";
	reply-type=original
Content-Transfer-Encoding: 7bit
Cc: "knittl" <knittl89@googlemail.com>, <git@vger.kernel.org>
To: "Tor Arntsen" <tor@spacetec.no>,
	"Thomas Rast" <trast@student.ethz.ch>
X-From: git-owner@vger.kernel.org Sun Sep 04 22:19:45 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1R0JAM-0006m6-R8
	for gcvg-git-2@lo.gmane.org; Sun, 04 Sep 2011 22:19:43 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753331Ab1IDUT3 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 4 Sep 2011 16:19:29 -0400
Received: from qmta11.westchester.pa.mail.comcast.net ([76.96.59.211]:37279
	"EHLO QMTA11.westchester.pa.mail.comcast.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1753214Ab1IDUT2 (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 4 Sep 2011 16:19:28 -0400
Received: from omta23.westchester.pa.mail.comcast.net ([76.96.62.74])
	by QMTA11.westchester.pa.mail.comcast.net with comcast
	id UkKD1h0011c6gX85BkKUxn; Sun, 04 Sep 2011 20:19:28 +0000
Received: from urbanjsPC ([71.236.72.62])
	by omta23.westchester.pa.mail.comcast.net with comcast
	id UkKQ1h00p1LdoTr3jkKRxZ; Sun, 04 Sep 2011 20:19:25 +0000
In-Reply-To: <CABNEGjy8M-pFTOs504Q1+G_DtocJwvzDyOAsJp9cn4BOSkv1TQ@mail.gmail.com>
X-Priority: 3
X-MSMail-Priority: Normal
X-Mailer: Microsoft Windows Mail 6.0.6001.18416
X-MimeOLE: Produced By Microsoft MimeOLE V6.0.6001.18645
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/180701>

Thanks for catching how this is not the default, and that it needs set. But 
exactly what is the value that works?
----- Original Message ----- 
From: "Tor Arntsen" <tor@spacetec.no>
To: "Thomas Rast" <trast@student.ethz.ch>
Cc: "knittl" <knittl89@googlemail.com>; "John S. Urban" 
<urbanjost@comcast.net>; <git@vger.kernel.org>
Sent: Sunday, September 04, 2011 3:11 PM
Subject: Re: Lost association between TAGS and COMMITs when rebased a git(1) 
repository


On Sun, Sep 4, 2011 at 8:43 PM, Thomas Rast <trast@student.ethz.ch> wrote:
> Tor Arntsen wrote:
>> On Sun, Sep 4, 2011 at 4:30 PM, knittl <knittl89@googlemail.com> wrote:
>> >
>> > On Sun, Sep 4, 2011 at 3:32 AM, John S. Urban <urbanjost@comcast.net> 
>> > wrote:
>> > > With my first use of git(1) I created a small project with about 200
>> > > "commits". When this was complete, I needed to label each commit with
>> > > information pointing it to a section of a document. I used tags for 
>> > > this.
>> >
>> > Use git notes[1] to attach additional info to existing commits. Git
>> > notes will by default be copied when using git rebase or git commit
>> > --amend (cf. notes.rewrite.<command> config)
>>
>> Is that true? I've always lost the notes when rebasing. I just tried
>> that again now (1.7.5.4), and after a rebase the notes attached to any
>> commit that was rebased just disappeared. I've always had to hunt down
>> and re-create the notes. It would indeed be much more convenient if
>> the notes would tag along.
>
> Yes, that support has been present since 1.7.1, but it's not enabled
> by default: you need to configure notes.rewriteRef.

Thanks. Got it working. So it's not by default, as was suggested by
knittl, it has to be enabled. BTW, it's not at all obvious from the
manpage what it should be set to, there's no actual example. Found it
by trial&error plus finding a diff for a test.

-Tor
