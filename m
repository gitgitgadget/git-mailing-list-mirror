From: Adam Brewster <adambrewster@gmail.com>
Subject: Re: [PATCH] svn: Add && to t9107-git-svn-migrarte.sh
Date: Wed, 12 Aug 2009 20:35:12 -0400
Message-ID: <c376da900908121735w7ee3c581pd1281efc83a2075d@mail.gmail.com>
References: <20090810083234.GA8698@dcvr.yhbt.net>
	 <1250046867-13655-1-git-send-email-adambrewster@gmail.com>
	 <20090812094940.GA22273@dcvr.yhbt.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: Eric Wong <normalperson@yhbt.net>
X-From: git-owner@vger.kernel.org Thu Aug 13 02:35:29 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MbOHw-0006mr-68
	for gcvg-git-2@gmane.org; Thu, 13 Aug 2009 02:35:28 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751206AbZHMAfO convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 12 Aug 2009 20:35:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750774AbZHMAfN
	(ORCPT <rfc822;git-outgoing>); Wed, 12 Aug 2009 20:35:13 -0400
Received: from mail-ew0-f214.google.com ([209.85.219.214]:64915 "EHLO
	mail-ew0-f214.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751105AbZHMAfM convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 12 Aug 2009 20:35:12 -0400
Received: by ewy10 with SMTP id 10so424189ewy.37
        for <git@vger.kernel.org>; Wed, 12 Aug 2009 17:35:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :date:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=gmUmzhCfi046ouyIJDXrrx9PcvdpVceT4pSdW5XVcl8=;
        b=Dkp8UrgH3hKNiGsXMcS/Jl6A3xZNR2nSlqdr087Kzt4CB5xdc0a4FfU603K8r09Iya
         m7AGFzRjlu4kmDPxVqkgbB2p+34ULiHlwGwmVMgW7/O97XsB/07p8sZmezvg7/Hc6gOR
         CBHEyoTZ9VjQLe1Q7aXue+kxSfWIWUQqVCHLg=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=x7YSNZoh0d4uZE5lhDCLdbUOAUe1quYYma9UtKOQeAxojUwhBKkqN3KUsV2bONgtjw
         rs+QeDlYtDVxlLI1fh9NvAPOlsiMrrhA25gjm9grfw5A5BiOwBOQ8aNDO2Rdt5z0gZEN
         LLhSlpEaXKaYNAvE/lXmElB+qmRvWLK8Rnxaw=
Received: by 10.216.86.139 with SMTP id w11mr103744wee.10.1250123712476; Wed, 
	12 Aug 2009 17:35:12 -0700 (PDT)
In-Reply-To: <20090812094940.GA22273@dcvr.yhbt.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/125761>

Eric,

Thanks the help in getting this right.

> I think the following change on top of yours would make most
> sense:
>

Looks good to me.

> The map_path() changes you originally made didn't work, either, since
> the -f $1 never took GIT_DIR or GIT_DIR/svn into account.
>

It was ugly, too.

> I think the below is a good enough test case to for compatibility
> against existing repos. =A0Let me know what you think, thanks!
>

Looks about right.

Thanks,
Adam
