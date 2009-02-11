From: Mike Ralphson <mike.ralphson@gmail.com>
Subject: Re: [PATCH] fast-export: ensure we traverse commits in topological 
	order
Date: Wed, 11 Feb 2009 10:48:18 +0000
Message-ID: <e2b179460902110248m8055b3amdebcfc550438cff2@mail.gmail.com>
References: <1234332233-10017-1-git-send-email-newren@gmail.com>
	 <1234332233-10017-2-git-send-email-newren@gmail.com>
	 <alpine.DEB.1.00.0902111125410.10279@pacific.mpi-cbg.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>
To: Elijah Newren <newren@gmail.com>
X-From: git-owner@vger.kernel.org Wed Feb 11 11:50:14 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LXCfM-0004vO-5F
	for gcvg-git-2@gmane.org; Wed, 11 Feb 2009 11:50:04 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754817AbZBKKsW (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 11 Feb 2009 05:48:22 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754792AbZBKKsV
	(ORCPT <rfc822;git-outgoing>); Wed, 11 Feb 2009 05:48:21 -0500
Received: from mail-qy0-f11.google.com ([209.85.221.11]:34336 "EHLO
	mail-qy0-f11.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754738AbZBKKsU (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 11 Feb 2009 05:48:20 -0500
Received: by qyk4 with SMTP id 4so98253qyk.13
        for <git@vger.kernel.org>; Wed, 11 Feb 2009 02:48:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :date:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=UAbXuPfRl04IelgMfcY9puTkbQ/UEHDuxcUCuuJ+7eU=;
        b=DZhNsbJuAfdM6anix0PGp58i43vDiqymRIlnDRKf7j8raiDS7EvMmhFuVsrXdeHO2x
         9DUf1b625KSGWW40DLl4/UeUs1rUNz7x75jBdfdydFId3IWnQf2hQmnbhFiavPRT4giY
         UVKnswsMIPs1ychOqeUTkHNaVopmgZEJUqv8M=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=CLNLHRvZnfVdIEBnbkUGUO07kKkGm9iADo4heAl36GLWIxxwKgc0U0cmwyrE51eO7f
         PVolkaz0MXI/uaekOyuCZvyYUtR8xXBq8PUJ3j26URHRc8zqka7ODrvmdU8xs2J6MvMo
         Wd8PARm6v3ItMaqTozoWQya3RY6OvePksp5qg=
Received: by 10.224.37.17 with SMTP id v17mr147544qad.134.1234349298796; Wed, 
	11 Feb 2009 02:48:18 -0800 (PST)
In-Reply-To: <alpine.DEB.1.00.0902111125410.10279@pacific.mpi-cbg.de>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/109402>

> On Tue, 10 Feb 2009, newren@gmail.com wrote:
> fast-export will only list as parents those commits which have already
> been traversed (making it appear as if merges have been squashed if not
> all parents have been traversed).  To avoid this silent squashing of
> merge commits, we request commits in topological order.

Any comparative timings? We don't need to rename this to 'git
reasonably-speedy-export'? 8-)

Mike
