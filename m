From: Uri Okrent <uokrent@gmail.com>
Subject: Re: Revert hunk?
Date: Thu, 27 May 2010 21:17:12 -0700
Message-ID: <AANLkTinPrO25SnneENN6ryofn5mZ0a4CxqXSnXBbP2xO@mail.gmail.com>
References: <loom.20100501T215211-11@post.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: git@vger.kernel.org
To: Steve Folly <steve@spfweb.co.uk>
X-From: git-owner@vger.kernel.org Fri May 28 06:17:33 2010
connect(): No such file or directory
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OHr0j-0001D9-P9
	for gcvg-git-2@lo.gmane.org; Fri, 28 May 2010 06:17:30 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752183Ab0E1ERQ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 28 May 2010 00:17:16 -0400
Received: from mail-gw0-f46.google.com ([74.125.83.46]:48610 "EHLO
	mail-gw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752078Ab0E1ERN (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 28 May 2010 00:17:13 -0400
Received: by gwaa12 with SMTP id a12so611106gwa.19
        for <git@vger.kernel.org>; Thu, 27 May 2010 21:17:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:received:in-reply-to
         :references:date:message-id:subject:from:to:cc:content-type;
        bh=C83tagV086MyZ2VMGrln7ZCvxJHaZUAaNN6cJulLqy0=;
        b=Y7pk4Z0t3w5VE32wIMVIWKiTotJRe+I/HiOULVyCYRkrWvygEFvohd0jwQ49LB/rgL
         3on4Cueu8jngAWK3PsHmNPYkRvO8QTDv2ckOjKYRZn+jJpJIhtASgNSnJXWpLbwtUOWD
         vxIis8tpQZFRzIH6xODRQ6XiZbK6IzuYE3VRo=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        b=RFpBKXb6e9f/0LoEZgE0muru4SXVO9SBzWB/Gc+x/gX0a9zj+Lt1NEy3R4xne/mAwS
         S+/Zi9B2y+JOhihKu3YIMNqEXjNBWQXww6TA4wXb2C0D946aQrFuShNN/6qgmUCXHI0X
         zhoX108OVHMIolA4on/YdKw3CRBaMKxPnTkPU=
Received: by 10.231.79.74 with SMTP id o10mr1993562ibk.36.1275020232292; Thu, 
	27 May 2010 21:17:12 -0700 (PDT)
Received: by 10.231.206.129 with HTTP; Thu, 27 May 2010 21:17:12 -0700 (PDT)
In-Reply-To: <loom.20100501T215211-11@post.gmane.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/147912>

On Sat, May 1, 2010 at 12:54 PM, Steve Folly <steve@spfweb.co.uk> wrote:
> git gui has an option to revert changes, but that applies
> to the whole file. Is there an option to revert a line
> or hunk rather than the whole file?

cola has the ability to stage/revert on a per line basis:

http://cola.tuxfamily.org/


-- 
   Uri

Please consider the environment before printing this message.
http://www.panda.org/how_you_can_help/
