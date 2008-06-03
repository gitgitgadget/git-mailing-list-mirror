From: "Matt Pearson" <404emailnotfound@gmail.com>
Subject: Re: Pushing an --amend-ed commit
Date: Mon, 2 Jun 2008 20:08:48 -0400
Message-ID: <706b4240806021708u4ade0f9ake53e26f53e34d97d@mail.gmail.com>
References: <6B355924-0EA9-4AF8-B051-F17FC4530495@manchester.ac.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: "Git Mailing List" <git@vger.kernel.org>
To: "Robert Haines" <rhaines@manchester.ac.uk>
X-From: git-owner@vger.kernel.org Tue Jun 03 02:10:09 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1K3K6G-0001gY-V1
	for gcvg-git-2@gmane.org; Tue, 03 Jun 2008 02:10:05 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753501AbYFCAJA (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 2 Jun 2008 20:09:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752887AbYFCAI7
	(ORCPT <rfc822;git-outgoing>); Mon, 2 Jun 2008 20:08:59 -0400
Received: from yw-out-2324.google.com ([74.125.46.31]:5310 "EHLO
	yw-out-2324.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752696AbYFCAI7 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 2 Jun 2008 20:08:59 -0400
Received: by yw-out-2324.google.com with SMTP id 9so649023ywe.1
        for <git@vger.kernel.org>; Mon, 02 Jun 2008 17:08:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        bh=s1Mq7SM6fPCvx5HHulkQ4aD5eTqJEjq+b8VL8Prtv1o=;
        b=tAa3AegVOVCMfMTgDwcQKmc92ZzGfAJRToWK1At7XDdfRLlNGrKolSp+mwejGq8lxDZYquXr40eRK60BNwfIinUlX7scDsWaC3RQyIbCf4ZPuGIiYj6JyJBnpzdnuGrWScufKyYAOQBRbQZ0gApDwIMgwWts3KXwt6ZemoDm1qY=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=WhWydbxodqeoTlz16K2RQbpdmFNasmHs6nKFBApiDp04zjiiDd7RKveF26PowgDj/adr73Lk5X3ufd1ylipX0aW8Zjf7bFUfSatL2tfbMmqMyKjDCyvphrTbm++JWK7JeJI9d9qdJkB2Gcz6QUxoq8EqSDAe7uG/nW1yttqJgow=
Received: by 10.151.108.4 with SMTP id k4mr4802855ybm.230.1212451728570;
        Mon, 02 Jun 2008 17:08:48 -0700 (PDT)
Received: by 10.150.52.8 with HTTP; Mon, 2 Jun 2008 17:08:48 -0700 (PDT)
In-Reply-To: <6B355924-0EA9-4AF8-B051-F17FC4530495@manchester.ac.uk>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/83599>

On Mon, Jun 2, 2008 at 5:51 AM, Robert Haines <rhaines@manchester.ac.uk> wrote:
> So, is it safe to "use the --force" in this instance when pushing? This
> should just replace the old commit with the --amended commit with no
> side-effects, shouldn't it?

Safe from what perspective?  If you're sure nobody has pulled from
you, then yes, it's fine.  If you know exactly who pulled and can
contact them to do a reset and re-pull, then it should be fine. If you
don't care about screwing up people who pulled from you, then I
suppose that's still fine.  However, screwing with history is
generally a bad idea, since now people who pull from you don't have
your current HEAD as a parent commit in their tree.  Finding common
ancestors is going to be messed up (and future merges with them,
possibly).

(also, first git mailing list post.  I hope none of the experienced
people have to correct me)
