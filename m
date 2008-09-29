From: "Mike Ralphson" <mike.ralphson@gmail.com>
Subject: Re: A note from the interim Git maintainer
Date: Mon, 29 Sep 2008 08:51:29 +0100
Message-ID: <e2b179460809290051q8ca76a4k7cf0af2748a5f0fc@mail.gmail.com>
References: <20080924154632.GR3669@spearce.org>
	 <e2b179460809260624n4b329345q3610069af5af75c2@mail.gmail.com>
	 <20080926225423.GA25502@coredump.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: "Shawn O. Pearce" <spearce@spearce.org>, git@vger.kernel.org
To: "Jeff King" <peff@peff.net>
X-From: git-owner@vger.kernel.org Mon Sep 29 09:52:48 2008
connect(): Connection refused
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KkDYg-0000Ky-U2
	for gcvg-git-2@gmane.org; Mon, 29 Sep 2008 09:52:43 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751734AbYI2Hvb (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 29 Sep 2008 03:51:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751838AbYI2Hvb
	(ORCPT <rfc822;git-outgoing>); Mon, 29 Sep 2008 03:51:31 -0400
Received: from qw-out-2122.google.com ([74.125.92.24]:57066 "EHLO
	qw-out-2122.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751642AbYI2Hva (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 29 Sep 2008 03:51:30 -0400
Received: by qw-out-2122.google.com with SMTP id 3so260248qwe.37
        for <git@vger.kernel.org>; Mon, 29 Sep 2008 00:51:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from:to
         :subject:cc:in-reply-to:mime-version:content-type
         :content-transfer-encoding:content-disposition:references;
        bh=Jn4VNuAYqO1cjnNy8sevM+EE4a+G5KTydRbL/ceD9I0=;
        b=lGvxxsGfn3Wx1f0P7TdKPYWHdruzC8Q/q/hGxkiPrXkd433z6JFnPbQu37NUKqcwBr
         +e1S2Yrll1qgvTW3B4ySfDit77QXB24yWFkrhgRH3VwYhY2YP8AHisWLoif/gfGveucg
         DuhfHKbUDDARckIlZyzprdjmw1aMPdQyp8DEo=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:to:subject:cc:in-reply-to:mime-version
         :content-type:content-transfer-encoding:content-disposition
         :references;
        b=jgW3MHpRHTHjjvnS83TeA88mkpMZSKkuF2Le4nnIF1Mt059iKwPgW3vWkv+wYRU5R/
         saDQ1oo+stU9kgWKAKE44PvWzNIPUUiENM6eSSfbmLpFHiLfkfPsJlpn7xgjoFLuxHzQ
         oJH6DXpuxlYISfUYMTKdjeMoVPaXAURHUH4O0=
Received: by 10.214.10.15 with SMTP id 15mr3803453qaj.9.1222674689331;
        Mon, 29 Sep 2008 00:51:29 -0700 (PDT)
Received: by 10.214.215.10 with HTTP; Mon, 29 Sep 2008 00:51:29 -0700 (PDT)
In-Reply-To: <20080926225423.GA25502@coredump.intra.peff.net>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/97000>

2008/9/26 Jeff King <peff@peff.net>
>
> On Fri, Sep 26, 2008 at 02:24:31PM +0100, Mike Ralphson wrote:
>
> > Jeff, if you want to switch your BSD builds to Shawn's tree too, I
> > made and pushed a tiny change to the gitbuild.sh script to allow for
> > the spearce/{branch} format becoming spearce_{branch} in the tag
> > names.
>
> Thanks, that's a good idea. I'm building Shawn's master (on my todo is
> adding the other branches, too, but I need to tweak my script or tweak
> gitbuild.sh and switch to it).

Feel free to push changes to gitbuild.sh, including getting rid of
anything which looks environment-specific.

Mike
