From: "Anatoly Yakovenko" <aeyakovenko@gmail.com>
Subject: Re: cant get git to work over http
Date: Tue, 19 Feb 2008 11:06:13 -0800
Message-ID: <e26d18e40802191106v51c907bdn6aa51acef5f530a3@mail.gmail.com>
References: <e26d18e40802181649l3c03df82l4eb91c88bec47bf4@mail.gmail.com>
	 <20080219063937.GB3819@glandium.org>
	 <e26d18e40802182309l693b2099wb42573aca7348091@mail.gmail.com>
	 <alpine.LSU.1.00.0802191115440.30505@racer.site>
	 <e26d18e40802191019j48a1ceadk4887ffc35100ab0a@mail.gmail.com>
	 <47BB1EC0.601@freescale.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: "Johannes Schindelin" <Johannes.Schindelin@gmx.de>,
	"Mike Hommey" <mh@glandium.org>, git@vger.kernel.org
To: "Jon Loeliger" <jdl@freescale.com>
X-From: git-owner@vger.kernel.org Tue Feb 19 20:07:10 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JRXno-0004uS-Ce
	for gcvg-git-2@gmane.org; Tue, 19 Feb 2008 20:06:52 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754594AbYBSTGR (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 19 Feb 2008 14:06:17 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753951AbYBSTGR
	(ORCPT <rfc822;git-outgoing>); Tue, 19 Feb 2008 14:06:17 -0500
Received: from wr-out-0506.google.com ([64.233.184.232]:23666 "EHLO
	wr-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754451AbYBSTGQ (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 19 Feb 2008 14:06:16 -0500
Received: by wr-out-0506.google.com with SMTP id c48so2162257wra.23
        for <git@vger.kernel.org>; Tue, 19 Feb 2008 11:06:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        bh=i78nbkdMZzvsdHoMHxFGf7BeqojKJBhmqMbUahmEO1g=;
        b=ikkg1WUBX+3xadixMVofu8j5BiWUo2Jzb9uAgA8S9cyYn7MGgoQdPR9Er43y+dw6b13ebO4ZGnQGAq9rVpIb6KamdUim8FuoPZgnHlKYKW21cATFwdFnwvRiafane0oDbEDM0+Uf31K7gSDffmKnixkyLCM8szfiPjl89nccoaQ=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=bt7GCGPkRnXggnUZ3+vYBo56F8j6SyjePXw2CNdDL+zMm/rZr8YeMwt8O9VcyDCmBdN3O5lkLumjt0tkFSANEwnphOrfR4QHChN5mspjbYCkKTqwgRmP+BfQudUJAir5LTBRl/TiDq7JYiIKAviG3+cVGCthGpuU8LtvMqQf+nU=
Received: by 10.115.111.1 with SMTP id o1mr1449415wam.87.1203447973951;
        Tue, 19 Feb 2008 11:06:13 -0800 (PST)
Received: by 10.114.167.5 with HTTP; Tue, 19 Feb 2008 11:06:13 -0800 (PST)
In-Reply-To: <47BB1EC0.601@freescale.com>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/74444>

> > If you often merge with the same branch, you may want to
> > configure the following variables in your configuration
> > file:
> >
> >     branch.master.remote = <nickname>
> >     branch.master.merge = <remote-ref>
> >     remote.<nickname>.url = <url>
> >     remote.<nickname>.fetch = <refspec>
> >
> > See git-config(1) for details
>
> Did you follow this advice?  You've set up the
> origin's URL now, and so it knows from where the
> fetch step will happen, but have you set up the
> merge step yet?  Does it know what branches to
> merge on that pull request?

i dont understand what these values should be.
http://www.kernel.org/pub/software/scm/git/docs/howto/setup-git-server-over-http.txt
 doesn't mention anything about configuring them.  So why cant i have
git working the same way over http as it does over ssh and the
filesystem?
