From: Jared Hance <jaredhance@gmail.com>
Subject: Re: [idea] separate .git dir and the working tree
Date: Sat, 05 Feb 2011 20:00:15 -0500
Message-ID: <1296954015.4048.0.camel@localhost.localdomain>
References: <AANLkTik4MjnpOzPdGy7ZDiH0in4e1DpjrhQFOHjUiEEE@mail.gmail.com>
	 <20110205032339.GA15303@mg1> <20110205132708.GA18391@elie>
	 <20110206002009.GA13594@mg1>  <20110206004013.GB13594@mg1>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org, redstun <redstun@gmail.com>,
	Jonathan Nieder <jrnieder@gmail.com>
To: Mike Gant <mike@gantsfort.com>
X-From: git-owner@vger.kernel.org Sun Feb 06 02:00:25 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PlszJ-00018b-6U
	for gcvg-git-2@lo.gmane.org; Sun, 06 Feb 2011 02:00:25 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751789Ab1BFBAU (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 5 Feb 2011 20:00:20 -0500
Received: from mail-qw0-f46.google.com ([209.85.216.46]:54344 "EHLO
	mail-qw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751706Ab1BFBAT (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 5 Feb 2011 20:00:19 -0500
Received: by qwa26 with SMTP id 26so2719070qwa.19
        for <git@vger.kernel.org>; Sat, 05 Feb 2011 17:00:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:subject:from:to:cc:in-reply-to:references
         :content-type:date:message-id:mime-version:x-mailer
         :content-transfer-encoding;
        bh=hcgIcyui1UuEwwTRi27RyFvVqrN7FGUJrQpw6yb1Hng=;
        b=nSkyFe4Js5p1poaFTvSEWGZ4tmULalVeQMzksDMgJ7Kf7T7vukw+Z/zt3M/+8YonpE
         rwBGIo9ImUF6sf7mYgPIFitL7ZhqDmBNSJ+EHZXMtDsJSItObcIQiEbJXfGnxZPtr9Jb
         zHzq6darNc0ANQPg0fsZjI+KZlq1iWgZrR86A=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=subject:from:to:cc:in-reply-to:references:content-type:date
         :message-id:mime-version:x-mailer:content-transfer-encoding;
        b=QOKBYouEbTe1rKN10gD7Ue2PnvTm21PrhocORQjBAdwXEm70OHoO5uhVb32pnhI3gI
         pPG95tsJJKG+jTyv2E6etMjJuXkDt8FAunscp78hE5i03uXhw6ut+Uml2+zLrrXUCk1d
         FuVm2EZUcMj/Kkb29Vvz52/235dFtmhm8ND8Q=
Received: by 10.229.238.82 with SMTP id kr18mr11814997qcb.98.1296954018132;
        Sat, 05 Feb 2011 17:00:18 -0800 (PST)
Received: from [192.168.1.100] (cpe-75-186-7-248.cinci.res.rr.com [75.186.7.248])
        by mx.google.com with ESMTPS id nb15sm1696210qcb.2.2011.02.05.17.00.16
        (version=SSLv3 cipher=RC4-MD5);
        Sat, 05 Feb 2011 17:00:17 -0800 (PST)
In-Reply-To: <20110206004013.GB13594@mg1>
X-Mailer: Evolution 2.32.1 (2.32.1-1.fc14) 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/166138>

On Sat, 2011-02-05 at 17:40 -0700, Mike Gant wrote:
> On Sat, Feb 05, 2011 at 05:20:09PM -0700, Mike Gant wrote:
> > On Sat, Feb 05, 2011 at 07:27:08AM -0600, Jonathan Nieder wrote:
> > > (restoring cc list; please do not cull cc's)
> > 
> > My apologies, but I didn't see a cc list in the original. Please
> > explain.
> > 
> > -Mike
> 
> Never mind, I think I understand.
> 
> So does anyone use Mutt? And do they know a recipe to move the sender
> address to the cc list? If not, I'll figure it out.
> 
> Thanks,
> -Mike
> --
> To unsubscribe from this list: send the line "unsubscribe git" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html

When I used Mutt, if I remember correctly, L did the job (list reply).
