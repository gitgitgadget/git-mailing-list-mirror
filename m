From: gapon <gapon007@gmail.com>
Subject: Re: git bug/feature request
Date: Tue, 27 Nov 2007 12:16:25 +0100
Message-ID: <200711271216.25283.gapon007@gmail.com>
References: <200711271127.41161.gapon007@gmail.com> <7A14A564-C424-4ACC-A860-A11DCC38C9A1@lrde.epita.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: Benoit Sigoure <tsuna@lrde.epita.fr>
X-From: git-owner@vger.kernel.org Tue Nov 27 12:17:05 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IwyQs-0003wf-Ip
	for gcvg-git-2@gmane.org; Tue, 27 Nov 2007 12:16:51 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751834AbXK0LQc convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 27 Nov 2007 06:16:32 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751204AbXK0LQc
	(ORCPT <rfc822;git-outgoing>); Tue, 27 Nov 2007 06:16:32 -0500
Received: from ug-out-1314.google.com ([66.249.92.171]:50755 "EHLO
	ug-out-1314.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751079AbXK0LQc convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 27 Nov 2007 06:16:32 -0500
Received: by ug-out-1314.google.com with SMTP id z38so1209488ugc
        for <git@vger.kernel.org>; Tue, 27 Nov 2007 03:16:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:subject:date:user-agent:cc:references:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:message-id;
        bh=b84IZtQFfG6r3XaGgiHs3MdCRD5nYOELH7LoTkZpHeM=;
        b=CTLOol+DAVJX1YiTEwFqrA32BB4nkyHAVu8gWkbsFtcP02e9wp1LJHdB9yYWCV7rLVbmQWXbVnwuy8ECb4wmZtLpbr885tAiDNaT5tPcbc3e2rlvkLqrDS8OjGpjdkLcwp4OPLwipO+M1OZioi3CVJr93oZ4OVegb5J2whH4sKs=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=received:from:to:subject:date:user-agent:cc:references:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:message-id;
        b=bm9koZ4zXNJLNmr4axpxqHPdLq07F6F1FsxbxHmBbR02FoLKAEN0v0+bO5aM6cZpB7Hc54x2qtRe/lSymh+S3i6M9RyxB3EtIO/kJSQF03du8HoKEJ5Vh5WeY+8yMOsB8UMk4B5ffyoZI90MiEu+go3W2FVeo3zqGcIH/Y7Alt0=
Received: by 10.82.146.14 with SMTP id t14mr1352139bud.1196162190419;
        Tue, 27 Nov 2007 03:16:30 -0800 (PST)
Received: from dhcp-eprg06-20-185.czech.sun.com ( [192.9.112.196])
        by mx.google.com with ESMTPS id p9sm4290841fkb.2007.11.27.03.16.28
        (version=SSLv3 cipher=OTHER);
        Tue, 27 Nov 2007 03:16:28 -0800 (PST)
User-Agent: KMail/1.9.7
In-Reply-To: <7A14A564-C424-4ACC-A860-A11DCC38C9A1@lrde.epita.fr>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/66186>

bzr:
while pushing, bzr tries to merge into the current working copy (of A)
-> all changes are applied or conflicts occure

hg:
while pushing, neither merge nor info message, but new head (branch) is=
=20
created in repo A - so then in A you can commit your changes but it's=20
different head (repo A has more heads, use hg heads to list them)
btw i filed and enhancement for hg, to let user know that there are mor=
e heads=20
in the repo (you have to use hg log or hg heads to discover that someon=
e else=20
has pushed into your repo and hg merge to merge them)

gapon


Dne =FAter=FD 27 listopadu 2007 Benoit Sigoure napsal(a):
> On Nov 27, 2007, at 11:27 AM, gapon wrote:
> > * yes, i know that this scenario is "incorrect" but... it's
> > possible and
> > therefore i think it should be somehow handled - i tried a similar
> > one with
> > hg and bzr and i like their behaviour more
>
> Would you mind describing the behavior of hg and bzr in this case?
>
> I was also bitten by this "feature" of Git.  Until I decided to put a
> bare repo in between and push my commits there.
