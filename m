From: "Marco Costalba" <mcostalba@gmail.com>
Subject: Re: Bug in gitk search box
Date: Thu, 26 Jul 2007 10:21:33 +0200
Message-ID: <e5bfff550707260121h7970988cybbdaaa4547f61b25@mail.gmail.com>
References: <20070725135621.GC21692@lavos.net>
	 <18087.60033.676105.538784@cargo.ozlabs.ibm.com>
	 <7vtzrrc1sb.fsf@assigned-by-dhcp.cox.net>
	 <18088.10039.780711.708582@cargo.ozlabs.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Cc: "Junio C Hamano" <gitster@pobox.com>,
	"Brian Downing" <bdowning@lavos.net>, git@vger.kernel.org
To: "Paul Mackerras" <paulus@samba.org>
X-From: git-owner@vger.kernel.org Thu Jul 26 10:21:43 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IDybN-0007hC-4t
	for gcvg-git@gmane.org; Thu, 26 Jul 2007 10:21:41 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1759272AbXGZIVh (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 26 Jul 2007 04:21:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1758382AbXGZIVh
	(ORCPT <rfc822;git-outgoing>); Thu, 26 Jul 2007 04:21:37 -0400
Received: from wa-out-1112.google.com ([209.85.146.180]:47919 "EHLO
	wa-out-1112.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757919AbXGZIVe (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 26 Jul 2007 04:21:34 -0400
Received: by wa-out-1112.google.com with SMTP id v27so502973wah
        for <git@vger.kernel.org>; Thu, 26 Jul 2007 01:21:33 -0700 (PDT)
DKIM-Signature: a=rsa-sha1; c=relaxed/relaxed;
        d=gmail.com; s=beta;
        h=domainkey-signature:received:received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=N60fM2g07P9KgCZrbrbCSS/0DOBUgn6zMZcKos9SllGP4lYxZC2Jbhw90wLW5RKm5IJnzM6wW0u3B7uC5LBcjHvjXTY7AVG4GUFHqHq7l4Q5hzybszjlel7Oqt93GCST8ZeimiFodu6sB5mreselvYnXGx8kSMZS+NvA49/36+A=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=beta;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=r65z7IFk5TmzO7sfLr4ZQgP23o+BDh1+VVAplGp2Rj0xXiDc4e+1DXcfrLY6QUbqMBslEmyh2bBMRUc2D/vS5E2Zp/88M4cMEw+EWp87AvMVYeA+IkZaHfvDYjWBmB9E9BzN5C8yyeYu0KooiUkaGGy0FSVPOCOZEoUeeZaYwSE=
Received: by 10.114.130.1 with SMTP id c1mr1494541wad.1185438093748;
        Thu, 26 Jul 2007 01:21:33 -0700 (PDT)
Received: by 10.114.61.9 with HTTP; Thu, 26 Jul 2007 01:21:33 -0700 (PDT)
In-Reply-To: <18088.10039.780711.708582@cargo.ozlabs.ibm.com>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/53806>

On 7/26/07, Paul Mackerras <paulus@samba.org> wrote:
>
> OK, I'll have to change gitk then.  It looks like both Marco and I got
> tricked by this.

Yes. With commit c1672ba272c8e of 22 of Jun I make qgit to always
append a '\0' at the end of the stream so to avoid to change parsing
function.

Marco
