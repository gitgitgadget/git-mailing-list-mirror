From: "=?ISO-8859-1?Q?Santi_B=E9jar?=" <sbejar@gmail.com>
Subject: Re: [RFC/PATCH] git-fetch: mega-terse fetch output
Date: Fri, 19 Oct 2007 12:03:24 +0200
Message-ID: <8aa486160710190303l4ce996daqf5c8025c857ea8@mail.gmail.com>
References: <20071019062219.GA28499@coredump.intra.peff.net>
	 <ee77f5c20710182339g30d025f0tfe74479d672ae36e@mail.gmail.com>
	 <20071019073938.GN14735@spearce.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: "David Symonds" <dsymonds@gmail.com>, "Jeff King" <peff@peff.net>,
	git@vger.kernel.org
To: "Shawn O. Pearce" <spearce@spearce.org>
X-From: git-owner@vger.kernel.org Fri Oct 19 12:08:36 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by dough.gmane.org with esmtp (Exim 4.50)
	id 1IiomR-0001C7-FD
	for gcvg-git-2@gmane.org; Fri, 19 Oct 2007 12:08:35 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755872AbXJSKD1 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 19 Oct 2007 06:03:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755767AbXJSKD1
	(ORCPT <rfc822;git-outgoing>); Fri, 19 Oct 2007 06:03:27 -0400
Received: from wr-out-0506.google.com ([64.233.184.233]:33379 "EHLO
	wr-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755452AbXJSKD0 (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 19 Oct 2007 06:03:26 -0400
Received: by wr-out-0506.google.com with SMTP id 36so386409wra
        for <git@vger.kernel.org>; Fri, 19 Oct 2007 03:03:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=beta;
        h=domainkey-signature:received:received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        bh=sK2bawG4HLOHc9KzyGwKwT3rBQCGvzsg9w20pjKVq98=;
        b=kWRhhpBxjckOA7lQx4K5N4Hp+gBLKjxlspkTgNio06wAOndhGZxJTMtv9jTKMEWgEYl9SlXp5Kq/sGRFgqWnwXIiQ7N9/s3xa+L/ORbpRwc1K4sars2ICB3P43Dp3kemyeujUxqwmDN7VQOU5OhTE2BwrxsX87dXxf35tBszF+I=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=beta;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=a1niHLkuLO4eCS3/lSdQWletJ5Uqnj8iC1sdRvqi2OAvJioYjgJlDJXcvuhJZsay/Y8GHOOXgCkpTZWh0ImkXlX4B02JQlKeo1dCCjL7YETFuT33Dk18T3/hKoLvYbY7VyrJf7nFkD6qGc3KfZVa52o+9KVKc45pEzc9HX/tagM=
Received: by 10.78.149.15 with SMTP id w15mr1060717hud.1192788204410;
        Fri, 19 Oct 2007 03:03:24 -0700 (PDT)
Received: by 10.78.137.1 with HTTP; Fri, 19 Oct 2007 03:03:24 -0700 (PDT)
In-Reply-To: <20071019073938.GN14735@spearce.org>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/61683>

Another possibility is with just some minor reductions from the
current output, as:

$ git fetch spearce
...
From git://repo.or.cz/git/spearce
* spearce/gitk: fast forward to branch 'gitk'
  old..new: 0d6df4d..2b5afb7
* spearce/maint: fast forward to branch 'maint'
  old..new: 1aa3d01..e7187e4
* spearce/master: fast forward to branch 'master'
  old..new: de61e42..7840ce6
* spearce/next: fast forward to branch 'next'
  old..new: 895be02..2fe5433
* spearce/pu: forcing update to non-fast forward branch 'pu'
  old...new: 89fa332...1e4c517

This way it is slightly less terse than the other proposals but not
that cryptic and it normally fits in one line without padding. And I
really like to see what has changed explicitly with the old..new line.

  Santi
