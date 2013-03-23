From: Antoine Pelisse <apelisse@gmail.com>
Subject: Re: [PATCH v9a 3/5] Implement line-history search (git log -L)
Date: Sat, 23 Mar 2013 11:32:22 +0100
Message-ID: <CALWbr2y+xDDfotCvFqJR0dNdfNe9rGPg5cTcoGNXh3f2kN=fOw@mail.gmail.com>
References: <cover.1364020899.git.trast@student.ethz.ch>
	<b8cabd5ca63a17577fca524891046e5a3d3dfc60.1364020899.git.trast@student.ethz.ch>
	<CALWbr2xW1SsNXq0wCh9jd_qGVrACLuQT-UETcG+zoxw9xjKSHw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: git <git@vger.kernel.org>, Junio C Hamano <gitster@pobox.com>,
	Bo Yang <struggleyb.nku@gmail.com>,
	=?UTF-8?Q?Zbigniew_J=C4=99drzejewski=2DSzmek?= <zbyszek@in.waw.pl>,
	Will Palmer <wmpalmer@gmail.com>
To: Thomas Rast <trast@student.ethz.ch>
X-From: git-owner@vger.kernel.org Sat Mar 23 11:32:55 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UJLkp-0005zo-7p
	for gcvg-git-2@plane.gmane.org; Sat, 23 Mar 2013 11:32:51 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751545Ab3CWKcY (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 23 Mar 2013 06:32:24 -0400
Received: from mail-qe0-f43.google.com ([209.85.128.43]:39361 "EHLO
	mail-qe0-f43.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751311Ab3CWKcX (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 23 Mar 2013 06:32:23 -0400
Received: by mail-qe0-f43.google.com with SMTP id 1so2774064qee.30
        for <git@vger.kernel.org>; Sat, 23 Mar 2013 03:32:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:x-received:in-reply-to:references:date:message-id
         :subject:from:to:cc:content-type;
        bh=sDnQsRkt1yQ2t/VmWB8h1ExSV68kQraqdQOTKMuBloY=;
        b=Tfh0WWrehz8FUyzQ9EWmnol/3BxG4iCaWp3Bp/MVP9LbQuRk7M+vNvFK+DbSzherQR
         4c0LY/m8fI72NKqIzQZx86OG+sz8kYGcwqJYc6EiYDSZdgtRM31s+UMKofHPjmnRKcp/
         vdkJ78/tTovsyQP5mM/Mof2NoYuq+nEDcI5pKulFKo+B18ze3gLX3d+U4SWEBHFCCMHd
         xXWJj9/oRGDfKYmvedl/0yt97uFLWiD6EYOo2tprTIgYsjxTpLbNwnIpGBQSLZIWG37T
         ViURp176tjawxu8mDVVF/QtUPxw1IRmf3xyW4xpvd+9Nf9pwnqFoxezWT73KL7eIiRof
         +W+Q==
X-Received: by 10.49.117.7 with SMTP id ka7mr1824307qeb.38.1364034742962; Sat,
 23 Mar 2013 03:32:22 -0700 (PDT)
Received: by 10.49.70.163 with HTTP; Sat, 23 Mar 2013 03:32:22 -0700 (PDT)
In-Reply-To: <CALWbr2xW1SsNXq0wCh9jd_qGVrACLuQT-UETcG+zoxw9xjKSHw@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/218906>

> You should probably add some failing tests

I guess it should be "failure" tests, not failing tests.
