From: Reece Dunn <msclrhd@googlemail.com>
Subject: Re: weird rename
Date: Tue, 31 May 2011 20:18:00 +0100
Message-ID: <BANLkTikuZ-ig0einn+GhMh9EJp4jp2TCxg@mail.gmail.com>
References: <7760D048-5534-42A2-82D2-D5BB9C75739C@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: Fabian Zeindl <fabian.zeindl@gmail.com>
X-From: git-owner@vger.kernel.org Tue May 31 21:18:09 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QRUS8-0007jx-Aq
	for gcvg-git-2@lo.gmane.org; Tue, 31 May 2011 21:18:08 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755391Ab1EaTSD convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 31 May 2011 15:18:03 -0400
Received: from mail-iy0-f174.google.com ([209.85.210.174]:39793 "EHLO
	mail-iy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751022Ab1EaTSC convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 31 May 2011 15:18:02 -0400
Received: by iyb14 with SMTP id 14so3897138iyb.19
        for <git@vger.kernel.org>; Tue, 31 May 2011 12:18:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=gamma;
        h=domainkey-signature:mime-version:in-reply-to:references:date
         :message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=gImTWWZ/so3/SqzP7ZyhvN3fLr9i4xMkYRDQLko2Yt4=;
        b=Sc8qOxJfk6QPqlU45S9MYuajJKKZ7iDgNS/BN8uhXLUfzN+SkVCiboxf6Bx0jSAj8B
         wfMIkdgEn2OlbFe5wEgCc0eLx9/YU7SKCdsT7FmntAUBHRmy+mCzOb0vhpHMtGwwYmUp
         FYTZ49a599o74A0Tf3NJnZLCeXZuuyRr9V5BM=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=googlemail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=n9/By9YQp4zurcToCOxCp7yfXQi1qKb/aTWwCTyJgb7yjzViI23p4Q+p5OrQoHgUMp
         DEQUGKiycRZK9Vsx8bDciXHkp7O+t4i3V2rFH3KcqC8pWnCK3wIQQB3Mqg9Jj7au4yJA
         +PVB0g/mYxM310DXB22gNQX0V60lE2unE9MTw=
Received: by 10.42.148.1 with SMTP id p1mr13127590icv.319.1306869480811; Tue,
 31 May 2011 12:18:00 -0700 (PDT)
Received: by 10.42.240.3 with HTTP; Tue, 31 May 2011 12:18:00 -0700 (PDT)
In-Reply-To: <7760D048-5534-42A2-82D2-D5BB9C75739C@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/174823>

On 31 May 2011 20:12, Fabian Zeindl <fabian.zeindl@gmail.com> wrote:
> Hi,
>
> =A0i use a GUI for git and discovered that it showed me a rename in a=
 commit where i actually replaced a file.
> So i looked at the commit via git show, and found the following:
>
> Binary files /dev/null and b/lib/swt-3.7M7-win32.jar differ
> diff --git a/lib/swt-3.7M7-win64.jar b/lib/swt-3.7M7-win64.jar
>
> Where is the /dev/null coming from?

/dev/null is used to indicate "does not exist" -- it is a file device
on Unix boxes that emits null characters or consumes output sending it
to oblivion :)!

Comparing /dev/null with A -- A is a new (added) file.

Comparing A with /dev/null -- A is deleted.

HTH,
- Reece
