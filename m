From: Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: Suggestions to make git easier to understand
Date: Thu, 11 Aug 2011 17:16:27 -0500
Message-ID: <20110811221627.GA32005@elie.gateway.2wire.net>
References: <CAGK7Mr5T4-DBK7rXeH-1=SNu5HBOEkLBW=CAh5Lhf7oHKjFAiw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Rafael Magana <raf.magana@gmail.com>
To: Philippe Vaucher <philippe.vaucher@gmail.com>
X-From: git-owner@vger.kernel.org Fri Aug 12 00:16:40 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QrdYN-0004To-UH
	for gcvg-git-2@lo.gmane.org; Fri, 12 Aug 2011 00:16:40 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753481Ab1HKWQf (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 11 Aug 2011 18:16:35 -0400
Received: from mail-gy0-f174.google.com ([209.85.160.174]:49893 "EHLO
	mail-gy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753477Ab1HKWQe (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 11 Aug 2011 18:16:34 -0400
Received: by gya6 with SMTP id 6so1628226gya.19
        for <git@vger.kernel.org>; Thu, 11 Aug 2011 15:16:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        bh=vBmOT67gghuIj4TbzjYsW/U/Nmlz2pAIYu5fmofypdw=;
        b=LrkfMSNCakCHJJI1GhkqN9+CKEZ1uwAB0Lw8En5FfbtHqG0uWPkBrC60JtVDQr2AQa
         K3+IMRovz6Smmu5ZUJ0Bvyrrm3XteI0nPBez7jhCabBYua9INdrFkSKtL1ftxyYjSUHB
         smUi9Gqfg3DePMUoavJr7GK1pYW5v+ffkhdu8=
Received: by 10.236.138.129 with SMTP id a1mr533055yhj.199.1313100994156;
        Thu, 11 Aug 2011 15:16:34 -0700 (PDT)
Received: from elie.gateway.2wire.net (adsl-69-209-69-68.dsl.chcgil.ameritech.net [69.209.69.68])
        by mx.google.com with ESMTPS id g69sm286034yhk.2.2011.08.11.15.16.32
        (version=SSLv3 cipher=OTHER);
        Thu, 11 Aug 2011 15:16:33 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <CAGK7Mr5T4-DBK7rXeH-1=SNu5HBOEkLBW=CAh5Lhf7oHKjFAiw@mail.gmail.com>
User-Agent: Mutt/1.5.21+46 (b01d63af6fea) (2011-07-01)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/179148>

Hi Philippe,

Philippe Vaucher wrote:

> http://raflabs.com/blogs/silence-is-foo/2011/04/07/staging-area-index-cache-git/
>
> I thought it made some good points about git being kinda confusing,
> for example sentences like "Changed but not updated" in git status
> could use a better sentence like "Changed but not in the index".

Sounds reasonable (well, with some more precise wording to reflect
that this means "changed but not all changes are reflected in the
index").

> Maybe
> --cached could have an alias like --index-only for things to be more
> intuitive as well.
> 
> `git rm --index-only somefile` is more understandable than `git rm
> --cached somefile` imho.
> 
> Also, in ls-files, --stage could maybe use an alias like --contents
> for it to be more self-explanatory.

These suggestions also seem sane.  Please send patches
(Documentation/SubmittingPatches explains how) so we can refine them
and fix this.

Thanks much,
Jonathan
