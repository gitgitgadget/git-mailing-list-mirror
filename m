From: Gergely Buday <gbuday@gmail.com>
Subject: removing a commit from a branch
Date: Wed, 4 May 2011 10:35:08 +0200
Message-ID: <BANLkTimtpvVRU=1iCbrteyHixaWGuVKDjQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed May 04 10:35:20 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QHXYF-0002Qa-Rq
	for gcvg-git-2@lo.gmane.org; Wed, 04 May 2011 10:35:20 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751934Ab1EDIfM (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 4 May 2011 04:35:12 -0400
Received: from mail-pw0-f46.google.com ([209.85.160.46]:41497 "EHLO
	mail-pw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751746Ab1EDIfJ (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 4 May 2011 04:35:09 -0400
Received: by pwi15 with SMTP id 15so419979pwi.19
        for <git@vger.kernel.org>; Wed, 04 May 2011 01:35:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:date:message-id:subject:from:to
         :content-type;
        bh=yXpTECUBeaN72+/RhmKvy2L3A59EEzdbK1p+aYJcmQw=;
        b=nmXh07a2jSaa6U0YFezTuNSXErqvuslDkuKnh4KCjW40W+0G0bChSeeYsR1uXGB/Y+
         VeaWnop7Gtdu7ZRjP8MOOpNIOPO8uUe/d0lacejsfewwVweCGOAZp0gBvxJ5FMpk+zZp
         8p3cctqdG9f6svT5heUjNay50DRd/pn1P7tgw=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:date:message-id:subject:from:to:content-type;
        b=fhI9G4/bX3zHA1QX1w3eeGwzbQ5G3tT+8VIsYCUoqEbBGtCdhQPBsRbPReImbE4EgS
         Q54KLDw4Ng5TOwLyhybemwFatxCrfwim2YjPo7dBu1tk2U+FHri7CVNE94CWroTMUO3S
         EeqCXbnTvFerR8uMP7FBzoXezTxad8F4PB5mQ=
Received: by 10.142.214.16 with SMTP id m16mr456862wfg.218.1304498108988; Wed,
 04 May 2011 01:35:08 -0700 (PDT)
Received: by 10.142.128.16 with HTTP; Wed, 4 May 2011 01:35:08 -0700 (PDT)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/172723>

Hi there,

I have a problematic commit in a series of commits on a branch. It
contains adding a large binary file, which I would like to avoid to
push to our main repository. How can I remove that from the series of
commits? A command-line solution, please, if possible.

Cheers

- Gergely
