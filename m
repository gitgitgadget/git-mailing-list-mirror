From: PJ Weisberg <pj@irregularexpressions.net>
Subject: Re: branch practice in my project
Date: Sun, 28 Aug 2011 12:42:55 -0700
Message-ID: <CAJsNXTmWmuycf0+vJ_TqcnQSoB1uNpexOJc=Av4OvZ=v_cAVFA@mail.gmail.com>
References: <CAPgpnMQmLUcxfNBDO53=s1SfigJtq2zk4H+npZeX0B_Vf0FAuA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: Lynn Lin <lynn.xin.lin@gmail.com>
X-From: git-owner@vger.kernel.org Sun Aug 28 21:49:43 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QxlMU-00073c-Qu
	for gcvg-git-2@lo.gmane.org; Sun, 28 Aug 2011 21:49:43 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752150Ab1H1Tti convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sun, 28 Aug 2011 15:49:38 -0400
Received: from p3plsmtpa01-10.prod.phx3.secureserver.net ([72.167.82.90]:33668
	"HELO p3plsmtpa01-10.prod.phx3.secureserver.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with SMTP id S1752144Ab1H1Tth convert rfc822-to-8bit
	(ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 28 Aug 2011 15:49:37 -0400
X-Greylist: delayed 399 seconds by postgrey-1.27 at vger.kernel.org; Sun, 28 Aug 2011 15:49:37 EDT
Received: (qmail 3039 invoked from network); 28 Aug 2011 19:42:57 -0000
Received: from unknown (209.85.161.46)
  by p3plsmtpa01-10.prod.phx3.secureserver.net (72.167.82.90) with ESMTP; 28 Aug 2011 19:42:57 -0000
Received: by fxh19 with SMTP id 19so3866787fxh.19
        for <git@vger.kernel.org>; Sun, 28 Aug 2011 12:42:55 -0700 (PDT)
Received: by 10.223.88.22 with SMTP id y22mr5789475fal.144.1314560575291; Sun,
 28 Aug 2011 12:42:55 -0700 (PDT)
Received: by 10.223.96.144 with HTTP; Sun, 28 Aug 2011 12:42:55 -0700 (PDT)
In-Reply-To: <CAPgpnMQmLUcxfNBDO53=s1SfigJtq2zk4H+npZeX0B_Vf0FAuA@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/180281>

On Sun, Aug 28, 2011 at 2:23 AM, Lynn Lin <lynn.xin.lin@gmail.com> wrot=
e:

> how to get the data back to master branch? =A0 I =A0suggest we can me=
rge
> release branch back, and others are afraid that merge conflict will b=
e
> a big deal for us so they suggest we can double commit into master an=
d
> release branch

I don't see how anyone would think "double commits" would be *less*
work than resolving merge conflicts.  (Espically if most changes don't
even conflict.)

The only reason I can think of for not merging release back into
master is if there are some changes on release that you don't want in
master.

-PJ
