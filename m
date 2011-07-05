From: Ramkumar Ramachandra <artagnon@gmail.com>
Subject: Re: [PATCH 12/13] revert: Introduce skip-all to cleanup sequencer data
Date: Tue, 5 Jul 2011 16:17:06 +0530
Message-ID: <CALkWK0mfoPOc5bgWBHwCR3+kZRyJWcQVnHgA12COoQimsrh3Vg@mail.gmail.com>
References: <1308661489-20080-1-git-send-email-artagnon@gmail.com>
 <1308661489-20080-13-git-send-email-artagnon@gmail.com> <7vtybj6ji2.fsf@alter.siamese.dyndns.org>
 <BANLkTimy17b-F7eg+R9ReRUrx0rhA1cumg@mail.gmail.com> <buowrfy8wtt.fsf@dhlpc061.dev.necel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio C Hamano <gitster@pobox.com>, Git List <git@vger.kernel.org>,
	Jonathan Nieder <jrnieder@gmail.com>,
	Christian Couder <chriscool@tuxfamily.org>,
	Daniel Barkalow <barkalow@iabervon.org>
To: Miles Bader <miles@gnu.org>
X-From: git-owner@vger.kernel.org Tue Jul 05 12:47:33 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Qe3AD-0008DN-6A
	for gcvg-git-2@lo.gmane.org; Tue, 05 Jul 2011 12:47:33 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755566Ab1GEKr2 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 5 Jul 2011 06:47:28 -0400
Received: from mail-wy0-f174.google.com ([74.125.82.174]:39406 "EHLO
	mail-wy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754772Ab1GEKr1 convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 5 Jul 2011 06:47:27 -0400
Received: by wyg8 with SMTP id 8so3895056wyg.19
        for <git@vger.kernel.org>; Tue, 05 Jul 2011 03:47:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type:content-transfer-encoding;
        bh=drMI49BRRtKXj8iscnryoiJEjpQw43+ALZUVuMsd/Cg=;
        b=BNMS1HPxBK8UBeq6u/5RJORhGIU+ejDyx3lOcpm5i5pWFmKfRn6lirbCCW+A+NKRw+
         NMT/V5Ci93ozuoGjkwNsMzip4/iak2jI2wxseAiPSni92fiCZAeE8cJlJGRoLC2/E61Z
         WpvjjukunNOytc3TqaQsFmxW+i3aKRbYBSPrs=
Received: by 10.216.233.211 with SMTP id p61mr5835253weq.107.1309862846071;
 Tue, 05 Jul 2011 03:47:26 -0700 (PDT)
Received: by 10.216.175.198 with HTTP; Tue, 5 Jul 2011 03:47:06 -0700 (PDT)
In-Reply-To: <buowrfy8wtt.fsf@dhlpc061.dev.necel.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/176610>

Hi Miles,

Miles Bader writes:
> Ramkumar Ramachandra <artagnon@gmail.com> writes:
>> Interesting side note: I'd initially wanted to use "skip_all" and
>> "continue", but "continue" is a C keyword. =C2=A0That's why I'd relu=
ctantly
>> suffixed "_oper" to both for consistency.
>
> It seems a good idea to restrict such uglification to only those case=
s
> where it's necessary, not make _everything_ ugly just for the sake of
> consistency.....
>
> [The traditional thing to do with C-keyword conflicts, when there's n=
o
> obvious and natural alternative, seems to just be intentional mispell=
ing
> -- "continu", "kontinue", "cont", "_continue", whatever. =C2=A0Yes, t=
hey're
> ugly, but people will know why you did it, and they'll forgive you.]

Interesting.  Are there such examples in the Git codebase as well?

-- Ram
