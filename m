From: "Julien \"_FrnchFrgg_\" Rivaud" <frnchfrgg.jr@gmail.com>
Subject: Re: Importing a subversion repository where some branches come from
 trunk subtrees
Date: Sat, 31 Mar 2012 12:23:52 +0200
Message-ID: <CABaB1pJumh8Oyx3Et+kjOLoW6x55Fg5gnehKwh+2gHHwHoTz9g@mail.gmail.com>
References: <CABaB1pJNs1FL6=CbJ97pq7O=jKK=G_4t-vsx-2c4vHXsuzr40g@mail.gmail.com>
	<4F76D769.7040301@pileofstuff.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Cc: git@vger.kernel.org
To: Andrew Sayers <andrew-git@pileofstuff.org>
X-From: git-owner@vger.kernel.org Sat Mar 31 12:24:05 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SDvTT-0007tA-Jd
	for gcvg-git-2@plane.gmane.org; Sat, 31 Mar 2012 12:23:59 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756927Ab2CaKXz (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 31 Mar 2012 06:23:55 -0400
Received: from mail-ey0-f174.google.com ([209.85.215.174]:63570 "EHLO
	mail-ey0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756174Ab2CaKXy (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 31 Mar 2012 06:23:54 -0400
Received: by eaaq12 with SMTP id q12so408099eaa.19
        for <git@vger.kernel.org>; Sat, 31 Mar 2012 03:23:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        bh=NecXz/iA1gJ5IazTr8sWqdhtmY0zbN52VWXerXLd59M=;
        b=hZhGFaRM24YuWKpUcg2d+gyXJo0t+EnZjFkIDHG8OcXBVN1CTQJUK6FVe2TSy+jKMW
         r/gotiFq/GT642V1n7U8FFNFkc6QkGPnBquMle4aqiCogNwnhNE3GGRcw/dUt1qDjaBX
         3KrjaYoaJ/SakZsHU8gT+Sz3bm/vp5IiXer9kKqfypTthdp1ZadBRhY6HQ9ZHZ1udxMc
         nsIYnoULR1bqW894q7o8zS4uHxHsT6oL3SiYbfDhNbCwz/2IK/Oknc6qs13+7Ly4aYkR
         NHGezmj+JBaZnntNCITnbZfvDleOl0qwPIJ6wH63naIM1ocYFYHSAjdKYm8mW3ylCZYz
         nfHg==
Received: by 10.14.119.72 with SMTP id m48mr200925eeh.119.1333189433020; Sat,
 31 Mar 2012 03:23:53 -0700 (PDT)
Received: by 10.213.30.12 with HTTP; Sat, 31 Mar 2012 03:23:52 -0700 (PDT)
In-Reply-To: <4F76D769.7040301@pileofstuff.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/194446>

On Sat, Mar 31, 2012 at 12:07 PM, Andrew Sayers
<andrew-git@pileofstuff.org> wrote:

> Would you mind taking a look at [1] and letting me know if it's an
> understandable description of your problem?
> [1]https://github.com/andrew-sayers/SVN-Branching-Language/blob/master/t/advanced/subproject_branch.sh

Yes, it indeed is a good description of the action that causes git-svn
to duplicate history (on the other hand, the cases I saw from the
blender repo seem more like overlooks and/or straight mistakes)

_FrnchFrgg_
