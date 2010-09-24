From: =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>
Subject: Re: Is .git/config pushed/pulled to/from server?
Date: Fri, 24 Sep 2010 21:51:57 +0000
Message-ID: <AANLkTik2ShiMJcMwAGyg9tEJTbtKJ_pA72=1SCn2Rt5p@mail.gmail.com>
References: <i7j608$mmc$1@dough.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: git@vger.kernel.org
To: Manuel Reimer <Manuel.Spam@nurfuerspam.de>
X-From: git-owner@vger.kernel.org Fri Sep 24 23:52:03 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OzGBX-0006k4-Bt
	for gcvg-git-2@lo.gmane.org; Fri, 24 Sep 2010 23:52:03 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758191Ab0IXVv6 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 24 Sep 2010 17:51:58 -0400
Received: from mail-iw0-f174.google.com ([209.85.214.174]:44093 "EHLO
	mail-iw0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758163Ab0IXVv5 (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 24 Sep 2010 17:51:57 -0400
Received: by iwn5 with SMTP id 5so2696532iwn.19
        for <git@vger.kernel.org>; Fri, 24 Sep 2010 14:51:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:received:in-reply-to
         :references:date:message-id:subject:from:to:cc:content-type;
        bh=sSpZRso0sabtAe2iS7GTvTVMk9CF336aSknw3Vs4Jqc=;
        b=Q4FOBytfbBB4/62i4tn60Ru4fFFicQzkbWzNA3sv+pgNQLQFnZcCuNLOVibI/8Yzr1
         26EZif52GjRQEIGaeYt4G7xtPVwiSbqHSBC+Fe4nI2zAy8L9uasZMDZGxfRczwCJw0yv
         ffjEhvZEpWbLTsYHY+OaeT2rC4loq++MGMjxM=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        b=mtLmvGVPXJMeJXXAGRVOFv1e+R7BJXjPmX2Es4kqMLzFceN8ApVwVFoIFpwDsTp7Ti
         kgDP3QToIsgOqQpD52K8N0pbEbKp9WmwIu4UVN2GSH2ZiKePp6GkOkiQYp9D+fIVRzxj
         kgEowzGdHH1Fr5tVvpF131sONx+zhG2EZ0IaU=
Received: by 10.231.85.206 with SMTP id p14mr4309183ibl.89.1285365117262; Fri,
 24 Sep 2010 14:51:57 -0700 (PDT)
Received: by 10.231.48.195 with HTTP; Fri, 24 Sep 2010 14:51:57 -0700 (PDT)
In-Reply-To: <i7j608$mmc$1@dough.gmane.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/157067>

On Fri, Sep 24, 2010 at 21:39, Manuel Reimer <Manuel.Spam@nurfuerspam.de> wrote:
> What I want to know: Is the "repository configuration" made with "git
> config" and saved to ".git/config" in the repository *my* own configuration
> or is this pushed to the server and so pulled by other users?

It's your configuration. It'll never be pushed anywhere.
