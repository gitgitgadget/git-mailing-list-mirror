From: cte <cestreich@gmail.com>
Subject: linking libgit.a in C++ projects
Date: Thu, 31 Jul 2008 02:53:37 -0700
Message-ID: <ac9f0f090807310253v1d97e2a1n4ddf34aa4fdc79f0@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Jul 31 11:54:52 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KOUrz-0001eU-2x
	for gcvg-git-2@gmane.org; Thu, 31 Jul 2008 11:54:51 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752264AbYGaJxj (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 31 Jul 2008 05:53:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752447AbYGaJxj
	(ORCPT <rfc822;git-outgoing>); Thu, 31 Jul 2008 05:53:39 -0400
Received: from yw-out-2324.google.com ([74.125.46.29]:37056 "EHLO
	yw-out-2324.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751689AbYGaJxi (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 31 Jul 2008 05:53:38 -0400
Received: by yw-out-2324.google.com with SMTP id 9so259253ywe.1
        for <git@vger.kernel.org>; Thu, 31 Jul 2008 02:53:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from:to
         :subject:mime-version:content-type:content-transfer-encoding
         :content-disposition;
        bh=hY+ZtI5Gb2c21+YZhW8PSdzOI6P/UhWlIVgJYTSImik=;
        b=nlS1SzbzmlSDb9hLsXWm1FEfVtGJBME3ameB7iG6wi62vet4KolMN07LCiUJ3ba3CP
         Gg8vEMODB4/yuwUObKnA9oVOPJfHTZ9Gg+9DyyZ7pXz0LIPmNishczpArXoW8iHSNvDw
         J6eRdwp3XcgPaFb0TE1HNCpqosKaBgbZ+11pY=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:to:subject:mime-version:content-type
         :content-transfer-encoding:content-disposition;
        b=DYdqu/t77Ntb7Vsq00nw/c/Z4gPhikjjPr80Z9wRQ1dGCCRRPV/icqSQUhr/bswycr
         yZAwAiVWnAzmIcnuQ4THWHzz9+wEMS8ykfWsPErGPi+PyNipOXGkKOmPqM+ntmFD4T75
         tQcxuAylIBKyTKkCyBtCD2UTh5EB8wkD+y3Fo=
Received: by 10.151.45.2 with SMTP id x2mr911826ybj.90.1217498017419;
        Thu, 31 Jul 2008 02:53:37 -0700 (PDT)
Received: by 10.151.78.17 with HTTP; Thu, 31 Jul 2008 02:53:37 -0700 (PDT)
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/90919>

I'm writing a git gui for OS X using cocoa/Objective-C++, and rather
than being lame and parsing the output the various git commands, I'm
using libgit.a to provide all of the needed functionality for my app.
However, the git source uses a few reserved C++ keywords; namely
'typename', and 'new'. So, I was wondering if it is worth submitting a
patch to fix these issues... I'm asking because I'm new to the whole
open source thing, and I don't want to get yelled at by the git
maintainers for submitting stupid patches that no one in their right
mind would accept :)

Thanks!
