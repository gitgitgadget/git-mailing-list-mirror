From: Drew Northup <drew.northup@maine.edu>
Subject: Re: Consistent terminology: cached/staged/index
Date: Sun, 27 Feb 2011 10:30:12 -0500
Message-ID: <1298820612.19827.65.camel@drew-northup.unet.maine.edu>
References: <AANLkTi=9OWqz66Ab6O9tc4eYSrhZZ1YC_+ta9sutAn30@mail.gmail.com>
	 <20110213193738.GA26868@elie> <7v8vxjwnhj.fsf@alter.siamese.dyndns.org>
	 <4D589CE0.7020203@pcharlan.com>
	 <1297897887.24521.57.camel@drew-northup.unet.maine.edu>
	 <AANLkTincNdUQ=736=M2Oei4LF0pR0c2T7r=bWJE3RFCu@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Cc: Pete Harlan <pgit@pcharlan.com>,
	Junio C Hamano <gitster@pobox.com>,
	Jonathan Nieder <jrnieder@gmail.com>,
	Piotr Krukowiecki <piotr.krukowiecki.news@gmail.com>,
	git@vger.kernel.org
To: Felipe Contreras <felipe.contreras@gmail.com>
X-From: git-owner@vger.kernel.org Sun Feb 27 16:31:46 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Ptib3-00044T-1t
	for gcvg-git-2@lo.gmane.org; Sun, 27 Feb 2011 16:31:45 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752222Ab1B0Pbk (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 27 Feb 2011 10:31:40 -0500
Received: from basalt.its.maine.edu ([130.111.32.66]:60067 "EHLO
	basalt.its.maine.edu" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752076Ab1B0Pbj (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 27 Feb 2011 10:31:39 -0500
Received: from [IPv6:2610:48:100:827:211:43ff:fe9f:cb7e] (drew-northup.unet.maine.edu [IPv6:2610:48:100:827:211:43ff:fe9f:cb7e])
	by basalt.its.maine.edu (8.13.8/8.13.8) with ESMTP id p1RFUILW026138
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NOT);
	Sun, 27 Feb 2011 10:30:23 -0500
In-Reply-To: <AANLkTincNdUQ=736=M2Oei4LF0pR0c2T7r=bWJE3RFCu@mail.gmail.com>
X-Mailer: Evolution 2.12.3 (2.12.3-8.el5_2.3) 
X-DCC-UniversityOfMaineSystem-Metrics: basalt.its.maine.edu 1003; Body=6
	Fuz1=6 Fuz2=6
X-MailScanner-Information: Please contact the ISP for more information
X-UmaineSystem-MailScanner-ID: p1RFUILW026138
X-MailScanner: Found to be clean
X-MailScanner-From: drew.northup@maine.edu
X-UmaineSystem-MailScanner-Watermark: 1299425464.52548@pTf1qHNXO1KaTLPVhKh2TA
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/168036>


On Sat, 2011-02-26 at 22:36 +0200, Felipe Contreras wrote:
> On Thu, Feb 17, 2011 at 1:11 AM, Drew Northup <drew.northup@maine.edu> wrote:
> >
> > On Sun, 2011-02-13 at 19:09 -0800, Pete Harlan wrote:
> >> On 02/13/2011 02:58 PM, Junio C Hamano wrote:
> >> >> --staged
> >> >> ~~~~~~~~
> >> >> diff takes --staged, but that is only to support some people's habits.
> >> > The term "stage" comes from "staging area", a term people used to explain
> >> > the concept of the index by saying "The index holds set of contents to be
> >> > made into the next commit; it is _like_ the staging area".
> >> >
> >> > My feeling is that "to stage" is primarily used, outside "git" circle, as
> >> > a logistics term.  If you find it easier to visualize the concept of the
> >> > index with "staging area" ("an area where troops and equipment in transit
> >> > are assembled before a military operation", you may find it easier to say
> >> > "stage this path ('git add path')", instead of "adding to the set of
> >> > contents...".
> >>
> >> FWIW, when teaching Git I have found that users immediately understand
> >> "staging area", while "index" and "cache" confuse them.
> >>
> >> "Index" means to them a numerical index into a data structure.
> >> "Cache" is a local copy of something that exists remotely.  Neither
> >> word describes the concept correctly from a user's perspective.
> >
> > According to the dictionary (actually, more than one) "cache" is a
> > hidden storage space. I'm pretty sure that's the sense most global and
> > therefore most appropriate to thinking about Git. (It certainly
> > describes correctly what web browser cache and on-CPU cache is doing.)
> > One would only think the definition you gave applied if they didn't know
> > that squirrels "cache" nuts. I don't think that the problem is the
> > idiom.
> 
> Not really. If a squirrel "caches" nuts, it means a squirrel is
> putting them in a hidden place to save them for future use. So, in the
> future, if said squirrel wants a nut, it doesn't have to look for it
> in the trees, just go to the cache. So the cache makes it easier to
> access whatever your want.
> 
> IOW; if you don't cache something, you would have more trouble getting
> it, but you still can.
> 
> That's not what Git is doing. Git is not putting changes in a place so
> the can be more easily accessed in the future. It is using a temporary
> device that allows the commit to be built through an extended period
> of time. It's not a cache.

As I noted earlier, "cache" classically has nothing whatsoever to do
with temporality, it is a descriptor of visibility. Any notion of
temporality or intentionality is imposed by the reader. THAT'S THE
PROBLEM. 

> >> I learned long ago to type "index" and "cached", but when talking (and
> >> thinking) about Git I find "the staging area" gets the point across
> >> very clearly and moves Git from interesting techie-tool to
> >> world-dominating SCM territory.  I'm surprised that that experience
> >> isn't universal.
> >
> > Perhaps that helps you associate it with other SCM/VCS software, but it
> > didn't help me. When I realized that the "index" is called that BECAUSE
> > IT IS AN INDEX (of content/data states for a pending commit operation)
> > the sky cleared and the sun came out.
> 
> That's not an index. An index is a guide of pointers to something
> else. It allows you to find whatever you are looking for by looking in
> small table of pointers instead of looking through all the samples.
> 
> IOW; if you don't index something, you would have more trouble finding
> it, but you still can.
> 
> That's not what Git is doing.

Index: "That which guides, points out, informs, or directs" [1913
Edition Webster's Dictionary--new one says something pretty similar if
not the same].
As far as I can tell Git is using the "Index" to do just that. Again, I
am discarding all notions of connotation here and focusing solely on the
denotation of the word. Besides, it is still possible to build a commit
with git without the "Index"; it is a real royal pain--and not the least
advisable for day-to-day use.

> > In all reality the closest thing Git has to an actual staging area is
> > all of the objects in .git/objects only recorded by the index itself.
> > Git-stored objects not compressed into pack files could technically be
> > described as "cached" using the standard definition--they aren't visible
> > in the working directory. Unfortunately this probably just muddies the
> > water for all too many users.
> 
> That's irrelevant. You can implement the same functionality in many
> other ways. How it is implement doesn't matter, what matters is what
> the user experiences.

Please re-read what I said, more slowly and without notion of previous
disagreement if you can muster it. We both agree that the notion of
caching here is superfluous to most users. Alas, I am not one to say
that what any one user experiences should dictate to us who all users
SHOULD experience Git. It is fairly clear to me that isn't what is
currently happening and any efforts to force the matter thus far haven't
helped matters much if at all.

> > So, in summary--the index is real, objects "cached" pending
> > commit/cleanup/packing are real; any "staging area" is a rhetorical
> > combination of the two. Given that rhetorical device may not work in all
> > languages (as Junio mentioned earlier) I don't recommend that we rely on
> > it.
> 
> Branches and tags are "rthetorical" devices as well. But behind scenes
> they are just refs. Shall we disregard 'branch' and 'tag'?
> 
> No. What Git does behind scenes is irrelevant to the user. What
> matters is what the device does, not how it is implemented; the
> implementation might change. "Stage" is the perfect word; both verb
> and a noun that express a temporary space where things are prepared
> for their final form.

Yes they (branches and tags) are. They also have a "physical"
manifestation. A "staging area" does not. This obviously is of little
importance to you (as a user--I know you do more than that), but would
matter a great deal to somebody like myself currently mulling over how
to craft a contribution to this project.

Alas, as Junio pointed out earlier, "stage" is a metaphor of limited
utility (it also means a large number of things in English alone--I tend
to think of theaters and not states when I read it). In fact, it opens
up more questions: "Staged where? In a cache. Where is the cache? It
doesn't really exist, but it is a combination of the Index and
under-referenced objects in the object store acting as a cache. Why? How
does it do that?....." We are therefore where we started. Users are just
as confused as they were before, and we're looking for a good watering
hole to cluster at and come up with a better way to explain it without
getting into the gritty details.

Details sometimes matter, sometimes they don't, and much more often the
reality is halfway between the two. Currently I think that Git is in
that middle state. Discarding outright the notion of the Index and of
caching doesn't make sense (as, at some level, that's what's happening),
yet staging isn't perfect either. That's my point.

(Please also see my pending reply to Jeff's missive from 8:43 UTC
today.)

-- 
-Drew Northup
________________________________________________
"As opposed to vegetable or mineral error?"
-John Pescatore, SANS NewsBites Vol. 12 Num. 59
