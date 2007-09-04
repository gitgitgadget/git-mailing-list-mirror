From: "Jon Smirl" <jonsmirl@gmail.com>
Subject: Re: Calculating tree nodes
Date: Mon, 3 Sep 2007 23:54:00 -0400
Message-ID: <9e4733910709032054y4407ce62o6b21935502bfacdb@mail.gmail.com>
References: <9e4733910709031913q278cb9dbp441756afb28607c6@mail.gmail.com>
	 <20070904025153.GS18160@spearce.org>
	 <9e4733910709032026s7f94eed9h25d5165840cc38d2@mail.gmail.com>
	 <Pine.LNX.4.64.0709040439070.28586@racer.site>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: "Shawn O. Pearce" <spearce@spearce.org>,
	"Git Mailing List" <git@vger.kernel.org>
To: "Johannes Schindelin" <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Tue Sep 04 05:54:15 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1ISPUR-0005uw-Fj
	for gcvg-git@gmane.org; Tue, 04 Sep 2007 05:54:11 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751701AbXIDDyE (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 3 Sep 2007 23:54:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751825AbXIDDyE
	(ORCPT <rfc822;git-outgoing>); Mon, 3 Sep 2007 23:54:04 -0400
Received: from py-out-1112.google.com ([64.233.166.176]:52214 "EHLO
	py-out-1112.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751701AbXIDDyD (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 3 Sep 2007 23:54:03 -0400
Received: by py-out-1112.google.com with SMTP id u77so5237849pyb
        for <git@vger.kernel.org>; Mon, 03 Sep 2007 20:54:02 -0700 (PDT)
DKIM-Signature: a=rsa-sha1; c=relaxed/relaxed;
        d=gmail.com; s=beta;
        h=domainkey-signature:received:received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=UkEyRLOB4dT5gJjZrPNU3TMls55T6Sili6BzwqMozrKBL9aT8YwZ56gGHOppuG1yn5wSI5LxHD3AdfHGknC/9jO5OsJ2+tIrX+zA8Uxy3Dzq4przh5vqZA1weY2KBAU/CiBKZCem16RD+rIfvsCEdfIQyEwFQ7aEqCQmPjVn4w8=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=beta;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=sb6M6GMK6Rd5HUUaUMIiZEGo2gi+ZZ70IfgR6BujqxdMUbtY0DHJrwJq60VUv5eCC34TXhychQd/BIfhV1QKPAbi8sK0GUbcTSOlCZGqQl8dgIjFbV1DMDNKOqtavQ+T+Lj8fsTys/QKRjK5akYs71P/tsbKWqHkYvL4S+82+Og=
Received: by 10.115.17.1 with SMTP id u1mr290027wai.1188878040107;
        Mon, 03 Sep 2007 20:54:00 -0700 (PDT)
Received: by 10.114.195.5 with HTTP; Mon, 3 Sep 2007 20:54:00 -0700 (PDT)
In-Reply-To: <Pine.LNX.4.64.0709040439070.28586@racer.site>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/57517>

On 9/3/07, Johannes Schindelin <Johannes.Schindelin@gmx.de> wrote:
> Hi,
>
> On Mon, 3 Sep 2007, Jon Smirl wrote:
>
> > Are tree objects really needed?
>
> Yes.  For performance reasons, since a simple commit would kill you in any
> reasonably sized repo.

That's not an obvious conclusion. A new commit is just a series of
edits to the previous commit. Start with the previous commit, edit it,
delta it and store it. Storing of the file objects is the same. Why
isn't this scheme fast than the current one?


>
> Hth,
> Dscho
>


-- 
Jon Smirl
jonsmirl@gmail.com
