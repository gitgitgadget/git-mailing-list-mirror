From: "Sean Kelley" <svk.sweng@gmail.com>
Subject: Embedded Linux development with GIT
Date: Thu, 5 Jul 2007 00:50:34 -0500
Message-ID: <a2e879e50707042250w22fe570cp4dda316e6b0f4cea@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Jul 05 07:50:38 2007
connect(): Connection refused
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1I6KEg-0001Tm-JU
	for gcvg-git@gmane.org; Thu, 05 Jul 2007 07:50:38 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755165AbXGEFug (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 5 Jul 2007 01:50:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755502AbXGEFuf
	(ORCPT <rfc822;git-outgoing>); Thu, 5 Jul 2007 01:50:35 -0400
Received: from nz-out-0506.google.com ([64.233.162.233]:41386 "EHLO
	nz-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754953AbXGEFuf (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 5 Jul 2007 01:50:35 -0400
Received: by nz-out-0506.google.com with SMTP id s18so1757722nze
        for <git@vger.kernel.org>; Wed, 04 Jul 2007 22:50:34 -0700 (PDT)
DKIM-Signature: a=rsa-sha1; c=relaxed/relaxed;
        d=gmail.com; s=beta;
        h=domainkey-signature:received:received:message-id:date:from:to:subject:mime-version:content-type:content-transfer-encoding:content-disposition;
        b=qu8RQJIpVo6P9YqOjaJUDF9VMRksjOHOqmm7UnvmNMiT25tv/MRGrgaLQmD4VwoYoQRpHO/hpwaw917A682/m4eZQTR/fEpMMaktckFJ5wQ+QvgSYEuvUhE9Auxe5bfP4ggGPp7R79f2JWWx2jZDHovqR9FliLKb2AT/jRmufnI=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=beta;
        h=received:message-id:date:from:to:subject:mime-version:content-type:content-transfer-encoding:content-disposition;
        b=ra6CYVcr+CAT8t/z5qr7AIl3ywA9qUhEnSFEInuCKPamLYkmphFGz59lgxdEgMvrcEj4MxiOuJydBqpeqIvyZ8H7wxH3oC0NCChF2QLN/eDtB1QSVu1W3/vYyFwKSrVz9iPunZxkYnGxzYM+p7ag6hNpSDQFhZhnxxwjBrhPu0c=
Received: by 10.114.24.1 with SMTP id 1mr7818870wax.1183614634100;
        Wed, 04 Jul 2007 22:50:34 -0700 (PDT)
Received: by 10.114.203.4 with HTTP; Wed, 4 Jul 2007 22:50:33 -0700 (PDT)
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/51658>

Hi,

I have a situation where we have a local GIT repository that is based
on v2.6.17.  We initially added the source tarball to an empty
repository and then started applying changes to it.  Looking back,
that might not have been the best idea 400 commits later.

My goal is to eventually bring our repository closer to mainline
revisions so as to make it easier to actually contribute back to the
community.  So how can I fix my repository so as to give it visibility
to Linus' kernel?

Here is my initial thoughts:

1) Clone kernel.org kernel and it is Master
2) Create a local Head based on 2.6.17 and call it Local
3) Pull my existing heavily patched repository into the Local branch and merge

Is it possible then to see our 400 odd commits then in the Local
branch on top of 2.6.17 so that we can see not only our history but
also the history that came before?  Then as Master advances we can see
about backporting and bringing our code close enough to mainline
kernel to actually be able to contribute back to the community and
submit patches.  Is this realistic approach.  I am unsure of the GIT
commands that I need to do this?

Thanks,

Sean
