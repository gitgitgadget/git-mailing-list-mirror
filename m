From: Sverre Rabbelier <srabbelier@gmail.com>
Subject: Re: whitespace checking in git-add?
Date: Sat, 21 Feb 2009 12:21:38 +0100
Message-ID: <fabb9a1e0902210321k6bdd8726jea7c930a5a61cce5@mail.gmail.com>
References: <20090220230454.GA10112@foursquare.net>
	 <alpine.LFD.2.00.0902202109010.5511@xanadu.home>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: Chris Frey <cdfrey@foursquare.net>, git@vger.kernel.org
To: Nicolas Pitre <nico@cam.org>
X-From: git-owner@vger.kernel.org Sat Feb 21 12:27:18 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Laq0j-0004iy-Ey
	for gcvg-git-2@gmane.org; Sat, 21 Feb 2009 12:27:09 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751420AbZBULVm (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 21 Feb 2009 06:21:42 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751389AbZBULVl
	(ORCPT <rfc822;git-outgoing>); Sat, 21 Feb 2009 06:21:41 -0500
Received: from mail-bw0-f161.google.com ([209.85.218.161]:60451 "EHLO
	mail-bw0-f161.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751388AbZBULVk (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 21 Feb 2009 06:21:40 -0500
Received: by bwz5 with SMTP id 5so3406120bwz.13
        for <git@vger.kernel.org>; Sat, 21 Feb 2009 03:21:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :date:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=AGyfQo3IGM/zhPPtA0s04IZ3ZIYWU/V1VJGb3qi1+ME=;
        b=fnZXzf+/SORAuddBnWxVK1LPZAwaDzMx38entGptcTHQkCcoZShZQMlgHovlB8nhOy
         T1BGsX5IP47UG3592rAIKwFRN2XRzELcBb4d+NIDGg4TxYj5bSYHLUvaQqBWNpEdFx6U
         LcQ+hbQ05tnWVODGxnfoY/kbJrXMn2kJ5qdlg=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=BwllLLteWblbSHDiNEScibOYCrtouhmL/foNoyWygMkUzFvDew/sPpD8/zvBXXSz/6
         vCoAkiqKSAmEENWvI1hEbRZo6npKFXyRygqiGqWGX70e6KC3D3LNUKHGcDVsfGq+lVgg
         Dfd2J/cAps2FkpzYlC3qMCzC9/k/SjHCS9VRI=
Received: by 10.103.91.2 with SMTP id t2mr2320124mul.47.1235215298805; Sat, 21 
	Feb 2009 03:21:38 -0800 (PST)
In-Reply-To: <alpine.LFD.2.00.0902202109010.5511@xanadu.home>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/110940>

Heya,

On Sat, Feb 21, 2009 at 03:14, Nicolas Pitre <nico@cam.org> wrote:
>  2) run 'git rebase -f --whitespace=fix HEAD~'

Thanks for the plug ;), but you should note that that only works on a
very recent git. It's not even in master yet, according to [0] it's
been in next for only 7 days.

[0] http://repo.or.cz/w/git.git?a=search&h=refs/heads/next&st=commit&s=srabbelier

-- 
Cheers,

Sverre Rabbelier
