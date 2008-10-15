From: "Jonathan del Strother" <maillist@steelskies.com>
Subject: Re: builtin conversion between tabs and spaces
Date: Wed, 15 Oct 2008 22:02:32 +0100
Message-ID: <57518fd10810151402p4ea3283anf4b3d175c4e82425@mail.gmail.com>
References: <d4bc1a2a0810141839r547a770j3a8e56312afa6a53@mail.gmail.com>
	 <d4bc1a2a0810141842q1e50c85au7d813f2e5e37a84c@mail.gmail.com>
	 <d4bc1a2a0810141844x76223e76xf04e07ece834fc61@mail.gmail.com>
	 <20081015062539.GB3775@blimp.localdomain>
	 <d4bc1a2a0810151352s6c963e32jc4f492a7c84841dc@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: "Alex Riesen" <raa.lkml@gmail.com>,
	"Git Mailing List" <git@vger.kernel.org>
To: "Stefan Karpinski" <stefan.karpinski@gmail.com>
X-From: git-owner@vger.kernel.org Wed Oct 15 23:03:54 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KqDX0-0005Cs-QJ
	for gcvg-git-2@gmane.org; Wed, 15 Oct 2008 23:03:47 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751438AbYJOVCf (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 15 Oct 2008 17:02:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752189AbYJOVCf
	(ORCPT <rfc822;git-outgoing>); Wed, 15 Oct 2008 17:02:35 -0400
Received: from yw-out-2324.google.com ([74.125.46.31]:1562 "EHLO
	yw-out-2324.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750899AbYJOVCe (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 15 Oct 2008 17:02:34 -0400
Received: by yw-out-2324.google.com with SMTP id 9so666269ywe.1
        for <git@vger.kernel.org>; Wed, 15 Oct 2008 14:02:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from:sender
         :to:subject:cc:in-reply-to:mime-version:content-type
         :content-transfer-encoding:content-disposition:references
         :x-google-sender-auth;
        bh=pIKrodURZnNvdTT2pJwL9TWqXu0GIAkvFSqapCl+Mxg=;
        b=nZuLASzwVJ8VCmycwmOPegKvnsLA17El+6eWtb5Fh/pSEgfitCbgogMySVJvXN8eTv
         Deg8/VC3o9vZ2OHlQxytIkNTGJIgN7LnkxcG3nlGqrrlM30JxIJx1Q3u/FlkAEAgOMc+
         NjPkE0KdYxKT4Pa7vd6BBfdS8nZoW9nWuoU50=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:sender:to:subject:cc:in-reply-to:mime-version
         :content-type:content-transfer-encoding:content-disposition
         :references:x-google-sender-auth;
        b=BpZBAyVCoFPhQi6x4mKuDhDX6sgGMhKSoDJSM82mXRiRXH4zdOZYZfN002UtB4D/Pj
         KzCIEM/OElBgaxEila3PDo9skTr2dnkftDGVOoTU0W8Ww7jZQABlc3WYBbP2bxyB0wts
         sANnNO7dyh49xTHkeDcz5lZoS8gfsLbskxpRs=
Received: by 10.142.192.11 with SMTP id p11mr619660wff.276.1224104552814;
        Wed, 15 Oct 2008 14:02:32 -0700 (PDT)
Received: by 10.142.70.18 with HTTP; Wed, 15 Oct 2008 14:02:32 -0700 (PDT)
In-Reply-To: <d4bc1a2a0810151352s6c963e32jc4f492a7c84841dc@mail.gmail.com>
Content-Disposition: inline
X-Google-Sender-Auth: 96714771c3a7150e
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/98327>

On Wed, Oct 15, 2008 at 9:52 PM, Stefan Karpinski
<stefan.karpinski@gmail.com> wrote:
> if you consistently use spaces, then tabs_to_spaces will
> always give you back your original version; if you consistently use
> tabs, then spaces_to_tabs will give you back your original version. If
> you use some crazy mix of the two, you cannot reconstruct your
> original without remembering where there were tabs versus spaces,

Just IMO, a crazy mix of tabs and spaces is the only _sane_ thing to
do.  Using tabs for the initial indentation, plus spaces for alignment
of function arguments / comments / whatever, is the only way of
getting a layout that will both look right regardless of the tab size,
and allow a viewer to alter the indentation size.
