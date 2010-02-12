From: Sverre Rabbelier <srabbelier@gmail.com>
Subject: Re: GSoC 2010
Date: Fri, 12 Feb 2010 10:52:27 +0100
Message-ID: <fabb9a1e1002120152x45b27e50re1942eeee03094bc@mail.gmail.com>
References: <fabb9a1e1002101223o6a00f7eavb84567c1119c8ebc@mail.gmail.com> 
	<20100212080620.GA31719@dcvr.yhbt.net> <alpine.DEB.1.00.1002121000290.20986@pacific.mpi-cbg.de> 
	<fabb9a1e1002120103j3f37d417ka5b7b7ca3ae8edd@mail.gmail.com> 
	<20100212091635.GA22942@glandium.org> <alpine.DEB.1.00.1002121034320.20986@pacific.mpi-cbg.de> 
	<be6fef0d1002120134p7dda53e4h7c970bd852e6ce99@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Cc: Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Mike Hommey <mh@glandium.org>,
	Eric Wong <normalperson@yhbt.net>,
	Daniel Barkalow <barkalow@iabervon.org>,
	Jeff King <peff@peff.net>,
	"Shawn O. Pearce" <spearce@spearce.org>,
	Git List <git@vger.kernel.org>
To: Tay Ray Chuan <rctay89@gmail.com>
X-From: git-owner@vger.kernel.org Fri Feb 12 10:52:58 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1NfsCj-0000fZ-Ru
	for gcvg-git-2@lo.gmane.org; Fri, 12 Feb 2010 10:52:54 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753287Ab0BLJws (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 12 Feb 2010 04:52:48 -0500
Received: from mail-pz0-f172.google.com ([209.85.222.172]:45955 "EHLO
	mail-pz0-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752653Ab0BLJwr (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 12 Feb 2010 04:52:47 -0500
Received: by pzk2 with SMTP id 2so1899132pzk.21
        for <git@vger.kernel.org>; Fri, 12 Feb 2010 01:52:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :from:date:message-id:subject:to:cc:content-type;
        bh=oYf7OxWdmyRBSeyKtAxPW9hrMoaUWjr6i0Y7C2LHkAA=;
        b=RvxaNaM0yWP+myUdk+Bbip0HFdl/HSpcAZCNVeu2JRSg2uh2C/2rLLKOWOUOnJJIyJ
         gh7l3M8Jrb6DbgcQUIjeBTd+kpF/+JJp2y9jwraIY4ToyyFDYKcRaAEGJiXzeEzyfJJk
         rtNjOcExNsXkQJDZFIyZaimPTzZGRUzpfRRVA=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        b=mCEn+tPOuD4K5dvxU8kdsbfAPkz+hPbkuoFYZaftCZqddnB1ECLiO36ALyWoFCNUw9
         4epFgrR/ZRORnd2VkJuWyBbKWRq4VicWOlF91yQfuH805bT+6a15Jn4Xc737bA2GKGaO
         +GwaXmUVw9o/077634iQF4L+URRAqDwAhmZrc=
Received: by 10.142.152.26 with SMTP id z26mr758796wfd.9.1265968367204; Fri, 
	12 Feb 2010 01:52:47 -0800 (PST)
In-Reply-To: <be6fef0d1002120134p7dda53e4h7c970bd852e6ce99@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/139675>

Heya,

On Fri, Feb 12, 2010 at 10:34, Tay Ray Chuan <rctay89@gmail.com> wrote:
> hmm, what about distribution? Will we be able to distribute this
> remote helper with the rest of Git's GPL-ed code?

As I just said [0], it won't matter. It can be safely distributed as a
separate package, as long as a binary 'git-remote-svn' is installed
git will be able to use it.

[0] http://article.gmane.org/gmane.comp.version-control.git/139671

-- 
Cheers,

Sverre Rabbelier
