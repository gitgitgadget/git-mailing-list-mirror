From: "Mike Coleman" <tutufan@gmail.com>
Subject: Isn't "dangling" a misnomer?
Date: Mon, 26 Feb 2007 10:35:50 -0600
Message-ID: <3c6c07c20702260835v4865ace1u18a20f6b1d0030b5@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Feb 26 17:36:32 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HLipz-0007Sh-VX
	for gcvg-git@gmane.org; Mon, 26 Feb 2007 17:36:32 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752459AbXBZQf4 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 26 Feb 2007 11:35:56 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752454AbXBZQfz
	(ORCPT <rfc822;git-outgoing>); Mon, 26 Feb 2007 11:35:55 -0500
Received: from nf-out-0910.google.com ([64.233.182.187]:53238 "EHLO
	nf-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752443AbXBZQfy (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 26 Feb 2007 11:35:54 -0500
Received: by nf-out-0910.google.com with SMTP id o25so1807732nfa
        for <git@vger.kernel.org>; Mon, 26 Feb 2007 08:35:51 -0800 (PST)
DKIM-Signature: a=rsa-sha1; c=relaxed/relaxed;
        d=gmail.com; s=beta;
        h=domainkey-signature:received:received:message-id:date:from:to:subject:mime-version:content-type:content-transfer-encoding:content-disposition;
        b=Scs6rowtL368OJeQX0n0Q5zIHT5Zgb3jAfHVVid2aXPxysH2m86K3yxP+l9DbLt7aFPSpSvwD6gp5/8t3y58teAieTZgY9nekS+CvMn+vE/TapQ5XRA/08ijBDKNPTbq2hHEAoBbHPtFjBopvCdQzHCcXSTMUvxWn40XuMDlxuI=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=beta;
        h=received:message-id:date:from:to:subject:mime-version:content-type:content-transfer-encoding:content-disposition;
        b=WuHj6Rgul+O5L8L2r7zAp2ArzcBEDSrMcJuBnze32YSKib7VUCujeQ3KS353BsqHOS4A8ypS1WuAWaRX7DuubxSC1+F7gtHzFEOvONuHOv4qMOEv2wc7SlNOlPpv27L+uHrZwAz21TdAyaA42jlArmocWXniFVI/aitRFHUMhEQ=
Received: by 10.49.8.1 with SMTP id l1mr12987694nfi.1172507750977;
        Mon, 26 Feb 2007 08:35:50 -0800 (PST)
Received: by 10.49.92.17 with HTTP; Mon, 26 Feb 2007 08:35:50 -0800 (PST)
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/40627>

I've been reading and rereading the git documentation and tripping
slightly over the word "dangling", as in "dangling object".  In
traditional use, one might talk of a dangling pointer A, where A
points to B and B is destroyed/invalidated/etc.  As a literal example,
A might be a machine address like 0x8808FEFE, which points to an area
of memory that once had a particular meaning, but now does not,
leaving the pointer "dangling".

This way the git docs use this term seems to be the other way
around---the object is still there and valid, but there are no
pointers to it.  In order for dangling to be going on, it seems like
you'd have to have a SHA1 hash for an object that is no longer in the
repository.  (If there's been previous discussion of this, I couldn't
find it.)

What about an alternative term like "orphaned" or "unreferenced"?  The
former is a bit more suggestive, but unfortunately might be confusing
since the terms like ancestors, parents, etc., are already being used
to talk about commit trees, which really is an orthogonal topic.  The
latter term seems like it would work, though it does sound a bit
sterile.

Mike
