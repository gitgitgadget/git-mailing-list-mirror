From: "Rado Dr." <radodr@gmail.com>
Subject: Fwd: git status & seg.fault
Date: Tue, 26 Oct 2010 08:44:56 +0200
Message-ID: <AANLkTinghepgdMRjEBhpAMz-Mr0g7szKyYEDfE=ttstS@mail.gmail.com>
References: <AANLkTinymMtDKt1V9xb+adJiSoOKT8YSy1qHuHc_=yVq@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Oct 26 08:45:29 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PAdHj-0002U6-Pu
	for gcvg-git-2@lo.gmane.org; Tue, 26 Oct 2010 08:45:28 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757262Ab0JZGpB convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 26 Oct 2010 02:45:01 -0400
Received: from mail-gy0-f174.google.com ([209.85.160.174]:57701 "EHLO
	mail-gy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756817Ab0JZGo5 convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 26 Oct 2010 02:44:57 -0400
Received: by gyg4 with SMTP id 4so2606480gyg.19
        for <git@vger.kernel.org>; Mon, 25 Oct 2010 23:44:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:received:in-reply-to
         :references:date:message-id:subject:from:to:content-type
         :content-transfer-encoding;
        bh=HQ7Fo5/v5M795J2ZqjKLzCjBRgp7ui3tCgxLqSpf21g=;
        b=laaqzWFPqc0l1sT0BuQ0+TUNE6JiAwKU4pzKEWwxk5gb0IX2/JcVDJg4RWuythiZmi
         RwtXDAFCrKtyEjAOHYateayyN9HX1E2du2hDEMdYd43H989IXhQXDWMms4N12LkmG0Ox
         9vUQiSH+DgDGK/wwuW2UdKK3/ERoWt/V8PEcE=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :content-type:content-transfer-encoding;
        b=aogYUeXJDqD4+pA66Vzq6XDTje2UfPiLC82TwaPE6BMLBD/FHswELiIhDZF9F2/JZz
         M+sY05j1xUb03Oylx6nAsXbkE6F/skTODXVZdrMeBKKqVS5VfzY2Lk2hgrlRvdAcxXHy
         utlzky4rJBhuCzEde5C1hOVW7GtJit6rzsPXs=
Received: by 10.151.83.13 with SMTP id k13mr2758945ybl.54.1288075496318; Mon,
 25 Oct 2010 23:44:56 -0700 (PDT)
Received: by 10.151.49.3 with HTTP; Mon, 25 Oct 2010 23:44:56 -0700 (PDT)
In-Reply-To: <AANLkTinymMtDKt1V9xb+adJiSoOKT8YSy1qHuHc_=yVq@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/159982>

Hi there,

I have "Segmentation fault" error after "git status" command in one of
my local repos. Just i one repo, other repos are OK. I can't find any
clue how to fix it, and as usually I need work with that repo ;-)

I tried this:
=A0- git gc =A0-> OK
=A0- git fsck ->
missing blob 0000000000000000000000000000000000000000
dangling blob 2f1f0144f786ca887c4911a064bbb28a047f1f77
dangling blob 7ffb0f4e430cd60261661138df61ecb50cf1d0a4

Is this the reason of fault? If yes, how can=A0I fix it.

My system info:
Linux 32bit,=A0Ubuntu 10.04 LTS - Lucid Lynx,
git version 1.7.0.4

Thank you for help
Rado Dr.
