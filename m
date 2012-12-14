From: Max Horn <postbox@quendi.de>
Subject: Re: What's cooking in git.git (Dec 2012, #03; Wed, 12)
Date: Fri, 14 Dec 2012 14:11:40 +0100
Message-ID: <F151B265-7E3E-4989-AA16-EB7CAC298126@quendi.de>
References: <7vhanq257s.fsf@alter.siamese.dyndns.org> <CAMP44s2DAuhk5FkDm0-cYsikY0o6vuZ4FyAnXhbtsgqKQF1dpg@mail.gmail.com> <7vvcc6z801.fsf@alter.siamese.dyndns.org> <CAMP44s3uyC0V6ycTv78mG36_i7ugMLwwNk2cqNZatEJuL7Ee1w@mail.gmail.com> <BF9B1394-0321-4F1C-AD1B-F40D02DBE71A@quendi.de> <CAMP44s3Es-rLjwe6sgOi9OmwQouM4AbFKAbGB5UgS6sUtYRgKQ@mail.gmail.com>
Mime-Version: 1.0 (Apple Message framework v1283)
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 8BIT
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: Felipe Contreras <felipe.contreras@gmail.com>
X-From: git-owner@vger.kernel.org Fri Dec 14 14:12:12 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TjV3j-0001Z5-JQ
	for gcvg-git-2@plane.gmane.org; Fri, 14 Dec 2012 14:12:12 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754050Ab2LNNLu (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 14 Dec 2012 08:11:50 -0500
Received: from wp256.webpack.hosteurope.de ([80.237.133.25]:43211 "EHLO
	wp256.webpack.hosteurope.de" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1753419Ab2LNNLs convert rfc822-to-8bit
	(ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 14 Dec 2012 08:11:48 -0500
Received: from fb07-alg-gast1.math.uni-giessen.de ([134.176.24.161]); authenticated
	by wp256.webpack.hosteurope.de running ExIM with esmtpsa (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	id 1TjV3B-0004VI-7E; Fri, 14 Dec 2012 14:11:37 +0100
In-Reply-To: <CAMP44s3Es-rLjwe6sgOi9OmwQouM4AbFKAbGB5UgS6sUtYRgKQ@mail.gmail.com>
X-Mailer: Apple Mail (2.1283)
X-bounce-key: webpack.hosteurope.de;postbox@quendi.de;1355490708;7a2baffc;
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/211491>

Felipe,

please stop referring to "facts" and "obvious". You pretend to be a being of pure reason and that everything you say is logical, drawn from facts. But you forget or perhaps do not know that logic by itself proofs nothing, it all depends on the axioms you impose. And yours are quite different from what others consider as such, and apparently also inconsistent. 

So, instead of trying to twist things around so that broken things in your code are not broken after all, why not simply re-roll your patch with the "obvious" fixes applies? As you write yourself, time is not pressing at all -- so I don't see why your patch should be merged now, and fixed later, contrary to how other people's patches are treated? Why not fix them first, and then apply? We do have time, after all! And nobody is expecting you to do that while you are on vacation, either. Nor that you do it instantly.

Just say: "OK, I see there is a problem with the patches; even though I consider it unimportant, I will play by the rules everybody here has to follow, and re-roll the patch series. But this is of low priority for me, so I cannot say right now when it will happen".

Everybody would be happy then. Except perhaps the hypothetical users, who would have to wait a bit longer -- but oh, not really, because they can just use remote-bzr from your repo, yay :-). I really like that about it, it lives in contrib, so one can use it w/o it being merged into git.git.

Instead, you make claims that make you look like a foolish and arrogant ass, all the while insulting Junio and me implicitly. Why do you do that??? It delays acceptance of your nice work. As you write, this hurts the users. So why do it?


Since you keep complaining that nobody ever really can point to anything wrong your said, I'll do you the favor by deconstructing one of the claims you made:


On 13.12.2012, at 20:06, Felipe Contreras wrote:

> On Thu, Dec 13, 2012 at 6:04 AM, Max Horn <postbox@quendi.de> wrote:
>> 
>> On 13.12.2012, at 11:08, Felipe Contreras wrote:
>> 
>>> On Thu, Dec 13, 2012 at 2:11 AM, Junio C Hamano <gitster@pobox.com> wrote:
>>>> Felipe Contreras <felipe.contreras@gmail.com> writes:
>>> 
>>>>>> New remote helper for bzr (v3).  With minor fixes, this may be ready
>>>>>> for 'next'.
>>>>> 
>>>>> What minor fixes?
>>>> 
>>>> Lookng at the above (fixup), $gmane/210744 comes to mind
>>> 
>>> That doesn't matter. The code and the tests would work just fine.
>> 
>> 
>> It doesn't matter? I find that statement hard to align with what the maintainer of git, and thus the person who decides whether your patch series gets merged or not, wrote just above? In fact, it seems to me that what Junio said matters a great deal...
> 
> So you think Junio knows more about remote-bzr than I do?


This is a classical straw man argument. No, I do not think that. But I do think that Junio knows enough to review your code, and I do think that the point he raised is valid. You disagree with the importance of his point

> I repeat; it
> doesn't affect the tests, it doesn't affect the code, it doesn't cause
> any problem. remote-bzr could be merged today, in fact, it could have
> been merged a month ago.
> 
> You don't trust me? Here, look:
> 
[..]

> All this code is a no-op, because, as Junio pointed out, cmd is null.
> How is that a problem? It's not.

It is a problem. Because either the code inside the if is important, and then this is a bug. Or it is not important -- then it should not be there in the first place.

Either way, the patch series should be re-rolled. Of course in a whatever time frame suits you. If you are not willing to do that, this is sad, but of course also your right!

[...]

>> This is a very strange attitude...
>> 
>> In another email, you complained about nobody reviewing your patches respectively nobody voicing any constructive criticism. Yet Junio did just that, and again in $gmane/210745 -- and you replied to neither, and acted on neither (not even by refuting the points brought up), and now summarily dismiss them as irrelevant. I find that quite disturbing :-(.
> 
> I didn't say it was irrelevant, it should be fixed,

Actually, you wrote:

 "That doesn't matter."

So I paraphrased. In any case, I am glad to hear you finally agree that it should be fixed (which you did *not* say in your initial reply). So the problem we have seems to be that you do not understand how patches typically handled in git.git. Well, based on my observation: If reviews point out things in a patch series that are not optimal or even broken, it is expected that the submitter fixes this locally and resubmits a new version of the series. In some cases, it is possible to make exceptions, e.g. trivial typo fixes can be applied on the fly. But otherwise, you re-roll, you do not get your stuff merged just based on the promise that you'll submit a series of fixes later. Esp. if the fixes are relatively easy. 

Of course more exceptions can be made, but based on what I saw, this is rare, and has to be justified quite well. I fail to see a justification in this case... You mentioned "the users" but AFAIK there are no known users yet, and even if, they can simply use remote-bzr from your tree.

This could perhaps be documented explicitly in Documentation/SubmittingPatches. Not sure if I think this would be a good idea or even helpful, just thinking out aloud.


> but Junio said
> "With minor fixes, this may be ready for 'next'." which is no true
> IMO, it's ready *now*, it was ready one month ago. For 'next', this
> problem doesn't matter.
> 
> The feedback is appreciated, but delaying the merging of this code for
> no reason makes little sense to me.

And here goes the insult. You say Junio has no reason to delay the merging. When you really mean that you don't agree with his reasons. So you attack his professionalism and integrity by alluding that he has some ulterior motives to delay the patch. E.g. that he is hates you, is just mean, does it out of stubbornness, etc.

> Junio, of course, can do whatever he wants. The removal of this no-op code can wait, or it can be done
> on top of v3, there's no need for re-roll, and Junio already
> complained about the v3 re-roll.
> 
> And I didn't act because I was on vacations, git development is not my
> only priority.

Of course. Nobody is complaining that you take too long to reply. We are just unhappy in the way you reply when you do reply :-(.


> And even if I had time, I don't see why I should
> prioritize this fix, it's not important, the code is ready.

Another straw man: Nobody asked you to prioritize the fix, take your time. It was you who asked that the series should be applied without any further fixes. 


> 
>>>> but there may be others.  It is the responsibility of a contributor to keep
>>>> track of review comments others give to his or her patches and
>>>> reroll them, so I do not recall every minor details, sorry.
>>> 
>>> There is nothing that prevents remote-bzr from being merged.
>> 
>> Well, I think that is up to Junio to decide in the end, though :-). He wrote
> 
> No. He can decide if the code gets merged, but he is not the voice of
> truth. Nothing prevents him from merging the code, except himself.
> There is no known issue with the code, that is a true fact.

Here are a multitude of fallacies hidden, partially explainable by a differing set of axioms, and/or shear arrogance.

Let us re-reread what was said: Initially, you claimed that "There is nothing that prevents remote-bzr from being merged".

Now, it wasn't said in the above, but let me make it explicit: This statement is "obviously"[1] wrong. There are parts of the patch series Junio thinks are not up to par, and he made it quite clear that he will not merge it until these things are resolved.

Hence, ignoring all else, there obviously *is* something that prevents remote-bzr from being merged. That is a "fact". You even admit so yourself, also contradicting yourself:

  "Nothing prevents him from merging the code, except himself."


So how is it possible that you can claim that there is nothing that prevents the merge? Ignoring the self-contradicting aspects of what you wrote, the basis for your differing conclusion seems to be that you change the terms of discussion and are using a different set of axioms. In particular, you apparently redefine
  "things that prevent remote-bzr from being merged"
as
  "things that in Felipe's view prevent remote-bzr from being merged".


Of course one can arbitrarily bend the rules by this definition. For example, we could redefine "nothing prevents the merge" as
 "no technical reasons prevent the merge", and the latter is indeed quite true; your patch series applies perfectly fine, git can do that. Of course the same holds for a patch which removes git.c from the repository, so I don't think this definition is particularly useful...


Back to your self-contradictory statement: It could be parsed as an (not well-formed) attempt to say that Junio has no objective reasons to reject your patch. I.e. you again imply that Junio's decision that the patch is not merge-ready is not based upon "logical conclusions from the given set of facts".  Indeed, I would dare say that many people on the list will have interpreted your statements this way... At least I did.

This is something what a lot of people would consider a strong insult towards the professionalism and integrity of Junio. There are more examples of this in previous communications between you and other people in the list. 

You finally add "There is no known issue with the code, that is a true fact.". Within your axiom set, this is certainly true. It certainly is not true in mine or Junio's... Yet you very strongly emphasis with your statement that your set of axioms is the correct one to use here, although I would guess that most people would disagree.


This is especially arrogant in view of the another straw man argument you are employing: By writing "[Junio] he is not the voice of truth.", you implicate that I or anybody were of this opinion. But I am not, and what I wrote cannot logically be construed as saying so. At least not within what most people would consider as axiom set; of course if your axiom set includes "Max believes Junio is the voice of truth", your claim because truth, albeit a tautological one. But let me make clear that any such axioms, or set of axioms leading to that implicating, are inconsistent: In my view, of course Junio is fallible and makes mistakes, and can be wrong etc. -- like any human being. Including most definitely me and you.



This is a horrible way of working within a team effort :-(. I find this a great pity, because I believe you are doing some really nice work, I esp. like your remote-hg which works much better for me than the others I tried so far.


Bye,
Max


[1]  As a mathematician, I was taught to avoid the word "obvious" in any written form of proof, as it makes you sound arrogant, and it also discourages the reader from thinking critical about a statement, which is considered extremely bad. But since you like it so much, I am using here on purpose.
