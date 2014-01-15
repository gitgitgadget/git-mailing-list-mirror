From: =?Big5?B?pEG7xL5Z?= <ch3cooli@gmail.com>
Subject: Re: After stash pop, refs/stash become 40 zeroes
Date: Wed, 15 Jan 2014 14:00:43 +0800
Message-ID: <CAHtLG6SWL3JL6hYskaA3eUqGyDiMVD3=y46pJzGCD9cejK=qwQ@mail.gmail.com>
References: <CAHtLG6TmkYdGRF3H-6CoVvnxZqZBBk3ZUR-ohTVvgeAe9tTuOA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=Big5
Content-Transfer-Encoding: QUOTED-PRINTABLE
To: git <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Wed Jan 15 07:00:50 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1W3JWy-0000vT-Lb
	for gcvg-git-2@plane.gmane.org; Wed, 15 Jan 2014 07:00:49 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750852AbaAOGAp convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 15 Jan 2014 01:00:45 -0500
Received: from mail-wg0-f49.google.com ([74.125.82.49]:47046 "EHLO
	mail-wg0-f49.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750764AbaAOGAo convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 15 Jan 2014 01:00:44 -0500
Received: by mail-wg0-f49.google.com with SMTP id a1so1298381wgh.4
        for <git@vger.kernel.org>; Tue, 14 Jan 2014 22:00:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :content-type:content-transfer-encoding;
        bh=+vUiIEKB0YUikL7WBmYaOvk+W8DkkV+c9MuDeDSEg88=;
        b=db9zDk4U95P2YrzZb5M/mywPuwZPVPeJtJgnjkPVxXiDpaICvCi26rwQM6KEYO/jBm
         /vLkzalzEwEbRC2Q2QxJAeYfq6svnSd3hU+4cQT44Vm8JU4ZXMgsJWB21Z0D7D0p9q0G
         /bvqgfM/06p4QYfUfFsMifVodqZkf7nk8u7jGP8kQe50uLFLY0CVHDCluqnWj6grGP4N
         z6Zuqgjxqha/XigWbRwTqbnnwP4bz3NIBC9KEhRlPsynnvwUtgT+1Wx8rFC5lVdKn+Id
         lNBcyDs+IayNm8mnOR099n6h93vnCuaQ5PeS7e71MZPHbyswUB1c+QaqlHY3KBNhW/fP
         zOSQ==
X-Received: by 10.180.37.162 with SMTP id z2mr258072wij.51.1389765643155; Tue,
 14 Jan 2014 22:00:43 -0800 (PST)
Received: by 10.216.53.137 with HTTP; Tue, 14 Jan 2014 22:00:43 -0800 (PST)
In-Reply-To: <CAHtLG6TmkYdGRF3H-6CoVvnxZqZBBk3ZUR-ohTVvgeAe9tTuOA@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/240434>

Also, logs/refs/stash becomes empty (0 bytes of file size) after pop.

2014/1/15 =A4A=BB=C4=BEY <ch3cooli@gmail.com>:
> Hi,
>
> what are the possible causes of this?
> After stash pop, refs/stash becomes 40 zeroes.
> This is the only stash, so refs/stash should be deleted after pop.
> However, it becomes 40 zeroes.
>
> git 1.8.x
