From: "Matt Graham" <mdg149@gmail.com>
Subject: Re: [PATCH] make git-status use a pager
Date: Thu, 24 Apr 2008 09:12:51 -0400
Message-ID: <1c5969370804240612i1dbd2f6dn842adc605b1bd4df@mail.gmail.com>
References: <1208998668-28770-1-git-send-email-bart@jukie.net>
	 <alpine.DEB.1.00.0804240920170.26553@eeepc-johanness>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Cc: "Bart Trojanowski" <bart@jukie.net>, git@vger.kernel.org
To: "Johannes Schindelin" <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Thu Apr 24 15:13:54 2008
connect(): Connection refused
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Jp1Gl-0006QO-LJ
	for gcvg-git-2@gmane.org; Thu, 24 Apr 2008 15:13:48 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752596AbYDXNMy (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 24 Apr 2008 09:12:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756293AbYDXNMy
	(ORCPT <rfc822;git-outgoing>); Thu, 24 Apr 2008 09:12:54 -0400
Received: from rn-out-0910.google.com ([64.233.170.191]:25010 "EHLO
	rn-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752382AbYDXNMx (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 24 Apr 2008 09:12:53 -0400
Received: by rn-out-0910.google.com with SMTP id e11so1359411rng.17
        for <git@vger.kernel.org>; Thu, 24 Apr 2008 06:12:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        bh=COKTSLdk2IgJGhzmkSR+hX0hNcx2nPxF30fXI2dWdHA=;
        b=XYIPvZy0iZPLK18XHx2d2a5IlPOBFuQRHji0BTvifKZ8i3lIAU1aXjkyshrSWMmyWTfgrM2ZMEZsBOsFRSF9SxLZfrqJDkJNo2Xtc/BfBY8cNzKl5MtPePYBTSLA0mitV4u0nt0d9lRYpebEy6rkLay45yTpX+A8oy8xxyUEme0=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=s7PM2PA0+MvrJDAZDmTeDGwuVlDwErrXUkndMtlwObBK7PUoBNyUloVc1UKHP35whkaLuhG/Gf3eYPkSbJ++iBbVYxtJZxVO7bZsRn+2S2W610TV0ik885HcPliFXoFanZrAyl5VI8P3YPehqbUIa2RDtKee8iS0GYLGgOoHm+8=
Received: by 10.142.77.11 with SMTP id z11mr464019wfa.23.1209042771770;
        Thu, 24 Apr 2008 06:12:51 -0700 (PDT)
Received: by 10.142.170.10 with HTTP; Thu, 24 Apr 2008 06:12:51 -0700 (PDT)
In-Reply-To: <alpine.DEB.1.00.0804240920170.26553@eeepc-johanness>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/80303>

On Thu, Apr 24, 2008 at 4:21 AM, Johannes Schindelin
<Johannes.Schindelin@gmx.de> wrote:
> Hi,
>
>  On Wed, 23 Apr 2008, Bart Trojanowski wrote:
>
>  > make git status act similar to git log and git diff by presenting long
>  > output in a pager.
>
>  Heh.  The first thing I do on new machines is to compile and install Git.
>  The second is "git config --global alias.ps '-p status'"  :-)
>
>  So I obviously like your patch.

Yes.  This also helps those of use who didn't know you could alias
status to always page and were constantly typing git status |less.
Thanks!
