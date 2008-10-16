From: "Richard Hartmann" <richih.mailinglist@gmail.com>
Subject: Re: commiting while the current version is in conflict
Date: Fri, 17 Oct 2008 01:31:02 +0200
Message-ID: <2d460de70810161631n4b9f766fv2bca0e44d1e4009@mail.gmail.com>
References: <2d460de70810161510ha220593g4615a55b2c3e3b25@mail.gmail.com>
	 <20081016224808.GO536@genesis.frugalware.org>
	 <2d460de70810161607n470e9479h8f7885040cbf5428@mail.gmail.com>
	 <20081016232332.GD9877@spearce.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Cc: "Miklos Vajna" <vmiklos@frugalware.org>, git@vger.kernel.org
To: "Shawn O. Pearce" <spearce@spearce.org>
X-From: git-owner@vger.kernel.org Fri Oct 17 01:32:49 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KqcKk-0000tY-Km
	for gcvg-git-2@gmane.org; Fri, 17 Oct 2008 01:32:47 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755998AbYJPXbI (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 16 Oct 2008 19:31:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755951AbYJPXbI
	(ORCPT <rfc822;git-outgoing>); Thu, 16 Oct 2008 19:31:08 -0400
Received: from hs-out-0708.google.com ([64.233.178.250]:50852 "EHLO
	hs-out-0708.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751281AbYJPXbG (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 16 Oct 2008 19:31:06 -0400
Received: by hs-out-0708.google.com with SMTP id 4so85383hsl.5
        for <git@vger.kernel.org>; Thu, 16 Oct 2008 16:31:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from:to
         :subject:cc:in-reply-to:mime-version:content-type
         :content-transfer-encoding:content-disposition:references;
        bh=KQcGm0WfcE5uqo4T4Fwo0sPyQzLNzacQ6fFD/63kLys=;
        b=o1xfcf4p+iMW7Ad3MdYJgD7Nso/9F5z8POiphEuJjo9MyyPm5UaBJdRZky0xMgcblM
         xi0SkbLkoY2G+pYLoyjmGnADe2JHsCNS6Wxxuad/3Dj/FbThOd0M0ZbFjMWueH7ymTKm
         izCoDgUc7m43d/H6Y8w6f2FDzBE7A+Ce+RchQ=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:to:subject:cc:in-reply-to:mime-version
         :content-type:content-transfer-encoding:content-disposition
         :references;
        b=VOu0sR5UhQalEnAxZ/OdAnfJH4bSS76rWjAAsjIcO0BuLVn3gGx44kU5/c8tV6Yh9q
         cZIS3GPuMUf2XeMZoc2haKGZ52kUewmLnfuwBbkn9LHraz/uudDV/o3glXAxA9LokyJ7
         wkMm3tqXF516e5SvQexynuB52YgMeERFFFQxo=
Received: by 10.101.66.14 with SMTP id t14mr3112079ank.146.1224199862211;
        Thu, 16 Oct 2008 16:31:02 -0700 (PDT)
Received: by 10.100.43.19 with HTTP; Thu, 16 Oct 2008 16:31:02 -0700 (PDT)
In-Reply-To: <20081016232332.GD9877@spearce.org>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/98436>

On Fri, Oct 17, 2008 at 01:23, Shawn O. Pearce <spearce@spearce.org> wrote:


> Yes, in the index.  But it erases it when you stage the file with
> "git add".
>
> Go look at my prior message about how "git commit -a" is staging
> the files prior to commit.  That makes git commit think everything
> has been resolved, because you've told git, everything is resolved.

This makes a good part of my latest email obsolete. Asynchronous
communication ftw ;)


Richard
