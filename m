From: Jared Hance <jaredhance@gmail.com>
Subject: [PATCH v4 0/4] Updated patch series for default upstream merge
Date: Thu, 10 Feb 2011 18:40:00 -0500
Message-ID: <1297381209-6377-1-git-send-email-jaredhance@gmail.com>
Cc: Jared Hance <jaredhance@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Feb 11 00:40:49 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Png7z-0005G9-07
	for gcvg-git-2@lo.gmane.org; Fri, 11 Feb 2011 00:40:47 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932426Ab1BJXkW (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 10 Feb 2011 18:40:22 -0500
Received: from mail-vx0-f174.google.com ([209.85.220.174]:50690 "EHLO
	mail-vx0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932163Ab1BJXkS (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 10 Feb 2011 18:40:18 -0500
Received: by vxb37 with SMTP id 37so1028081vxb.19
        for <git@vger.kernel.org>; Thu, 10 Feb 2011 15:40:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:from:to:cc:subject:date:message-id:x-mailer;
        bh=Z/TpycX0ffgdir/sABTwik+hDhhxCgoIgh0yNQW7yyo=;
        b=LnUL+6z8jm3eAp9jnps++N8YGcY73uuapOyzTJeYF7ozDpNPdzAo3CdTLUMqSZCatT
         b1dqwxFsf2YRy0N/Ne6PW4Ej7CsZUrRKd2WmXbcMdfuTNXTAxRHaOwkIFcu2qGBVMXl/
         6ThT89tzs+FYnwhRgI6RLeFXqZBsIUQdBKE/I=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer;
        b=oPSgHxcXc2WBam6SIusb1KSqu35j2fcvqSv5PRAf+bZYQT+lyLn3d3qxonFkRMClPx
         lCFswaq0i5pcree+xsr8SBEULdKD+gi9pwYDbOyq7Pa4WGLyPSXONM5mMfv1ZDNpiVmy
         Ctqie22NuaWuE48qdubWUJPce0dZiXpNpgH9w=
Received: by 10.220.91.198 with SMTP id o6mr5988424vcm.22.1297381218057;
        Thu, 10 Feb 2011 15:40:18 -0800 (PST)
Received: from localhost.localdomain (cpe-75-186-7-248.cinci.res.rr.com [75.186.7.248])
        by mx.google.com with ESMTPS id r7sm126736vbx.19.2011.02.10.15.40.16
        (version=TLSv1/SSLv3 cipher=OTHER);
        Thu, 10 Feb 2011 15:40:16 -0800 (PST)
X-Mailer: git-send-email 1.7.4
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/166515>

This patch series allows for `git merge` to default to the upstream of the
current branch.

This update adds fixes based on all of the style-feedback from the previous
patch series; functionally it is equivalent (except for the first patch).

Should I have put the patch submitted by Jonathan Nieder in this series? I
didn't place it in the tree but it should apply on top if it.

Jared Hance (4):
  merge: update the usage information to be more modern
  merge: introduce setup_merge_commit helper function
  merge: introduce per-branch-configuration helper function
  merge: add support for merging from upstream by default

 Documentation/config.txt |    6 +++
 builtin/merge.c          |   90 ++++++++++++++++++++++++++++++++--------------
 2 files changed, 69 insertions(+), 27 deletions(-)

-- 
1.7.4
