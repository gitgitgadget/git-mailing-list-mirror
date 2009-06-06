From: Tay Ray Chuan <rctay89@gmail.com>
Subject: Re: [PATCH 03/23] http*: cleanup slot->local after fclose
Date: Sat, 6 Jun 2009 09:15:21 +0800
Message-ID: <be6fef0d0906051815v7eb6cc65vf00830645bff6489@mail.gmail.com>
References: <20090606000133.33101b1e.rctay89@gmail.com>
	 <m3vdna5s3d.fsf@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: Git Mailing List <git@vger.kernel.org>,
	Junio C Hamano <gitster@pobox.com>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Mike Hommey <mh@glandium.org>
To: Jakub Narebski <jnareb@gmail.com>
X-From: git-owner@vger.kernel.org Sat Jun 06 03:15:30 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MCkVN-0007BN-Sy
	for gcvg-git-2@gmane.org; Sat, 06 Jun 2009 03:15:30 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753385AbZFFBPW (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 5 Jun 2009 21:15:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753205AbZFFBPV
	(ORCPT <rfc822;git-outgoing>); Fri, 5 Jun 2009 21:15:21 -0400
Received: from wf-out-1314.google.com ([209.85.200.174]:53582 "EHLO
	wf-out-1314.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752824AbZFFBPU (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 5 Jun 2009 21:15:20 -0400
Received: by wf-out-1314.google.com with SMTP id 26so826187wfd.4
        for <git@vger.kernel.org>; Fri, 05 Jun 2009 18:15:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :date:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=XxSuvM2kQv23DByEMCZ6JOkMkuEKbcXP5T4lCi889pE=;
        b=qyNT/RCtrasDa5WTfcrjgV/8dRqE1bCz39Ylbsdzi1hecCsDd4uiwHafJdAjy1LwmG
         8LKkA8sK4oGnEoN9qHQ9Rd992tDtorRCYfqEGBLxSCQ9fLFKtj/0TWrI2J47hMH293xc
         j8ZI22P7GljTgcBfsUs+xlfAH3kQszAGZlBr8=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=dCoip3UqXRARsdSwO7MLsAGGcpKDsQl4bIPy+FI2wnp5ZCiu231jB8pdIjCGSWTuD4
         kifyEG0pGfPxLMY5CS6HeIVtmJDN4hPseHAitmeT10xvx4mUviqhEwk+G+2Z8d8/gkDJ
         X3CgYpPuu3XrrzdbPxFRp1uRdR5XXtiltHrOo=
Received: by 10.142.103.11 with SMTP id a11mr1599616wfc.303.1244250921820; 
	Fri, 05 Jun 2009 18:15:21 -0700 (PDT)
In-Reply-To: <m3vdna5s3d.fsf@localhost.localdomain>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/120860>

Hi,

On Sat, Jun 6, 2009 at 4:43 AM, Jakub Narebski<jnareb@gmail.com> wrote:
> You mean here passing FILE* pointer to a fclosed file to ftell()?

Ok.

> Just in case: 30th May 2009?

Yes.

-- 
Cheers,
Ray Chuan
