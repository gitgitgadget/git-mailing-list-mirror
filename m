From: "Philip Oakley" <philipoakley@iee.org>
Subject: Re: How to rebase when some commit hashes are in some commit messages
Date: Wed, 14 Oct 2015 00:06:58 +0100
Organization: OPDS
Message-ID: <B8985A8E92044BD8845B1ABD23FABA13@PhilipOakley>
References: <561C1132.3090606@orange.fr> <vpqsi5fx2gr.fsf@grenoble-inp.fr> <561CC5E0.7060206@orange.fr> <20151013160004.11a103942062ee09c53bd235@domain007.com> <AD64941D9533442AB025BE27FF8F08AF@PhilipOakley> <CA+P7+xoDia6PC+qJeVn3sD5g4jk7KRuDAPOcEHvrntd+ndUraA@mail.gmail.com> <CANoM8SVAGQ4AL9wBiBMaAu0GvaotC8rhn-rWQhLjsyWr4DnXmw@mail.gmail.com> <B846BC4FDE6944D39DC79E245264E544@PhilipOakley> <CA+P7+xpgY-PGdxDKHBeu0X=U6FKMavzmjexUTWatUzEdw8CmcQ@mail.gmail.com>
Reply-To: "Philip Oakley" <philipoakley@iee.org>
Mime-Version: 1.0
Content-Type: text/plain;
	format=flowed;
	charset="UTF-8";
	reply-type=original
Content-Transfer-Encoding: 7bit
Cc: "Mike Rappazzo" <rappazzo@gmail.com>,
	"Konstantin Khomoutov" <kostix+git@007spb.ru>,
	"Francois-Xavier Le Bail" <devel.fx.lebail@orange.fr>,
	"Matthieu Moy" <Matthieu.Moy@grenoble-inp.fr>,
	"Git List" <git@vger.kernel.org>
To: "Jacob Keller" <jacob.keller@gmail.com>
X-From: git-owner@vger.kernel.org Wed Oct 14 01:07:07 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Zm8ev-00047g-Vb
	for gcvg-git-2@plane.gmane.org; Wed, 14 Oct 2015 01:07:06 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752048AbbJMXHB (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 13 Oct 2015 19:07:01 -0400
Received: from out1.ip04ir2.opaltelecom.net ([62.24.128.240]:15563 "EHLO
	out1.ip04ir2.opaltelecom.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751795AbbJMXHA (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 13 Oct 2015 19:07:00 -0400
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-Anti-Spam-Result: A2BPUQB3jR1WPFc7FlxeGQECBIMGgUKGW224MoMTgn8EBAKBSE0BAQEBAQEHAQEBAUABJBtBAQEDAQGDWQUBAQEBAgEIAQEZFR4BASEFBgIDBQIBAxUDAgIFIQICFAEECBIGBwMUBhMIAgECAwGICAMKDK8ehliHZg2FNoEihVOEfoJQgj2CcDGBFAWWFgGBHooHg0yRaH+HSYItgjk9M4IAaIFvM4FnAQEB
X-IPAS-Result: A2BPUQB3jR1WPFc7FlxeGQECBIMGgUKGW224MoMTgn8EBAKBSE0BAQEBAQEHAQEBAUABJBtBAQEDAQGDWQUBAQEBAgEIAQEZFR4BASEFBgIDBQIBAxUDAgIFIQICFAEECBIGBwMUBhMIAgECAwGICAMKDK8ehliHZg2FNoEihVOEfoJQgj2CcDGBFAWWFgGBHooHg0yRaH+HSYItgjk9M4IAaIFvM4FnAQEB
X-IronPort-AV: E=Sophos;i="5.17,680,1437433200"; 
   d="scan'208";a="611981330"
Received: from host-92-22-59-87.as13285.net (HELO PhilipOakley) ([92.22.59.87])
  by out1.ip04ir2.opaltelecom.net with SMTP; 14 Oct 2015 00:06:58 +0100
X-Priority: 3
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook Express 6.00.2900.5931
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2900.6157
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/279529>

From: "Jacob Keller" <jacob.keller@gmail.com>
> On Tue, Oct 13, 2015 at 12:24 PM, Philip Oakley <philipoakley@iee.org>
> wrote:
>> IIUC (as an alternate example),  in G4W one can submit a (long) pull
>> request
>> with internal back references that would be merged directly, so the
>> sha1's
>> could be updated as Francois-Xavier originally asked. I have a series
>> that's
>> been bumping along for a long while that needs regular rebasing, though
>> doesn't have sha1 back references, so I can see that the need does
>> happen. I
>> can see that others may have a workflow that would work well with the
>> sha1
>> auto-update.
>>
>> --
>> Philip
>>
>
> I still don't see how this is useful, because the part that *can* be
> implemented is not valuable and the part that is valuable can't be
> implemented.
>
> So, what we can implement easily enough:
>
> you rebase a series and any time the message contains sha1 of a commit
> we're modifying in this rebase, we update the sha1 to match again.
> This seems reasonable, but not useful. Why would you reference a
> commit that is *ITSELF* being rebased. No one has explained a
> reasonable use for this... I'm sure there exists one, but I would want
> an explanation of one first.
>
This particular case is about self-references within a long series. At the
moment, on the Git list there is general comments about say [PATCH v3
18/44], whichs is great for for the list ($gmane) but not for a `git log`.
In flows where PRs are valid, one can have what was [34/44] refering to
prior patch [26/44] as `deadbeaf` or whatever. It won't be suitable for most
flows but will be useful for a proportion (as already evidenced by the
request).

> The "useful" case is if you rebase "onto" a tree that has a previous
> history that has been changed. In this case, how do you propose we
> find it.

This use case (where upstream also rebases) hasn't been considered. It would
be a tricky one. As long as the possibility (of such an A depends on B
re-write) isn't closed off then the smaller requested case could still go
ahead.

> Doing as suggested above, ie: only changing sha1s that we are
> already rebasing works, but why are you backreferencing it if you are
> re-writing the commit?

 Essentially one wants to say `$CURR_COMMIT~nn` (i.e. "see nn commits
earlier in my series") and have that replaced with its cannonical sha1, and
updated when rebased.
It sort of begs the question whether there should be a ref shorthand for
"the (this) current commit" to allow THIS~<n> as an interpretable [valid?]
format.

> That doesn't make sense to me at all. Yes, you
> can do it, but I don't get why this is valuable.

> If you're backref is
> "fixes xyz" why not just fix xyz instead of have two commits. If the
> back ref has some other value... what is that value? I don't
> understand it I guess.
For the 'fixes' (of a bug report) case we are already talking about an
immutable so it would not be part of this.
Its use may be more of the type "Using helper function xyz introduced
earlier in patch abcde", which would change after each rebase.

>
> It just seems pretty narrow focus. I mean if someone wants to
> implement it, that is fine.
>
Agreed
--
Philip 
