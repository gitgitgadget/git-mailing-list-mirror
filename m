From: "Martin Langhoff" <martin.langhoff@gmail.com>
Subject: Re: [PATCH 2/2] Add keyword unexpansion support to convert.c
Date: Wed, 18 Apr 2007 14:50:00 +1200
Message-ID: <46a038f90704171950g4b408fedm1028e7f934a9b53c@mail.gmail.com>
References: <200704171041.46176.andyparkins@gmail.com>
	 <Pine.LNX.4.64.0704170829500.5473@woody.linux-foundation.org>
	 <46250175.4020300@dawes.za.net>
	 <Pine.LNX.4.64.0704171121090.5473@woody.linux-foundation.org>
	 <20070417235649.GE31488@curie-int.orbis-terrarum.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Cc: "Linus Torvalds" <torvalds@linux-foundation.org>,
	"Git Mailing List" <git@vger.kernel.org>,
	"Rogan Dawes" <lists@dawes.za.net>,
	"Andy Parkins" <andyparkins@gmail.com>
To: "Robin H. Johnson" <robbat2@gentoo.org>
X-From: git-owner@vger.kernel.org Wed Apr 18 04:50:37 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1He0Fg-0001Wd-A7
	for gcvg-git@gmane.org; Wed, 18 Apr 2007 04:50:36 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965164AbXDRCuD (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 17 Apr 2007 22:50:03 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965337AbXDRCuD
	(ORCPT <rfc822;git-outgoing>); Tue, 17 Apr 2007 22:50:03 -0400
Received: from wx-out-0506.google.com ([66.249.82.233]:8633 "EHLO
	wx-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S965301AbXDRCuB (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 17 Apr 2007 22:50:01 -0400
Received: by wx-out-0506.google.com with SMTP id h31so16280wxd
        for <git@vger.kernel.org>; Tue, 17 Apr 2007 19:50:00 -0700 (PDT)
DKIM-Signature: a=rsa-sha1; c=relaxed/relaxed;
        d=gmail.com; s=beta;
        h=domainkey-signature:received:received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=PrsJqzEh8fEHFaMVQ0d/0CeiTwGvK1yN5hsmyfYpqBqRgINphAimhYmy0YbfzBRpBam88wiDJSMBh5GB7aUsrPmY5yyrd4Xl0QxwYJXsuHgFOBXiD1oAZdC2YqBhw20v/7Cu4HjA/WqxJ/5fvZpZpWRvUzKqtZPTuemNvRc71zc=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=beta;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=kRC/Lhzdz4Ru60UiyYyVcmanMNaBmCWhwyke0+zVkrhIfmADaJkFSIqcBwbVS7EMCmhDAaVCY/FgOTI971inKnd28ABorv3hN61FtLMDasENCgVWAPBd5eRoJUVTpLhfvT7V+keUVp8pimHRhEaHqb1LUsN5Dk0FRG/6segpgDU=
Received: by 10.90.118.8 with SMTP id q8mr2600621agc.1176864600642;
        Tue, 17 Apr 2007 19:50:00 -0700 (PDT)
Received: by 10.90.52.17 with HTTP; Tue, 17 Apr 2007 19:50:00 -0700 (PDT)
In-Reply-To: <20070417235649.GE31488@curie-int.orbis-terrarum.net>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/44855>

On 4/18/07, Robin H. Johnson <robbat2@gentoo.org> wrote:
> As for a usage case:
> - J.PEBKAC.User gets a a tree (from a tarball or GIT, we should gain the
>   same output)
> - Copies some file outside of the tree (the user is NOT smart enough,
>   and resists all reasonable attempts at edumacation)
> - Modifies said file outside of tree.
> - Contacts maintainer with entire changed file.
> - User vanishes off the internet.

That's a valid case, but as Linus hints, that's a snippet of perl/bash
away to find "closest matches". We could have a

      git-findclosestmatch <head> path/to/scan/ randomfile.c

That would quickly return a few candidates together with the commit
they appear in.

cheers,



martin
