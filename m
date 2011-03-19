From: Nguyen Thai Ngoc Duy <pclouds@gmail.com>
Subject: Re: About Summer of code idea -- better big-file support
Date: Sat, 19 Mar 2011 20:48:25 +0700
Message-ID: <AANLkTikHigPhaWkiozsurbxjvR5WkAGW9LUtFRT9tK8=@mail.gmail.com>
References: <AANLkTi=Z_4cGBSPQW2YVuj=dd8mcO4YQ0G2owknt7vfw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Git <git@vger.kernel.org>
To: =?UTF-8?B?5b6Q6L+q?= <xudifsd@gmail.com>
X-From: git-owner@vger.kernel.org Sat Mar 19 14:49:07 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Q0wWh-0003pv-19
	for gcvg-git-2@lo.gmane.org; Sat, 19 Mar 2011 14:49:07 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752263Ab1CSNtA convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sat, 19 Mar 2011 09:49:00 -0400
Received: from mail-ww0-f42.google.com ([74.125.82.42]:42466 "EHLO
	mail-ww0-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752130Ab1CSNs6 convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Sat, 19 Mar 2011 09:48:58 -0400
Received: by wwk4 with SMTP id 4so2136102wwk.1
        for <git@vger.kernel.org>; Sat, 19 Mar 2011 06:48:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc:content-type:content-transfer-encoding;
        bh=UnfGD1cMjpLAA8N63zrBRuZUKjafQoB/99nOxCnDKsM=;
        b=pbH0axuI2/qCJXMj3VIA1LTgUfpegXBRPEh6Y4F16YGH7zHjn3iPnU1pxcg1D7JXYh
         cBwl1yN4yEeFd4aXFS7f3onkjcFzW+Yp07bnaCp9bumJ0/WhEiE/NveCU0FqoD/IC94J
         ZVyNJGPOvgbKOHlwpZpGIBc6zQt14g69dXYzs=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type:content-transfer-encoding;
        b=HDZPCBIJSHYVIPznk3wvRW8xtPJJosvYEtKaXazDAtmWhQrTB/azWSKxiKW2ZrLtyd
         ieIwFX4psHrIPOQxH8EyNGGJ3/F62F0WGuVJ8Ks+AEFi6mIkF1zxTcTGDpjGZ/fMB5na
         HR82rvSkJtuyzY1g+Go31ekDbuT3pOtjJXmaU=
Received: by 10.216.120.129 with SMTP id p1mr2355084weh.81.1300542535109; Sat,
 19 Mar 2011 06:48:55 -0700 (PDT)
Received: by 10.216.163.202 with HTTP; Sat, 19 Mar 2011 06:48:25 -0700 (PDT)
In-Reply-To: <AANLkTi=Z_4cGBSPQW2YVuj=dd8mcO4YQ0G2owknt7vfw@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/169431>

2011/3/19 =E5=BE=90=E8=BF=AA <xudifsd@gmail.com>:
> So, how do you guys think about that we can test the file type, and t=
hen
> decide to use zlib or not?

We already have core.bigFileThreshold, which can be used to determine
storage type (traditional one with zlib, or some fancy ones for big
files). If that's not enough, .gitattributes can be used to mark
certain files as 'big'.

See below link for recent discussions regarding big file support:

http://thread.gmane.org/gmane.comp.version-control.git/165389/focus=3D1=
68956

On the store of big files, bup (at github) model might fit in as well
if large files change a small portion regularly.
--=20
Duy
