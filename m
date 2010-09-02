From: Luke Kenneth Casson Leighton <luke.leighton@gmail.com>
Subject: Re: git pack/unpack over bittorrent - works!
Date: Thu, 2 Sep 2010 20:17:39 +0100
Message-ID: <AANLkTi=Q7EfeUDB6PuSa88PDtaBZSMMuaMqh8hU25ECb@mail.gmail.com>
References: <AANLkTik-w6jWgrt_kwAk2uNGhF_=3tMEpTZs3nyF_zGA@mail.gmail.com>
	<AANLkTinu=RoGfq93d+yjHiQwCt0HXx4YtqfvhXyZdO=F@mail.gmail.com>
	<AANLkTimpE6rf0azHtrz6BFK5d7YojF+G1YuSA1gusSC=@mail.gmail.com>
	<4C7FC3DC.3060907@gmail.com>
	<AANLkTikBnKQJmgOms2wK1+6fCLtHWiWkhuCVMN7kKLXP@mail.gmail.com>
	<20100902155810.GB14508@sigill.intra.peff.net>
	<alpine.LFD.2.00.1009021233190.19366@xanadu.home>
	<4C7FDA32.5050009@gmail.com>
	<alpine.LFD.2.00.1009021326290.19366@xanadu.home>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: A Large Angry SCM <gitzilla@gmail.com>, Jeff King <peff@peff.net>,
	Nguyen Thai Ngoc Duy <pclouds@gmail.com>,
	git <git@vger.kernel.org>
To: Nicolas Pitre <nico@fluxnic.net>
X-From: git-owner@vger.kernel.org Thu Sep 02 21:17:52 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OrFID-00086f-HK
	for gcvg-git-2@lo.gmane.org; Thu, 02 Sep 2010 21:17:49 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753832Ab0IBTRm convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 2 Sep 2010 15:17:42 -0400
Received: from mail-ew0-f46.google.com ([209.85.215.46]:60434 "EHLO
	mail-ew0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753488Ab0IBTRl convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 2 Sep 2010 15:17:41 -0400
Received: by ewy23 with SMTP id 23so570108ewy.19
        for <git@vger.kernel.org>; Thu, 02 Sep 2010 12:17:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:received:in-reply-to
         :references:date:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=4boaGh855OkJke+uhuCdHNIkwr/ZvCVJfTdV/51g0a4=;
        b=s9MOFAW1703xl7CpddnoZPCKWzBvWvH6sRviOU5KRr+7JV+3kVIXt8rJyl0FbxSIKS
         ocaqrVAzMER7YnKrTasQVs7ZBzT5mPP6EYVu+mouEchtqj8tLAsUKHkE/81KBYhdZJED
         HNKC6UI/b1JZtd3pLHz+ykl0HdYtrAil6Tse0=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=qzs+wNqWAoy1zz4TmukOwT1GK/HLe9iTuxyLXPSZO8p1DwQWdFyVCMVKmYlTKNklKu
         VzuaF4dr76RKTwXqSY23FOUBi/ofxBKIJ+2l51Etlx+5wES5SmBtejEf2Rib8nONcRmG
         zQAVf/1JJ+8Y8kvl5bS43zPsRlBYMcXDxSoSQ=
Received: by 10.213.109.10 with SMTP id h10mr12070ebp.43.1283455060243; Thu,
 02 Sep 2010 12:17:40 -0700 (PDT)
Received: by 10.220.98.8 with HTTP; Thu, 2 Sep 2010 12:17:39 -0700 (PDT)
In-Reply-To: <alpine.LFD.2.00.1009021326290.19366@xanadu.home>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/155158>

On Thu, Sep 2, 2010 at 6:31 PM, Nicolas Pitre <nico@fluxnic.net> wrote:
> On Thu, 2 Sep 2010, A Large Angry SCM wrote:
>
>> On 09/02/2010 12:41 PM, Nicolas Pitre wrote:
>>
>> > For example, right now you already can't rely on having the exact =
same
>> > pack output even on the same machine using the same arguments and =
the
>> > same inputs simply by using threads. =C2=A0As soon as you're using=
 more than
>> > one thread (most people do these days) then your pack output becom=
es non
>> > deterministic.
>>
>> Finally, the real pack expert weighs in!
>
> BTW I just have a little time to quickly scan through my git mailing
> list backlog these days, and stumbled on this by luck. =C2=A0So if pe=
ople
> want my opinion on such matters it is safer to CC me directly.

 appreciated nicolas.  will keep it short.  ish :)

 * based on what you kindly mentioned about "git repack -f", would a
(well-written!) patch to git pack-objects to add a
"--single-thread-only" option be acceptable?

 * would you, or anyone else with enough knowledge of how this stuff
reaallly works, be willing to put some low-priority back-of-mind
thought into how to create a "canonical" pack format - one that can be
enabled with a command-line-option?  the reason i ask is because if i
even attempted such a task, i'd die of laughing (probably manically)
if it was ever accepted.  i'd rather live :)


 questions (not necessarily for nicolas) - can anyone think of any
good reasons _other_ than for multiple file-sharing to have a
"canonical" pack-object?

off the top of my head i can think of one: rsync if the transfer is
interrupted.  if the pack-objects are large - and not guaranteed to be
the same - then an interrupted rsync transfer would be a bit of a
waste of bandwidth.  however if the pack-object could always be made
the same, the partial transfer could carry on.   musing a bit
further... mmm... i supooose the same thing applies equally to http
and ftp.  it's a bit lame, i know: can anyone think of any better
reasons?

l.
