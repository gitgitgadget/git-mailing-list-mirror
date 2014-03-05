From: Mickey Killianey <mickey@killianey.com>
Subject: Negation in refspecs
Date: Wed, 5 Mar 2014 10:06:26 -0800
Message-ID: <CACAUoX6Y5eC_9PxihkecfgWeCetj4K30sVm7wHosTqqh=_0unA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Mar 05 19:06:57 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WLGDY-0005PE-Tw
	for gcvg-git-2@plane.gmane.org; Wed, 05 Mar 2014 19:06:57 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756215AbaCESGt (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 5 Mar 2014 13:06:49 -0500
Received: from mail-we0-f181.google.com ([74.125.82.181]:58022 "EHLO
	mail-we0-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756004AbaCESGs (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 5 Mar 2014 13:06:48 -0500
Received: by mail-we0-f181.google.com with SMTP id q58so1685948wes.12
        for <git@vger.kernel.org>; Wed, 05 Mar 2014 10:06:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:sender:from:date:message-id:subject:to:content-type;
        bh=LrvY/VNKniFXGYo45/cIU65RKG8zbe8RaP47psBSick=;
        b=Gs+QgwgDUDam4yTBfkAK9ry4mBGJF4ukcyvtnUqSDOeGy65f8SYwj+554IrD/lzKL2
         yCZ+Wt3y0HlIMTD6/wdR+tRXhEPt2IGMwNZLwsL3kQ3CysMizkCaDGii0+4syWa+ciZj
         UgtyQur8gXz1UTRp/Dn2Kkrk5Vp49p6dVrUMAOe1NQ5DOJOcc/wuCjVaY0v7/qa6hR7Q
         y+4jGb14vzi7uoVMdN7FNyCaZVFfHXOX/bJHAtA701Z6T46vICNbNv8GkE0qWwfsfFNi
         zLJyflvQB0S3kX/iHcu1LS6KRY4nsXkz9Q8EcD25uGMD5ZCWQzN1IpvuuXRtUqeCcQY2
         xRoA==
X-Received: by 10.194.87.195 with SMTP id ba3mr2990117wjb.53.1394042807041;
 Wed, 05 Mar 2014 10:06:47 -0800 (PST)
Received: by 10.194.158.225 with HTTP; Wed, 5 Mar 2014 10:06:26 -0800 (PST)
X-Google-Sender-Auth: v3zvVCXhmQGSlzM5DQmMADehgZw
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/243455>

Is there any syntax to support partial negations of refspecs, such as:

+refs/heads/*:refs/remotes/origin/*
!refs/heads/dont-pull:
!:refs/remotes/origin/dont-push

If not now, is negation something that might be possible/reasonable in
a future version of Git, or is it difficult/unlikely to change?

Mick
