From: Erik Faye-Lund <kusmabite@gmail.com>
Subject: Re: GIT get corrupted on lustre
Date: Wed, 23 Jan 2013 16:54:44 +0100
Message-ID: <CABPQNSaNmuXEn6hNd_xH01oCoykBs_y85=0bigmDBDH3Aazj2g@mail.gmail.com>
References: <50D861EE.6020105@giref.ulaval.ca> <50D870A0.90205@interlinx.bc.ca>
 <50EC453A.2060306@giref.ulaval.ca> <50EDDF12.3080800@giref.ulaval.ca>
 <50F7F793.80507@giref.ulaval.ca> <CAGK7Mr4R=OwfWt4Kat75C8YDi3iLTavMLxeoLxkf1-gKhxrucg@mail.gmail.com>
 <50F8273E.5050803@giref.ulaval.ca> <871B6C10EBEFE342A772D1159D1320853A042AD7@umechphj.easf.csd.disa.mil>
 <50F829A9.7090606@calculquebec.ca> <871B6C10EBEFE342A772D1159D1320853A044B42@umechphj.easf.csd.disa.mil>
 <50F98B53.9080109@giref.ulaval.ca> <CABPQNSbJr4dR9mq+kCwGe-RKb9PA7q=SKzbFW+=md_PLzZh=nQ@mail.gmail.com>
 <87a9s2o6ri.fsf@pctrast.inf.ethz.ch> <kdk2ss$498$1@ger.gmane.org>
 <87r4lejpx8.fsf@pctrast.inf.ethz.ch> <50FF051D.5090804@giref.ulaval.ca>
 <878v7keuh3.fsf@pctrast.inf.ethz.ch> <CABPQNSad1EKbmt3Gjs+uB9fud4YBqmk++5GMqF2s047Lcc8GwQ@mail.gmail.com>
 <87d2wvc3v0.fsf@pctrast.inf.ethz.ch> <CABPQNSb89h28O_a3uVoVrNisZqPcHHVFm8nP7GdFGCb=PVdcsQ@mail.gmail.com>
 <871udbc3af.fsf@pctrast.inf.ethz.ch>
Reply-To: kusmabite@gmail.com
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Cc: Thomas Rast <trast@student.ethz.ch>,
	Eric Chamberland <Eric.Chamberland@giref.ulaval.ca>,
	"Brian J. Murrell" <brian@interlinx.bc.ca>, git@vger.kernel.org,
	"Pyeron, Jason J CTR (US)" <jason.j.pyeron.ctr@mail.mil>,
	Maxime Boissonneault <maxime.boissonneault@calculquebec.ca>,
	Philippe Vaucher <philippe.vaucher@gmail.com>,
	=?ISO-8859-1?Q?S=E9bastien_Boisvert?= 
	<sebastien.boisvert@calculquebec.ca>
To: Thomas Rast <trast@inf.ethz.ch>
X-From: git-owner@vger.kernel.org Wed Jan 23 16:55:50 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Ty2fy-0000eq-Uh
	for gcvg-git-2@plane.gmane.org; Wed, 23 Jan 2013 16:55:47 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754584Ab3AWPzZ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 23 Jan 2013 10:55:25 -0500
Received: from mail-ia0-f169.google.com ([209.85.210.169]:43800 "EHLO
	mail-ia0-f169.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753105Ab3AWPzY (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 23 Jan 2013 10:55:24 -0500
Received: by mail-ia0-f169.google.com with SMTP id j5so4197402iaf.0
        for <git@vger.kernel.org>; Wed, 23 Jan 2013 07:55:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=x-received:mime-version:reply-to:in-reply-to:references:from:date
         :message-id:subject:to:cc:content-type;
        bh=h28RMOtt0aWWAf0gS2lVR3zIc5rMxRqb2KEIOBfkR+k=;
        b=dZeeLL24d2DQ6vwuzAVOq/AujA2IV+RQwdSiarrV0MsMY2ATdGO0BRyAnSOjm4ThwC
         1z1maK+Xezwi07vtxuGxmYNaToikrOfZxjurivpTQVqdy9HQTU75nCHRtkSz5g73up4Z
         QUnORsExUCW7djOhqqBoUon8f6oSycJwz+v8kd/NvQ3WJ3E4ebaE86G2aIDza6oJ/BYt
         QXfV6MdvmDTzjChimggJLjd4LlRmlIwNmPSsy0pGWmUQ4/hc+RFHGoY6fmsblqSpE4sM
         Q16meAxC9nXWTAOp5RQ1PTr40iW0Zw3l6SJGngHAEa0KQCgC7/izKT084enKn0kj0NCZ
         /BtQ==
X-Received: by 10.50.197.161 with SMTP id iv1mr15548372igc.53.1358956524256;
 Wed, 23 Jan 2013 07:55:24 -0800 (PST)
Received: by 10.64.9.112 with HTTP; Wed, 23 Jan 2013 07:54:44 -0800 (PST)
In-Reply-To: <871udbc3af.fsf@pctrast.inf.ethz.ch>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/214331>

On Wed, Jan 23, 2013 at 4:44 PM, Thomas Rast <trast@inf.ethz.ch> wrote:
> Erik Faye-Lund <kusmabite@gmail.com> writes:
>
>> On Wed, Jan 23, 2013 at 4:32 PM, Thomas Rast <trast@student.ethz.ch> wrote:
>>> Erik Faye-Lund <kusmabite@gmail.com> writes:
>>>
>>>> POSIX allows error codes
>>>> to be generated other than those defined. From
>>>> http://pubs.opengroup.org/onlinepubs/009695399/functions/xsh_chap02_03.html:
>>>>
>>>> "Implementations may support additional errors not included in this
>>>> list, *may generate errors included in this list under circumstances
>>>> other than those described here*, or may contain extensions or
>>>> limitations that prevent some errors from occurring."
>>>
>>> That same page says, however:
>>>
>>>   For functions under the Threads option for which [EINTR] is not listed
>>>   as a possible error condition in this volume of IEEE Std 1003.1-2001,
>>>   an implementation shall not return an error code of [EINTR].
>>
>> Yes, but surely that's for pthreads functions, no? utime is not one of
>> those functions...
>
> Ah, my bad.  In fact in
>
>   http://pubs.opengroup.org/onlinepubs/9699919799/xrat/V4_xsh_chap02.html
>
> there is a paragraph "Signal Effects on Other Functions", which says
>
> <snip>
>
> Taken together this should mean that the bug is in fact simply that the
> calls do not *restart*.  They are (like you say) allowed to return EINTR
> despite not being specified to, *but* SA_RESTART should restart it.
>

Right, thanks for clearing that up.

> Now, does that make it a lustre bug or a glibc bug? :-)

That's kind of uninteresting, the important bit is that it is indeed a
bug (outside of Git).
