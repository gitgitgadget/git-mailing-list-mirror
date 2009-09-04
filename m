From: Sverre Rabbelier <srabbelier@gmail.com>
Subject: Re: [PATCH 1/8] Make the "traditionally-supported" URLs a special 
	case
Date: Fri, 4 Sep 2009 07:29:23 +0200
Message-ID: <fabb9a1e0909032229k5e6e2ed5mc11e8ff9c16dfcc0@mail.gmail.com>
References: <alpine.LNX.2.00.0909032213180.28290@iabervon.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: Daniel Barkalow <barkalow@iabervon.org>
X-From: git-owner@vger.kernel.org Fri Sep 04 07:30:31 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MjRNW-0000R8-3K
	for gcvg-git-2@lo.gmane.org; Fri, 04 Sep 2009 07:30:30 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932611AbZIDF3n (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 4 Sep 2009 01:29:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932510AbZIDF3n
	(ORCPT <rfc822;git-outgoing>); Fri, 4 Sep 2009 01:29:43 -0400
Received: from ey-out-2122.google.com ([74.125.78.27]:17513 "EHLO
	ey-out-2122.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932494AbZIDF3m (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 4 Sep 2009 01:29:42 -0400
Received: by ey-out-2122.google.com with SMTP id 25so522346eya.19
        for <git@vger.kernel.org>; Thu, 03 Sep 2009 22:29:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :from:date:message-id:subject:to:cc:content-type;
        bh=k0YOEN9Y5yxHWEgTZc8z4gXaqDSMezFOiEd9f9Yqdk0=;
        b=lorTDAi7cyluedFoYS6KjuoMFBIvCIHu0M/+Am48p5ksCXC30xzN3xUayLSAcat2jf
         86dXKDkvDuxUI56bNkaXTvmjud2dSMXS6FEm72cS5fiQWCJhLSqgVc1DhYK68t/UfD9U
         PfCgi9vfXLgYu0FTPfJTunOCTu33YGn8lqW8g=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        b=A3R+jplejwJyFEtwy99/AdyYDfHLGwgAV9GOe+J+kJ/WvcdCDSvtyokGb0XBSuolNN
         jyccHAB4DLuHehd2hEn5o+9mCask6OVUPO9gfApgDT2x3EhmtWJUcRs9EfMWk2on9gJz
         gzp8M1knLksHaZojshuiRMESFzy6gJruWX2jE=
Received: by 10.216.53.12 with SMTP id f12mr2077568wec.72.1252042183068; Thu, 
	03 Sep 2009 22:29:43 -0700 (PDT)
In-Reply-To: <alpine.LNX.2.00.0909032213180.28290@iabervon.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/127686>

Heya,

On Fri, Sep 4, 2009 at 04:13, Daniel Barkalow<barkalow@iabervon.org> wrote:
> Instead of trying to make http://, https://, and ftp:// URLs
> indicative of some sort of pattern of transport helper usage, make
> them a special case which runs the "curl" helper, and leave the
> mechanism by which arbitrary helpers will be chosen entirely to future
> work.

I'm sorry, I missed a few emails I think :(. Would you mind explaining
why we chose to special-case the curl helpers instead of the symlink
scheme?

-- 
Cheers,

Sverre Rabbelier
