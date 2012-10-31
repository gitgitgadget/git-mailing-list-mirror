From: Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: [PATCH] test-lib: avoid full path to store test results
Date: Tue, 30 Oct 2012 19:13:18 -0700
Message-ID: <20121031021318.GB15167@elie.Belkin>
References: <1351570377-894-1-git-send-email-felipe.contreras@gmail.com>
 <20121030044609.GA10873@elie.Belkin>
 <CAMP44s3ap19TDsSo_fmNqJp+ROWo2Ka8bc35YQmR3mMw375WsQ@mail.gmail.com>
 <20121031012730.GY15167@elie.Belkin>
 <CAMP44s1xAeW2QZsNwRVRx+DEhYVVdiKbw-y-aNuo6unuv7pYZQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
	Jeff King <peff@peff.net>,
	=?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= <avarab@gmail.com>,
	Johannes Sixt <j6t@kdbg.org>
To: Felipe Contreras <felipe.contreras@gmail.com>
X-From: git-owner@vger.kernel.org Wed Oct 31 03:13:42 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TTNoF-0003iV-Oa
	for gcvg-git-2@plane.gmane.org; Wed, 31 Oct 2012 03:13:36 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964877Ab2JaCNY (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 30 Oct 2012 22:13:24 -0400
Received: from mail-pa0-f46.google.com ([209.85.220.46]:61997 "EHLO
	mail-pa0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932069Ab2JaCNX (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 30 Oct 2012 22:13:23 -0400
Received: by mail-pa0-f46.google.com with SMTP id hz1so600024pad.19
        for <git@vger.kernel.org>; Tue, 30 Oct 2012 19:13:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        bh=4Wn5Ac1JXNXfmHT/C1zMK/I9VjjWf92gaoCjZsGDV3Q=;
        b=Q05gCCU9dNDSRQDKLdj7w3RwzYx1zk9854GvGYR+VNN73qs4XMDKSFyQ1DrQi2DGlP
         LcmDviJo65oq9mZpTXiu1JONeibt9Erw6uR/GCRbw5f48m/JMBZ6Tq6OnVodqbuv7bj2
         7E7hOWqx4JAKZGfWRpjFSm5RGniHV1QB0rj3I40x1MoofQW2rZ03ETFo3rdKscIJ6W+0
         BxD+hTm/IX++Ila/PAq0Q66RadwEYdrxuUcOk4J/41qmM1T/4o+bMdoNcGODS0CKwsdv
         AczPxRJck+XKlIy5OPB+bdOERvfzePjCiv5NExTyDNvgpP0VZzog5XfkSK3mP30RlDjL
         SRHg==
Received: by 10.68.230.234 with SMTP id tb10mr107837742pbc.71.1351649603051;
        Tue, 30 Oct 2012 19:13:23 -0700 (PDT)
Received: from elie.Belkin (c-67-180-61-129.hsd1.ca.comcast.net. [67.180.61.129])
        by mx.google.com with ESMTPS id tm8sm1444263pbc.48.2012.10.30.19.13.21
        (version=SSLv3 cipher=OTHER);
        Tue, 30 Oct 2012 19:13:22 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <CAMP44s1xAeW2QZsNwRVRx+DEhYVVdiKbw-y-aNuo6unuv7pYZQ@mail.gmail.com>
User-Agent: Mutt/1.5.21+51 (9e756d1adb76) (2011-07-01)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/208786>

Felipe Contreras wrote:

> It's all fun and games to write explanations for things, but it's not
> that easy when you want those explanations to be actually true, and
> corrent--you have to spend time to make sure of that.

That's why it's useful for the patch submitter to write them, asking
for help when necessary.

As a bonus, it helps reviewers understand the effect of the patch.
Bugs averted!

[...]
> Either way, if obvious fixes that are one-liners require an essay for
> you, I give up.

I guess it is fair to call a reasonable subject line plus a couple of
sentences an essay.  Yes, obvious fixes especially require that, since
the bug caused by an obvious fix is one of the worst kinds.
