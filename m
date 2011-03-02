From: Jez <jezreel@gmail.com>
Subject: In-depth git blame?
Date: Wed, 2 Mar 2011 15:43:42 -0500
Message-ID: <AANLkTi=694NiUMzcHkNZ09sotcoN+=wPMnxnom5_ex+f@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Mar 02 21:44:15 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Pusu4-0002aM-3a
	for gcvg-git-2@lo.gmane.org; Wed, 02 Mar 2011 21:44:12 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755568Ab1CBUoF (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 2 Mar 2011 15:44:05 -0500
Received: from mail-iy0-f174.google.com ([209.85.210.174]:61077 "EHLO
	mail-iy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754516Ab1CBUoD (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 2 Mar 2011 15:44:03 -0500
Received: by iyb26 with SMTP id 26so298551iyb.19
        for <git@vger.kernel.org>; Wed, 02 Mar 2011 12:44:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:from:date:message-id:subject:to
         :content-type;
        bh=tMtPWale2Os9tEsFJ/F3rABS/wy22iIi/LVOkrdIyrA=;
        b=gGQk7g/DoSIpqlcsVpbqM8q7FIM6Ps3WdGRTXBc+R+f+vN/6nJ9ucDEjsb/oikQx/T
         2SOOtDDr6YD6f/Di+Bat8kqMKKF25n4Spu14fU+7AlHBmyTc8Z5QtZwhF8W0ynkJgV16
         8/VMw0jPHxrNdGhA0svsnbqpGEF8s0BHsOdl0=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:from:date:message-id:subject:to:content-type;
        b=d0Oke49z/3lkcQQ50H43BBBWOIbqnXFlw4fEe64cgbZpbFcVuBikSrOuPfugbaq2oK
         SFYQE7FHnbTaIstiRb0NymLE5nwDgKGdx6tuJE4taGmiOOYmQl29LrJ64eiFa7+4vvsk
         PHdxn876/r1xXsiItBHOHgT1lVqwHJfjn/cMQ=
Received: by 10.42.18.193 with SMTP id y1mr564471ica.524.1299098643122; Wed,
 02 Mar 2011 12:44:03 -0800 (PST)
Received: by 10.231.15.194 with HTTP; Wed, 2 Mar 2011 12:43:42 -0800 (PST)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/168339>

Hi all,

Git-blame is useful, but sometimes I want to know the series of
commits that have affected a line -- not just the most recent one. Is
there a way to do this?

Regards,
Jez
