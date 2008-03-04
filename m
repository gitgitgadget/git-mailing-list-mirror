From: "Whit Armstrong" <armstrong.whit@gmail.com>
Subject: Re: t3900-i18n-commit.sh problem on Solaris
Date: Tue, 4 Mar 2008 11:14:30 -0500
Message-ID: <8ec76080803040814l694a0a11i6aa8e2c9f608413c@mail.gmail.com>
References: <8ec76080803040751y4bf808f9ma83a9faa4f857039@mail.gmail.com>
	 <e2b179460803040811y38e639b6wa83857c49b55aa05@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: "Mike Ralphson" <mike.ralphson@gmail.com>
X-From: git-owner@vger.kernel.org Tue Mar 04 17:15:16 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JWZnM-0000x2-KY
	for gcvg-git-2@gmane.org; Tue, 04 Mar 2008 17:15:13 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1763838AbYCDQOd (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 4 Mar 2008 11:14:33 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1763841AbYCDQOd
	(ORCPT <rfc822;git-outgoing>); Tue, 4 Mar 2008 11:14:33 -0500
Received: from wr-out-0506.google.com ([64.233.184.234]:3949 "EHLO
	wr-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1763838AbYCDQOc (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 4 Mar 2008 11:14:32 -0500
Received: by wr-out-0506.google.com with SMTP id 50so1301557wra.13
        for <git@vger.kernel.org>; Tue, 04 Mar 2008 08:14:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        bh=C3KmOx5XQ6Kww930xzJmwtWQFWVAGYtE4kZpTv95oMU=;
        b=nkHZQmcjnkEnPu1O8Mz/zESe5K1/VmGi4l+ZdKqlDNyePMvqDkJ4v1yLKSKq+XgZVPlDKjrF04v7DSrWjaj84Kx4X3NKEfa6oA1IPJ3BULF9Bw5KBQun0PkPgarxjiYWVykR2COStyqPGCmxHgrTEQ+iK46ZIvMBbPoR6Pd7B5w=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=DonRjVdi1F7VJnBLUc1SgaLPcUK9aPiudBFeqD5vP0RgKYcJ3uf2bHzi9KenOCueSerC6DztthNTb2h7ArOZMBeoKWoDEIuEe6QLdMc4Ua1e3Lsc+s9lfKXrK0mXBJ0YfxLur2/NGrpuWpKl1pFctb7ZcY5hplnC1X3Q1/fHdL0=
Received: by 10.141.87.13 with SMTP id p13mr723971rvl.62.1204647270404;
        Tue, 04 Mar 2008 08:14:30 -0800 (PST)
Received: by 10.141.201.19 with HTTP; Tue, 4 Mar 2008 08:14:30 -0800 (PST)
In-Reply-To: <e2b179460803040811y38e639b6wa83857c49b55aa05@mail.gmail.com>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/76115>

will give that a try and come back.

On Tue, Mar 4, 2008 at 11:11 AM, Mike Ralphson <mike.ralphson@gmail.com> wrote:
> On 04/03/2008, Whit Armstrong <armstrong.whit@gmail.com> wrote:
>  > this is with git latest: c95b3ad9ea310ec89e31a21edecaaf2c374e2c46
>  >  (GIT_VERSION = 1.5.4.3.447.gc95b3)
>  >
>  >
>  >  xs5-trd-p1.grn:warmstro> sh t3900-i18n-commit.sh -i -v
>  >  ...
>  >  ...
>  >  ...
>
> >  * FAIL 22: ISO-2022-JP should be shown in EUCJP now
>  >
>
> >  Is this a Solaris problem?
>
>  Could be. Some builtin iconv() functions / libiconv implementations
>  don't seem to have support for all of the character encodings git
>  expects.
>
>  Are you able to link against a current GNU libiconv instead?
>
>  Mike
>
