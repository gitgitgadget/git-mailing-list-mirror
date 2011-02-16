From: Sverre Rabbelier <srabbelier@gmail.com>
Subject: Re: non-empty index with git commit -a
Date: Wed, 16 Feb 2011 09:52:23 +0000
Message-ID: <AANLkTik_F=d1CjNVfj35wgv0pL1LefOMnttXjs=s2wCQ@mail.gmail.com>
References: <AANLkTi=5E8D0mwMDNuMdgZS69kOnKCfs=Q8X5bpcjnYF@mail.gmail.com>
 <20110216023645.GA7085@sigill.intra.peff.net> <20110216032047.GA2858@elie>
 <AANLkTinbcHW+ja7T=PiCEorNdnK6W2DvA_c9F8JTEMKB@mail.gmail.com> <20110216085114.GA9413@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Jonathan Nieder <jrnieder@gmail.com>,
	Git List <git@vger.kernel.org>,
	Jakub Narebski <jnareb@gmail.com>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Wed Feb 16 10:53:16 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Ppe4Q-0001Ig-OB
	for gcvg-git-2@lo.gmane.org; Wed, 16 Feb 2011 10:53:15 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755659Ab1BPJxI (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 16 Feb 2011 04:53:08 -0500
Received: from mail-yi0-f46.google.com ([209.85.218.46]:51976 "EHLO
	mail-yi0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754055Ab1BPJxF (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 16 Feb 2011 04:53:05 -0500
Received: by yib18 with SMTP id 18so515266yib.19
        for <git@vger.kernel.org>; Wed, 16 Feb 2011 01:53:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc:content-type;
        bh=Om1u/7gzPrDrv3d7ZVIvgc9ggAYB843fd3RnCowpGJA=;
        b=UtF4WWeXFRZn4FnnrCJ1RMwBgV1mNB++AqWM8efs/xCG8zfk4feXRj+ydGdnpE3iXt
         lTO+pMezrdPCv2Ej4xCLaljtoOFt5lz/cSdm/oKQdm4meKo1B9CHxGwNAi5b44RQgyWi
         ZEj0huFl1bPT3jk68pPWFmwFtoSWjgVCQUIUA=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        b=I9V4RH9YoKEbFRE+bkUIrHo60SfWeCpLJ7NJ/ULhpyU9kbJATTB6oHYIv3u1MYAB5b
         BHM52gMvKjFVkbKx9cYkDvgxWVxOzQNz4U462w00HUz/+23Y3HFn87gRbdt+fjx9lnem
         YMHC7PfmOJtroAq3bVwUzBp3XGgA09vBLQcvQ=
Received: by 10.150.198.8 with SMTP id v8mr466091ybf.393.1297849983634; Wed,
 16 Feb 2011 01:53:03 -0800 (PST)
Received: by 10.151.158.19 with HTTP; Wed, 16 Feb 2011 01:52:23 -0800 (PST)
In-Reply-To: <20110216085114.GA9413@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/166940>

Heya,

On Wed, Feb 16, 2011 at 08:51, Jeff King <peff@peff.net> wrote:
> I can just as easily run "git add -u", or "git add -p" on top of some
> changes and then realize afterwards that I actually wanted the previous
> index state.

I disagree, those are all index manipulation tools, `git commit -a` is not.

-- 
Cheers,

Sverre Rabbelier
