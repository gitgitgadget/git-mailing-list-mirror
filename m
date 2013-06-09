From: Felipe Contreras <felipe.contreras@gmail.com>
Subject: Re: [PATCH v4 10/45] sequencer: trivial fix
Date: Sun, 9 Jun 2013 13:21:02 -0500
Message-ID: <CAMP44s2MrV+dFk+vv-NXyWAd0_M+Nb+SaHANNmv-hatWF1mYEg@mail.gmail.com>
References: <1370796057-25312-1-git-send-email-felipe.contreras@gmail.com>
	<1370796057-25312-11-git-send-email-felipe.contreras@gmail.com>
	<20130609171810.GA10858@goldbirke>
	<CAMP44s3yhVbgkhtrSfHpk=VwcwMkb66ELA-xR0i6FCVGyRwHJw@mail.gmail.com>
	<20130609173342.GB2091@goldbirke>
	<CAMP44s2YdG_pE7gnKfUJJP0SaO5pKu+kxPB=T74p14fuqXU9OQ@mail.gmail.com>
	<20130609175353.GC2091@goldbirke>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
	Ramkumar Ramachandra <artagnon@gmail.com>,
	Jonathan Nieder <jrnieder@gmail.com>,
	Martin von Zweigbergk <martin.von.zweigbergk@gmail.com>
To: =?UTF-8?Q?SZEDER_G=C3=A1bor?= <szeder@ira.uka.de>
X-From: git-owner@vger.kernel.org Sun Jun 09 20:21:13 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UlkEo-0007Ka-JD
	for gcvg-git-2@plane.gmane.org; Sun, 09 Jun 2013 20:21:10 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751415Ab3FISVG convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sun, 9 Jun 2013 14:21:06 -0400
Received: from mail-lb0-f180.google.com ([209.85.217.180]:54923 "EHLO
	mail-lb0-f180.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750906Ab3FISVE convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 9 Jun 2013 14:21:04 -0400
Received: by mail-lb0-f180.google.com with SMTP id o10so3222791lbi.25
        for <git@vger.kernel.org>; Sun, 09 Jun 2013 11:21:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        bh=9crGXX8kPBtzNvXlIvPdq3cUSxznPPYU88vq1YvTeYY=;
        b=BdUc1r/xiP1+LDlXXD660c7ChGD97MJWkmOM/1xS/qIvmBMj7knx6fi+/YmFWKgE4e
         hIlNfc5Xx6We059pVUy+/hRE2D6wP8oMUDuM1qcBrUerC+zKoJtK+cmMot5hrahnLXnE
         8Lo9VZh+w2iRYQi1PKiimeBr22cHstLw9ohkhYFmFwAzinMqZdkawwqhsgtUYxmgqOTQ
         fgQudnMLyG9dzDwnISrTMvjfycx68Hyc+PU4Y06StcUT6kGkFYxBXQx1dvzv6MIKT2WC
         tDrMdKx1d00ptA4KJgkEyedlUILdNS7LLaI4gTTxZVnyCIYpXk2bYXwthLfZen8gBXOV
         3mMg==
X-Received: by 10.112.166.67 with SMTP id ze3mr5070139lbb.25.1370802062984;
 Sun, 09 Jun 2013 11:21:02 -0700 (PDT)
Received: by 10.114.59.202 with HTTP; Sun, 9 Jun 2013 11:21:02 -0700 (PDT)
In-Reply-To: <20130609175353.GC2091@goldbirke>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/227084>

On Sun, Jun 9, 2013 at 12:53 PM, SZEDER G=C3=A1bor <szeder@ira.uka.de> =
wrote:
> On Sun, Jun 09, 2013 at 12:47:16PM -0500, Felipe Contreras wrote:
>> On Sun, Jun 9, 2013 at 12:33 PM, SZEDER G=C3=A1bor <szeder@ira.uka.d=
e> wrote:
>> > On Sun, Jun 09, 2013 at 12:23:01PM -0500, Felipe Contreras wrote:
>> >> On Sun, Jun 9, 2013 at 12:18 PM, SZEDER G=C3=A1bor <szeder@ira.uk=
a.de> wrote:
>> >> > On Sun, Jun 09, 2013 at 11:40:22AM -0500, Felipe Contreras wrot=
e:
>> >> >> We should free objects before leaving.
>> >> >>
>> >> >> Signed-off-by: Felipe Contreras <felipe.contreras@gmail.com>
>> >> >
>> >> > A shortlog-friendlier subject could be: "sequencer: free object=
s
>> >> > before leaving".
>> >>
>> >> I already defended my rationale for this succinct commit message:
>> >>
>> >> http://thread.gmane.org/gmane.comp.version-control.git/225609/foc=
us=3D225610
>> >
>> > Your arguments were unconvincing.
>>
>> That's your opinion.
>
> And Duy's.  And John's, too, apparently.

And it could the opinion of a thousand more people, it doesn't make it
anything more than an opinion. To think anything else is to fall in
argumentum ad populum.

--=20
=46elipe Contreras
