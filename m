From: Pavan Kumar Sunkara <pavan.sss1991@gmail.com>
Subject: Re: web-based client for Git, was Re: GSoC 2010
Date: Fri, 12 Feb 2010 17:28:25 +0530
Message-ID: <e72faaa81002120358k3cb99e26wedd5b4a81f4ad0b8@mail.gmail.com>
References: <fabb9a1e1002101223o6a00f7eavb84567c1119c8ebc@mail.gmail.com>
	 <20100211214833.GU9553@machine.or.cz>
	 <201002120502.43565.chriscool@tuxfamily.org>
	 <e72faaa81002120222p19db9c75u737e2615c14930b1@mail.gmail.com>
	 <e72faaa81002120226y5e4b1c28tbaf6a7dccb9634dc@mail.gmail.com>
	 <alpine.DEB.1.00.1002121149470.20986@pacific.mpi-cbg.de>
	 <20100212113538.GV9553@machine.or.cz>
	 <e72faaa81002120355t4c8596d0q66da4aeb4cce3a94@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Cc: Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Git List <git@vger.kernel.org>
To: Petr Baudis <pasky@suse.cz>
X-From: git-owner@vger.kernel.org Fri Feb 12 12:58:35 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1NfuAJ-0007cj-WD
	for gcvg-git-2@lo.gmane.org; Fri, 12 Feb 2010 12:58:32 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756326Ab0BLL61 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 12 Feb 2010 06:58:27 -0500
Received: from mail-yx0-f196.google.com ([209.85.210.196]:41296 "EHLO
	mail-yx0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756243Ab0BLL60 (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 12 Feb 2010 06:58:26 -0500
Received: by yxe34 with SMTP id 34so477789yxe.15
        for <git@vger.kernel.org>; Fri, 12 Feb 2010 03:58:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :date:message-id:subject:from:to:cc:content-type;
        bh=PQmCgogiPrqk7MYV5xx9M67qva8VP5c+OcNuhg0v/W0=;
        b=Ith+V8YNh7CW9OLZKG3DTg+fTJw4npTGsQZ+8AZb5q4Ru6CESTMRgC+ygsoiF+unzj
         63HbQgpKh9wIfpqoN3gmF+vMPekkTP0DmLoI2p2oIPF+jyzY0qS21mM5yeIGb6bC6fEJ
         mRL3ImwkC194IrN0T16hQzRG5fLCSXSXKVxM0=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        b=NYVzMRAD3+Am2RWTl+JiLatZbkPpJhZ1Cs1R5jtB47G8eprp/iL/jT12Oxpt7rfqCd
         ESO3q3fOjCOx+wCN2EROwzRx/3D5qh3WTdomoh1GdE2OQxW+n18L9dndkkwZgu7x1nc5
         Wg7aBnpAo1fHq5Dfbt6doP20kHYsFCPcCyzws=
Received: by 10.91.50.9 with SMTP id c9mr1310354agk.116.1265975905171; Fri, 12 
	Feb 2010 03:58:25 -0800 (PST)
In-Reply-To: <e72faaa81002120355t4c8596d0q66da4aeb4cce3a94@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/139690>

I would be happy to elaborate this.

First of all, this is not another gitweb or gitorious.
This is a client to use git. I mean, you could use this to work on git
repositories. (even editing files)

This program can be used in 2 ways. One, Use it locally and Two,
hosted in a website for many users

It's structure will be like this:
* When you start this program by typing gittor in terminal, A new
window will be opened with your preferred browser
* It will take you directly to you repositories overview whose file
paths have been previously provided by you.
* Now after selecting a repository, you can explore among the commits,
diffs, blames, trees (similiar to git web)
* But also you will have other options like
  # Edit file: Opens a browser based syntax highlighted file editor.
  # See status: See the status of current working repository(git status)
  # See diff: See diffs
  # Create and/or Change branches
  # Add/Remove files.
  # Show functionalities
  # Commit with log messages
  # Push/Pull remote repositories
  # Garbage collection
  # And all other major functionalities while using git on a working repository

So, as u see, it is a combination of gitweb and GUI client to use git.
This opens in a internet browser, because it's easy to write GUI for it.(HTML)

Also it can be used by companies by hosting it in a website and ask
their members to login and work on it by website URL.

But mostly this will be used locally.

-pavan
