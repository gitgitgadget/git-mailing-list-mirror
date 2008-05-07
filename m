From: "Sitaram Chamarty" <sitaramc@gmail.com>
Subject: creating tracking branches with git gui
Date: Wed, 7 May 2008 13:34:43 +0530
Message-ID: <2e24e5b90805070104i337f9196g90134d11f35a1094@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed May 07 10:06:30 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Jteef-0001J2-04
	for gcvg-git-2@gmane.org; Wed, 07 May 2008 10:05:58 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754567AbYEGIEr (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 7 May 2008 04:04:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754100AbYEGIEr
	(ORCPT <rfc822;git-outgoing>); Wed, 7 May 2008 04:04:47 -0400
Received: from ti-out-0910.google.com ([209.85.142.191]:33277 "EHLO
	ti-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754062AbYEGIEo (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 7 May 2008 04:04:44 -0400
Received: by ti-out-0910.google.com with SMTP id b6so44435tic.23
        for <git@vger.kernel.org>; Wed, 07 May 2008 01:04:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from:to:subject:mime-version:content-type:content-transfer-encoding:content-disposition;
        bh=JwBK9IfIRjCRnGLGeUFCUnmhBuMETPjWu9G483IxgPA=;
        b=ieNI4xewsydkRvop2n46Ey4hlywIbJG57CIzuJa/DHZw1rV/mjJvzIMetsbEMg4so9cJp2X5GZ4NE1n9dQnERDaRDSfo3mhp16oCxtHGig630dV5WR+tHhqPxR2ARmgVpc8q2E0TLlRmN8v/57JXDX1iz4bFgkhOjVNWyQOP7k4=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:to:subject:mime-version:content-type:content-transfer-encoding:content-disposition;
        b=D0aXAxcHduEbeM7S5PgW5n8AABtF421PY5J0Yl8VtBAj3pMVhcJJWCtWKS7wCBfMOm53+3iW5na3VhsOpjiMKTWMTfMTKpciI6zmYKJtcEwupI2rQ0ynjft3X4S2nqw/9fVDmna7+dxx9oAi7yEZ4gGacc3/MuH4vWulbAMof9Q=
Received: by 10.110.53.11 with SMTP id b11mr164537tia.57.1210147483179;
        Wed, 07 May 2008 01:04:43 -0700 (PDT)
Received: by 10.110.105.1 with HTTP; Wed, 7 May 2008 01:04:43 -0700 (PDT)
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/81411>

Hello,

Using git gui to create tracking branches only creates the local
branch, but does not establish tracking.  Using the command "git
branch newbr origin/newbr" works as expected of course.

I clicked on "Branch", then "Create", chose the "Match Tracking Branch
Name" radio button, chose the appropriate branch (origin/newbr) in the
list below, then finally hit Create at the bottom right.

I can write up a more detailed note if required but I thought I'd ask
if this was a bug in my understanding first :-)

Thanks,

Sitaram
