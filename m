From: Thomas Berg <merlin66b@gmail.com>
Subject: Re: [PATCH] git-p4: Corrected typo.
Date: Mon, 31 Jan 2011 00:34:44 +0100
Message-ID: <AANLkTi=kmcWn9WWbhA4bMZ5bEo1imacEugT0BcOU9jry@mail.gmail.com>
References: <1290130693-30855-2-git-send-email-vitor.hda@gmail.com>
	<1290648419-6107-1-git-send-email-vitor.hda@gmail.com>
	<AANLkTimQhFzEXr=T9F8TJzTeWwKroTt_BG87RtQCLivv@mail.gmail.com>
	<AANLkTikeB724f_vE6qvu1h1o5JG150mcmaHVBjLkOEWP@mail.gmail.com>
	<AANLkTimLQxiB=dnd6=iB5uEpzOSfqks=FDJ=xORehuw8@mail.gmail.com>
	<AANLkTi=PPN69uuJmUBDHKtmn59DzUbdk=Qu4Ug-kok89@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Cc: git@vger.kernel.org
To: Vitor Antunes <vitor.hda@gmail.com>
X-From: git-owner@vger.kernel.org Mon Jan 31 00:35:28 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Pjgnn-0005jJ-1Y
	for gcvg-git-2@lo.gmane.org; Mon, 31 Jan 2011 00:35:27 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750874Ab1A3Xeq (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 30 Jan 2011 18:34:46 -0500
Received: from mail-qy0-f181.google.com ([209.85.216.181]:59089 "EHLO
	mail-qy0-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750807Ab1A3Xep (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 30 Jan 2011 18:34:45 -0500
Received: by qyk12 with SMTP id 12so5545890qyk.19
        for <git@vger.kernel.org>; Sun, 30 Jan 2011 15:34:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:in-reply-to:references:date
         :message-id:subject:from:to:cc:content-type;
        bh=TSrLB/3sgpNRJUVS0CU37YnEHNobn+twMaVZjUqsY9U=;
        b=hTFCu6r1rVwWjLuQAq4udwTrdJGtH1alxtJkp/ljhOM57HCV+wny4mc3y6DqbT4Z1d
         wpY5Cga2MTNqUxEqsScJHNhHASb/iwm3ROgW0hzA0Qxwqgd5JXdpDdKHkd7ZhpwAHxIi
         TMoS6thn97wmiBCGjmcNAktIAb3LwKVwDs+yI=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        b=iHPC9PtOnhIb8esGtRH/Oi47Q3y9t1WOzy5jrDuDNoVoN63+B5MQoAupn2GsRxDcMs
         lCEMmW0AqDAyp6UzeIsJPo+8Naiq0Cy88HaIzBZdpVP9lG6Zw/+4ln+sYkNqz/dZvwsf
         Bbm22CSs8fWeHkw+PxE/UrMRKBmkE0Vef1PnM=
Received: by 10.229.236.196 with SMTP id kl4mr3489705qcb.69.1296430484366;
 Sun, 30 Jan 2011 15:34:44 -0800 (PST)
Received: by 10.229.223.131 with HTTP; Sun, 30 Jan 2011 15:34:44 -0800 (PST)
In-Reply-To: <AANLkTi=PPN69uuJmUBDHKtmn59DzUbdk=Qu4Ug-kok89@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/165711>

Hi Vitor,

On Mon, Jan 31, 2011 at 12:21 AM, Vitor Antunes <vitor.hda@gmail.com> wrote:
> Hi Thomas,
>
> I've just sent out the patches to the mailing list. I'm looking
> forward to receive some feedback from you :)

Thanks, I will try to get it tested tomorrow.

By the way, on this mailing list please don't top post. I think the
preferred style is interleaved posting:
http://en.wikipedia.org/wiki/Posting_style#Interleaved_style

>
> I also have some branch detection related patch prepared. Do you use
> this feature often?

No, the Perforce repo I work with is so non-standard that the only
solution has been to import all the branches separately and graft the
history together. This covers all my needs at the moment.

Cheers,
Thomas
