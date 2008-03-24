From: "Catalin Marinas" <catalin.marinas@gmail.com>
Subject: Re: [ANNOUNCE] Stacked GIT 0.14.2
Date: Mon, 24 Mar 2008 23:24:20 +0000
Message-ID: <b0943d9e0803241624ne83602emc1fb4727402555d3@mail.gmail.com>
References: <b0943d9e0803241259s5280cdc1o255a4412b3fa7bfc@mail.gmail.com>
	 <alpine.LNX.1.10.0803242113070.9368@fbirervta.pbzchgretzou.qr>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: git <git@vger.kernel.org>,
	"Linux Kernel Mailing List" <linux-kernel@vger.kernel.org>,
	"Josef Sipek" <jsipek@fsl.cs.sunysb.edu>
To: "Jan Engelhardt" <jengelh@computergmbh.de>
X-From: git-owner@vger.kernel.org Tue Mar 25 00:25:10 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Jdw2N-00054h-FW
	for gcvg-git-2@gmane.org; Tue, 25 Mar 2008 00:25:07 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755354AbYCXXYZ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 24 Mar 2008 19:24:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755218AbYCXXYZ
	(ORCPT <rfc822;git-outgoing>); Mon, 24 Mar 2008 19:24:25 -0400
Received: from wr-out-0506.google.com ([64.233.184.225]:17247 "EHLO
	wr-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754686AbYCXXYY (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 24 Mar 2008 19:24:24 -0400
Received: by wr-out-0506.google.com with SMTP id c48so1962150wra.1
        for <git@vger.kernel.org>; Mon, 24 Mar 2008 16:24:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=beta;
        h=domainkey-signature:received:received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        bh=KunBbbDnicW1dUT1hqc4H2T9O1QPXGIXzDT3EfHyepE=;
        b=FIm9jJB+PNkplSx83YRnbeEKDQO+bmlrESP+AIKiRUavoleKOzOXMjPqBGzHeXXsJtbzZ0PqpPGKR3zyKAuRYFnGH1XPCRrqaOYtV7u141By320qBy8EvYQ+QfQK6wkv4LLynq+veS5OhJ0cPFbnrkPSFCsLoeaibZCUmZYPYSA=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=beta;
        h=message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=WB8KFUmLVCr/cB0uNHuFRrUqsscKpQ3wMxxXGuXN3mxtWf7LZNQqT2xVhPXxfTnYVP9R/vCtmhV2HfT1Vv2ME/TG5v5R67CV2nZVlKjzv9uVg9UEBoSWCS57lA1HVXJPGHvkXD6imOe0dk4QPdEkzmjUrzwdRQvI0QJCxgpsG48=
Received: by 10.141.29.18 with SMTP id g18mr2701147rvj.162.1206401060859;
        Mon, 24 Mar 2008 16:24:20 -0700 (PDT)
Received: by 10.141.175.11 with HTTP; Mon, 24 Mar 2008 16:24:20 -0700 (PDT)
In-Reply-To: <alpine.LNX.1.10.0803242113070.9368@fbirervta.pbzchgretzou.qr>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/78125>

On 24/03/2008, Jan Engelhardt <jengelh@computergmbh.de> wrote:
> On Monday 2008-03-24 20:59, Catalin Marinas wrote:
>
>  > Stacked GIT 0.14.2 release is available from http://www.procode.org/stgit/.
>  >
>  > StGIT is a Python application providing similar functionality to Quilt
>  > (i.e. pushing/popping patches to/from a stack) on top of GIT.
>
>
> I always wondered what the difference between stgit and guilt is.
>  Does anyone have a comparison up?

There was a thread last year:

http://kerneltrap.org/mailarchive/git/2007/6/14/249310

I don't follow the guilt development to be able to comment. They are
pretty similar regarding patch management but it's probably best to
try both and see which tool you like. StGIT might have a few more
features as it was around for longer (e-mail templates, patch
synchronisation between branches etc.) but guilt seems actively
developed as well.

I might be wrong here but I'm not sure whether guilt uses three-way
merging when pushing a patch or just a two-way diff apply. The
three-way merging has several advantages in dealing with conflicts.

-- 
Catalin
