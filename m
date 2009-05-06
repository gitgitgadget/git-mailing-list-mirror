From: Erik Faye-Lund <kusmabite@googlemail.com>
Subject: Re: [BUG] git config: cygwin git version 1.6.1.2 does not deletes 
	empty sections
Date: Wed, 6 May 2009 20:08:06 +0200
Message-ID: <40aa078e0905061108o21830f07xfb9d5c185c93fda6@mail.gmail.com>
References: <85647ef50905060850t2e6c2051jfa6d3596b680cc74@mail.gmail.com>
	 <85647ef50905060904w49879c57r4a5773a487f09c85@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Constantine Plotnikov <constantine.plotnikov@gmail.com>
X-From: git-owner@vger.kernel.org Wed May 06 20:08:22 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1M1lXW-0001rf-KU
	for gcvg-git-2@gmane.org; Wed, 06 May 2009 20:08:19 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756543AbZEFSIK (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 6 May 2009 14:08:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754015AbZEFSII
	(ORCPT <rfc822;git-outgoing>); Wed, 6 May 2009 14:08:08 -0400
Received: from mail-fx0-f158.google.com ([209.85.220.158]:59333 "EHLO
	mail-fx0-f158.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753628AbZEFSIH (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 6 May 2009 14:08:07 -0400
Received: by fxm2 with SMTP id 2so304438fxm.37
        for <git@vger.kernel.org>; Wed, 06 May 2009 11:08:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :date:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=wXh3gST1qWBU/5tp3wpuNQJGd9RTehf16fufbsGlIqs=;
        b=nfyJiNaU0Ad4aHg8fXXzkuBK0zs+Gxkxt1IoQc3PwsqV2w9PzOZMoo9E161gT7W9mZ
         vC2ZbjIAej948gPPGcrABvp4WHLFft3RN3moMl3//qHDXkILOwFWeaePYjqxb4aT/8N+
         IzeGQErpmLSqfUB6Kt57jGgNRakgV60VydNcA=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=googlemail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=sTbthwjO9pb1JYyN2HMFaiHPCkJBD0rpKOyEOeZxaTn21EscGyFJklTvtCH+MXjWBH
         aE2UY8ocU0jRP+f+nj+jiF9wnEcCDF2odSchfMcIyYtqEMBP0WYoJaI4NjlkB0bLLjyB
         3zMf2daLVs0XOvs5UqyuwO0lyKLHxc2p2pJOA=
Received: by 10.204.53.143 with SMTP id m15mr1440365bkg.119.1241633286933; 
	Wed, 06 May 2009 11:08:06 -0700 (PDT)
In-Reply-To: <85647ef50905060904w49879c57r4a5773a487f09c85@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/118362>

On Wed, May 6, 2009 at 6:04 PM, Constantine Plotnikov
<constantine.plotnikov@gmail.com> wrote:
> The bug is also confirmed on MSYS git version 1.6.2.2.1669.g7eaf8.

The same issue is present in git 1.6.2.1 on Linux. Not that I'm too
sure it's really a bug, though ;)

-- 
Erik "kusma" Faye-Lund
kusmabite@gmail.com
(+47) 986 59 656
