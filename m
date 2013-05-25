From: Eric Sunshine <sunshine@sunshineco.com>
Subject: Re: [PATCH v2 27/48] remote-hg: add test for new bookmark special
Date: Sat, 25 May 2013 02:27:44 -0400
Message-ID: <CAPig+cRMj-xyFzf22emEHfhOzfFn7MC-t1aaCDU9uBA6Qi3+SA@mail.gmail.com>
References: <1369449004-17981-1-git-send-email-felipe.contreras@gmail.com>
	<1369449004-17981-28-git-send-email-felipe.contreras@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Cc: Git List <git@vger.kernel.org>, Junio C Hamano <gitster@pobox.com>,
	Jeff King <peff@peff.net>
To: Felipe Contreras <felipe.contreras@gmail.com>
X-From: git-owner@vger.kernel.org Sat May 25 08:27:52 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Ug7xG-0003Gw-8H
	for gcvg-git-2@plane.gmane.org; Sat, 25 May 2013 08:27:50 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751245Ab3EYG1q (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 25 May 2013 02:27:46 -0400
Received: from mail-la0-f44.google.com ([209.85.215.44]:65245 "EHLO
	mail-la0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750862Ab3EYG1p (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 25 May 2013 02:27:45 -0400
Received: by mail-la0-f44.google.com with SMTP id fr10so5182687lab.17
        for <git@vger.kernel.org>; Fri, 24 May 2013 23:27:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:sender:in-reply-to:references:date
         :x-google-sender-auth:message-id:subject:from:to:cc:content-type;
        bh=Q/WW8P90o4PixpSMzLPqbvJAzuOIhLHDf2Rgv1Bkpk0=;
        b=vcSFoCkr0TFZ4PpSF8TJ7urKneoqdXH2cDBAmZ1R5SN7xWtH4v/0KHDPEoHSIcK7qM
         5piJRjeezUNO9ZEeeNgpygm5YCDZ0jEBJyYN1JjBrx1+PqLVgO4mPqwnwE32lP+vZIOh
         M3RMPFswOgLwA7DMEg4mRCx6LllkYfD0Ql/l+HG9lIXlRTufk6EW1/6dTyH3217mBHq0
         6f9NAPaT7K/nL2TEuQaWsS7LBksTGx/2ws9vxosKVoL8to2LiRptR2wLIls6OUbgGLx3
         umGPsgC4LBw4TqurtwJPeGCYDB2dc23n57jnqHz6a9mbQP0Up6Rw8NwUymJkxmVSaGe2
         rkLw==
X-Received: by 10.112.181.38 with SMTP id dt6mr10404882lbc.3.1369463264441;
 Fri, 24 May 2013 23:27:44 -0700 (PDT)
Received: by 10.114.161.4 with HTTP; Fri, 24 May 2013 23:27:44 -0700 (PDT)
In-Reply-To: <1369449004-17981-28-git-send-email-felipe.contreras@gmail.com>
X-Google-Sender-Auth: tBIExPkvGLlLvBS60j4qIBpXzaU
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/225490>

On Fri, May 24, 2013 at 10:29 PM, Felipe Contreras
<felipe.contreras@gmail.com> wrote:
> From the point of view of Mercurial, this creates a new branch head, and
> requires a forced push.
>
> Ideally, whoever, we would want it to work just like in git; new

s/whoever/however/

> branches can be pushed without problems.
>
> Signed-off-by: Felipe Contreras <felipe.contreras@gmail.com>
