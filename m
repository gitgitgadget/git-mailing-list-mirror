From: Felipe Contreras <felipe.contreras@gmail.com>
Subject: Re: Consistent terminology: cached/staged/index
Date: Sat, 26 Feb 2011 22:36:39 +0200
Message-ID: <AANLkTincNdUQ=736=M2Oei4LF0pR0c2T7r=bWJE3RFCu@mail.gmail.com>
References: <AANLkTi=9OWqz66Ab6O9tc4eYSrhZZ1YC_+ta9sutAn30@mail.gmail.com>
	<20110213193738.GA26868@elie>
	<7v8vxjwnhj.fsf@alter.siamese.dyndns.org>
	<4D589CE0.7020203@pcharlan.com>
	<1297897887.24521.57.camel@drew-northup.unet.maine.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Pete Harlan <pgit@pcharlan.com>,
	Junio C Hamano <gitster@pobox.com>,
	Jonathan Nieder <jrnieder@gmail.com>,
	Piotr Krukowiecki <piotr.krukowiecki.news@gmail.com>,
	git@vger.kernel.org
To: Drew Northup <drew.northup@maine.edu>
X-From: git-owner@vger.kernel.org Sat Feb 26 21:36:50 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PtQsj-0001nF-MR
	for gcvg-git-2@lo.gmane.org; Sat, 26 Feb 2011 21:36:50 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752628Ab1BZUgm convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sat, 26 Feb 2011 15:36:42 -0500
Received: from mail-bw0-f46.google.com ([209.85.214.46]:63681 "EHLO
	mail-bw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752475Ab1BZUgl convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Sat, 26 Feb 2011 15:36:41 -0500
Received: by bwz15 with SMTP id 15so2799241bwz.19
        for <git@vger.kernel.org>; Sat, 26 Feb 2011 12:36:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:in-reply-to:references:date
         :message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=7Mm0oe2IEM0P3+ohIOBSCqojAsbFIE+nrO/HAd18T30=;
        b=m/OGqg91D1hwqiM7ejrDTllrYEA2rsU73pWYNZsWHiqW9mr+rxk8+DdDwLrP0QPy3s
         Qf9bVqsVktw9zBuBaBRv6WbjZEHty3nswqNJVHCn6r0ROre9c1VZ1tRBe0dzwKbehlUW
         h/T+RzszDmZ66Lm/zbgeqfawY4sy2kMvbbyw0=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=uf3LV6vPX1O4zl7+jeEfd2lkhzSINGcENIrMHZTTKbQT4A7pN+yLD0GqziO1KyVUeX
         b1IFY6THj/h/pWzS5rpKpRkq4BWGRFG8djYqJft6ZdbDpk6WqeFuLQrPLIJcRxacRF5o
         2i/vI880yes8hlrFncV4DCSEH81sER0+KYtOo=
Received: by 10.204.56.14 with SMTP id w14mr3327060bkg.27.1298752599670; Sat,
 26 Feb 2011 12:36:39 -0800 (PST)
Received: by 10.204.67.141 with HTTP; Sat, 26 Feb 2011 12:36:39 -0800 (PST)
In-Reply-To: <1297897887.24521.57.camel@drew-northup.unet.maine.edu>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/167993>

On Thu, Feb 17, 2011 at 1:11 AM, Drew Northup <drew.northup@maine.edu> =
wrote:
>
> On Sun, 2011-02-13 at 19:09 -0800, Pete Harlan wrote:
>> On 02/13/2011 02:58 PM, Junio C Hamano wrote:
>> >> --staged
>> >> ~~~~~~~~
>> >> diff takes --staged, but that is only to support some people's ha=
bits.
>> > The term "stage" comes from "staging area", a term people used to =
explain
>> > the concept of the index by saying "The index holds set of content=
s to be
>> > made into the next commit; it is _like_ the staging area".
>> >
>> > My feeling is that "to stage" is primarily used, outside "git" cir=
cle, as
>> > a logistics term. =C2=A0If you find it easier to visualize the con=
cept of the
>> > index with "staging area" ("an area where troops and equipment in =
transit
>> > are assembled before a military operation", you may find it easier=
 to say
>> > "stage this path ('git add path')", instead of "adding to the set =
of
>> > contents...".
>>
>> FWIW, when teaching Git I have found that users immediately understa=
nd
>> "staging area", while "index" and "cache" confuse them.
>>
>> "Index" means to them a numerical index into a data structure.
>> "Cache" is a local copy of something that exists remotely. =C2=A0Nei=
ther
>> word describes the concept correctly from a user's perspective.
>
> According to the dictionary (actually, more than one) "cache" is a
> hidden storage space. I'm pretty sure that's the sense most global an=
d
> therefore most appropriate to thinking about Git. (It certainly
> describes correctly what web browser cache and on-CPU cache is doing.=
)
> One would only think the definition you gave applied if they didn't k=
now
> that squirrels "cache" nuts. I don't think that the problem is the
> idiom.

Not really. If a squirrel "caches" nuts, it means a squirrel is
putting them in a hidden place to save them for future use. So, in the
future, if said squirrel wants a nut, it doesn't have to look for it
in the trees, just go to the cache. So the cache makes it easier to
access whatever your want.

IOW; if you don't cache something, you would have more trouble getting
it, but you still can.

That's not what Git is doing. Git is not putting changes in a place so
the can be more easily accessed in the future. It is using a temporary
device that allows the commit to be built through an extended period
of time. It's not a cache.

>> I learned long ago to type "index" and "cached", but when talking (a=
nd
>> thinking) about Git I find "the staging area" gets the point across
>> very clearly and moves Git from interesting techie-tool to
>> world-dominating SCM territory. =C2=A0I'm surprised that that experi=
ence
>> isn't universal.
>
> Perhaps that helps you associate it with other SCM/VCS software, but =
it
> didn't help me. When I realized that the "index" is called that BECAU=
SE
> IT IS AN INDEX (of content/data states for a pending commit operation=
)
> the sky cleared and the sun came out.

That's not an index. An index is a guide of pointers to something
else. It allows you to find whatever you are looking for by looking in
small table of pointers instead of looking through all the samples.

IOW; if you don't index something, you would have more trouble finding
it, but you still can.

That's not what Git is doing.

> In all reality the closest thing Git has to an actual staging area is
> all of the objects in .git/objects only recorded by the index itself.
> Git-stored objects not compressed into pack files could technically b=
e
> described as "cached" using the standard definition--they aren't visi=
ble
> in the working directory. Unfortunately this probably just muddies th=
e
> water for all too many users.

That's irrelevant. You can implement the same functionality in many
other ways. How it is implement doesn't matter, what matters is what
the user experiences.

> So, in summary--the index is real, objects "cached" pending
> commit/cleanup/packing are real; any "staging area" is a rhetorical
> combination of the two. Given that rhetorical device may not work in =
all
> languages (as Junio mentioned earlier) I don't recommend that we rely=
 on
> it.

Branches and tags are "rthetorical" devices as well. But behind scenes
they are just refs. Shall we disregard 'branch' and 'tag'?

No. What Git does behind scenes is irrelevant to the user. What
matters is what the device does, not how it is implemented; the
implementation might change. "Stage" is the perfect word; both verb
and a noun that express a temporary space where things are prepared
for their final form.

--=20
=46elipe Contreras
