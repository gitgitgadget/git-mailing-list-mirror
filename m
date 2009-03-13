From: Jay Soffian <jaysoffian@gmail.com>
Subject: Re: git doc build failure on OS X 10.5.6 (Leopard) during xmlto phase
Date: Fri, 13 Mar 2009 12:18:02 -0400
Message-ID: <76718490903130918r733e3ef4meae49311883969b5@mail.gmail.com>
References: <5e68abd90903110721o414283a4te188b58e0e4df8ad@mail.gmail.com>
	 <76718490903110812t5e1723ebi28a84da680422d8a@mail.gmail.com>
	 <76718490903110839m17041c7bxd7912eb09496c81a@mail.gmail.com>
	 <76718490903110849x2ef48a89j3f17706390991eda@mail.gmail.com>
	 <49B7E670.7060606@drmicha.warpmail.net> <gp95vf$gp1$1@ger.gmane.org>
	 <49B8EF3E.2070208@drmicha.warpmail.net>
	 <20090312170931.GB19175@inocybe.teonanacatl.org>
	 <49BA356D.8050007@drmicha.warpmail.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Cc: Todd Zullinger <tmz@pobox.com>,
	Alejandro Riveira <ariveira@gmail.com>, git@vger.kernel.org,
	Tom Holaday <tlholaday@gmail.com>
To: Michael J Gruber <git@drmicha.warpmail.net>
X-From: git-owner@vger.kernel.org Fri Mar 13 17:20:17 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LiA7B-0007d3-UD
	for gcvg-git-2@gmane.org; Fri, 13 Mar 2009 17:20:06 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754358AbZCMQSI (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 13 Mar 2009 12:18:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754096AbZCMQSH
	(ORCPT <rfc822;git-outgoing>); Fri, 13 Mar 2009 12:18:07 -0400
Received: from yx-out-2324.google.com ([74.125.44.30]:23915 "EHLO
	yx-out-2324.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752299AbZCMQSE (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 13 Mar 2009 12:18:04 -0400
Received: by yx-out-2324.google.com with SMTP id 8so318920yxm.1
        for <git@vger.kernel.org>; Fri, 13 Mar 2009 09:18:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :date:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=/7fkvbCoHyrzxkcp9lGT9EnsDbP1xd9wN2wTrhR3Mgs=;
        b=xktYVpTkusuTA+4FfCpIyvjgHJua+d4VHNT1VXQCiKRUMjv2q8xzn8mMRqVY025t6A
         Ss02+TOgFDNXN/5Pp01/xnT2tH+1D5BlBf0wKZsFDOAp6yS8k4TUMj/sBBsfnhQMHAv2
         FXTSam2vXD5dAOeZtkN3Q3TodrZcmm88dqW/w=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=tRJL+RWwg5m3ahGeg23IFq7FuDtru27ecbrqT9ebusPjXlsFOcw4FT+7IB+ItFcRcG
         hcJbfjVfkmvekuszW8+nY2SlWlAWxdTLo43hOzxexaosNsxhDhMPgcAXRaYORjXP0RBZ
         JkmsT9U6Rp0Bf2qv3oObcXoBPtFnEVtzAW7so=
Received: by 10.151.112.10 with SMTP id p10mr2215162ybm.61.1236961082702; Fri, 
	13 Mar 2009 09:18:02 -0700 (PDT)
In-Reply-To: <49BA356D.8050007@drmicha.warpmail.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/113204>

On Fri, Mar 13, 2009 at 6:29 AM, Michael J Gruber
<git@drmicha.warpmail.net> wrote:
> On a related issue: Does anybody know which asciidoc versions need
> asciidoc7compatible to be set? 8.2.5 and above certainly don't, so we
> should not advise using it. asciidoc's hg repo doesn't go back much more
> (the initial revision does not need it either), and I haven't dug for
> their earlier history yet.

I'm using 8.3.1 and set asciidoc7compatible. I don't recall why I set
it, but I'm sure I had a good reason for it. :-)

j.
