From: Luke Kenneth Casson Leighton <luke.leighton@gmail.com>
Subject: Re: git pack/unpack over bittorrent - works!
Date: Sun, 5 Sep 2010 18:22:59 +0100
Message-ID: <AANLkTikgiO21M7a7Ovz5nB2kW60dE7wQe5gc-4O+wbER@mail.gmail.com>
References: <B757A854-C7BF-4CBF-9132-91D205344606@mit.edu>
	<7voccezr7m.fsf@alter.siamese.dyndns.org>
	<20100903183120.GA4887@thunk.org>
	<alpine.LFD.2.00.1009031522590.19366@xanadu.home>
	<04755B03-EE1D-48FA-8894-33AA8E2661C0@mit.edu>
	<alpine.LFD.2.00.1009040040030.19366@xanadu.home>
	<5B5470E5-57E6-48D2-981B-CE77FA43546F@mit.edu>
	<AANLkTi==yv2CkgKEPJbTLf0P2XMtLmny1t6Zqhwh8wbV@mail.gmail.com>
	<20100904181405.GB4887@thunk.org>
	<AANLkTikAfSrfKRaK3ozXV_eT6Rd-VRbXQUQLk3SY8QnJ@mail.gmail.com>
	<20100904224139.GD4887@thunk.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Nicolas Pitre <nico@fluxnic.net>,
	Junio C Hamano <gitster@pobox.com>, git <git@vger.kernel.org>
To: "Ted Ts'o" <tytso@mit.edu>
X-From: git-owner@vger.kernel.org Sun Sep 05 19:23:11 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OsIvr-0003vB-Rw
	for gcvg-git-2@lo.gmane.org; Sun, 05 Sep 2010 19:23:08 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753992Ab0IERXB convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sun, 5 Sep 2010 13:23:01 -0400
Received: from mail-vw0-f46.google.com ([209.85.212.46]:42504 "EHLO
	mail-vw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753645Ab0IERXA convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 5 Sep 2010 13:23:00 -0400
Received: by vws3 with SMTP id 3so2713374vws.19
        for <git@vger.kernel.org>; Sun, 05 Sep 2010 10:23:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:received:in-reply-to
         :references:date:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=3sjq1eCaVVh7WXaI3FGzIcHZ4HnHr7HJLe3bdJckwsA=;
        b=RLVxI74MhKVqNrQhsJWRer/65FAiDE4R/60jtFoBNqr/SHzufwjhFfJwv1bervXhsb
         VOOT1gyUARj//E6huk2coapO/69H+3pbE/Kn35b+FOM6uCCewzo/iZ8aAz8gjbHGhrUP
         dax2jSflzfR3L1qp4dcEEf1zLSDcp0I7mL1h8=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=xMAkPCjocu+qfFOA9T5P4nlKySU5M8XtZx34GMVE2aquqO69p8E5C320aH9fpEE3es
         qzsWC0ds1/iAvfzWLEZ8Nx59yDTxN+xRd43jxTzpzphJhROMymjqwCNthfKPl0L+hBzv
         yGRCEtrymJfQXcPK1SnPh7QHW+tYY4PaO03lM=
Received: by 10.220.62.202 with SMTP id y10mr511760vch.58.1283707379964; Sun,
 05 Sep 2010 10:22:59 -0700 (PDT)
Received: by 10.220.98.8 with HTTP; Sun, 5 Sep 2010 10:22:59 -0700 (PDT)
In-Reply-To: <20100904224139.GD4887@thunk.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/155462>

On Sat, Sep 4, 2010 at 11:41 PM, Ted Ts'o <tytso@mit.edu> wrote:
> On Sat, Sep 04, 2010 at 09:00:56PM +0100, Luke Kenneth Casson Leighto=
n wrote:
>> > Which brings me back to my original question --- what problem exac=
tly
>> > are you trying to solve? =C2=A0What's the scenario?
>>
>> i described those in prior messages. =C2=A0to summarise: they're bas=
ically
>> reduction of dependence on centralised infrastructure, and to allow
>> developers to carry on doing code-sprints using bugtrackers, wikis a=
nd
>> anything else that can be "git-able" as its back-end, _even_ in the
>> cases where there is little or absolutely no bandwidth... and _still=
_
>> sync up globally once any one of the developers gets back online.
>
> So at all of the code sprints I've been at, the developers all have
> locally very good bandwidth between each other. =C2=A0And if they don=
't

 ted - with respect, much as i'd like to debate the merits or
otherwise of the purpose of this work, i'd far rather actually focus
on actually doing it. can i leave it to you and the other people here
on the list to debate both sides - actually three sides because there
is a case for helping casey to get "git hive" going, as well?

 i look forward to seeing lots more ideas and use-cases beyond those
which i can envisage, and am grateful to the people who have been
privately contacting me to express gratitude at potentially having
something which makes software development and free software
involvement easier, in circumstance such as difficult or expensive
internet connectivity.

 l.
