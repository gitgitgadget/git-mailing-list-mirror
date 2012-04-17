From: Felipe Contreras <felipe.contreras@gmail.com>
Subject: Re: [PATCH v2] completion: add new git_complete helper
Date: Tue, 17 Apr 2012 19:13:14 +0300
Message-ID: <CAMP44s1sj27U_s3Y3nLL6pkMrPMVvTo982c85x-hH5szvprK0g@mail.gmail.com>
References: <1334524814-13581-1-git-send-email-felipe.contreras@gmail.com>
	<20120415213718.GB5813@burratino>
	<20120416221531.GA2299@goldbirke>
	<CAMP44s2N9wFg5kx7jw2w6G6BQ1riX-W9cKt8kBPaofugm0OV1g@mail.gmail.com>
	<7vty0inys6.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: =?UTF-8?Q?SZEDER_G=C3=A1bor?= <szeder@ira.uka.de>,
	Jonathan Nieder <jrnieder@gmail.com>, git@vger.kernel.org,
	Thomas Rast <trast@student.ethz.ch>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Apr 17 18:13:25 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SKB1u-0004gg-Qa
	for gcvg-git-2@plane.gmane.org; Tue, 17 Apr 2012 18:13:23 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756229Ab2DQQNQ convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 17 Apr 2012 12:13:16 -0400
Received: from mail-ey0-f174.google.com ([209.85.215.174]:41786 "EHLO
	mail-ey0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755863Ab2DQQNQ convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 17 Apr 2012 12:13:16 -0400
Received: by eaaq12 with SMTP id q12so1632789eaa.19
        for <git@vger.kernel.org>; Tue, 17 Apr 2012 09:13:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        bh=eurTvdlDURwYjsUH0CarAkVNKN3X14rCcUYlfqfGYoo=;
        b=gr7VqkAQ/H9q439oSl43ssaDQy1Dz16rzcaHnOXQM0t0apbIeOsLZgwZMUxkHmTOTB
         GvCNd48XL/c60rdYG7pQzDk6GNNnP3E2ky5RzOK2sG09zEOsTc7Rht+z/ktkzMaX9ZJS
         u2OHBOSd94SUJhFUiHMZAr/Pv/EkaZTNhdLSPzyE8StlcDu0NzIyKnFFgCZsQ5VNoCKE
         VYbZuqQ6atsz56SNmFadI+AGYFMfukrRhP81+2AQX0Q78BdyZfWAlK8pCZ6BdHr8IY66
         jNnaj97cyynnD1dXVXkKQOVeFr8YUzNPBatR/JBrT/DSMsxEx/GaXko+VSF7VSjqsff3
         Ejug==
Received: by 10.213.104.132 with SMTP id p4mr1143043ebo.101.1334679194812;
 Tue, 17 Apr 2012 09:13:14 -0700 (PDT)
Received: by 10.213.19.67 with HTTP; Tue, 17 Apr 2012 09:13:14 -0700 (PDT)
In-Reply-To: <7vty0inys6.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/195769>

On Tue, Apr 17, 2012 at 6:50 PM, Junio C Hamano <gitster@pobox.com> wro=
te:
> Felipe Contreras <felipe.contreras@gmail.com> writes:
>
>> 2012/4/17 SZEDER G=C3=A1bor <szeder@ira.uka.de>:
>>> On Sun, Apr 15, 2012 at 04:37:18PM -0500, Jonathan Nieder wrote:
>>>> Felipe Contreras wrote:
>>
>>>> A name like __git_complete should work, presumably.
>>>
>>> And foo_wrap() should also fit into those namespaces.
>>
>> Yeah, I don't have a problem with that, just forgot about it.
>>
>> But git_complete I think is different.
>
> Is git_complete something the user types interactively, or is it mean=
t to
> be used in their .bashrc to help them complete arguments to their cus=
tom
> scripts that take arguments similar to Git Porcelains?

It's meant for their .bashrc, but can be used interactively, exactly
like 'complete'. You can type 'complete -o bashdefault -o default -o
nospace -F _git git' in the command like, but that would rarely
happen.

--=20
=46elipe Contreras
