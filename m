From: Johnny Lee <johnnylee194@gmail.com>
Subject: Re: [Question] Why sometimes the unmerged file doesn't contains any 
	conflicts
Date: Mon, 13 Apr 2009 11:43:52 +0800
Message-ID: <488807870904122043q5bf3884fu1012446e1e71c048@mail.gmail.com>
References: <488807870904121935nab40117n56070570ecd31aa7@mail.gmail.com>
	 <7vk55pxoax.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon Apr 13 05:45:29 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LtD6t-00035A-TS
	for gcvg-git-2@gmane.org; Mon, 13 Apr 2009 05:45:28 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754019AbZDMDnz convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sun, 12 Apr 2009 23:43:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753434AbZDMDny
	(ORCPT <rfc822;git-outgoing>); Sun, 12 Apr 2009 23:43:54 -0400
Received: from yw-out-2324.google.com ([74.125.46.30]:31556 "EHLO
	yw-out-2324.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753404AbZDMDnx convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 12 Apr 2009 23:43:53 -0400
Received: by yw-out-2324.google.com with SMTP id 5so2049631ywb.1
        for <git@vger.kernel.org>; Sun, 12 Apr 2009 20:43:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :date:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=DM2hPRb2kL1NSlEEG7O0VgvuDPnx0b3etn2tCqGTqpY=;
        b=iWn+Tu3aag0A9WiqHMcIhW7w/hhR1GfgMte+E5tiea5Rjk2ZSfVdHwtmj0lCk82vDQ
         KmntZ2eXVe3+2Hmu1Rg+iUtjzPksGV4EbW4yICUhRZUPk1eSztbryJzHqJHxBFIhs4W9
         NyWlWi1A9VQcI3yHljdi/w1zkJKtmC51QYGzQ=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=GjCRg5YP2A8TOR69bxDzOAOehkqIVB5UZujMoXTcFR/qM+zmGqMUlLxUcegaSN4DCw
         1Gvsqnz8X03QMtZpm0caXBTkmA0TnsFfGqSSm6kMAJSHcmCaNNC2pFUuILQdDiz9XuZ0
         ZDF23Q2XgwMcKsmP+Y+rcJHsMNEsubSDABpYI=
Received: by 10.151.6.15 with SMTP id j15mr12098083ybi.60.1239594232283; Sun, 
	12 Apr 2009 20:43:52 -0700 (PDT)
In-Reply-To: <7vk55pxoax.fsf@gitster.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/116407>

I didn't see the log of "Resolved '%s' using previous resolution.".
I'm must having the latter situation.

Thanks Junio for pointing this out for me.

Cheers,
Johnny

On Mon, Apr 13, 2009 at 10:47 AM, Junio C Hamano <gitster@pobox.com> wr=
ote:
> Johnny Lee <johnnylee194@gmail.com> writes:
>
>> Sometimes when I merge two branches, the unmerged files don't contai=
n
>> any conflicts.
>> When I edit the file, I can't find any conflict information. Usually
>> all I have to do is manually "git add" them.
>>
>> I do the merge with a clean workspace, all changes have been committ=
ed.
>> This doesn't happen all the time, usually the unmerged files contain=
s
>> the correct conflict information inside.
>>
>> Do you know what's going on here?
>> The version of my git is: 1.6.2.1
>
> Do you see something like these output when it happens? =A0If that is=
 what
> is happening to you, then it is perfectly normal, and the command eve=
n
> gives explanations on what it did to you. =A0The only thing you need =
to do
> is to read them ;-).
>
> =A0 =A0$ git merge lt/pack-object-memuse
> =A0 =A0Auto-merging builtin-pack-objects.c
> =A0 =A0CONFLICT (content): Merge conflict in builtin-pack-objects.c
> =A0 =A0Auto-merging builtin-rev-list.c
> =A0 =A0CONFLICT (content): Merge conflict in builtin-rev-list.c
> =A0 =A0Auto-merging list-objects.c
> =A0 =A0CONFLICT (content): Merge conflict in list-objects.c
> =A0 =A0Auto-merging list-objects.h
> =A0 =A0CONFLICT (content): Merge conflict in list-objects.h
> =A0 =A0Auto-merging revision.c
> =A0 =A0Auto-merging revision.h
> =A0 =A0Auto-merging upload-pack.c
> =A0 =A0CONFLICT (content): Merge conflict in upload-pack.c
> =A0 =A0Resolved 'builtin-pack-objects.c' using previous resolution.
> =A0 =A0Resolved 'builtin-rev-list.c' using previous resolution.
> =A0 =A0Resolved 'list-objects.c' using previous resolution.
> =A0 =A0Resolved 'list-objects.h' using previous resolution.
> =A0 =A0Resolved 'upload-pack.c' using previous resolution.
> =A0 =A0Automatic merge failed; fix conflicts and then commit the resu=
lt.
>
> Notice the last set of lines "Resolved '%s' using previous resolution=
=2E"
>
> Another possibility is the common ancestor of the two branches did no=
t
> have the file in question and you added the same file on each of thes=
e
> branches in a non-conflicting way. =A0That sometimes suggests a bad
> workflow, but in an environment where two people independently pick u=
p the
> same patch on their branches and you end up merging with these two pe=
ople,
> it is also perfectly normal.
>
>



--=20
we all have our crosses to bear
