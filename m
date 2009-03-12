From: Felipe Contreras <felipe.contreras@gmail.com>
Subject: Re: [PATCH v2] git-clone: Add option --branch to override initial 
	branch
Date: Thu, 12 Mar 2009 11:12:16 +0200
Message-ID: <94a0d4530903120212m360c1db8y763b69bc8610ae64@mail.gmail.com>
References: <alpine.DEB.1.00.0903030047130.10279@pacific.mpi-cbg.de>
	 <1236040414-19089-1-git-send-email-torarnv@gmail.com>
	 <7vbpsh93q5.fsf@gitster.siamese.dyndns.org>
	 <loom.20090309T143413-334@post.gmane.org>
	 <94a0d4530903090901o6e8c2a40k676387f90ee461b3@mail.gmail.com>
	 <4d8e3fd30903110152m1b52de30ge630d6b9f6a4c7fe@mail.gmail.com>
	 <buoocw7s79y.fsf@dhlpc061.dev.necel.com>
	 <4d8e3fd30903120148u52164fe3offe665bf70ef6d8d@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Miles Bader <miles@gnu.org>, git@vger.kernel.org,
	torarnv@gmail.com, Junio C Hamano <gitster@pobox.com>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>
To: Paolo Ciarrocchi <paolo.ciarrocchi@gmail.com>
X-From: git-owner@vger.kernel.org Thu Mar 12 10:14:52 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Lhgz9-00055V-2C
	for gcvg-git-2@gmane.org; Thu, 12 Mar 2009 10:13:51 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751690AbZCLJMV convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 12 Mar 2009 05:12:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751459AbZCLJMT
	(ORCPT <rfc822;git-outgoing>); Thu, 12 Mar 2009 05:12:19 -0400
Received: from fg-out-1718.google.com ([72.14.220.159]:43173 "EHLO
	fg-out-1718.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751156AbZCLJMT convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 12 Mar 2009 05:12:19 -0400
Received: by fg-out-1718.google.com with SMTP id 16so87393fgg.17
        for <git@vger.kernel.org>; Thu, 12 Mar 2009 02:12:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :date:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=LgRwI/YZ/JeFJDiEq2bsitxi4KL2GXI9OZfsq+B/w+c=;
        b=oDIHfxS7SnKApWT0tRQjbCV5nvjTmHXc3WQS1pZNdTENi6azf0tjSK7V8ZE3B3fYcK
         9kE+UA5BRaP5B1fG4A4oL3aUafdM2We3pAwoYz6urYRBa4Nq3JyWpC+jEp7964Syr7au
         tWtosm0KSglcYFre1RcJ0NnSGDUBz4fIiRjvk=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=NBSGMA1B9JEnwxVdNEFmTXulF2bkyDhW0wKAG7MUBJXb9UkjWbe5yIeQxk0FDL/Wj/
         D2IJ4UW6PamEDRyy3FSu/AKvhSUol6GcZsWzqz65L5QfdXeyHucwQMGabvqQlYTuooKR
         UMpXzj+iELCzVb6w5lJPQ+gUpjSN1aVL0CUCo=
Received: by 10.86.94.11 with SMTP id r11mr6586213fgb.53.1236849136200; Thu, 
	12 Mar 2009 02:12:16 -0700 (PDT)
In-Reply-To: <4d8e3fd30903120148u52164fe3offe665bf70ef6d8d@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/113026>

On Thu, Mar 12, 2009 at 10:48 AM, Paolo Ciarrocchi
<paolo.ciarrocchi@gmail.com> wrote:
> On Thu, Mar 12, 2009 at 5:18 AM, Miles Bader <miles@gnu.org> wrote:
>> Paolo Ciarrocchi <paolo.ciarrocchi@gmail.com> writes:
>>> $ git clone -n URL
>>> $ git checkout -b foo origin/bar
>>>
>>> That being said, I see the following command as an improvement over
>>> the actual GIT UI:
>>>
>>> =C2=A0$ git clone git://URI -b bar
>>
>> Note that in your original advice, foo and bar can be different, and
>> it's not clear to me what "-b bar" should do...
>>
>> Personally I frequently use foo =3D=3D bar (no local master branch),=
 but I
>> think another common pattern is foo !=3D bar, but foo or bar =3D=3D =
"master".
>>
>> Maybe a syntax similar to push, like "-b LOCAL_BR:REMOTE_BR",
>> with "-b BR" being shorthand for "-b BR:BR"?
>
> Yes, makes sense.

+1

--=20
=46elipe Contreras
