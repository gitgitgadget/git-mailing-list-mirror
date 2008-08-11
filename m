From: "Francis Moreau" <francis.moro@gmail.com>
Subject: Re: git-bisect: weird usage of read(1)
Date: Mon, 11 Aug 2008 18:23:19 +0200
Message-ID: <38b2ab8a0808110923u21d543f0qbc9dee0f99c97311@mail.gmail.com>
References: <38b2ab8a0808110657y24ac9526wca4acea3bddaec00@mail.gmail.com>
	 <alpine.DEB.1.00.0808111615260.24820@pacific.mpi-cbg.de.mpi-cbg.de>
	 <38b2ab8a0808110718x2f63608ga3d2d77e317ce4eb@mail.gmail.com>
	 <3f4fd2640808110859r148550d2h833dae05b9e6544e@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: "Johannes Schindelin" <Johannes.Schindelin@gmx.de>,
	git@vger.kernel.org
To: "Reece Dunn" <msclrhd@googlemail.com>
X-From: git-owner@vger.kernel.org Mon Aug 11 18:24:40 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KSaC1-0002SI-W6
	for gcvg-git-2@gmane.org; Mon, 11 Aug 2008 18:24:26 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755028AbYHKQXW (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 11 Aug 2008 12:23:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755002AbYHKQXV
	(ORCPT <rfc822;git-outgoing>); Mon, 11 Aug 2008 12:23:21 -0400
Received: from hs-out-0708.google.com ([64.233.178.241]:41784 "EHLO
	hs-out-0708.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752478AbYHKQXV (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 11 Aug 2008 12:23:21 -0400
Received: by hs-out-0708.google.com with SMTP id 4so184117hsl.5
        for <git@vger.kernel.org>; Mon, 11 Aug 2008 09:23:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from:to
         :subject:cc:in-reply-to:mime-version:content-type
         :content-transfer-encoding:content-disposition:references;
        bh=cCTuRnGZk29+2Je+MVeUHpPT6zJGL7kDlzXZ1c5FZOo=;
        b=cZiTNAdEqTavYv133Y1f0l81+lHN3xyfK2OOyf1fuSyhtM7ImfW5Im5vKJOBFbxWJw
         efkdd8oll5K9RT9YRuT8rWrLwROaib3yUfiVKfo3T8lFSzFwmS4PipDbnW2CXj56f+Sj
         cMi36qUeqYafIyI96LeVzAqHqQYeRId3BAtBU=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:to:subject:cc:in-reply-to:mime-version
         :content-type:content-transfer-encoding:content-disposition
         :references;
        b=mJ5LOAJwpIVdKamHGaHdM+6MK7G8NCMFu4T9ucbRbCZxfil6hN7Lb6BwBLWmOHN2Eb
         cNpdnp0MjD6Nvig++Mu0o/F0TIbxZWXT/xIiL74pd6gudbkePzhWCRYDvbGP3QA0losd
         194fLVLbgVL5SdzU2I6H7YI9qDgSiBlLHk5M8=
Received: by 10.90.83.18 with SMTP id g18mr10826103agb.76.1218471799931;
        Mon, 11 Aug 2008 09:23:19 -0700 (PDT)
Received: by 10.90.98.3 with HTTP; Mon, 11 Aug 2008 09:23:19 -0700 (PDT)
In-Reply-To: <3f4fd2640808110859r148550d2h833dae05b9e6544e@mail.gmail.com>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/91957>

On Mon, Aug 11, 2008 at 5:59 PM, Reece Dunn <msclrhd@googlemail.com> wrote:
> $ $(read yesno) && echo yes || echo no
> n
> yes
> $ $(read yesno) && echo yes || echo no
> y
> yes

funny, seeing these 2 cases I'm wondering why Bash is not complaining...

-- 
Francis
