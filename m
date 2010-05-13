From: Avery Pennarun <apenwarr@gmail.com>
Subject: Re: Advice on choosing git
Date: Wed, 12 May 2010 20:31:32 -0400
Message-ID: <AANLkTikc6_jZoMzF1VhfJBSk1DRHCNNP3puPT0Z2Usk5@mail.gmail.com>
References: <4BEA4B46.6010009@smartmediacorp.com> <201005130018.o4D0I7iI079145@kzsu.stanford.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Noah Silverman <noah@smartmediacorp.com>, git@vger.kernel.org
To: Joe Brenner <doom@kzsu.stanford.edu>
X-From: git-owner@vger.kernel.org Thu May 13 02:32:28 2010
connect(): No such file or directory
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OCMLg-00068J-S2
	for gcvg-git-2@lo.gmane.org; Thu, 13 May 2010 02:32:25 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755117Ab0EMAb6 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 12 May 2010 20:31:58 -0400
Received: from mail-gx0-f227.google.com ([209.85.217.227]:43053 "EHLO
	mail-gx0-f227.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751435Ab0EMAb5 convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 12 May 2010 20:31:57 -0400
Received: by gxk27 with SMTP id 27so425605gxk.1
        for <git@vger.kernel.org>; Wed, 12 May 2010 17:31:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:mime-version:received:in-reply-to
         :references:from:date:message-id:subject:to:cc:content-type
         :content-transfer-encoding;
        bh=gr55j4QvuntyiBEWKdI6vZ/KULTtZCyucN5DNBr+eQ4=;
        b=hPH/vGLHaI+kzrnTvFCHL0nzGe0sQL5f8uiCNbTf1hXqAmgMjDAGFhmlYj5plkkIXn
         iPWIiEapEA7rlgOL/HzBuh+r8cmBH08Kxjcg9ugmnprOm4FQ3wneqPqLKdHf+uaQYRT7
         PM9socbsmwamtC2stJMnaSHhZW8NmNLEpxRAo=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type:content-transfer-encoding;
        b=u+FC2OFZxtdGXsjROC989By/PyNja9Ki5Jgc8Fo4f4WSrLj+2DS3yCujgfmd5M9NJ6
         HK0at065CgNbIBH78HUp9sdHUcLcXuGHZ8Lwc2zL4A0GbExe320s0E4bSpMYl/JwgVvm
         LbmPRKl/XjqhMIJJdNRDuSTBu8fNRp8NU5Jrs=
Received: by 10.151.2.38 with SMTP id e38mr12008042ybi.78.1273710712868; Wed, 
	12 May 2010 17:31:52 -0700 (PDT)
Received: by 10.150.217.12 with HTTP; Wed, 12 May 2010 17:31:32 -0700 (PDT)
In-Reply-To: <201005130018.o4D0I7iI079145@kzsu.stanford.edu>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/146971>

On Wed, May 12, 2010 at 8:18 PM, Joe Brenner <doom@kzsu.stanford.edu> w=
rote:
> Noah Silverman <noah@smartmediacorp.com> wrote:
>> 1) Size. =A0THIS IS MY MAIN CONCERN - If I want to sync my home, off=
ice,
>> and server Document directories. =A0From what I have read, I will
>> effectively have multiple copies of each item on my hard drive, thus
>> eating up a lot of space
>
> Pretty much any version control system is going to have this problem,
> and it gets really bad if you've got any files that aren't straight t=
ext.

Note that most people probably don't need to worry about this
nowadays.  Disk $/gigabyte just keeps dropping and is now at
absolutely abysmally small levels.  You can only fill up your disks if
you download tons of movies and/or create tons of VMs.

If you're struggling with a laptop drive that's too small, just buy a
new one for $100 and solve all your problems.

So you're fine with storing multiple copies.  Just make sure your
backup/syncing software has an expiration algorithm so you don't end
up storing *all* the historical copies.

I'd like to adapt bup to support this usage model eventually.
However, I haven't yet written the expiration algorithm and it doesn't
yet support two-way syncing.  The fundamental design allows for this,
though, so it's just a matter of having some free time.  Meanwhile,
you might want to take a look at something like rdiff-backup.

Have fun,

Avery
