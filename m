From: Ralf Thielow <ralf.thielow@googlemail.com>
Subject: Re: fmt-merge-message: add empty line between tag and signature verification
Date: Fri, 25 May 2012 20:35:30 +0200
Message-ID: <CAN0XMO+LH9ZYSAtRVLOPU3p0bP4mryHkML2wi1KhNEui+AL=uA@mail.gmail.com>
References: <alpine.LFD.2.02.1205250850001.19607@i5.linux-foundation.org>
	<7vtxz4tcmn.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Linus Torvalds <torvalds@linux-foundation.org>,
	Git Mailing List <git@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri May 25 20:35:44 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SXzMQ-000442-Ox
	for gcvg-git-2@plane.gmane.org; Fri, 25 May 2012 20:35:39 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932243Ab2EYSfc convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 25 May 2012 14:35:32 -0400
Received: from mail-we0-f174.google.com ([74.125.82.174]:54982 "EHLO
	mail-we0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755961Ab2EYSfb convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 25 May 2012 14:35:31 -0400
Received: by weyu7 with SMTP id u7so752799wey.19
        for <git@vger.kernel.org>; Fri, 25 May 2012 11:35:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        bh=l+2OLsomxyptfe5dWQkk7+8P72M2mynTZf/+778MnIc=;
        b=NyUaGfx3nbBIcdkR9hz1cjQvN6pzJryklcbUQM25igFUks8g7Ri9e69HiKaNK0ItmR
         ntA6z7bcusndTL1DjOZBo1AWBYlM6QFWvoAYI0n6dHVcYSITpsoUz4tDL7IRuUQDwp4a
         PHoUk2rKXGTIoiilFpO67ddl8NsW94WUKvW/77Dc3MrVPWb2NWgbQT6uTQFnsB+h51Z/
         7pmZTJIIryTAL/55C5Y0+FD0ib2AaiDCCUuiy21yDGIl3GW+UKPMFrAfewDzzV3C3UJd
         j0634P1xsmKWs0wtiu5mHxSaw4Lps2sIEJB2leF4YUEYADxQhEuxF5DWnnZcChzlXLvD
         eypg==
Received: by 10.216.135.219 with SMTP id u69mr2483602wei.89.1337970930054;
 Fri, 25 May 2012 11:35:30 -0700 (PDT)
Received: by 10.194.0.132 with HTTP; Fri, 25 May 2012 11:35:30 -0700 (PDT)
In-Reply-To: <7vtxz4tcmn.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/198505>

On Fri, May 25, 2012 at 7:05 PM, Junio C Hamano <gitster@pobox.com> wro=
te:
>> Btw, I'd also like to see the merge notes (notably the conflict file=
 list)
>> before the generated shortlog, but that seems to really not work wit=
h the
>> current fmt-merge-message model. =C2=A0Oh well.
>
> Postponing to assess if such a change is feasible, I am not sure if t=
hat
> ordering makes more sense than the current one. =C2=A0Is the objectiv=
e to more
> strongly motivate people to explain what happened to the conflicts?

IMHO it only makes sense when you have a short list of conflicted files=
=2E
I mostly work on Java projects and when we merge a branch this list can
be very long. This is caused by several tools, different IDEs, differen=
t OSes
and so on and so forth. Anyway...
What I want to see on a merge like this is the shortlog. I only become
interested in
the conflicts if there is an issue in the software caused by a
conflict resolution.
Just my experience on Java projects I'm working on.
