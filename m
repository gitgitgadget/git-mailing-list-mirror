From: Jiang Xin <worldhello.net@gmail.com>
Subject: Re: [PATCH v8 2/2] status: always show tracking branch even no change
Date: Mon, 26 Aug 2013 16:04:00 +0800
Message-ID: <CANYiYbFNGZ=Y4BagNyrZEhO2c6O_J7g-MjA35fqBj2B9aXQf5w@mail.gmail.com>
References: <2f3a942d7049e80dca689aa68d494b70c288f2c7.1377500206.git.worldhello.net@gmail.com>
	<1861495981.5462037.1377503238201.JavaMail.root@openwide.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Cc: Git List <git@vger.kernel.org>, Junio C Hamano <gitster@pobox.com>,
	Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
To: Jeremy Rosen <jeremy.rosen@openwide.fr>
X-From: git-owner@vger.kernel.org Mon Aug 26 10:04:10 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VDrmT-0005dM-BX
	for gcvg-git-2@plane.gmane.org; Mon, 26 Aug 2013 10:04:09 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755505Ab3HZIED (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 26 Aug 2013 04:04:03 -0400
Received: from mail-wg0-f41.google.com ([74.125.82.41]:43550 "EHLO
	mail-wg0-f41.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755268Ab3HZIEB (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 26 Aug 2013 04:04:01 -0400
Received: by mail-wg0-f41.google.com with SMTP id c11so3473098wgh.2
        for <git@vger.kernel.org>; Mon, 26 Aug 2013 01:04:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        bh=a4KS71Ki4YtIkJ5AGXNP4vo2syjij/OtLTpg7Iz89Es=;
        b=XGD+qImsp3NDZkkGPIdc33czNJhTgP9hnfP4ZN81dqJdoDoi+AMhVIKjq09Tdqq7sW
         r+CRT02H08a/R00/5bcJbIFOhdU0YwuAZGQavF5TwEFAFzTK4HK1gmudLBSgYmTt2xG6
         rKNWlcEPH80x7AutDN0rIu8GyBWTxT4hq6c41YsbwjY31GyYJhIOk+GjGwRi9umOXB3U
         TLsZeZs51Yfbd/R3r5d1a9V3l7BKWGGDYJAM2p4R+sXrXEUOjUFS/kqQaMBTupJmhp9R
         MlSXFLsYrH4pYJXNyBivWQ/Dv3dSuH3Ab9BP4cSEFgiBh9yhP3SBZkXZGGcBuexg8gmx
         BJiw==
X-Received: by 10.194.175.133 with SMTP id ca5mr8787338wjc.19.1377504240240;
 Mon, 26 Aug 2013 01:04:00 -0700 (PDT)
Received: by 10.194.71.175 with HTTP; Mon, 26 Aug 2013 01:04:00 -0700 (PDT)
In-Reply-To: <1861495981.5462037.1377503238201.JavaMail.root@openwide.fr>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/232985>

2013/8/26 Jeremy Rosen <jeremy.rosen@openwide.fr>:
>
> nitpicking, but shouldn't this be worded as "up to date" rather than "identical" ?
>
> The reason is that identical gives the idea that the two branch happen to be on the same
> commit wheras "up to date" gives the idea that there is a special relationship between
> these two particular branches. We are not just listing all branches on the same
> commit as us, we are actively telling you about this branch because it's interesting
> to you.

That's better. I want to use 'up to date' in the beginning, but I don't know
which prep. should be used. Now I realize I should:

    s/identical to/up to date with/

-- 
Jiang Xin
