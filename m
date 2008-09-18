From: Dmitry Potapov <dpotapov@gmail.com>
Subject: Re: [PATCH (GIT-GUI,GITK) 1/8] git-gui: Cleanup handling of the default encoding.
Date: Thu, 18 Sep 2008 21:19:36 +0400
Message-ID: <20080918171936.GE21650@dpotapov.dyndns.org>
References: <1221685659-476-1-git-send-email-angavrilov@gmail.com> <1221685659-476-2-git-send-email-angavrilov@gmail.com> <20080918150238.GC21650@dpotapov.dyndns.org> <48D281E6.1070204@viscovery.net> <20080918165032.GD21650@dpotapov.dyndns.org> <bb6f213e0809181000l52c55e8ctdfa49a59002e60cf@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Johannes Sixt <j.sixt@viscovery.net>, git@vger.kernel.org,
	"Shawn O. Pearce" <spearce@spearce.org>,
	Paul Mackerras <paulus@samba.org>
To: Alexander Gavrilov <angavrilov@gmail.com>
X-From: git-owner@vger.kernel.org Thu Sep 18 19:20:57 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KgNBV-0002mT-5s
	for gcvg-git-2@gmane.org; Thu, 18 Sep 2008 19:20:53 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754715AbYIRRTp (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 18 Sep 2008 13:19:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754631AbYIRRTp
	(ORCPT <rfc822;git-outgoing>); Thu, 18 Sep 2008 13:19:45 -0400
Received: from ug-out-1314.google.com ([66.249.92.169]:51006 "EHLO
	ug-out-1314.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754627AbYIRRTo (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 18 Sep 2008 13:19:44 -0400
Received: by ug-out-1314.google.com with SMTP id k3so785132ugf.37
        for <git@vger.kernel.org>; Thu, 18 Sep 2008 10:19:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:date:from:to:cc:subject
         :message-id:references:mime-version:content-type:content-disposition
         :in-reply-to:user-agent;
        bh=jR+JJr0Nhu+yCd3muNB1qN4VT23cvKdRX/5RdHWzxLs=;
        b=DKCimnWToWvClnY2H9Si16Z7/Kpp6MnRbEvuRf1O6gbgAvXaI7sqcHVd/DBfiEc/hX
         hhIdWm8j+zSKn/wKSwAMxZzolVGyn8kGMlbvz+1xdRWzOdQmm2Q+o1JmdkQHV7uJ/Pxb
         8IvjcZQikZZ1PZ73+SHJNuV6fWAM31Szyr49g=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        b=hXH2KYSpZ40p8oTBGKt9af2KX0VjE9aIseYKFEneS7N3wN2a/f2RxU75ir3COSsOS/
         ZaMIzU+ewgLBHePjbeV8IY6AFweODkUmCewtrI0J4t+KW+v4FgPY1HKwPVbovgT7r+W/
         MVew2lKJAn4+o5vSMdzQHLMi8nqrO8RY/OXr8=
Received: by 10.103.52.13 with SMTP id e13mr3118595muk.80.1221758381600;
        Thu, 18 Sep 2008 10:19:41 -0700 (PDT)
Received: from localhost ( [85.141.191.174])
        by mx.google.com with ESMTPS id s10sm1415542muh.12.2008.09.18.10.19.38
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Thu, 18 Sep 2008 10:19:40 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <bb6f213e0809181000l52c55e8ctdfa49a59002e60cf@mail.gmail.com>
User-Agent: Mutt/1.5.13 (2006-08-11)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/96224>

On Thu, Sep 18, 2008 at 09:00:07PM +0400, Alexander Gavrilov wrote:
> 
> You are here missing the fact, that the actual current default for
> git-gui is not utf-8, but 'binary', essentially equivalent to
> ISO-8859-1.

In this case, I was just confused by the comment to the patch, which was
saying "Make diffs and blame default to the system (locale) encoding
instead of hard-coding UTF-8."

> UTF-8 was suggested by a patch that has been around in the
> 'pu' branch since January, and which I took as a base for my series.
> Gitk on the other hand uses the locale encoding.

I see... Then your patch makes perfect sense regardless of Windows
support, which was presented as the rationale for the patch.

Thanks,
Dmitry
