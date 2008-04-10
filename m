From: "Ian Brown" <ianbrn@gmail.com>
Subject: Creating a patch set with git-format-patch
Date: Thu, 10 Apr 2008 11:51:59 +0300
Message-ID: <d0383f90804100151s6ffde16al6035116c27c9cb3a@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Apr 10 10:52:57 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JjsWW-0003Hl-G6
	for gcvg-git-2@gmane.org; Thu, 10 Apr 2008 10:52:48 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754726AbYDJIwE (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 10 Apr 2008 04:52:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754008AbYDJIwD
	(ORCPT <rfc822;git-outgoing>); Thu, 10 Apr 2008 04:52:03 -0400
Received: from fg-out-1718.google.com ([72.14.220.159]:52372 "EHLO
	fg-out-1718.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754662AbYDJIwB (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 10 Apr 2008 04:52:01 -0400
Received: by fg-out-1718.google.com with SMTP id l27so2697723fgb.17
        for <git@vger.kernel.org>; Thu, 10 Apr 2008 01:52:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from:to:subject:mime-version:content-type:content-transfer-encoding:content-disposition;
        bh=F61gy5sAGsIAUbc4NBwGxXA58aJPhbSQmPkYwKb8hBQ=;
        b=DPpNelTY3UhCNHLiDbKk6207L9rhvoTH87vfV/6eW6J7wzj8L7UVhX7dTpeammjdMKZddKKBZr1VfDBSLS0SxfJBmmJPJEBXUmwRisuT+rKdT5amMR5lfTNQ7tWMZVEmWDxb3TL2sw5eVvwI1C/G82uc25BbTVKEciVcFPWlM5w=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:to:subject:mime-version:content-type:content-transfer-encoding:content-disposition;
        b=LDF7VzvMFiJe4P37P69Vjxoxer+iOYef9LGl8aXE4TwKYj3HnwJ59W69PkD9GuUsi2BOrS9cp4AezEHV/YU44QSvmavKiup75/sxE8skaz2WQvmxk3baUSrmAXADd1ShUtsLPy6HPWpYOYRarDM47bFpsr6QqnLUDwGJoB/MH60=
Received: by 10.86.70.8 with SMTP id s8mr2586371fga.29.1207817520003;
        Thu, 10 Apr 2008 01:52:00 -0700 (PDT)
Received: by 10.86.33.3 with HTTP; Thu, 10 Apr 2008 01:51:59 -0700 (PDT)
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/79199>

Hello,
  I have a question regarding creating a patch set with git-format-patch:
I had downloaded a git repository of the Linux kernel.

I intend to  make a change in two files: net/ipv4/route.c and
include/net/dst.h and send a
patch set of two patches for review.
Now I want to create this  patch set of two pathces correctly;
First patch for net/ipv4/route.c and second for include/net/dst.h.

what should I do ?

Regards,
Ian
