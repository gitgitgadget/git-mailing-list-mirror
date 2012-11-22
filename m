From: Felipe Contreras <felipe.contreras@gmail.com>
Subject: Re: [PATCH v5 00/15] fast-export and remote-testgit improvements
Date: Thu, 22 Nov 2012 01:51:11 +0100
Message-ID: <CAMP44s1XgmP=-cD+A013LGYWQfkfGJQDDa5w4ubsEkDSBAT2Ng@mail.gmail.com>
References: <1352642392-28387-1-git-send-email-felipe.contreras@gmail.com>
	<CAMP44s3h5+KS3ixoLkJeiS+n_neBV-Dyj=Cww0ZrU6UKsNxphQ@mail.gmail.com>
	<7vtxsi22g6.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: git@vger.kernel.org,
	Johannes Schindelin <johannes.schindelin@gmx.de>,
	Max Horn <max@quendi.de>, Jeff King <peff@peff.net>,
	Sverre Rabbelier <srabbelier@gmail.com>,
	Brandon Casey <drafnel@gmail.com>,
	Brandon Casey <casey@nrlssc.navy.mil>,
	Jonathan Nieder <jrnieder@gmail.com>,
	Ilari Liusvaara <ilari.liusvaara@elisanet.fi>,
	Pete Wyckoff <pw@padd.com>, Ben Walton <bdwalton@gmail.com>,
	Matthieu Moy <Matthieu.Moy@imag.fr>,
	Julian Phillips <julian@quantumfyre.co.uk>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Nov 22 21:14:21 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TbdAB-00012j-QB
	for gcvg-git-2@plane.gmane.org; Thu, 22 Nov 2012 21:14:20 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756688Ab2KVUN7 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 22 Nov 2012 15:13:59 -0500
Received: from mail-oa0-f46.google.com ([209.85.219.46]:57699 "EHLO
	mail-oa0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756685Ab2KVUNm (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 22 Nov 2012 15:13:42 -0500
Received: by mail-oa0-f46.google.com with SMTP id h16so8346878oag.19
        for <git@vger.kernel.org>; Thu, 22 Nov 2012 12:13:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        bh=dNEVmiYLVU9Z/U9ABaipi7JVyZEQL1n2vK1/LqEtiCo=;
        b=gPbUHgGhFmQuybA44PhUqQySPtl/IEzuVkr7pgz08EHKNzXxYh8rf11HTSGojvR8Md
         bpoIVSjyKTb7xOpk/fIbpq2c5OgD20nnCE//CyrXnjQykKaFQTZ9wQCrW6QtDPBMo2Up
         COpuMHYy9SacIa6ATSwuN6G41NF7ni/EFWYGBssmjdMAt7thX5h3TcCX0hT+XoRnpaso
         oiaZou2TddRR9fY5okWwkeBaUX8DUeSo/AzaiDd4ewEr159mEnegzaS9N34Jiqq4OZNK
         0hY2Hkad3Yj6d6tZ46XqNDuQQgjF8Kg5kv1MjspnDtf156CLac0nuGIUZSEnVMssc0j1
         meGg==
Received: by 10.60.22.161 with SMTP id e1mr17540019oef.93.1353545471521; Wed,
 21 Nov 2012 16:51:11 -0800 (PST)
Received: by 10.60.32.196 with HTTP; Wed, 21 Nov 2012 16:51:11 -0800 (PST)
In-Reply-To: <7vtxsi22g6.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/210208>

On Wed, Nov 21, 2012 at 8:05 PM, Junio C Hamano <gitster@pobox.com> wrote:

> I can agree that the updates to fast-export will make remote-testgit
> script work better, but I cannot tell how big an impact the changes
> will have to people's existing use of fast-export.  Some of them may
> be relying on the current behaviour (in other words, they may be
> relying on "existing bugs"), which may mean that this series will
> bring regression to them.  I am still open to reasonable objections
> along the lines of "This script X uses fast-export and is broken
> when used with the updated behaviour." if there is any.

We've discussed about this extensively, and I've asked the same;
nobody put forward any. I've also thought long and hard; can't think
of any.

Cheers.

-- 
Felipe Contreras
