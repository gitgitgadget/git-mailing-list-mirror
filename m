From: Felipe Contreras <felipe.contreras@gmail.com>
Subject: Re: [PATCH] send-email: add proper default sender
Date: Tue, 13 Nov 2012 08:18:30 +0100
Message-ID: <CAMP44s2P14tfCm6SV3A1tks-BJ-go0gDPE3aiWMST-dEL4SETA@mail.gmail.com>
References: <1352653610-2090-1-git-send-email-felipe.contreras@gmail.com>
	<20121112233546.GG10531@sigill.intra.peff.net>
	<CAMP44s0emar-C27SX-FDsUVB6Sevuy4fBFHuO2OD6xELCEjmGg@mail.gmail.com>
	<20121113000217.GH10531@sigill.intra.peff.net>
	<CAMP44s16y9WSmnTdb04EMSzXVgzfYP7pSMo6qZi0HY0bjouA0w@mail.gmail.com>
	<20121113032727.GA8387@sigill.intra.peff.net>
	<CAMP44s0SDHVzSd-8Rq7Z1sbiQ6m0pxX+2pgx16_DoWnHeyNsNQ@mail.gmail.com>
	<20121113040104.GA9361@sigill.intra.peff.net>
	<CAMP44s1w3oZhEUM-cnO=kECH2bhdOTGVuKy8JS4uhWFbA_oi3w@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: git@vger.kernel.org, Thomas Rast <trast@student.ethz.ch>,
	Junio C Hamano <gitster@pobox.com>,
	Jonathan Nieder <jrnieder@gmail.com>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Tue Nov 13 08:18:47 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TYAlh-0006wp-7p
	for gcvg-git-2@plane.gmane.org; Tue, 13 Nov 2012 08:18:45 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751818Ab2KMHSc (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 13 Nov 2012 02:18:32 -0500
Received: from mail-ob0-f174.google.com ([209.85.214.174]:49954 "EHLO
	mail-ob0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751627Ab2KMHSb (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 13 Nov 2012 02:18:31 -0500
Received: by mail-ob0-f174.google.com with SMTP id uo13so7101248obb.19
        for <git@vger.kernel.org>; Mon, 12 Nov 2012 23:18:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        bh=2R6CdPtKhEM8Je8BlroJuilUKxLa4c+O+80+MKOv7KM=;
        b=jENRZL4TBCSWM82ejzTqLO8n+FM7rr9xHgs00q84toAlpKT+ERxd8t3MbY6oyuDqZ7
         hgdF5+8twcvBVyIeDW7kxXReL0Mv0snnn/Fg9N9xvF3ovSvXZ57wzqy4IpcGh4cVk9+Y
         EgerIaXbwR03nBeNEztN+Xb3SdAfd5yfZFB3mtjvRaQcsDHJrofIcej8v3qdRnihImVe
         CfUMi1oa9n9rO7NyGkqBUonpi4JPgkLhbevrJMw1l94cRW8l0fYP65t3YR+zbfcVd73G
         tHwq/81M2K2fsx02Exvyjv3mXBlhxKwtCVYda2PjszHMSIMwXu/CnwBybPPBf4Y/6Ujb
         wDfA==
Received: by 10.60.1.163 with SMTP id 3mr16336712oen.30.1352791110986; Mon, 12
 Nov 2012 23:18:30 -0800 (PST)
Received: by 10.60.4.74 with HTTP; Mon, 12 Nov 2012 23:18:30 -0800 (PST)
In-Reply-To: <CAMP44s1w3oZhEUM-cnO=kECH2bhdOTGVuKy8JS4uhWFbA_oi3w@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/209583>

On Tue, Nov 13, 2012 at 7:42 AM, Felipe Contreras
<felipe.contreras@gmail.com> wrote:

> 6) GIT_AUTHOR
>
> Who should the emails appear to be from? [Felipe Contreras 4th
> <felipe.contreras+4@gmail.com>]
>
> What about after my change?
>
> 6.1) GIT_AUTHOR without anything else
>
> fatal: empty ident name (for <felipec@nysa.(none)>) not allowed
> var GIT_COMMITTER_IDENT: command returned error: 128

This was supposed to be above (before my change).

-- 
Felipe Contreras
