From: "Martin Langhoff" <martin.langhoff@gmail.com>
Subject: Re: git-branch, older repos and more confusion
Date: Thu, 12 Apr 2007 18:16:20 +1200
Message-ID: <46a038f90704112316v4aaa6246s9e07a3af8262b119@mail.gmail.com>
References: <46a038f90704112114t520374b2qea4f860575c21bce@mail.gmail.com>
	 <20070412042308.GA22539@coredump.intra.peff.net>
	 <46a038f90704112205g53ab4750s673f449ee40165b4@mail.gmail.com>
	 <20070412052118.GA30459@coredump.intra.peff.net>
	 <46a038f90704112300k3abd66d0nc4372962dbee8616@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Cc: "Git Mailing List" <git@vger.kernel.org>
To: "Jeff King" <peff@peff.net>
X-From: git-owner@vger.kernel.org Thu Apr 12 08:16:30 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Hbsbd-0006ap-Nb
	for gcvg-git@gmane.org; Thu, 12 Apr 2007 08:16:30 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1945911AbXDLGQW (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 12 Apr 2007 02:16:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1945915AbXDLGQV
	(ORCPT <rfc822;git-outgoing>); Thu, 12 Apr 2007 02:16:21 -0400
Received: from wx-out-0506.google.com ([66.249.82.234]:1489 "EHLO
	wx-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1945911AbXDLGQV (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 12 Apr 2007 02:16:21 -0400
Received: by wx-out-0506.google.com with SMTP id h31so452746wxd
        for <git@vger.kernel.org>; Wed, 11 Apr 2007 23:16:20 -0700 (PDT)
DKIM-Signature: a=rsa-sha1; c=relaxed/relaxed;
        d=gmail.com; s=beta;
        h=domainkey-signature:received:received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=hi36Gok6rkN3/U2nP23l0HOv59YC1J+SzpwEFl9f+U3e9AwS5NxH/GxUUsPL0fblnkLJFWleJsHN5pYawksu3xXtjbg7DdJ/7p4wf91Mhs8VWWrlQtSi5uNKDiiD2+DbdwLdwbnqJG7rmKV+bUBMOOHD0n6plDDHu0qVh9geY9A=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=beta;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=Z42Notlv5EUOatJQQefM4YqiIlsXVDCV4RpPLXZ3/4ypEPxgJK0RKhCUjLheqzRhCwt9gKWDqBS9LvPtfIDBaYso96x0Fni4hWx0wWUUqMik8FP9wXU+Awn9gX/6F0bw4y5imX8AyjklFYGxQ/wQMxw1d6ke7/6vzW6KhOD3x5s=
Received: by 10.90.94.2 with SMTP id r2mr1354587agb.1176358580454;
        Wed, 11 Apr 2007 23:16:20 -0700 (PDT)
Received: by 10.90.120.11 with HTTP; Wed, 11 Apr 2007 23:16:20 -0700 (PDT)
In-Reply-To: <46a038f90704112300k3abd66d0nc4372962dbee8616@mail.gmail.com>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/44326>

On 4/12/07, Martin Langhoff <martin.langhoff@gmail.com> wrote:
> On my own I had gotten almost to the same sequence you show above, but
> couldn't get it right. With what you are showing me now, I'd say

And I think I got it sussed out with:

   git-clone <repo> mydir
   cd mydir
   git-push origin origin/v1.9-maint:refs/heads/v1.9-clientname
   git-checkout --track -b v1.9-clientname origin/v1.9-clientname

cheers,


martin
