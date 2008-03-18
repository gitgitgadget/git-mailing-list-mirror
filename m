From: Jon Loeliger <jdl@freescale.com>
Subject: Re: [RFC/PATCH Second draft] Fast forward strategies allow, never,
 and only
Date: Tue, 18 Mar 2008 09:12:12 -0500
Message-ID: <47DFCDBC.2010400@freescale.com>
References: <402c10cd0803101959q619efa86pbd501e5e2cc018c2@mail.gmail.com> <402c10cd0803172127u480276c9s4f9d716b4912ad5e@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Sverre Hvammen Johansen <hvammen@gmail.com>
X-From: git-owner@vger.kernel.org Tue Mar 18 15:15:01 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JbcZa-000403-F1
	for gcvg-git-2@gmane.org; Tue, 18 Mar 2008 15:13:50 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754005AbYCRONJ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 18 Mar 2008 10:13:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753990AbYCRONJ
	(ORCPT <rfc822;git-outgoing>); Tue, 18 Mar 2008 10:13:09 -0400
Received: from az33egw02.freescale.net ([192.88.158.103]:36332 "EHLO
	az33egw02.freescale.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753976AbYCRONH (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 18 Mar 2008 10:13:07 -0400
Received: from az33smr02.freescale.net (az33smr02.freescale.net [10.64.34.200])
	by az33egw02.freescale.net (8.12.11/az33egw02) with ESMTP id m2IECfbH020463;
	Tue, 18 Mar 2008 07:12:41 -0700 (MST)
Received: from [10.214.72.221] (mvp-10-214-72-221.am.freescale.net [10.214.72.221])
	by az33smr02.freescale.net (8.13.1/8.13.0) with ESMTP id m2IECeau007495;
	Tue, 18 Mar 2008 09:12:40 -0500 (CDT)
User-Agent: Thunderbird 2.0.0.6 (Windows/20070728)
In-Reply-To: <402c10cd0803172127u480276c9s4f9d716b4912ad5e@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/77502>

Sverre Hvammen Johansen wrote:

> diff --git a/Documentation/fast-forward-options.txt
> b/Documentation/fast-forward-options.txt
> new file mode 100644
> index 0000000..87fd0ae
> --- /dev/null
> +++ b/Documentation/fast-forward-options.txt
> @@ -0,0 +1,69 @@
> +FAST FORWARD OPTIONS
> +--------------------
>

> +
> +However, if your workflow require a linear history for the special
> +branch ("master"), topic branches must be rebased before merging them
> +back to "master".  A pull or a merge from the "master branch of a
> +topic branch may accidentally introduce a merge commit that was not
> +already in the topic branch if the topic that were merged was not
> +properly rebased.  This will creating a none linear history.

s/none /non/

jdl
