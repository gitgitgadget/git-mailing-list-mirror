From: Mark Lodato <lodatom@gmail.com>
Subject: Re: master^ is not a local branch -- huh?!?
Date: Fri, 29 Jan 2010 21:40:03 -0500
Message-ID: <ca433831001291840o751fa02eve1ae301537674325@mail.gmail.com>
References: <ron1-2E17EF.12204629012010@news.gmane.org> <7viqakh8ty.fsf@alter.siamese.dyndns.org> 
	<alpine.LFD.2.00.1001291716070.1681@xanadu.home> <7vaavwh6yh.fsf@alter.siamese.dyndns.org> 
	<alpine.LFD.2.00.1001291833580.1681@xanadu.home> <7vy6jgcutb.fsf@alter.siamese.dyndns.org> 
	<fabb9a1e1001291618m71f61209v4f26fb66c6ad99ae@mail.gmail.com> 
	<7viqakcu56.fsf@alter.siamese.dyndns.org> <ca433831001291701m50b8c2b7p16bcc6fd4f3f3d55@mail.gmail.com> 
	<alpine.LFD.2.00.1001292013150.1681@xanadu.home>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio C Hamano <gitster@pobox.com>,
	Sverre Rabbelier <srabbelier@gmail.com>,
	Git List <git@vger.kernel.org>, Ron1 <ron1@flownet.com>,
	Jacob Helwig <jacob.helwig@gmail.com>
To: Nicolas Pitre <nico@fluxnic.net>
X-From: git-owner@vger.kernel.org Sat Jan 30 03:41:21 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Nb3Gx-0004wI-VS
	for gcvg-git-2@lo.gmane.org; Sat, 30 Jan 2010 03:41:20 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756172Ab0A3Ck0 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 29 Jan 2010 21:40:26 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756166Ab0A3Ck0
	(ORCPT <rfc822;git-outgoing>); Fri, 29 Jan 2010 21:40:26 -0500
Received: from mail-px0-f182.google.com ([209.85.216.182]:44377 "EHLO
	mail-px0-f182.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755787Ab0A3CkZ convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 29 Jan 2010 21:40:25 -0500
Received: by pxi12 with SMTP id 12so2229386pxi.33
        for <git@vger.kernel.org>; Fri, 29 Jan 2010 18:40:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :from:date:message-id:subject:to:cc:content-type
         :content-transfer-encoding;
        bh=zCGZWrJPiUJ9+FPTx/NunOnpzv1svEnJrdUBuhOXGf8=;
        b=F10tVWtcxOCvDT/mdvNmysyXDm9ZjRExFCAEQX9zrUzhdKVYHdO2SnaEAQ2iiQA0iW
         KAF9CtTCH/8AnxIZchbxA8aDmUhGD4xMTqNr4JUrQI4JkAOUnTfLT+ybQf1R4KlEBK1o
         4DXldAvJu+4g0RU4pFAtp5eitAvK9p2YBjvMQ=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type:content-transfer-encoding;
        b=KtZZa2HT/6dlfJ96FMGiE71frLNi9Hij+5BZua2qes7sXrE/1nFMTfbagr2fCWRmzI
         okLCIasKpvzPqk7sVsn6bi83oQmkbk/+QBGrzjLuXyMsvEEVnbr4HfH3fEzmHdwL3h89
         98YW9XFfxCBbqelLx+8TgW13xftTmlrYS/N4U=
Received: by 10.114.3.2 with SMTP id 2mr1085361wac.156.1264819223082; Fri, 29 
	Jan 2010 18:40:23 -0800 (PST)
In-Reply-To: <alpine.LFD.2.00.1001292013150.1681@xanadu.home>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/138427>

On Fri, Jan 29, 2010 at 8:22 PM, Nicolas Pitre <nico@fluxnic.net> wrote=
:
> On Fri, 29 Jan 2010, Mark Lodato wrote:
>
>> Still, I find it slightly confusing and unfriendly. =C2=A0How about =
the following?
>
> It is slightly inaccurate.

Is the following the only inaccuracy?  Do you have any other feedback?

>> Checking out commit 'master^0'.
>>
>> Since this is not a local branch head, any commits you make will be =
lost
>> when you check out another branch or commit. =C2=A0(In git terminolo=
gy, HEAD
>> is detached.) =C2=A0If you just wish to look at files without commit=
ting,
>> this is fine. =C2=A0If you wish to make commits and retain them, you=
 may
>> create a new branch by running:
>>
>> =C2=A0 git checkout -b <new_branch_name>
>
> This gives the impression that any commit you make on a detached HEAD
> are going to be lost, unless you create a new branch first.

What about "...you may want to create..."?  This does not imply that
creating a new branch now is the *only* way, just the most likely.  If
a user knows another way, that user probably does not need this
warning in the first place.
