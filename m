From: "Mikael Magnusson" <mikachu@gmail.com>
Subject: Re: [Bug] for-each-ref: %(object) and %(type) unimplemented
Date: Wed, 25 Jun 2008 21:08:30 +0200
Message-ID: <237967ef0806251208u65c17652gc6091da98294f807@mail.gmail.com>
References: <48625DAD.5040404@gmail.com>
	 <20080625160814.GA3321@sigill.intra.peff.net>
	 <20080625161433.GA6612@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Cc: "Lea Wiemann" <lewiemann@gmail.com>,
	"Junio C Hamano" <gitster@pobox.com>,
	"Git Mailing List" <git@vger.kernel.org>
To: "Jeff King" <peff@peff.net>
X-From: git-owner@vger.kernel.org Wed Jun 25 21:09:49 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KBaN9-0006fZ-HT
	for gcvg-git-2@gmane.org; Wed, 25 Jun 2008 21:09:39 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753968AbYFYTIc (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 25 Jun 2008 15:08:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753962AbYFYTIc
	(ORCPT <rfc822;git-outgoing>); Wed, 25 Jun 2008 15:08:32 -0400
Received: from rv-out-0506.google.com ([209.85.198.234]:12309 "EHLO
	rv-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753904AbYFYTIb (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 25 Jun 2008 15:08:31 -0400
Received: by rv-out-0506.google.com with SMTP id k40so8334648rvb.1
        for <git@vger.kernel.org>; Wed, 25 Jun 2008 12:08:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from:to
         :subject:cc:in-reply-to:mime-version:content-type
         :content-transfer-encoding:content-disposition:references;
        bh=FbpykNduTt4iuKs5Z7057n50aapAxU7HukgsgKIWI5Q=;
        b=KdZe6Xe+so7N+ymebGadaj7ElrIb6OA/W12qvCPlRrybweOqE7Zw2QXkh3xkQY/UJL
         KgBeSReRETX5YOgBojCViszWI2He1fkZx1GCJGomYI9/9QM2pT7L4Bb+e9p1Y1M4li8m
         ZlZSbn+3REYHVbB7RbHviy96PwNWaIkx1gREg=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:to:subject:cc:in-reply-to:mime-version
         :content-type:content-transfer-encoding:content-disposition
         :references;
        b=Jt9Nm3+Ct00RkfpBJ89nAU7z/cYuImlSOQbXs2Kiih5r9Tqk7gMbxUSF3x0nS774ja
         LH3Zfs7V9JXNnxmAWHi5JWUaZJRzl5B5tsAluYzS70cMlbAfr3i7Myb3qkO4OnVi47pF
         /q6z6fziM/Nxz7mY60x0jOYtIEqV5wkuRFzKQ=
Received: by 10.141.123.4 with SMTP id a4mr16719004rvn.172.1214420910671;
        Wed, 25 Jun 2008 12:08:30 -0700 (PDT)
Received: by 10.141.68.4 with HTTP; Wed, 25 Jun 2008 12:08:30 -0700 (PDT)
In-Reply-To: <20080625161433.GA6612@sigill.intra.peff.net>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/86323>

2008/6/25 Jeff King <peff@peff.net>:
> On Wed, Jun 25, 2008 at 12:08:15PM -0400, Jeff King wrote:
>
>> Since you seem to be testing for-each-ref, maybe it would make sense to
>> put together a test script that exercises each of the atoms?
>
> Hmm. Actually, there is a test in t6300 that runs with each atom name.
> Unfortunately, it doesn't bother actually checking the output for
> sanity, so the fact that these atoms returned the empty string was
> missed.

The documentation also says "tree" and "parent" should work (which they
also don't).

-- 
Mikael Magnusson
