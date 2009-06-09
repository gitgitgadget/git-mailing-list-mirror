From: Avery Pennarun <apenwarr@gmail.com>
Subject: Re: Git merge selective files
Date: Tue, 9 Jun 2009 14:32:14 -0400
Message-ID: <32541b130906091132sc5a647cn5fe0289ff9793cc3@mail.gmail.com>
References: <34b359190906090253v653ecc71q6684f4ebff2be59d@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: joe higton <draxil@gmail.com>
X-From: git-owner@vger.kernel.org Tue Jun 09 20:33:21 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1ME68N-0007Hn-Uc
	for gcvg-git-2@gmane.org; Tue, 09 Jun 2009 20:33:20 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752987AbZFIScd convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 9 Jun 2009 14:32:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752950AbZFIScd
	(ORCPT <rfc822;git-outgoing>); Tue, 9 Jun 2009 14:32:33 -0400
Received: from mail-gx0-f214.google.com ([209.85.217.214]:57893 "EHLO
	mail-gx0-f214.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752386AbZFIScc convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 9 Jun 2009 14:32:32 -0400
Received: by gxk10 with SMTP id 10so209735gxk.13
        for <git@vger.kernel.org>; Tue, 09 Jun 2009 11:32:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :from:date:message-id:subject:to:cc:content-type
         :content-transfer-encoding;
        bh=XsTDHK9odJ9GBXJk2k3KTwXYgx6QxTQSXf3YZpt6yKE=;
        b=x/ewd1l4p1v+wOGdAoXF3Am0C27SKLKbSHanEhnBWzH+CVZlYDCg/QVIWGYkDEW28u
         wz2BAiK5R8X005tmHTekA/KdPEk2eiFhqBzBaXsrBZrwbWGZDlVJBbY94LcYIHxDLCkN
         a8C2WVuKF4ZbyUQQvuqLDDjE6Hog/F4iLQgzA=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type:content-transfer-encoding;
        b=vH1sk5ppG2TXhX1objcw6niginBZuFHgbqt8btB1PEvQRB0wWJtB27FP0TZpfauMNj
         oOWP016bsDNuYaDTn0762tE2qRZ/J9LLifUgge23drC3uRe3nqPh81DFdEK2KF5p+1L2
         vDBgZMBkbhXNwpbxh0YKa43a0zttWfBwvI8W8=
Received: by 10.151.69.9 with SMTP id w9mr948266ybk.49.1244572354315; Tue, 09 
	Jun 2009 11:32:34 -0700 (PDT)
In-Reply-To: <34b359190906090253v653ecc71q6684f4ebff2be59d@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/121200>

On Tue, Jun 9, 2009 at 5:53 AM, joe higton<draxil@gmail.com> wrote:
> =A0 =A0 I want to merge changes from a branch but only to one file, I
> don't want to pick up the changes from other files. I've scoured
> google and the docs a bit but I can't find anything useful. Is this
> possible?

You might want to try just using

    git diff old-version new-version | patch -p1

(where old-version and new-version are the appropriate commit ids or
branch names or whatever)

And then committing the results.

Have fun,

Avery
