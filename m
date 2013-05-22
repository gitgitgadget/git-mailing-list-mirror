From: Felipe Contreras <felipe.contreras@gmail.com>
Subject: Re: [RFC/PATCH 2/2] doc: command line interface (cli) dot-repository dwimmery
Date: Wed, 22 May 2013 17:15:29 -0500
Message-ID: <CAMP44s0mKAtTy=B09ZGGx6XqVEpJtgXqs57ybWf71H9LYDpMhQ@mail.gmail.com>
References: <1368964449-2724-1-git-send-email-philipoakley@iee.org>
	<1368964449-2724-3-git-send-email-philipoakley@iee.org>
	<20130519173924.GB3362@elie.Belkin>
	<7v38thwn6l.fsf@alter.siamese.dyndns.org>
	<BDA138F1A58247F4A4940B3436A94485@PhilipOakley>
	<7v1u91uw95.fsf@alter.siamese.dyndns.org>
	<08847FEAFB00489695F31AA651F5EA2E@PhilipOakley>
	<7vfvxgqp3m.fsf@alter.siamese.dyndns.org>
	<CAMP44s3G5BPbw3MO8W3rmDabJ-ewf-C5FH8HHO_o0cPf0f55BA@mail.gmail.com>
	<7C4B7B2B8AD949F0833D1919EEACD224@PhilipOakley>
	<CAMP44s3rpS==ANz_OEVyVeUWXFNBu7RZaxJ5k-b7N5k9WFFhVw@mail.gmail.com>
	<6B51848E2F9A40078A2E42CE4BB499DA@PhilipOakley>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Junio C Hamano <gitster@pobox.com>,
	Jonathan Nieder <jrnieder@gmail.com>,
	GitList <git@vger.kernel.org>
To: Philip Oakley <philipoakley@iee.org>
X-From: git-owner@vger.kernel.org Thu May 23 00:15:42 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UfHJs-0005Dc-Lc
	for gcvg-git-2@plane.gmane.org; Thu, 23 May 2013 00:15:41 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757667Ab3EVWPe (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 22 May 2013 18:15:34 -0400
Received: from mail-lb0-f175.google.com ([209.85.217.175]:59448 "EHLO
	mail-lb0-f175.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757648Ab3EVWPa (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 22 May 2013 18:15:30 -0400
Received: by mail-lb0-f175.google.com with SMTP id v10so2628654lbd.6
        for <git@vger.kernel.org>; Wed, 22 May 2013 15:15:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        bh=oM0Ox6h5GEQQI1KHk2vGj8/TvJNpJBK+/e/cSDLQ9fM=;
        b=DL9PbT1LEP1wvTZhSdLIRwC6gS2/A/WOA0rLUr77tcpiMscnOLFGayUyPUMC/npBM7
         i3ASGZBW3w1vxyQI9yYFaJ/7cSz1oQ93AfhWiPxXCM2ASKT0/H0VBJBFqfRZ4WZEYn6I
         WMlIli5YmNHUVgrr7zpPxECnAn6bpHOei14A5D/3ZPsbaJe7ZINA58HCwHUKe3masx1l
         YHHpsSG33Y/AdmrZsle7EUAQ3PrBaV8gy8rniQikl3q5EO6seevPTSxZYf71QeI+Yifq
         H9jNR1x42a8M/Wgeh3Rpbyb8y24eT6EjY6J862/KSWiZV7HNxCOGKAnCX166R1gpn+zL
         wDNA==
X-Received: by 10.152.2.233 with SMTP id 9mr4966486lax.34.1369260929344; Wed,
 22 May 2013 15:15:29 -0700 (PDT)
Received: by 10.114.174.170 with HTTP; Wed, 22 May 2013 15:15:29 -0700 (PDT)
In-Reply-To: <6B51848E2F9A40078A2E42CE4BB499DA@PhilipOakley>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/225197>

On Wed, May 22, 2013 at 5:09 PM, Philip Oakley <philipoakley@iee.org> wrote:
> From: "Felipe Contreras" <felipe.contreras@gmail.com>
> Sent: Wednesday, May 22, 2013 12:03 AM

>>> The value of the trick was acknowledged as now being in use
>>> http://article.gmane.org/gmane.comp.version-control.git/223572
>>
>>
>> How is that more useful than 'git branch -f master $sha1'?
>
>
> The 'trick' checks for a fast forward, while the branch update is forced. It
> depends on what checks are desired.

If that was truly useful, surely we could add an option for 'git
branch' to do just that.

> My original patch was to simply document Git's dot repository capability
> that does not appear to be that well known. Let's not keep it as an Easter
> Egg.

I know, all I said is that I think nobody cares about that
implementation detail. Instead of explaining to the user why Git has
so many quirks, we should get rid of them and make it work more in
line with users' expectations.

-- 
Felipe Contreras
