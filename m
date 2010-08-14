From: =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>
Subject: Re: windows smoke tester (was Re: What's cooking in git.git (Aug
 2010, #02; Wed, 11))
Date: Sat, 14 Aug 2010 00:46:54 +0000
Message-ID: <AANLkTimqhESzC6-1WOpmSNoNzr_=9hq4Egi3OMST0jNE@mail.gmail.com>
References: <7vlj8cvi2e.fsf@alter.siamese.dyndns.org>
	<4C63BD9B.6000608@viscovery.net>
	<AANLkTi=9_FPS=zzcZ3ndqcd83KmQ-eVT9JmLbwjiZtXz@mail.gmail.com>
	<AANLkTi=N-fA9r-Akm3_=ucFYew8BhcsQoWM-Z9S8+58C@mail.gmail.com>
	<AANLkTina+62MczLNhXC6VCtz_kQZ_t0+uZ8fH=vTV=XO@mail.gmail.com>
	<4C64308D.8030000@gmail.com>
	<AANLkTikh14FVmE6E78FNRvSG0B_5ZmNcOLSwye4ExNVx@mail.gmail.com>
	<4C647360.50304@gmail.com>
	<AANLkTimp5TSvjcmZG-pGtG6ep3axertqWuooS7e+A3Ow@mail.gmail.com>
	<4C647C85.2080109@gmail.com>
	<AANLkTikuy3q8JrppTr+YPwZHFh2PNk+An2qvdoWiuAJH@mail.gmail.com>
	<4C65E660.9030707@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Johannes Sixt <j.sixt@viscovery.net>, git@vger.kernel.org,
	kusmabite@gmail.com
To: Chris Packham <judge.packham@gmail.com>
X-From: git-owner@vger.kernel.org Sat Aug 14 02:47:07 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Ok4tr-0003zT-Kg
	for gcvg-git-2@lo.gmane.org; Sat, 14 Aug 2010 02:47:03 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756494Ab0HNAq6 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 13 Aug 2010 20:46:58 -0400
Received: from mail-gx0-f174.google.com ([209.85.161.174]:43507 "EHLO
	mail-gx0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753122Ab0HNAq5 convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 13 Aug 2010 20:46:57 -0400
Received: by gxk23 with SMTP id 23so1183728gxk.19
        for <git@vger.kernel.org>; Fri, 13 Aug 2010 17:46:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:received:in-reply-to
         :references:date:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=wbHKYOQ9Na3eWpf7snpaRVbHvfqetrNsvnHv/y02rFM=;
        b=dNxD3RgRpXELDGZIO91zakW5WskTByatVqPj/TOtyUaJQb9bpSA4P2rpevB+3Kz33Y
         vkEZWPLa8nM49sBNhA5wby0+LDDXGN6LdmNe8le9ZmAGx3Ydtzow2Es7iisdN3oSJkzo
         cISWA16nMio5beqjnOhhZcp17+3CSPDpxE418=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=X4aFP8kinoQTU8QABf5odUk7L+HZLsP9lNIMS+fCuCSuczWJp2Ff8M7KZ6PVUEbcik
         u6u9+X+5k9ZknvSrQtaBo1XwnO6ugPMw63sg/6ttqDSe/13Nf2TTdqqzuVoToM392Vms
         uxPQfcGV+JyCsSQVtPkVDlHXZWohEzQhZ95pI=
Received: by 10.231.149.140 with SMTP id t12mr2349853ibv.100.1281746814533;
 Fri, 13 Aug 2010 17:46:54 -0700 (PDT)
Received: by 10.231.186.226 with HTTP; Fri, 13 Aug 2010 17:46:54 -0700 (PDT)
In-Reply-To: <4C65E660.9030707@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/153538>

On Sat, Aug 14, 2010 at 00:42, Chris Packham <judge.packham@gmail.com> =
wrote:
> On 12/08/10 18:01, =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason wrote:
>> If it comes with its own perl it should also have a cpan shell:
>>
>> =C2=A0 =C2=A0 perl -MCPAN -e 'install TAP::Harness::Archive'
>>
>> That should be easier than installing strawberry in addition to the
>> mingw perl.
>
> OK this is me officially giving up on windows (or at least this
> particular windows box).
>
> I couldn't install any perl modules with the environment provided by
> msysgit, I couldn't make msys play nice with strawberry perl. In
> desperation I tried cygwin and again I failed to get any perl modules
> installed (although it did get further than msys).
>
> I think a major part of the problem is the way the box was setup by t=
he
> IT department at work. It has its home drive set to a network share
> which both cygwin and msys pick up on. This seems to cause problems f=
or
> the CPAN module when it tries to download and build stuff there.
>
> I'd like to be able to help, but I lack the windows knowledge to chan=
ge
> any of the setup that was made by the IT team. If I get my hands on
> another windows box with a more standard install I'll give it another
> try. For now, I'm admitting defeat.

Thanks for trying. But since you have perl (but not any modules) I
might try to just produce some self-contained script that smokers can
drop in that has the needed Perl parts.

Can you try this though:

    curl -L http://cpanmin.us | perl --self-upgrade -s

That should install cpanminus, then try to install the archive module.
