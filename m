From: Patrick Doyle <wpdster@gmail.com>
Subject: Re: What changed in merge commit?
Date: Mon, 18 Jul 2011 13:25:30 -0400
Message-ID: <CAF_dkJCvNHWYfjmF8bX5CT+wyQ9ftvN7aAr0FBeg5ZQ7BSuyUA@mail.gmail.com>
References: <CAF_dkJC-ee2Bqyi2_Fx_j8mu3tCFsV8o=xMRLjx+s2di4=HfkQ@mail.gmail.com>
 <CABPQNSaOQxBqf34_799zc46EnHsc7L3BiSATyYq+Q6oGs0H6sw@mail.gmail.com> <1311009024.18226.121.camel@oxylap>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: kusmabite@gmail.com, git <git@vger.kernel.org>
To: =?ISO-8859-1?Q?Christof_Kr=FCger?= <git@christof-krueger.de>
X-From: git-owner@vger.kernel.org Mon Jul 18 19:25:58 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QirZt-0004xB-HF
	for gcvg-git-2@lo.gmane.org; Mon, 18 Jul 2011 19:25:57 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754437Ab1GRRZw convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 18 Jul 2011 13:25:52 -0400
Received: from mail-fx0-f52.google.com ([209.85.161.52]:34789 "EHLO
	mail-fx0-f52.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754412Ab1GRRZv convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 18 Jul 2011 13:25:51 -0400
Received: by fxd18 with SMTP id 18so6970473fxd.11
        for <git@vger.kernel.org>; Mon, 18 Jul 2011 10:25:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type:content-transfer-encoding;
        bh=QRof0tlBa2R6TlWpUGXqAvm3dUTiJv7XuWhuPSITUFc=;
        b=wuH5wA1u0kj15Xf4M/tDEt4Cn0R4sMIp78gskgRl2+GOfveInH19a5eKZYte9/UOd/
         n2DrlTlyihy2/rB3ygE/7Amq6S6SPG58BsWWQA0+pk3Yn2aSXYSt6bhGNw3ClQX7O0EM
         IqA4C61U2uKg8AoUiQeX82OI5eAWXPjeyl2p4=
Received: by 10.223.58.76 with SMTP id f12mr4794689fah.75.1311009950211; Mon,
 18 Jul 2011 10:25:50 -0700 (PDT)
Received: by 10.223.144.203 with HTTP; Mon, 18 Jul 2011 10:25:30 -0700 (PDT)
In-Reply-To: <1311009024.18226.121.camel@oxylap>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/177388>

2011/7/18 Christof Kr=FCger <git@christof-krueger.de>:
> You could also use "git log --name-status -m" which will show multipl=
e
> entries for each parent of the merge commit.
> See "man git-diff-tree" and look for the description of the options -=
m,
> -c and --cc

Thanks...

$ git log --name-status -m --first-parent

is what I was looking for.  I thought I recalled there being something
like that, but could not recall nor find on the git-log man page the
"-m" option.  Of course I can see it now :-)

Thanks for pointing me in the right direction.

--wpd
