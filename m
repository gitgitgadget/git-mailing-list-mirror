From: Felipe Contreras <felipe.contreras@gmail.com>
Subject: Re: moving to a git-backed wiki
Date: Thu, 3 Feb 2011 22:34:38 +0200
Message-ID: <AANLkTi=qR5xYBg3NKRASuyatnEm1k3fVNc-i5VOwszpM@mail.gmail.com>
References: <7vwrll57ha.fsf@alter.siamese.dyndns.org>
	<7vsjw957fq.fsf_-_@alter.siamese.dyndns.org>
	<7vzkqg4x2h.fsf_-_@alter.siamese.dyndns.org>
	<20110131225529.GC14419@sigill.intra.peff.net>
	<AANLkTimHCp_JKUw1keJoA4zD_q7Sci+rOwPeAs_T=7xH@mail.gmail.com>
	<20110201201144.GA16003@sigill.intra.peff.net>
	<AANLkTikfzzELUaN3B+20rh9D51St8mUYs4p-WYjp8JVV@mail.gmail.com>
	<4D488DCD.3080305@eaglescrag.net>
	<4D4929F4.3020805@snarc.org>
	<4D4A11D7.4040103@eaglescrag.net>
	<20110203174518.GA14871@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: "J.H." <warthog19@eaglescrag.net>, Vincent Hanquez <tab@snarc.org>,
	Jay Soffian <jaysoffian@gmail.com>,
	Scott Chacon <schacon@gmail.com>,
	Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Thu Feb 03 21:34:51 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Pl5t9-0006wm-QM
	for gcvg-git-2@lo.gmane.org; Thu, 03 Feb 2011 21:34:48 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751959Ab1BCUek convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 3 Feb 2011 15:34:40 -0500
Received: from mail-fx0-f46.google.com ([209.85.161.46]:44536 "EHLO
	mail-fx0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751640Ab1BCUek convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 3 Feb 2011 15:34:40 -0500
Received: by fxm20 with SMTP id 20so1635292fxm.19
        for <git@vger.kernel.org>; Thu, 03 Feb 2011 12:34:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:in-reply-to:references:date
         :message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=4Bo+8kLKioa8eiOXI292OOrAZcDqmielwsXHIqB+ZC4=;
        b=jLUOd4WOs4QssJOSKaVFE+H45SQ4/G8aFJpsIolC+E2C/SY74cl56GvcuO3M0ohzek
         JQbFPVTAWmyPiehkukGv309DMdadRsoMbAFjMB8Q+YOPMjfvOBztTttvSzrXdM4xg5q5
         jQSF/L53ku5sylSSkOas0elObDuZa4ruUCpe4=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=gQiOvwUsesVtH/9g55j+3aglVt4v8ErwcaFBOrCdarphsA0owe0wANc2AtCKmtBHcV
         yGrrUt/46EI5hSO2qixEVGH3FLQvuZ1NlABZWsU5zQ/5rXV/wbh/vo4TksP7vU/9MenX
         NKCxrjgV/FfrneZ3Shc6N9qdjsASzmqzdG1FM=
Received: by 10.223.71.199 with SMTP id i7mr4310429faj.57.1296765278643; Thu,
 03 Feb 2011 12:34:38 -0800 (PST)
Received: by 10.223.105.78 with HTTP; Thu, 3 Feb 2011 12:34:38 -0800 (PST)
In-Reply-To: <20110203174518.GA14871@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/165996>

On Thu, Feb 3, 2011 at 7:45 PM, Jeff King <peff@peff.net> wrote:
> On Wed, Feb 02, 2011 at 06:24:23PM -0800, J.H. wrote:
>
>> On 02/02/2011 01:55 AM, Vincent Hanquez wrote:
>> > =C2=A0On 01/02/11 22:48, J.H. wrote:
>> >> The wiki will almost universally have a "central site" no matter =
what
>> >> the backend. =C2=A0Personally I see little advantage to having a =
git backed
>> >> wiki myself.
>> > with git based wiki, you can clone the whole wiki on your local ma=
chine,
>> > and read/edit/commit on it locally using standard editor tool (i.e=
=2E
>> > $EDITOR). and the history/revision/diff is completely built-in.
>>
>> That would be fine for things like source code or documentation, but=
 you
>> end up with a single person who would need to merge / push things to=
 a
>> central location, a-la git.wiki.kernel.org. =C2=A0You are now taking
>> something, that is already editable by anyone, and making it only
>> editable by a single person.
>
> I don't think it makes sense to use the same workflow for the wiki as
> git.git itself uses. The point of having a wiki is to keep the barrie=
r
> to editing extremely low; the point of source code control is to keep
> the quality of contributions high.
>
> But that doesn't mean they can't be accessed by the same tool.
>
> Forget about a git-backed wiki for a moment, and imagine a regular ol=
d
> Mediawiki. What are the operations you can perform? You can look at
> the current or any past version of a page, you can do diffs between
> versions of pages, and you can create a new version of a page. All
> through some CGI forms.

Howe about these?

1) Support for discussion; since changes can be controversial.

2) Support for article move; so everything is kept organized.

3) Support for "who is linking here". Also helps reorganization.

4) Support for categories. Ditto.

5) Support for watchlist, e-mail notifications. So that you are
up-to-date with the changes.

6) Support for contribution backtracking. So that it's easy to know who=
's who.

7) Personal wiki pages (with discussion). So you can put information
about yourself, and general notes.

--=20
=46elipe Contreras
