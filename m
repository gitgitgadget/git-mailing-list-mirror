From: Ramkumar Ramachandra <artagnon@gmail.com>
Subject: Re: submodule: if $command was not matched, don't parse other args
Date: Tue, 25 Sep 2012 00:01:17 +0530
Message-ID: <CALkWK0mpDp652Hmgx2-KCw+SdFmFKHMLAOya=vRy-fsV_YH4MQ@mail.gmail.com>
References: <CALkWK0npySdS7FDt=6VKdtoNS2gqQH5WaTQ4H6TEmXdP9fuF=g@mail.gmail.com>
 <7v8vc13ilc.fsf@alter.siamese.dyndns.org> <505F489B.1000309@web.de>
 <50607748.6000204@xiplink.com> <7v7grj1jkr.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: marcnarc@xiplink.com, Jens Lehmann <Jens.Lehmann@web.de>,
	Git List <git@vger.kernel.org>, Heiko Voigt <hvoigt@hvoigt.net>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon Sep 24 20:31:50 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TGDRd-0008DE-65
	for gcvg-git-2@plane.gmane.org; Mon, 24 Sep 2012 20:31:49 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757525Ab2IXSbj (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 24 Sep 2012 14:31:39 -0400
Received: from mail-qa0-f53.google.com ([209.85.216.53]:64050 "EHLO
	mail-qa0-f53.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756781Ab2IXSbj (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 24 Sep 2012 14:31:39 -0400
Received: by qaat11 with SMTP id t11so1115308qaa.19
        for <git@vger.kernel.org>; Mon, 24 Sep 2012 11:31:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        bh=0rmoHbGX8hmMbwNmiYDdU7D/K4EJzvs1iFpuzIMDmT8=;
        b=s6m2h+TvxefmuAG08z2diHA0ujA1tieOf8w3LGmAc18JGdg8qKjQV8NzturNqaKUR+
         OhDAGEFD49phmi9bYpZTSa4y/mWqiDLHJlC8O+XQrQggchFpOHmnAwV4Rx3Nb6YVMNSc
         Kql3fA9ZpsaQMfAy5f3e/30PuborQajswfl3ZiwC2vnmZapCUznZFnz7QhJzHhYfVdsF
         F+JbxeMTp/Nv3iBj8QdOM0RffXlc9+lzeMS+ePpnCEtwHwn+d8CaDn3OiBryKK1W008Q
         6S74qO9CCFd65uUBkkguo5/7lKzuSCJ1/tPnBWIvOf37VNTG/lxgTL0dZ7bBw5D7TgFa
         72VA==
Received: by 10.224.9.9 with SMTP id j9mr34046792qaj.32.1348511498419; Mon, 24
 Sep 2012 11:31:38 -0700 (PDT)
Received: by 10.49.84.105 with HTTP; Mon, 24 Sep 2012 11:31:17 -0700 (PDT)
In-Reply-To: <7v7grj1jkr.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/206305>

Hi Junio,

Junio C Hamano wrote:
> OK, I do not think Ramkumar's patch hurts anybody, but dropping the
> "nothing on the command line defaults to 'status' action" could.  So
> let's queue the patch as-is at least for now and leave the default
> discussion to a separarte thread if needed.

Please don't do that, because it breaks test 41 in
t7400-submodule-bash.  I'll add a hunk to remove the test and send a
patch tomorrow.

Thanks.

Ram
