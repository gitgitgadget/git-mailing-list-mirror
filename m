From: "Sverre Rabbelier" <alturin@gmail.com>
Subject: Re: [PATCH - stgit] Patch to allow import of compressed files
Date: Tue, 10 Jun 2008 11:57:05 +0200
Message-ID: <bd6139dc0806100257k4700d364occ08457279e8a735@mail.gmail.com>
References: <484D78BF.6030504@gmail.com>
	 <20080610063328.GB26965@diana.vm.bytemark.co.uk>
	 <alpine.DEB.1.10.0806092335420.17180@swallowtail>
	 <bd6139dc0806100107y415a292eqe22af7a7b2215e65@mail.gmail.com>
	 <20080610095349.GA30119@diana.vm.bytemark.co.uk>
Reply-To: sverre@rabbelier.nl
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: "Asheesh Laroia" <asheesh@asheesh.org>,
	"Clark Williams" <clark.williams@gmail.com>,
	"Catalin Marinas" <catalin.marinas@gmail.com>, git@vger.kernel.org
To: "=?ISO-8859-1?Q?Karl_Hasselstr=F6m?=" <kha@treskal.com>
X-From: git-owner@vger.kernel.org Tue Jun 10 11:58:03 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1K60c6-0004XZ-B2
	for gcvg-git-2@gmane.org; Tue, 10 Jun 2008 11:58:02 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753346AbYFJJ5I convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 10 Jun 2008 05:57:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751938AbYFJJ5H
	(ORCPT <rfc822;git-outgoing>); Tue, 10 Jun 2008 05:57:07 -0400
Received: from wf-out-1314.google.com ([209.85.200.171]:35499 "EHLO
	wf-out-1314.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751329AbYFJJ5G convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 10 Jun 2008 05:57:06 -0400
Received: by wf-out-1314.google.com with SMTP id 27so2521653wfd.4
        for <git@vger.kernel.org>; Tue, 10 Jun 2008 02:57:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from:reply-to
         :to:subject:cc:in-reply-to:mime-version:content-type
         :content-transfer-encoding:content-disposition:references;
        bh=VQCsQI5mVDwz5BF9IJJVediIWrGzGscuBqNja6ufjvQ=;
        b=YxD6A/zr2Ltgmj5SpNZh1Vn3R52ir5NWGaJ5WnCLhmPTnIAADIp7z4r+2fcRJdGAd3
         sdCeHIcCkw1ykbc25qCu4S/9dEmMyeFX/rs7Za8pM5BD52Z/G0brrWc0JUJeOzh7B2z3
         4iCjffrA8vYFzjYOcX2ciqAFL/NNyxPZQ6MNQ=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:reply-to:to:subject:cc:in-reply-to
         :mime-version:content-type:content-transfer-encoding
         :content-disposition:references;
        b=xB8YYgA237rxBFuRFOUul5RpQd6Nyk0Jf7zQ+1xMKLhVpCHk/WhHaByoEG4EdnpGSp
         z90iZzTCKxlkXu5YETbHQdLV5uXikUuA89UtIfXQ+io6bPfa0/dM/nliQpNT7MR/Y53Q
         FM87ZQJypPVGnoacb9g2SbDcBnki7+aI6CvQw=
Received: by 10.142.213.9 with SMTP id l9mr104107wfg.208.1213091825379;
        Tue, 10 Jun 2008 02:57:05 -0700 (PDT)
Received: by 10.143.38.17 with HTTP; Tue, 10 Jun 2008 02:57:05 -0700 (PDT)
In-Reply-To: <20080610095349.GA30119@diana.vm.bytemark.co.uk>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/84489>

On Tue, Jun 10, 2008 at 11:53 AM, Karl Hasselstr=F6m <kha@treskal.com> =
wrote:
> On 2008-06-10 10:07:25 +0200, Sverre Rabbelier wrote:
>
>> How about adding in '.tar' decompression as well, -after- the '.gz'
>> decompression? That way you can have .tar.gz's and still be fine.
>
> A tar file would presumably contain more than one patch -- it'd be
> more like a directory of patches than a single patch file.

Why?
$ tar czvf mypatch.patch.tar.gz mypatch.patch

> I'm not saying it wouldn't be nice to support it, but it's not what
> the original poster needed, and building it would be a bunch of extra
> work.

A bunch of extra work? http://docs.python.org/lib/module-tarfile.html
I say it'd be about as much work as the original patch ;).

--=20
Cheers,

Sverre Rabbelier
