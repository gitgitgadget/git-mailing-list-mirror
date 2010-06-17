From: Nazri Ramliy <ayiehere@gmail.com>
Subject: Re: moving a remote branch?
Date: Thu, 17 Jun 2010 14:19:59 +0800
Message-ID: <AANLkTimTSU7Db7cMlC0ZxQ47IoBUr4Ee4G-GfgDoYLmK@mail.gmail.com>
References: <AANLkTikA5jGl1LiU2sNTN1NP_syTfPAeLF7sS6dBozyN@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: Thomas Anderson <zelnaga@gmail.com>
X-From: git-owner@vger.kernel.org Thu Jun 17 08:20:09 2010
connect(): No such file or directory
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OP8SO-0007lO-Iw
	for gcvg-git-2@lo.gmane.org; Thu, 17 Jun 2010 08:20:08 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752927Ab0FQGUB convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 17 Jun 2010 02:20:01 -0400
Received: from mail-gy0-f174.google.com ([209.85.160.174]:49640 "EHLO
	mail-gy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751023Ab0FQGUA convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 17 Jun 2010 02:20:00 -0400
Received: by gye5 with SMTP id 5so4673866gye.19
        for <git@vger.kernel.org>; Wed, 16 Jun 2010 23:19:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:received:in-reply-to
         :references:date:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=7JfBhqB13EfY4Fpf58YavB/aOuRr+poNFD5Z/ggGxX0=;
        b=DwokZ8Q3WLmnkmqekJA0aR64zv7Ac/k3I1An7BoLlI2y1h7rBFs6asNa2A23gmumHR
         gLlBwVY4Q/OJ3Thebxsxe36HIVyR6jRNxUYULUK6WXW/j2y5S8W4uhdVCHqFPKzSMt4I
         Rah/jaPGAoItg1MfFlzLMzUXGnhAwvLXipzoU=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=GLReybhM5ccmInzqrW8PC59Cz1nVPozqxnFSv6TJHq3uBdNu6DKhqZy5MKayROZwN3
         85A5e3xxQ4WczBRCzYj8UFqXWBnTC5QHd6Ah82EzocQMdKpHiMG02B9kIcvxcZYyL4dA
         VEqN2zVlyCj5dLLe6O1xwQ7M2Vv8rEyfxk2g0=
Received: by 10.91.164.27 with SMTP id r27mr7339536ago.77.1276755599349; Wed, 
	16 Jun 2010 23:19:59 -0700 (PDT)
Received: by 10.90.29.10 with HTTP; Wed, 16 Jun 2010 23:19:59 -0700 (PDT)
In-Reply-To: <AANLkTikA5jGl1LiU2sNTN1NP_syTfPAeLF7sS6dBozyN@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/149291>

On Thu, Jun 17, 2010 at 12:35 PM, Thomas Anderson <zelnaga@gmail.com> w=
rote:
> git branch -m origin/zelnaga/featurea origin/zelnaga/featureb doesn't
> seem to be working for me. =A0Instead, I get this error:l
>
> error: refname refs/heads/origin/zelnaga/featurea
> fatal: Branch rename failed
>
> Any ideas?

The error  message could be improved here.

The reason you get the error is because you were asking git
to rename a "remote" branch, which it refuses to do because,
well, it's a remote branch, and for all practical purposes git
won't allow you to modify any "remote" stuff as they are all
read-only from our point of view.

If you run "git remote -v" you'll most likely see that "origin"
is listed in the output which means that your "origin/zelnaga/featurea"
is a remote branch because its name begin with "origin/".

Hope this helps.

nazri.
