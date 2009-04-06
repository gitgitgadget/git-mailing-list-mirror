From: Dmitry Potapov <dpotapov@gmail.com>
Subject: Re: non-ascii filenames issue
Date: Tue, 7 Apr 2009 02:33:36 +0400
Message-ID: <37fcd2780904061533o73b393b4j1358ea6259fbd33a@mail.gmail.com>
References: <20090405093640.GA9803@home> <87ab6v2zor.fsf@iki.fi>
	 <20090405100127.GA12126@home>
	 <43d8ce650904050351p72590d52l8861b3901f95201a@mail.gmail.com>
	 <alpine.DEB.2.00.0904060823400.21376@ds9.cixit.se>
	 <alpine.DEB.1.00.0904061109330.10279@pacific.mpi-cbg.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: Peter Krefting <peter@softwolves.pp.se>,
	Teemu Likonen <tlikonen@iki.fi>, git@vger.kernel.org
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Tue Apr 07 00:35:47 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LqxPu-0000Ca-4j
	for gcvg-git-2@gmane.org; Tue, 07 Apr 2009 00:35:46 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756863AbZDFWdm (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 6 Apr 2009 18:33:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1757390AbZDFWdl
	(ORCPT <rfc822;git-outgoing>); Mon, 6 Apr 2009 18:33:41 -0400
Received: from mail-fx0-f158.google.com ([209.85.220.158]:59485 "EHLO
	mail-fx0-f158.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758033AbZDFWdi (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 6 Apr 2009 18:33:38 -0400
Received: by fxm2 with SMTP id 2so2094309fxm.37
        for <git@vger.kernel.org>; Mon, 06 Apr 2009 15:33:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :date:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=GjQd8bYJeV4wajQ4JyxXBLqcNGW8DEYtqh9JZ+2Ezck=;
        b=FjAkOsHQVEMpgyq+dXtMObyGMeSHXL1Mk22yAn2QZJCOHDmea0Qb0nsaAK8I9pIFt5
         QjIYgT1wgDStYJ0REEveAC1EA1RoqnxqrNqdhXluRdQ0JqJWlTr1bWzRLIxCuPLp+SOa
         bbvuUifSSDKpu82Ovuubuipb/Zzh3eo5Gi5O8=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=ZbFztpnzcoqEFb57LpgW/cNaCLAI2DoCVVyjHGVr7+zk0B2cutBdo6FZWBgcRhtK1o
         ZHLMkZDj9ziwxplQBP4AmEPkx5HxiDGxfNBB3GTKLMJ+7/9JpvAMp0nUa2RtlPscUW3D
         b686WwRT9Wv2i3FTmeU5CApochHwRxxpMtRQU=
Received: by 10.86.36.17 with SMTP id j17mr3515260fgj.19.1239057216183; Mon, 
	06 Apr 2009 15:33:36 -0700 (PDT)
In-Reply-To: <alpine.DEB.1.00.0904061109330.10279@pacific.mpi-cbg.de>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/115889>

On Mon, Apr 06, 2009 at 11:12:35AM +0200, Johannes Schindelin wrote:
>
> Most Russian programmers I know do not run in a UTF-8 locale.

Actually, on Linux, people gradually switching to UTF-8 from koi8-r,
but on Windows MSCRT does not support UTF-8, so you do have much choice
here but to use Windows-1251. BTW, the upcoming Cygwin 1.7 is going to
have UTF-8 as the default locale. So, IMHO, UTF-8 is the only reasonable
choice for internal file name representation...

Dmitry
