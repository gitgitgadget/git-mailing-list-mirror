From: "Catalin Marinas" <catalin.marinas@gmail.com>
Subject: Re: [StGit PATCH] Do not crash if a patch log ref is missing
Date: Sun, 14 Sep 2008 22:01:55 +0100
Message-ID: <b0943d9e0809141401o36b1347ctf6444a695b74a8b7@mail.gmail.com>
References: <20080912215449.10270.38860.stgit@localhost.localdomain>
	 <20080914080839.GA30664@diana.vm.bytemark.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: "=?ISO-8859-1?Q?Karl_Hasselstr=F6m?=" <kha@treskal.com>
X-From: git-owner@vger.kernel.org Sun Sep 14 23:03:05 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KeykJ-00038I-NH
	for gcvg-git-2@gmane.org; Sun, 14 Sep 2008 23:03:04 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754108AbYINVB4 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sun, 14 Sep 2008 17:01:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754064AbYINVB4
	(ORCPT <rfc822;git-outgoing>); Sun, 14 Sep 2008 17:01:56 -0400
Received: from rv-out-0506.google.com ([209.85.198.234]:23235 "EHLO
	rv-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754028AbYINVBz convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 14 Sep 2008 17:01:55 -0400
Received: by rv-out-0506.google.com with SMTP id k40so1847568rvb.1
        for <git@vger.kernel.org>; Sun, 14 Sep 2008 14:01:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from:to
         :subject:cc:in-reply-to:mime-version:content-type
         :content-transfer-encoding:content-disposition:references;
        bh=tTWM0oPbznnOSDXllAe/QC/qBspWmuVxzi6MhIWze1A=;
        b=IOIWDhrTVyaO+HejQvm9LXq1FgaxTCZvkUp845gJvCeH6k2+HBDsuywmEPtsQr/quU
         l8t0AojRljyJJXchdLb8ciyka00IM2TXFrnv7EWUG4rcZVDl2H+Gpk/5pi2G98u9pz4q
         fA2RJB65IRQd0JIR6mszeLoT+au8r7WfnYTIQ=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:to:subject:cc:in-reply-to:mime-version
         :content-type:content-transfer-encoding:content-disposition
         :references;
        b=SxBZ6VFgokt3LDpkp10T+iPihRZptkGnbH8lwEpJm3oLmAk41ZE31VbBaiDGhUMYx/
         Y0BlGKb4Hq7EF3i/0O2hrwOZqHunUj+K7PHb13Rifw3yYnA8er6OgXnk70l2ZX8fHxXo
         H6SJXoRnqJE+ENU8tgK7pjFt5ZFNgAepaS740=
Received: by 10.141.197.8 with SMTP id z8mr4249448rvp.285.1221426115114;
        Sun, 14 Sep 2008 14:01:55 -0700 (PDT)
Received: by 10.140.199.1 with HTTP; Sun, 14 Sep 2008 14:01:55 -0700 (PDT)
In-Reply-To: <20080914080839.GA30664@diana.vm.bytemark.co.uk>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/95859>

On 14/09/2008, Karl Hasselstr=F6m <kha@treskal.com> wrote:
> On 2008-09-12 22:54:58 +0100, Catalin Marinas wrote:
>
>  > Since we'll get rid of the individual patch logs, StGit should
>  > ignore if such a ref is missing when deleting the compatibility
>  > patch files.
>
>
> I agree this is a good idea from a robustness perspective. Did you
>  encounter a case where the deletion actually failed?

Yes, I was deleting some older patches and it happened for one of them
not to have a log reference. It left the stack in a pretty undefined
state (and used the stable StGit to delete the rest of the patches as
it is more tolerant :-)).

--=20
Catalin
