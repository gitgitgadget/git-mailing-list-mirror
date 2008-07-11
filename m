From: "Sverre Rabbelier" <alturin@gmail.com>
Subject: Re: [GitStats] Bling bling or some statistics on the git.git repository
Date: Sat, 12 Jul 2008 00:50:00 +0200
Message-ID: <bd6139dc0807111550w1f4a9e5fl636df73572bd27de@mail.gmail.com>
References: <bd6139dc0807090621n308b0159n92d946c165d3a5dd@mail.gmail.com>
	 <bd6139dc0807111404y1d3dd48ao6d2903da4cd1aa56@mail.gmail.com>
	 <alpine.DEB.1.00.0807112215050.8950@racer>
	 <bd6139dc0807111452x778759d4jd6ac71338974018e@mail.gmail.com>
	 <alpine.DEB.1.00.0807112257450.8950@racer>
Reply-To: sverre@rabbelier.nl
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: "Git Mailinglist" <git@vger.kernel.org>,
	"David Symonds" <dsymonds@gmail.com>
To: "Johannes Schindelin" <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Sat Jul 12 00:51:11 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KHRSD-0007dn-D6
	for gcvg-git-2@gmane.org; Sat, 12 Jul 2008 00:51:06 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753246AbYGKWuF (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 11 Jul 2008 18:50:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752855AbYGKWuE
	(ORCPT <rfc822;git-outgoing>); Fri, 11 Jul 2008 18:50:04 -0400
Received: from yw-out-2324.google.com ([74.125.46.28]:15389 "EHLO
	yw-out-2324.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752496AbYGKWuD (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 11 Jul 2008 18:50:03 -0400
Received: by yw-out-2324.google.com with SMTP id 9so1994930ywe.1
        for <git@vger.kernel.org>; Fri, 11 Jul 2008 15:50:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from:reply-to
         :to:subject:cc:in-reply-to:mime-version:content-type
         :content-transfer-encoding:content-disposition:references;
        bh=DEdJ8uZx/7l+gPIk/KKqWhlMJB2kHypORFSbHrSAk7M=;
        b=SmyfSe6ZbGfIgs+MGYqaNKLwSZeczI8jjjPaP0/GsXGjrUDGFmLTFRf1f6eHrWAw8R
         vKHvEeJqfjzR7GiNf09FU7lX0AXC5qjTRd71iLz1tGNpXU7ubBOvxfthpooQl9iXae+D
         WF1IbiGPZbkk0z6QHPUB7oHBXjwWrbb+8RObg=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:reply-to:to:subject:cc:in-reply-to
         :mime-version:content-type:content-transfer-encoding
         :content-disposition:references;
        b=aStlqiLhQplkrT8fViMPnVq17P11xXl7EI+EyOnyjdxQ71CTR+vVhAPEAitcSeeWO9
         3erfh4lmoYeyAmgkN617IHqVpkdlZ9XYP53fnmQVc8wK6CyhYQAZ5f8mku33rcqnXGXB
         aUip5ULfIkQTN/iNGTaTBprpF+Jqg51loUzgI=
Received: by 10.151.141.16 with SMTP id t16mr16746669ybn.60.1215816600179;
        Fri, 11 Jul 2008 15:50:00 -0700 (PDT)
Received: by 10.150.53.8 with HTTP; Fri, 11 Jul 2008 15:50:00 -0700 (PDT)
In-Reply-To: <alpine.DEB.1.00.0807112257450.8950@racer>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/88194>

On Sat, Jul 12, 2008 at 12:07 AM, Johannes Schindelin
<Johannes.Schindelin@gmx.de> wrote:
>> On Fri, Jul 11, 2008 at 11:22 PM, Johannes Schindelin
>> Yeah, I wish 'git log -C -C -M --numstat --sacrifice-chicken
>> --pretty=format:%ae --' would take care of that... That is, a git-blame
>> like mechanism that would detect such moves on a per-commit basis and
>> report them would be very useful to me.
>
> Well, the chicken (or better, a goat) should be sacrificed by you...  The
> option I would call "--code-moves".

If you suggest I write up a patch to 'git log' I am afraid that would
require quite a bit more skill && knowledge of 'git log' than I have
(which is about Null :P).

> But the semantics of that need to be sorted out in a shell script first;
> maybe like I outlined (if that was not coherent, please say so).

Python is one big shell script :P, so if you meant that it should be
part of GitStats (instead of part of 'git log', which I commented on
above), python would be just fine :). The concept was clear enough
though, I think I understand what you mean.

> Well, it is not a matter of getting it right, but it is a matter of
> changes.  For example, everytime we move code from one program into the
> library, and create a file for that, code changes.

<snip>

Yes, that's true, with what you described it makes sense :).

>> Very much so, but the former I figure can be easily done with 'git log
>> -C -C -M' I discovered (I need to parse it's output though, and also
>> determine what to do with moves statistics wise. Should changes made
>> due to moves just be ignored?)
>
> That is not very interesting, as we often move so small parts (think "one
> function") that -C -C -M does not trigger.

Right, why aim for the stuff when there's much more interesting fun
out there? If there was a --code-moves I agree with you that it would
be a lot more interesting to have than going with the current approach
and throwing in '-C -C -M'.

>> That sounds interesting, I won't need to actually do that though, I
>> already have a diff parser that gives me the lines added VS lines
>> deleted on a hunk-by-hunk basis. If it is a true move (e.g., code
>> removed in file X and added in file Y) it should be trivial to detect
>> that.
>> Something along the lines of:
>> for hunk in added:
>>   if hunk in deleted:
>>     print("Over here!!")
>
> I think that is not enough, as a code move can mean that part of a
> function was refactored into a function.  The consequence is often a
> reindent, and possibly rewrapping.

Mhhh, such would be beyond the scope of implementing manually indeed,
and should be left to the likes of a diff tool instead in order to
prevent reinventing the wheel :).

> And it can mean that some lines have to be inserted here and there.  I
> still would count that as a code move "with touch-ups".

True, true, so it turns out that the most interesting data is the most
difficult to mine, how typical.

> So I'd like to see something like
>
> <number-of-commits>: <lines-added> <lines-removed> \
>        <lines-moved-from> <lines-moved-to> <filename>

Ah, I like the idea of recording moved-from and moved-to seperately
instead of ignoring it, why throw away such a perfectly useful
statistic. It would be really nice if I could get this data from 'git
log' (e.g., the lines-moved-from and lines-moved-to) instead of having
to calculate it myself.

> BTW I realized something else: your
> http://alturin.googlepages.com/full_activity.txt lists only
> "gitk-git/po/es.po" under git-git/po/.  And it has as many added as
> deleted lines.

Correct, that's because that is what 'git log' tells me. Have a look at:
$ git log --pretty=format:%ae --numstat HEAD --
And grep for "\.po", you'll see that it lists the other po files under
"/po/de.po"

> So I suspect that "po/*" really lists both gitk's as well as git-gui's .po
> files, but merged together.

Feasible, if I use '-C -C -M' then the behavior on a directory rename
should be to take the found statistics under that directory and move
them too. That could be expensive though, what with having to search
all the keys whether they are affected and so.

-- 
Cheers,

Sverre Rabbelier
