From: Johan Sageryd <j416@1616.se>
Subject: Re: [PATCH] Documentation/revisions: Document shorthand
Date: Sat, 02 Jul 2011 01:01:38 +0200
Message-ID: <4E0E51D2.9070407@1616.se>
References: <1309298960-55011-1-git-send-email-j416@1616.se> <4E0C2627.9040709@drmicha.warpmail.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Michael J Gruber <git@drmicha.warpmail.net>
X-From: git-owner@vger.kernel.org Sat Jul 02 01:02:56 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Qcmje-00009z-7o
	for gcvg-git-2@lo.gmane.org; Sat, 02 Jul 2011 01:02:54 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757801Ab1GAXBn (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 1 Jul 2011 19:01:43 -0400
Received: from mail-bw0-f46.google.com ([209.85.214.46]:38590 "EHLO
	mail-bw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757660Ab1GAXBm (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 1 Jul 2011 19:01:42 -0400
Received: by bwd5 with SMTP id 5so2926766bwd.19
        for <git@vger.kernel.org>; Fri, 01 Jul 2011 16:01:40 -0700 (PDT)
Received: by 10.204.36.134 with SMTP id t6mr3505167bkd.57.1309561300493;
        Fri, 01 Jul 2011 16:01:40 -0700 (PDT)
Received: from j.local (c213-89-102-157.bredband.comhem.se [213.89.102.157])
        by mx.google.com with ESMTPS id c13sm3387240bkc.14.2011.07.01.16.01.38
        (version=SSLv3 cipher=OTHER);
        Fri, 01 Jul 2011 16:01:39 -0700 (PDT)
User-Agent: Mozilla/5.0 (Macintosh; U; Intel Mac OS X 10.6; en-GB; rv:1.9.2.18) Gecko/20110616 Thunderbird/3.1.11
In-Reply-To: <4E0C2627.9040709@drmicha.warpmail.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/176540>

On 2011-06-30 09.30, Michael J Gruber wrote:
> If rev~ is meant to be documented usage (I thought rev^ to be preferred
> but may be wrong) then we should make the descriptions of rev~<n> and
> rev^<n> more uniform.


Hello Michael,

Yes, I thought about this too, there is indeed room for improvement.
However in that case we should also think about uniforming the
descriptions of for instance "<refname>@{<n>}", "@{<n>}", "@{-<n>}" in a
similar way.

The current descriptions are in themselves quite clear and I didn't feel
the need to spend much time rewriting it all. But I do believe that we
should strive to document all possible syntax, preferred or not, and
that is the reason for me suggesting this patch. The more complete the
better, optimising can be done at any time.

Johan
