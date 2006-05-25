From: "Cameron McBride" <cameron.mcbride@gmail.com>
Subject: git-cvsserver wart?
Date: Thu, 25 May 2006 12:42:49 -0400
Message-ID: <dcedf5e20605250942g6a7417dfh5f2f26df29842def@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII;
	format=flowed
Content-Transfer-Encoding: 7BIT
X-From: git-owner@vger.kernel.org Thu May 25 18:43:06 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FjIvG-0004kX-Pz
	for gcvg-git@gmane.org; Thu, 25 May 2006 18:42:55 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030267AbWEYQmv (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 25 May 2006 12:42:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030269AbWEYQmv
	(ORCPT <rfc822;git-outgoing>); Thu, 25 May 2006 12:42:51 -0400
Received: from nz-out-0102.google.com ([64.233.162.199]:36657 "EHLO
	nz-out-0102.google.com") by vger.kernel.org with ESMTP
	id S1030267AbWEYQmu convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 25 May 2006 12:42:50 -0400
Received: by nz-out-0102.google.com with SMTP id 18so1844275nzp
        for <git@vger.kernel.org>; Thu, 25 May 2006 09:42:49 -0700 (PDT)
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:mime-version:content-type:content-transfer-encoding:content-disposition;
        b=E2qTCTQ0Lem1rOkMVuri17RgCAC3tt/ClPuxGKjX9TGnNbN8onaz5KzlHYZs5DqTCqdfhtwIYuu6s7FunejJ8CDBKzPoxTUR2UYqr2iZ13Q+Dh44vTyw8PtUdmeSgUSVkkNMdJZ+ALTJniIgIgFZITI4yL6IXY2ez2nzjoZAPO0=
Received: by 10.64.24.20 with SMTP id 20mr757983qbx;
        Thu, 25 May 2006 09:42:49 -0700 (PDT)
Received: by 10.65.53.4 with HTTP; Thu, 25 May 2006 09:42:49 -0700 (PDT)
To: git@vger.kernel.org
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/20747>

I'm a new git user, so if I'm doing something boneheaed - sharp kicks
are welcome.

For reasons I won't go into, the ability to use cvs clients is darn
near crucial.  Although most development is local (where I install /
use git), pulling down the latest updates and pushing up minor changes
via CVS is helpful at remote locations where I don't want to maintain
clients.  Git with git-cvsserver makes this very nice.   Thanks to
all!

Now, the problem I ran into:

code/ntropy> cvs up
Can't use an undefined value as an ARRAY reference at
/usr/local/bin/git-cvsserver line 761.
closing dbh with active statement handles
cvs [update aborted]: end of file from server (consult above messages if any)
code/ntropy> cvs -v
Concurrent Versions System (CVS) 1.11.1p1 (client/server)

Doing a 'cvs up -dP' (or either of the two individually) seems to work fine.

so, it's an old client, a newer client doesn't have this problem.  a
bare 'cvs up' works fine on:
Concurrent Versions System (CVS) 1.11.17 (client/server)

Just to be clear, it appears everything gets updated with the
workaround - but there might be something else amiss, so I thought it
was worth mentioning.

Cameron

p.s.  I'm assuming the following statement is harmless (it's always present):
closing dbh with active statement handles
