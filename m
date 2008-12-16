From: "Nguyen Thai Ngoc Duy" <pclouds@gmail.com>
Subject: Re: What's cooking in git.git (Dec 2008, #02; Sun, 14)
Date: Tue, 16 Dec 2008 08:35:02 +0700
Message-ID: <fcaeb9bf0812151735g37f14022o8176a342f9b0d9f1@mail.gmail.com>
References: <7v7i632mg9.fsf@gitster.siamese.dyndns.org>
	 <alpine.LNX.1.00.0812151423390.19665@iabervon.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Cc: "Junio C Hamano" <gitster@pobox.com>, git@vger.kernel.org
To: "Daniel Barkalow" <barkalow@iabervon.org>
X-From: git-owner@vger.kernel.org Tue Dec 16 02:36:24 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LCOrH-0000hw-8A
	for gcvg-git-2@gmane.org; Tue, 16 Dec 2008 02:36:23 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751588AbYLPBfF (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 15 Dec 2008 20:35:05 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751406AbYLPBfF
	(ORCPT <rfc822;git-outgoing>); Mon, 15 Dec 2008 20:35:05 -0500
Received: from rv-out-0506.google.com ([209.85.198.234]:39740 "EHLO
	rv-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751541AbYLPBfD (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 15 Dec 2008 20:35:03 -0500
Received: by rv-out-0506.google.com with SMTP id k40so2758332rvb.1
        for <git@vger.kernel.org>; Mon, 15 Dec 2008 17:35:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from:to
         :subject:cc:in-reply-to:mime-version:content-type
         :content-transfer-encoding:content-disposition:references;
        bh=pwkZRPs5w2jJk3Ccz50ydOYxNardx1bB6qHq6buctKc=;
        b=ehQkcYFurviJq2eyBr7FE6C7VVeMAfoi5VSb3Gwab9iN27vtKMu4UB2Eu+O8LohNW2
         A1KfpH+Y0CPTabYnHtZrZb8kvTIjZxuUDFuQPFUGtKkxCfUnmHGJQT/9zI7GUto3W5/j
         SZWXo0Nf59p/AMBLMgNtsdgiKieNehdD/ypY4=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:to:subject:cc:in-reply-to:mime-version
         :content-type:content-transfer-encoding:content-disposition
         :references;
        b=fTMhdqowbgxT59KnzW9OmlcFItEb8wHCbUpniPiEgI4tK+3KFFbBZfx6+YR6fKlBLt
         PocrG4BHU1JlLmxmACeQvrJSSn7AwJ5YwPucy7paTA7rnTL+Mqf9D1i4j35YSxW1bDdr
         o8b2p5QpkL++ze1h4In6kvQJ4MYLyBVPVp9dg=
Received: by 10.141.195.5 with SMTP id x5mr4034291rvp.168.1229391302898;
        Mon, 15 Dec 2008 17:35:02 -0800 (PST)
Received: by 10.140.247.12 with HTTP; Mon, 15 Dec 2008 17:35:02 -0800 (PST)
In-Reply-To: <alpine.LNX.1.00.0812151423390.19665@iabervon.org>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/103230>

On 12/16/08, Daniel Barkalow <barkalow@iabervon.org> wrote:
>  >  + grep: skip files outside sparse checkout area
>  >  + Prevent diff machinery from examining worktree outside sparse
>  >    checkout
>
>
> I think this patch (slightly reframed) would be good to have independantly
>  of the series; it also means that we won't do weird things if someone
>  changes a file in the worktree which is marked as CE_VALID, and may well
>  may CE_VALID sufficient for the index representation of paths outside the
>  checkout.

I have made a fixup patch for CE_VALID. Unfortunately I have not had
time to write tests and finish it before submitting. I may have free
time this weekend to complete.
-- 
Duy
