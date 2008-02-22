From: "C. E. Ball" <ceball@users.sourceforge.net>
Subject: Re: Interrupted git-svn dcommit, now I get segmentation faults
Date: Fri, 22 Feb 2008 17:13:27 +0800
Message-ID: <4e2a3a120802220113q4df473c0xcaad4760aea7f49b@mail.gmail.com>
References: <loom.20080221T062522-821@post.gmane.org>
	 <47BDD096.7040606@vilain.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: "Sam Vilain" <sam@vilain.net>
X-From: git-owner@vger.kernel.org Fri Feb 22 10:14:16 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JSTyt-0007kW-3F
	for gcvg-git-2@gmane.org; Fri, 22 Feb 2008 10:14:11 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752425AbYBVJNe (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 22 Feb 2008 04:13:34 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752653AbYBVJNd
	(ORCPT <rfc822;git-outgoing>); Fri, 22 Feb 2008 04:13:33 -0500
Received: from ug-out-1314.google.com ([66.249.92.173]:30010 "EHLO
	ug-out-1314.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752206AbYBVJNb (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 22 Feb 2008 04:13:31 -0500
Received: by ug-out-1314.google.com with SMTP id z38so1234909ugc.16
        for <git@vger.kernel.org>; Fri, 22 Feb 2008 01:13:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from:sender:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references:x-google-sender-auth;
        bh=L5E4G12D0LbT4hFLJj5wiExqVUiCysO4aMVDCwdwX5M=;
        b=u902NAS1O36p17VZYAf3/84ca42y8i6t/0iqCfPSQzy+CUGuvdDVUbIC02YH4jV9zhjZL4xiqk/dVMvB4qVb7wzazAlJfexKkl5g9tSkPyIid1bcFT8rDOfofWDxLbwdtILPUWz32r27p+ioGwKgBiJhqAuOBvWZAEjwyy8cFj4=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:sender:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references:x-google-sender-auth;
        b=BUj/J7DU2BzBNteJWkudN3dLZOY+RAAl5ologTZV2tVzMztRY2yVVslVD4qi69+VONhhoTq/RRSuE4Gd3kTAv7RSmfQeAx/GrFZovXbBa6/z8F3ykJLdWhW70ARi/tUnlUlR8XkocQcCtfMBPCArsVnnZ4Pt24Jcyu94e51kmOo=
Received: by 10.67.101.17 with SMTP id d17mr2085308ugm.53.1203671607379;
        Fri, 22 Feb 2008 01:13:27 -0800 (PST)
Received: by 10.86.79.1 with HTTP; Fri, 22 Feb 2008 01:13:27 -0800 (PST)
In-Reply-To: <47BDD096.7040606@vilain.net>
Content-Disposition: inline
X-Google-Sender-Auth: d84c287cb0e65bb3
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/74706>

>  If you get stuff like that you can move the git-svn state out of the
>  way, and re-run git-svn fetch; it will rebuild the metadata.
>
>   $ mv .git/svn .git/svn.bad
>   $ git-svn fetch
>
>  Not a fix I know, but might work for you ;)

Thank you very much, that did work for me!

Chris
