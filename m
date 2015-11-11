From: Atousa Duprat <atousa.p@gmail.com>
Subject: Re: [PATCH v4 2/3] Limit the size of the data block passed to SHA1_Update()
Date: Wed, 11 Nov 2015 15:46:51 -0800
Message-ID: <CA+izobv=PUf+6WWfQNEO+bwfzLRQ3V-TKQdUS0-qNJ0aCSkJzA@mail.gmail.com>
References: <1446705523-30701-1-git-send-email-apahlevan@ieee.org>
	<1446705523-30701-2-git-send-email-apahlevan@ieee.org>
	<xmqqtwp05mgn.fsf@gitster.mtv.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: git@vger.kernel.org, Atousa Pahlevan Duprat <apahlevan@ieee.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Nov 12 00:46:57 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Zwf6O-0001sh-UV
	for gcvg-git-2@plane.gmane.org; Thu, 12 Nov 2015 00:46:57 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752324AbbKKXqw (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 11 Nov 2015 18:46:52 -0500
Received: from mail-yk0-f179.google.com ([209.85.160.179]:35006 "EHLO
	mail-yk0-f179.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752301AbbKKXqw (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 11 Nov 2015 18:46:52 -0500
Received: by ykba77 with SMTP id a77so76654560ykb.2
        for <git@vger.kernel.org>; Wed, 11 Nov 2015 15:46:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        bh=66s7ZE2pq5P9s7Lxz6EQgYpQhSfX6Ow58jr56hnjWg4=;
        b=KbsZipCVYUrfn6VrWqb21rY9Z9pTKiMKXhRKHVgzSheBSC5S4v+Ox+o9Fxe0xqbt9U
         PCE5KsppshYImw3gy14MV2NTRH9n31T6EMHSiERtEdrBz+XLw6OBx6s3rbKLFwxDeI3x
         iHED9W4ikJRESQ+OTC5wzUV0LSXcXw9eao9Yi7n3j/lCiUNnQ68u6M59xA+kF9e4CE1y
         WfNf4FRscaTyk1yMeQR40aLXU7g/094hoNGWvJk9nscLHa8Ux7XJNxL2hntBJTq74mRO
         lvHOoG78rFa/q2U5sVSdGinCH3oCJ4AvsEWwa55vdbGe0vMS3nOeJgKcKMu5ezyAGhoZ
         TLOQ==
X-Received: by 10.129.2.194 with SMTP id 185mr12556238ywc.331.1447285611622;
 Wed, 11 Nov 2015 15:46:51 -0800 (PST)
Received: by 10.37.83.195 with HTTP; Wed, 11 Nov 2015 15:46:51 -0800 (PST)
In-Reply-To: <xmqqtwp05mgn.fsf@gitster.mtv.corp.google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/281208>

> Adjusting to the proposed change to 1/3, this step would become the
> attached patch.  Note that I thought the above would not scale well
> so I did it a bit differently.

Thank you, I understand now the changes that you made.
Let me know if this can be improved any further.

Atousa
