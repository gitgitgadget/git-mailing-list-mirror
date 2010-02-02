From: Tay Ray Chuan <rctay89@gmail.com>
Subject: Re: Delivery Status Notification (Failure)
Date: Tue, 2 Feb 2010 12:15:26 +0800
Message-ID: <be6fef0d1002012015q2a10af1cq4c5e5f968039ee45@mail.gmail.com>
References: <a362e8011001290617n326a9dcx7c345ec31dff4ebe@mail.gmail.com>
	 <001636ed7681994278047e4e4a6f@google.com>
	 <a362e8011001290618g542be5f5y2777a925ba9bd936@mail.gmail.com>
	 <1976ea661001290704h3ed4761dscf95ba848b373555@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Cc: Laszlo Papp <djszapi@archlinux.us>, git@vger.kernel.org,
	normalperson@yhbt.net
To: Frank Li <lznuaa@gmail.com>
X-From: git-owner@vger.kernel.org Tue Feb 02 05:15:45 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1NcAAy-0001U0-Iw
	for gcvg-git-2@lo.gmane.org; Tue, 02 Feb 2010 05:15:44 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753965Ab0BBEPa (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 1 Feb 2010 23:15:30 -0500
Received: from mail-iw0-f186.google.com ([209.85.223.186]:57461 "EHLO
	mail-iw0-f186.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753001Ab0BBEP2 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 1 Feb 2010 23:15:28 -0500
Received: by iwn16 with SMTP id 16so623987iwn.5
        for <git@vger.kernel.org>; Mon, 01 Feb 2010 20:15:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :date:message-id:subject:from:to:cc:content-type;
        bh=vRsOi5NEAgWVAfFWGQ0Dd9COW8bVuRZPnHNTSxN/3pY=;
        b=SKRqppZwrnFD3pVWNyqQ2sm4F+gBSByAKDv+W89PQtaPdU16q2DSqyxcaJMN1xJMF1
         NNIZdH8nwF3I5LZPLXFPQ/erJEfDJ3czSo7BKx/kO6lXsSbArRpMys7xXgHjGhdkW/3r
         dP/35GaU0t+rp8DXuxk/yxRGOaCbB1PmyPsXk=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        b=QMe4nw91a/5EjXST131S3y06N8slfD7ej1it/JDAyABoTJI28Kfekcn8lXkG8dGAB3
         /oBAidWDKtwliGyW+rfRG9W1B/xQlKj3SWAV1k7gk++qFAreV4Rqm6Kx00x2gWIjy5Ox
         mRgdZkjN1prAa1+2Bd6dc54/FQUj6PrrN7lIc=
Received: by 10.231.151.197 with SMTP id d5mr2813351ibw.73.1265084126627; Mon, 
	01 Feb 2010 20:15:26 -0800 (PST)
In-Reply-To: <1976ea661001290704h3ed4761dscf95ba848b373555@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/138675>

Hi,

On Fri, Jan 29, 2010 at 11:04 PM, Frank Li <lznuaa@gmail.com> wrote:
> I prefer git-svn can provide environment to launch a external
> application to input password like open ssh.

how about users who are authenticating over http with basic and
digest? How does one go about launching an external app for password
input in those cases?

Please don't take this as a criticism of your personal preference. I
believe this feature would make things convenient for users who want
it - those who don't, nothing changes.

Even ssh (via ssh-keygen) lets you specify the passphrase at
command-run time. Others include htpasswd, htdigest...

-- 
Cheers,
Ray Chuan
