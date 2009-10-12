From: Martin Langhoff <martin.langhoff@gmail.com>
Subject: Re: Supressing sorting of trees
Date: Mon, 12 Oct 2009 22:24:16 +0200
Message-ID: <46a038f90910121324s34c29133t7ba4558771bf404f@mail.gmail.com>
References: <loom.20091012T152113-874@post.gmane.org>
	 <20091012142032.GG9261@spearce.org>
	 <loom.20091012T171550-239@post.gmane.org>
	 <alpine.DEB.1.00.0910121803360.4985@pacific.mpi-cbg.de>
	 <loom.20091012T182258-9@post.gmane.org>
	 <46a038f90910121236x6bbe258bwa3bc3fdcc54de524@mail.gmail.com>
	 <DF65B4B0-62B1-4469-99E1-3305434F9D59@into-technology.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Cc: git@vger.kernel.org
To: Salvatore Mangano <smangano@into-technology.com>
X-From: git-owner@vger.kernel.org Mon Oct 12 22:34:34 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MxRb8-00014W-Jk
	for gcvg-git-2@lo.gmane.org; Mon, 12 Oct 2009 22:34:26 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757946AbZJLUYy (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 12 Oct 2009 16:24:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1757931AbZJLUYy
	(ORCPT <rfc822;git-outgoing>); Mon, 12 Oct 2009 16:24:54 -0400
Received: from mail-ew0-f208.google.com ([209.85.219.208]:44614 "EHLO
	mail-ew0-f208.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757628AbZJLUYy (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 12 Oct 2009 16:24:54 -0400
Received: by ewy4 with SMTP id 4so2774072ewy.37
        for <git@vger.kernel.org>; Mon, 12 Oct 2009 13:24:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :date:message-id:subject:from:to:cc:content-type;
        bh=h6uqk4LwAU3BMGO7ADk8djUniVPIkS9F8bg+ZEOX3BY=;
        b=c/T+2vijVvzWtbCqT6EfiN1y8Ne3vRlOSPzL05KEkEV8d1KLE1klre5pr8t97mZisQ
         E+LBb66SrLjseML1WG5gTVHZkyo5qLKq4NYXVAwHcLEKeGkfhQZeuwZaD82zx/oolpX8
         sG2jmTksBQRnCZQrTxMHN0+iVmRzH0jLaaD+A=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        b=hvNtW1vD7tsjJ6MIYXmdYzPR/g4/UFQotp7eh7KzzErMp8E/WbNrzSOsioSvlKOlEl
         x7iN0TeWaMlleyMJQnuKicCLvWEvgKCmuxpQVCiLiNtHgJq3Towps9aDHZmiq5vQwT8t
         TvA5H8QoiUeC9HfyvI5WwcqLCrwylp1OxG3uc=
Received: by 10.211.153.20 with SMTP id f20mr4520875ebo.1.1255379056071; Mon, 
	12 Oct 2009 13:24:16 -0700 (PDT)
In-Reply-To: <DF65B4B0-62B1-4469-99E1-3305434F9D59@into-technology.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/130061>

On Mon, Oct 12, 2009 at 10:02 PM, Salvatore Mangano
<smangano@into-technology.com> wrote:
> point to specific code

Shaun pointed out some very core code. And it is just a core concept.
Just read up on the core organizing concept that is the "tree". Git
relies on the layout of the tree being strictly deterministic.

It is a prevalent assumption in the whole codebase.

Yes you can change it, but assume you will have to audit/rewrite 80%
of the core code.

Want "proof"? Go change it, then try "make  test", or reimport a large
repository try to use the git commands over it. We'll relax and watch
the fireworks :-)



m
-- 
 martin.langhoff@gmail.com
 martin@laptop.org -- School Server Architect
 - ask interesting questions
 - don't get distracted with shiny stuff  - working code first
 - http://wiki.laptop.org/go/User:Martinlanghoff
