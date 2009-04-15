From: Caleb Cushing <xenoterracide@gmail.com>
Subject: Re: git-new-workdir not working right?
Date: Wed, 15 Apr 2009 06:31:04 -0400
Message-ID: <81bfc67a0904150331t6787fcfbjd391013a8235ece0@mail.gmail.com>
References: <81bfc67a0904132109k45f09f79s21ce3132ade02001@mail.gmail.com>
	 <alpine.LNX.2.00.0904141540410.29027@reaper.quantumfyre.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: Julian Phillips <julian@quantumfyre.co.uk>
X-From: git-owner@vger.kernel.org Wed Apr 15 12:32:49 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Lu2Q6-0006VP-S4
	for gcvg-git-2@gmane.org; Wed, 15 Apr 2009 12:32:43 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753183AbZDOKbK convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 15 Apr 2009 06:31:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751911AbZDOKbI
	(ORCPT <rfc822;git-outgoing>); Wed, 15 Apr 2009 06:31:08 -0400
Received: from an-out-0708.google.com ([209.85.132.250]:10516 "EHLO
	an-out-0708.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751014AbZDOKbG convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 15 Apr 2009 06:31:06 -0400
Received: by an-out-0708.google.com with SMTP id d14so2841312and.1
        for <git@vger.kernel.org>; Wed, 15 Apr 2009 03:31:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :date:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=MZdnvWYf8ov/34oBbGLjv/8bEON4tl8kAOpwfKH1lV8=;
        b=jsO5zT9YpOOqk5xSg7uWgIkn8YENkDtkvpbUaR8+TXmDtlj3I2a3Fpwp7Ii/iIhzl/
         u5wYnGj3EVC9TeSFUCSABHD/wfD6zTejSLapbvVCRBk7eByuXMeGQBjx33niD18O5RiC
         PwlRRX7cmL3rYRRF0JzqQjqDI/O2M6zOfn8M0=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=QGtQs9b5JO6I0LU40F4HyoAm4RwzbTqjkAxe6/DPHQIGcFzAwoSD9A0hoZdU5HzvEJ
         SwpJdA4TLtzCt3YpTG+UZwvF6kfBAJUe7LhoWkFft0UbarLUIB6USFfqlgokc6LWGTL+
         8YBXoR7oXXbUD4NNUH6bHY0E5g6HTaigf4w9o=
Received: by 10.100.45.9 with SMTP id s9mr51852ans.133.1239791464796; Wed, 15 
	Apr 2009 03:31:04 -0700 (PDT)
In-Reply-To: <alpine.LNX.2.00.0904141540410.29027@reaper.quantumfyre.co.uk>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/116602>

On Tue, Apr 14, 2009 at 10:47 AM, Julian Phillips
<julian@quantumfyre.co.uk> wrote:
> Works fine for me. =C2=A0Are you sure you didn't have a typo in your =
original
> git-new-workdir invocation? =C2=A0If so, could you supply:
>
> =C2=A01) the complete output of running git-new-workdir
> =C2=A02) the output of "git rev-parse --git-dir" run in path/to/repo/=
=2Egit
>
> Also, you shouldn't need to supply the .git, so "git new-workdir
> path/to/repo newworkdirname" should also work, have you tried that?
>

git-new-workdir portage/ test
/home/port/portdev/.bin/git-new-workdir: line 58: cd:
/home/port/portdev/tree/portage
=2Egit: No such file or directory
/home/port/portdev/tree/test
cp: cannot stat `/home/port/portdev/tree/HEAD': No such file or directo=
ry
fatal: Not a git repository (or any of the parent directories): .git

git-new-workdir portage/.git/ test
/home/port/portdev/.bin/git-new-workdir: line 58: cd:
/home/port/portdev/tree/portage/.git
=2E: No such file or directory
/home/port/portdev/tree/test
cp: cannot stat `/home/port/portdev/tree/HEAD': No such file or directo=
ry
fatal: Not a git repository (or any of the parent directories): .git

git rev-parse --git-dir portage/
fatal: Not a git repository (or any of the parent directories): .git

cd portage/
/home/port/portdev/tree/portage
slave-iv portage $ git rev-parse --git-dir .
=2Egit
=2E

git-new-workdir . ../test/ << seems to work too.


--=20
Caleb Cushing

http://xenoterracide.blogspot.com
