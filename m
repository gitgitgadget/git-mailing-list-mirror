From: Michael Witten <mfwitten@gmail.com>
Subject: Re: Merging one file only
Date: Sun, 21 Aug 2011 21:32:49 +0000
Message-ID: <CAMOZ1BvY13ynmtCkhFNU9Dc8PqwVQUrp8ham5zHrdq2vbMY5JQ@mail.gmail.com>
References: <1313958819073-6709333.post@n2.nabble.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: =?UTF-8?Q?Ma=C3=AFeul?= <maieul@maieul.net>
X-From: git-owner@vger.kernel.org Sun Aug 21 23:34:10 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QvFek-0005NV-1p
	for gcvg-git-2@lo.gmane.org; Sun, 21 Aug 2011 23:34:10 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752693Ab1HUVdV convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sun, 21 Aug 2011 17:33:21 -0400
Received: from mail-iy0-f170.google.com ([209.85.210.170]:40306 "EHLO
	mail-iy0-f170.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752527Ab1HUVdU convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 21 Aug 2011 17:33:20 -0400
Received: by iye16 with SMTP id 16so9179096iye.1
        for <git@vger.kernel.org>; Sun, 21 Aug 2011 14:33:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type:content-transfer-encoding;
        bh=5F4nlMF1nm+D/ebcrN+QA24NXuWCIQhh2wOwL5qaRkE=;
        b=kejH1jt7C2FupHa02+9Wl9npxd2DrgROstEYstujSIp/BCg2UrUDF3Z2HhnLoDwexY
         9x/w0GW7HmRGmbarU0Zz/Rdqk2Z1rCroK5+cp/bSYd9d/ai+6Pk/BXtItNbAuABJKAFy
         PDI5qw6O2X1soOCObeXwhBwPrBCHd+G+SzZDQ=
Received: by 10.42.75.194 with SMTP id b2mr1890911ick.62.1313962400105; Sun,
 21 Aug 2011 14:33:20 -0700 (PDT)
Received: by 10.42.174.129 with HTTP; Sun, 21 Aug 2011 14:32:49 -0700 (PDT)
In-Reply-To: <1313958819073-6709333.post@n2.nabble.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/179815>

On Sun, Aug 21, 2011 at 20:33, Ma=C3=AFeul <maieul@maieul.net> wrote:
> Hello,
>
> my problem is :
> - I have 2 branches : "master" and "sty"
> - In the branch sty, I have commit that i don't want to merge on the =
branch
> master. The only file that I want merge are the *dtx files.
>
> My question is : how can i do to merge *dtx files from "sty" to "mast=
er",
> and have log of commit on the *dtx ? Is it possible ?

There are a number of ways to do this, some more general than others.

Do you know all of the names of the files for which you don't want
associated commits? Do the files that you don't want get changed in
some of the commits that you do want?
