From: Michael Witten <mfwitten@gmail.com>
Subject: Re: [PATCH RFC 6/6] send-email: Remove horrible mix of tabs and 
	spaces
Date: Tue, 7 Apr 2009 16:42:36 -0500
Message-ID: <b4087cc50904071442ka298564x52112c1eac9ac284@mail.gmail.com>
References: <1239139522-24118-1-git-send-email-mfwitten@gmail.com>
	 <1239139522-24118-2-git-send-email-mfwitten@gmail.com>
	 <1239139522-24118-3-git-send-email-mfwitten@gmail.com>
	 <1239139522-24118-4-git-send-email-mfwitten@gmail.com>
	 <1239139522-24118-5-git-send-email-mfwitten@gmail.com>
	 <1239139522-24118-6-git-send-email-mfwitten@gmail.com>
	 <9b18b3110904071435p320e5d1dh16061d04a3a8ab57@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: demerphq <demerphq@gmail.com>
X-From: git-owner@vger.kernel.org Tue Apr 07 23:44:19 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LrJ5b-00080q-Ql
	for gcvg-git-2@gmane.org; Tue, 07 Apr 2009 23:44:16 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1761872AbZDGVmj convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 7 Apr 2009 17:42:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1761862AbZDGVmj
	(ORCPT <rfc822;git-outgoing>); Tue, 7 Apr 2009 17:42:39 -0400
Received: from qw-out-2122.google.com ([74.125.92.24]:42798 "EHLO
	qw-out-2122.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1761665AbZDGVmi convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 7 Apr 2009 17:42:38 -0400
Received: by qw-out-2122.google.com with SMTP id 8so3223970qwh.37
        for <git@vger.kernel.org>; Tue, 07 Apr 2009 14:42:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :date:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=wvFluc+YsGU1Oz001VZWIw7PHNXetKWbCZSgpp1/eNQ=;
        b=TIsj2MQOTs4Ldx38bz1aD9UHR/894KTVl5b46WrKTPPxvwfIXQ8q8Ymy1lAi0D4Spv
         Buax3tJ1A5y/dQMz0Y66a2TbN9AiirKxomehQuG1+CqNymOsu6uybKPj3NsS6VthI7+p
         HL05YzNl0LGJE1XRjLAbunCaeevZbsNX6bnGs=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=SjIApitL0o2SMJC863cCOx907fgI6wV+b732FSafvQo4+lnzD8gJ7hRyiIuQOp+sg0
         /RtgYbUE65nk9jwtc+HdUEacv7dasa58MgOYWEPFfq+PqO8fx+3ROlbmDp01zq+NtkPJ
         Lx9hngv1DXfNT4yeFYoP4uNYsOeY68gbY3zyg=
Received: by 10.224.28.199 with SMTP id n7mr1008994qac.90.1239140556870; Tue, 
	07 Apr 2009 14:42:36 -0700 (PDT)
In-Reply-To: <9b18b3110904071435p320e5d1dh16061d04a3a8ab57@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/115996>

On Tue, Apr 7, 2009 at 16:35, demerphq <demerphq@gmail.com> wrote:
> 2009/4/7 Michael Witten <mfwitten@gmail.com>:
>> +## WARNING! ACHTUNG! ATTENTION! ADVERTENCIA!
>> +## =A0 Currently, this file uses tabs (like the rest of git source)=
 to
>> +## =A0 delineate code structure. Do NOT under any circumstances mix=
 tabs
>> +## =A0 and spaces across lines that share a relationship in terms o=
f layout.
>> +## =A0 In fact, it would currently be best to use only tabs, so ple=
ase set
>> +## =A0 your editor(s) accordingly. This code is already trashy enou=
gh. Please
>> +## =A0 don't make it worse.
>
> Perltidy the file?
>
> Yves

Oooh, that's sexy!

I'll have to give that a try. However, I've been entertaining the idea
of rewriting the whole thing anyway; it's in need of much more than
reformatting.

As a side note, Yves, I sent the patches to perl5-porters again about
1.6666666 hours ago, but nothing seems to have come through; I'll try
again later.

Michael
