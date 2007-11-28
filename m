From: "Jason Sewall" <jasonsewall@gmail.com>
Subject: Re: [RFC] git-gui USer's Survey 2007 (was: If you would write git from scratch now, what would you change?)
Date: Wed, 28 Nov 2007 10:48:13 -0500
Message-ID: <31e9dd080711280748n30972cd1na8be3c705cc6fe93@mail.gmail.com>
References: <200711252248.27904.jnareb@gmail.com> <fiet88$68n$1@ger.gmane.org>
	 <e5bfff550711261125i92fb057i85d7217b18cd495d@mail.gmail.com>
	 <20071127012013.GG14735@spearce.org> <fifstd$ilj$1@ger.gmane.org>
	 <20071127015833.GL14735@spearce.org>
	 <Pine.LNX.4.64.0711271136050.27959@racer.site>
	 <fiib19$dj6$1@ger.gmane.org>
	 <Pine.LNX.4.64.0711281225150.27959@racer.site>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Cc: "Jakub Narebski" <jnareb@gmail.com>,
	"Shawn O. Pearce" <spearce@spearce.org>, git@vger.kernel.org
To: "Johannes Schindelin" <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Wed Nov 28 16:48:40 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IxP9Q-0002Pt-PQ
	for gcvg-git-2@gmane.org; Wed, 28 Nov 2007 16:48:37 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756683AbXK1PsQ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 28 Nov 2007 10:48:16 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755699AbXK1PsQ
	(ORCPT <rfc822;git-outgoing>); Wed, 28 Nov 2007 10:48:16 -0500
Received: from wa-out-1112.google.com ([209.85.146.183]:55288 "EHLO
	wa-out-1112.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751213AbXK1PsP (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 28 Nov 2007 10:48:15 -0500
Received: by wa-out-1112.google.com with SMTP id v27so1782138wah
        for <git@vger.kernel.org>; Wed, 28 Nov 2007 07:48:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        bh=phXDA0IRUTNeAzQR2TDwZbMth96ocan90m0b7O6N75w=;
        b=XrNNnurfKrS9qeEKNQa+Ryj1WocjjL5UCjowXTkIWi/h2COaXJAO0Mj82kSCCy+su2bueFtNhziQu21wTBDKHQoUaF2fnJ6pI+9p818XLJs1JbGq/n5t3Tu/ydDgkEKu82JLcVQW3dP8serJYi90eoU5G8nIg5/Bhf6DcxX1ERQ=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=DJ43Dy2I+9lxq5RYHlgvF92Be9KqYf4USuNhrTe3LXlZRi5oY0kx6vobGraonwHUmfckrlGsoqbWcfTnn9H6qZHic3VSbN2E11oVd8FqXi17roqQrqc1lC7y//SZmAUa7HBpl15R70LwZyQqSaVFvZyKvUZqH13uVH/K1P4P76M=
Received: by 10.115.106.7 with SMTP id i7mr939471wam.1196264893325;
        Wed, 28 Nov 2007 07:48:13 -0800 (PST)
Received: by 10.115.78.17 with HTTP; Wed, 28 Nov 2007 07:48:13 -0800 (PST)
In-Reply-To: <Pine.LNX.4.64.0711281225150.27959@racer.site>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/66357>

On Nov 28, 2007 7:32 AM, Johannes Schindelin <Johannes.Schindelin@gmx.de> wrote:
> Hi,
>
> On Wed, 28 Nov 2007, Jakub Narebski wrote:
>
> > Johannes Schindelin wrote:
> >
> > 1. What language and what toolkit should git-gui be written in?
> >    (single choice)
> >
> >    a. Tcl/Tk    (current implementation)
> >    b. C++/Qt
> >    c. C/GTK+
> >    d. Python    (native)
> >    e. Python/PyQt
> >    f. Python/PyGTK
> >    g. Ruby
> >    h. Java/Swing
> >    i. Java/SWT
> >    j. XUL+JavaScript+CSS/XULRunner
> >    k. other
> >    l. no opinion

Since we're listing off a bunch of toolkits, I should pitch FLTK,
which is well-supported across platforms, reasonably featured, and
pretty lightweight (probably much smaller than any of the other ones
listed, in terms of dependency installs)

That said...

> Personally, I am quite comfortable with the existing implementation, and
> IMHO people dismiss contributing to git-gui too easily; Tcl is not all
> that complicated, and it is not hard at all to change/imitate existing
> code.

Agreed. I don't know much about Tcl/Tk, but I think that git-gui is
fine as-is. It's not very "pretty" compared to all of the fancy Gtk
apps the make up my system, but that's not an obstacle for me. (The
fonts are pretty bad, though)

Jason
