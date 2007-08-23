From: "Jon Smirl" <jonsmirl@gmail.com>
Subject: gitweb-projects
Date: Thu, 23 Aug 2007 17:38:53 -0400
Message-ID: <9e4733910708231438q4c454686p55cef622e61d6a2a@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
To: "Git Mailing List" <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Thu Aug 23 23:39:41 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IOKOw-0002wY-Vn
	for gcvg-git@gmane.org; Thu, 23 Aug 2007 23:39:39 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932405AbXHWVi6 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 23 Aug 2007 17:38:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1765985AbXHWVi5
	(ORCPT <rfc822;git-outgoing>); Thu, 23 Aug 2007 17:38:57 -0400
Received: from rv-out-0910.google.com ([209.85.198.189]:54105 "EHLO
	rv-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932380AbXHWViy (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 23 Aug 2007 17:38:54 -0400
Received: by rv-out-0910.google.com with SMTP id k20so492975rvb
        for <git@vger.kernel.org>; Thu, 23 Aug 2007 14:38:53 -0700 (PDT)
DKIM-Signature: a=rsa-sha1; c=relaxed/relaxed;
        d=gmail.com; s=beta;
        h=domainkey-signature:received:received:message-id:date:from:to:subject:mime-version:content-type:content-transfer-encoding:content-disposition;
        b=XuoFYUyk9FD8/zn7NM5BE6RTUx1YU+N2icSl0DnO4h0M5kQCF15kY+ZpZTGqSNi2cfUcCsYI8Xm0OS4D8KFUHag5X4OkQYlai6ZTbyH1fK+UFQ+SxzcJKqkzOpWlS8MtTXuKYYcsRq4bZggpuF4mGT7A3vvl3B5G2Iclrw9OaRs=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=beta;
        h=received:message-id:date:from:to:subject:mime-version:content-type:content-transfer-encoding:content-disposition;
        b=jQKNUnM2keR0a0dPeCxecIluJv38OmdqBvcOUTmBzQ9ZpjPSmSvU7iy7UQ8HQANQnSjwOYedwV9HK6ddfsJIOXaAkCTsj6yrM0DZNnR/5pYUCGhppwdfGWaD5xON6a7QmNIZNa3+1V2klNFgYK/nfs61vYkkVSDchShP/LsTYDw=
Received: by 10.115.60.1 with SMTP id n1mr594851wak.1187905133810;
        Thu, 23 Aug 2007 14:38:53 -0700 (PDT)
Received: by 10.114.195.5 with HTTP; Thu, 23 Aug 2007 14:38:53 -0700 (PDT)
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/56535>

What is the magic incantation for encoding an email address along with
the project owner name? From the source I see these strings need to be
URL encoded (it doesn't seem to be in the doc) but now I'm getting XML
errors.

I tried this:
mpc5200b.git Jon+Smirl+%3Cjonsmirl%2664%3Bgmail.com%3E

Does this string really need to be URL encoded? Couldn't you split on
the first space and then url encode it in the perl code? That would
let me write the string in English instead of geek.

mpc5200b.git Jon Smirl <jonsmirl@gmail.com>

-- 
Jon Smirl
jonsmirl@gmail.com
