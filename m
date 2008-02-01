From: "Carlos Rica" <jasampler@gmail.com>
Subject: Re: Wishlist: Please add --author to git-tag
Date: Fri, 1 Feb 2008 15:48:42 +0100
Message-ID: <1b46aba20802010648j6f305cbve55d50d1ead74a73@mail.gmail.com>
References: <47A20503.2000603@debian.org>
	 <20080131193550.GB10905@artemis.madism.org>
	 <1b46aba20801311449l774a6213kc33c49c0682c0228@mail.gmail.com>
	 <alpine.LSU.1.00.0801312345520.23907@racer.site>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: "Pierre Habouzit" <madcoder@debian.org>, git@vger.kernel.org
To: "Johannes Schindelin" <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Fri Feb 01 15:49:22 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JKxCj-0001vZ-8R
	for gcvg-git-2@gmane.org; Fri, 01 Feb 2008 15:49:21 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753722AbYBAOss (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 1 Feb 2008 09:48:48 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753359AbYBAOss
	(ORCPT <rfc822;git-outgoing>); Fri, 1 Feb 2008 09:48:48 -0500
Received: from wr-out-0506.google.com ([64.233.184.231]:42603 "EHLO
	wr-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752659AbYBAOsr (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 1 Feb 2008 09:48:47 -0500
Received: by wr-out-0506.google.com with SMTP id c48so1078580wra.23
        for <git@vger.kernel.org>; Fri, 01 Feb 2008 06:48:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        bh=pgawuNCgaSvpqHHz+2pDxO5kjVk71UfWsy8Y24rQnvE=;
        b=TGn3dmkl9TubqWAyZMZvd4EmfuRplOIt1Cvj94F8rEiJou/FzWJU9RwPzyPBZF7zG/SomyPXrcw7Sv0UXYvKMEnj0EWk+1YOZtVYIavQ4/TNG0HiaRl0vIyYsXxMejAt4oSwtCSlMtj4JVp2MHsxxtBAy0oZHYIFPJGEFBr5FqI=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=WybgmgvlcPRhonyIl9z7HnchsEvDKdOY3PD2qgR3tfb1IEvhunUSfdhq6qzge8YJhDOlyQvQr+6rgAdmbodXcFiPUdypzdT4j17r5Jm6ZQruTUeYQHIbK36uDpIjS48bRP4K0qZf5OFMVJB7tACwQngQo8uV8osyuxqzwbAvPEg=
Received: by 10.142.52.9 with SMTP id z9mr2187269wfz.134.1201877322998;
        Fri, 01 Feb 2008 06:48:42 -0800 (PST)
Received: by 10.142.99.13 with HTTP; Fri, 1 Feb 2008 06:48:42 -0800 (PST)
In-Reply-To: <alpine.LSU.1.00.0801312345520.23907@racer.site>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/72176>

On Feb 1, 2008 12:48 AM, Johannes Schindelin <Johannes.Schindelin@gmx.de> wrote:
> Hi,
>
> On Thu, 31 Jan 2008, Carlos Rica wrote:
>
> > On Jan 31, 2008 8:35 PM, Pierre Habouzit <madcoder@debian.org> wrote:
> > > On Thu, Jan 31, 2008 at 05:27:31PM +0000, Daniel Baumann wrote:
> > >
> > > > git commit supports --author to overwrite the author information on
> > > > a particular commit; it would be nice if git tag would offer the
> > > > same.
> > >
> > >   Meanwhile,
> > >
> > >   GIT_AUTHOR_NAME="John Doe" GIT_AUTHOR_EMAIL=luser@example.com git tag
> >
> > That didn't work for me,
>
> Hey jasam, good to see you again.
>
> I think that you have to use "-s" or "-a" for the author information to
> take effect (IOW a lightweight tag will not pick it up, since it is only a
> 41-byte file, and does not change the object database).

This way it doesn't work for me either. You know, the tag object has
only a "tagger", who is always the committer. Currently, I'm inspecting
the resulting object using "git cat-file tag t". I cannot find where that author
name specified in the command line should be stored for tags.

It is nice to see you too!
Carlos
