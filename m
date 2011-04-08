From: Jonathan Nieder <jrnieder@gmail.com>
Subject: Pushing to a "dumb" server (Re: New to git)
Date: Fri, 8 Apr 2011 17:54:55 -0500
Message-ID: <20110408225127.GA27695@elie>
References: <BANLkTimy-95OJGxU9XzcaR=0jTJWXOwsDg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Jeff King <peff@peff.net>
To: Marco Maggesi <marco.maggesi@gmail.com>
X-From: git-owner@vger.kernel.org Sat Apr 09 00:55:19 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Q8KaD-00017N-6p
	for gcvg-git-2@lo.gmane.org; Sat, 09 Apr 2011 00:55:17 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757696Ab1DHWzJ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 8 Apr 2011 18:55:09 -0400
Received: from mail-yx0-f174.google.com ([209.85.213.174]:63078 "EHLO
	mail-yx0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757453Ab1DHWzF (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 8 Apr 2011 18:55:05 -0400
Received: by yxs7 with SMTP id 7so1610304yxs.19
        for <git@vger.kernel.org>; Fri, 08 Apr 2011 15:55:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:date:from:to:cc:subject:message-id:references
         :mime-version:content-type:content-disposition:in-reply-to
         :user-agent;
        bh=FUNjtNd70wN/DofLqPklRskVLJuGN/dm64OC0RYddgw=;
        b=UHWxqyYDDrcRaVmpJCN6t6cyCvPio1pS9NmRRZHF43cur6N/+M2WEHm1XldEuesynY
         VZREN3WSSiiaINSDjCGvagIzpc/zimeYHWn9h4iH1DhZFHcnIGmT6NiOeHnfpA3Stkes
         mcI5RWWCVtb2MoagJiWhcsVF6A9LDrqi3WU4k=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        b=oiqnDfU/xKtwHXjMz3uzW0TImbyn2sBeKT8h7q75Qd3tvNxASgHuml05kfAvR9fIbX
         J/88AzHYg2+iIHekMtKs+KRGVTaXZBj1zqbhzhGMhB2SLj6X2meQrLoAv5pBk6eG8eId
         v1AlhreLZR31LCTakC1rf6OSEio9djcRZwbxA=
Received: by 10.90.248.11 with SMTP id v11mr2567944agh.37.1302303305048;
        Fri, 08 Apr 2011 15:55:05 -0700 (PDT)
Received: from elie (adsl-69-209-53-77.dsl.chcgil.sbcglobal.net [69.209.53.77])
        by mx.google.com with ESMTPS id c4sm183618ana.23.2011.04.08.15.55.00
        (version=SSLv3 cipher=OTHER);
        Fri, 08 Apr 2011 15:55:02 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <BANLkTimy-95OJGxU9XzcaR=0jTJWXOwsDg@mail.gmail.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/171173>

Hi,

Marco Maggesi wrote:

> My problem is that I can hardly install git on the server for several
> reasons that I will not explain here (also I'm not the administrator
> of the server).
> So I am looking for other solutions.

Have you looked into "git bundle"?

I should also mention that git can be run from ~/bin without trouble.
If you lack the ability to modify your $PATH, "git fetch" and "git
push" have --upload-pack and --receive-pack options that can be used
to specify alternate commands like '~/bin/git upload-pack'.

Ciao,
Jonathan
