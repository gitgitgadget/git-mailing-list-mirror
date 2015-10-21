From: David Turner <dturner@twopensource.com>
Subject: Re: t7063-status-untracked-cache.sh test failure on next
Date: Wed, 21 Oct 2015 13:50:00 -0400
Organization: Twitter
Message-ID: <1445449800.8302.12.camel@twopensource.com>
References: <5627A31C.10906@ramsayjones.plus.com> <5627B7DD.3020909@web.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Ramsay Jones <ramsay@ramsayjones.plus.com>,
	Junio C Hamano <gitster@pobox.com>,
	GIT Mailing-list <git@vger.kernel.org>
To: Torsten =?ISO-8859-1?Q?B=F6gershausen?= <tboegi@web.de>
X-From: git-owner@vger.kernel.org Wed Oct 21 19:50:16 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZoxWe-0003Rn-DH
	for gcvg-git-2@plane.gmane.org; Wed, 21 Oct 2015 19:50:12 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751843AbbJURuG convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 21 Oct 2015 13:50:06 -0400
Received: from mail-pa0-f53.google.com ([209.85.220.53]:34664 "EHLO
	mail-pa0-f53.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750698AbbJURuF (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 21 Oct 2015 13:50:05 -0400
Received: by padhk11 with SMTP id hk11so60912633pad.1
        for <git@vger.kernel.org>; Wed, 21 Oct 2015 10:50:04 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:message-id:subject:from:to:cc:date:in-reply-to
         :references:organization:content-type:mime-version
         :content-transfer-encoding;
        bh=nDAuYrwUbflpcZu2cpeHCW+No6KZ+ZrOEnVSUFFEqns=;
        b=RpFHk+k34hGVtZ7yEY2DWsEO1Z6IrXqRtYUTeEgXr85j9kAZzsTmP+Iel7grjPlTbP
         4RwFcdsz9EX49Cb5kTu0LHnDVAFrqnv/8CDvv4T5VFMSx+D1KNhtKIbmywektn5udZNe
         y1K0dL+omKLUIjp48CCd0C2uV0dww8Xcisu2Kc3B5cSPzve4Dbw/kWHk/QqpkAS6SPA7
         1Mbdu1pO5V3DHFxMhxbX4lgt0jEoZBkfgnYQtb+Op+nXFQw9gHE787xvZxg31RNxktMk
         AHR1VZ75xm4irqiFM1YiYSjN3Hsk8GE+0nzZlgKAK9ZUQkq4/29AVr+ehL+DagT36erE
         KHew==
X-Gm-Message-State: ALoCoQmoKYLjeuOgYz+lHLs+zdV96A5GAx2b8MwAKlFp5SEx8As5Udg1jhTCj+IZg4YfNNBy2Wk4
X-Received: by 10.68.179.33 with SMTP id dd1mr12081460pbc.134.1445449804366;
        Wed, 21 Oct 2015 10:50:04 -0700 (PDT)
Received: from ubuntu ([8.25.196.26])
        by smtp.gmail.com with ESMTPSA id qn5sm10265572pac.41.2015.10.21.10.50.02
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 21 Oct 2015 10:50:03 -0700 (PDT)
In-Reply-To: <5627B7DD.3020909@web.de>
X-Mailer: Evolution 3.12.11-0ubuntu3 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/279993>

On Wed, 2015-10-21 at 18:05 +0200, Torsten B=C3=B6gershausen wrote:
> On 21.10.15 16:37, Ramsay Jones wrote:
> > Hi Junio,
> >=20
> > While testing the next branch today, I had a test failure, viz:
> >=20
> >     $ tail ntest-out-fail
> >     Test Summary Report
> >     -------------------
> >     t7063-status-untracked-cache.sh                  (Wstat: 256 Te=
sts: 32 Failed: 22)
>=20
> Does this patch help ?
> (Recently send & tested by David. I just copy & paste the diff)

My patch fixes one of the tests, but Ramsay has a zillion failures
(presumably because test 1 fails and most everything else follows from
that).

That test could fail if your clock were running fast and you had
1-second resolution timetamps on your filesystem and you were somewhat
unlucky. =20
