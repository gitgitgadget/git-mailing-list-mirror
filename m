From: Philippe Vaucher <philippe.vaucher@gmail.com>
Subject: Re: Newbie grief
Date: Wed, 2 May 2012 10:25:45 +0200
Message-ID: <CAGK7Mr4U67GD7t2_Yy=VPcG_dY0riXO0bX6T88NRBFeqVXsGTA@mail.gmail.com>
References: <4F9F128C.5020304@palm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: "git@vger.kernel.org" <git@vger.kernel.org>
To: Rich Pixley <rich.pixley@palm.com>
X-From: git-owner@vger.kernel.org Wed May 02 10:26:28 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SPUtE-0001mC-JT
	for gcvg-git-2@plane.gmane.org; Wed, 02 May 2012 10:26:24 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755096Ab2EBI0S convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 2 May 2012 04:26:18 -0400
Received: from mail-ob0-f174.google.com ([209.85.214.174]:61481 "EHLO
	mail-ob0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753334Ab2EBI0Q convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 2 May 2012 04:26:16 -0400
Received: by obbtb18 with SMTP id tb18so660726obb.19
        for <git@vger.kernel.org>; Wed, 02 May 2012 01:26:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type:content-transfer-encoding;
        bh=rH2vUtIGo9KJgdt3VoHl0OFSKsExqSG6DPyJ9HeNGZ4=;
        b=KEUTP3SvqQoD8OS/tZ/AskgmxsSO3LZZ13st300/ae8OIDLYNdR54yGZQp88ACA0nM
         AYxo41I+JT9RFCauc1KqoVOJ9Ww1nbL1EqwL4fegTvN2mWVG4L2vCtDsx/ceftPyErIF
         1aacVxk8Ou8sSvPCrcK28nuEZjizcbDNN03zVeckkPcuWQ9E6DKorOSeq37E14W+8oWM
         wZkILANsIV8C0MTX0Tmhp02Ah+vA9FnHTUAiNW5vn56rCgV1Letzke64tRKu3WnoN7u4
         0fSTIy1oJ+OKTHHAX67QbBICfLg178tjtinO30DhrCyXu5W+cOM1lcvilQ79ScTi0th4
         VA5Q==
Received: by 10.50.191.200 with SMTP id ha8mr3982683igc.45.1335947175593; Wed,
 02 May 2012 01:26:15 -0700 (PDT)
Received: by 10.50.65.101 with HTTP; Wed, 2 May 2012 01:25:45 -0700 (PDT)
In-Reply-To: <4F9F128C.5020304@palm.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/196793>

> In other systems, this is a simple star network. =A0Clone a repositor=
y, use, push, pull, etc. =A0But with git, I can't push unless the cache=
 repository is bare, but if the cache repository is bare, then a change=
 to the central repository will cause the two to become wedged since ne=
ither can push or fetch the other. =A0It seems that git is allergic to =
the dual head branch solution or something, which is surprising and dis=
appointing.


If I understand correctly, you're looking for a system where you have
a lot of systems that needs to share the modifications on their repo
*without* having a central repo. Basically you want a lot of non-bare
repositories pushing/pulling from each others.

It sounds to me that your problem could easily be solved if your
restrict yourself to "pulling" only. Whenever you want the latest
change from repo on machine A, just pull from machine A and benefit
from the automagic merging etc.

Tell me if there's something I'm missing, or maybe describe a simple
scenario we can relate with in terms of ideal commands to type and
things happening.

Thanks,
Philippe
