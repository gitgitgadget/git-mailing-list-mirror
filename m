From: Lars Hjemli <hjemli@gmail.com>
Subject: Re: [feature request] gitweb: tags in history
Date: Sat, 21 Aug 2010 20:50:40 +0200
Message-ID: <AANLkTim=Qj1zco8j-3rAbgwsutfFO6_ikihpYKFtd7R5@mail.gmail.com>
References: <20100821092616.5e57135b@hyperion.delvare>
	<20100821111555.11879d02@hyperion.delvare>
	<AANLkTi=JHzQm4hm-nuTyZq2CL_2z785KtMvVcmaqtgyF@mail.gmail.com>
	<201008211921.22495.jnareb@gmail.com>
	<AANLkTik+NBvdVkN-TvC_F5MWGZrtgEZMPOXr=Tsr1eA_@mail.gmail.com>
	<20100821200707.6cca565e@hyperion.delvare>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Jakub Narebski <jnareb@gmail.com>,
	Git mailing list <git@vger.kernel.org>
To: Jean Delvare <khali@linux-fr.org>
X-From: git-owner@vger.kernel.org Sat Aug 21 20:50:59 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Omt9e-00086A-EY
	for gcvg-git-2@lo.gmane.org; Sat, 21 Aug 2010 20:50:58 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752019Ab0HUSun convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sat, 21 Aug 2010 14:50:43 -0400
Received: from mail-fx0-f46.google.com ([209.85.161.46]:39463 "EHLO
	mail-fx0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751822Ab0HUSum convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Sat, 21 Aug 2010 14:50:42 -0400
Received: by fxm13 with SMTP id 13so2340679fxm.19
        for <git@vger.kernel.org>; Sat, 21 Aug 2010 11:50:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:received:in-reply-to
         :references:date:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=NtK7gOztzmkEBhUnQUZp3vDv7NOVzAIaE6m4fqATD6w=;
        b=hrNBfuOediGqd5zUwg3hgGX1xYh1XRw0NYnUYWhlFzsYYAjNTzmqJxnUXojty+OREs
         zJt+EcHJ885TBNwEbgOLiIRGThE4EhcNA0Q60Nui0eNeNPlBA/+H6ca+cW+Ymfnh8LD4
         cvKrxqohBvTyWELYVliWZmgG17xYJRKBaM7rE=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=s8ymN/gV/2ZtZFKSKwB/rQzlU/luApvYGRhziT/mdjPJgyas9LYG5JQSMNhZBcPNTY
         QYQj4goCBAMKs+EbsDPQrcGdcOH38otfZDhQGIF5AThceU4elh7PjtgBCtM43PcZydfc
         tPUx4EbaWdNgndlvQ9mmaRz84dCZXFICZc1Ig=
Received: by 10.239.172.67 with SMTP id z3mr136734hbe.92.1282416640497; Sat,
 21 Aug 2010 11:50:40 -0700 (PDT)
Received: by 10.239.180.20 with HTTP; Sat, 21 Aug 2010 11:50:40 -0700 (PDT)
In-Reply-To: <20100821200707.6cca565e@hyperion.delvare>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/154151>

On Sat, Aug 21, 2010 at 20:07, Jean Delvare <khali@linux-fr.org> wrote:
> On Sat, 21 Aug 2010 19:47:12 +0200, Lars Hjemli wrote:
>> On Sat, Aug 21, 2010 at 19:21, Jakub Narebski <jnareb@gmail.com> wro=
te:
>> > Lars Hjemli wrote:
>> >> <shameless plug>
>> >> With cgit, you can answer such questions by combining path limiti=
ng
>> >> and range queries, e.g.
>> >> http://hjemli.net/git/cgit/log/scan-tree.c?qt=3Drange&q=3Dv0.8.2.=
=2Ev0.8.3
>> >> shows all commits affecting scan-tree.c between v0.8.2 and v0.8.3=
=2E
>> >> Maybe gitweb could implement something similar?
>> >> </shameless plug>
>> >
>> > Gitweb also supports range limiting in log-like views from some ti=
me,
>> > but currently there is no UI for that, and you have to handcraft t=
he URL,
>> > e.g.:
>> >
>> > =C2=A0http://gitweb.example.com/repo.git?a=3Dhistory;f=3Dfoo.c;hpb=
=3Dv0.8.2;hb=3Dv0.8.3
>> >
>> > or (in the path_info form)
>> >
>> > =C2=A0 =C2=A0http://gitweb.example.com/repo.git/history/v0.8.2..v0=
=2E8.3:/foo.c
>>
>> Nice, I didn't know gitweb supported this - maybe it's all Jean need=
s?
>
> Well, as long as there is no UI for it, it's not too useful: I'm can
> run git on the command line for the same result (with git log.)
>
> Also, it doesn't exactly suits my needs. I don't necessarily know in
> advance the range in which the change happened. Quite often, the
> question I have to answer is the other way around, that is: when did =
a
> given change happen? Sometimes I know the commit ID and I can just ca=
ll
> "git name-rev" (although it's somewhat slow and the output isn't
> friendly), but sometimes I don't know even that, and this is when I'd
> like to be able to just browse the history for a given file with
> all relevant tags printed. This also gives a more general picture
> of what happened to the file over time immediately, which is sometime=
s
> useful.

Ok, this fundamentally does not mix well with the kind of output which
gitweb/cgit generates (linear list of commits) - you'll need
--topo-order and a visual indication of "branch timelines", i.e. gitk.

--=20
larsh
