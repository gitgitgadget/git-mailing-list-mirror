From: Andreas Schwab <schwab@linux-m68k.org>
Subject: Re: git tag --contains <commit> -n=1 ?
Date: Wed, 23 Dec 2009 18:19:02 +0100
Message-ID: <m2fx71pq0p.fsf@whitebox.home>
References: <4B324327.5010809@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: "NODA\, Kai" <nodakai@gmail.com>
X-From: git-owner@vger.kernel.org Wed Dec 23 18:19:24 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NNUrq-0005JV-VC
	for gcvg-git-2@lo.gmane.org; Wed, 23 Dec 2009 18:19:23 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755351AbZLWRTR (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 23 Dec 2009 12:19:17 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754398AbZLWRTR
	(ORCPT <rfc822;git-outgoing>); Wed, 23 Dec 2009 12:19:17 -0500
Received: from mail-out.m-online.net ([212.18.0.9]:34591 "EHLO
	mail-out.m-online.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754139AbZLWRTQ (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 23 Dec 2009 12:19:16 -0500
Received: from mail01.m-online.net (mail.m-online.net [192.168.3.149])
	by mail-out.m-online.net (Postfix) with ESMTP id AF0E31C15A54;
	Wed, 23 Dec 2009 18:19:14 +0100 (CET)
X-Auth-Info: aXbX8eWAFdLvFyQDYv+USDoOOAcM+qQceP5lAe/cmFM=
Received: from whitebox.home (p508B6E19.dip.t-dialin.net [80.139.110.25])
	by mail.mnet-online.de (Postfix) with ESMTP id 977BC90249;
	Wed, 23 Dec 2009 18:19:14 +0100 (CET)
Received: by whitebox.home (Postfix, from userid 501)
	id 9CB481E539C; Wed, 23 Dec 2009 18:19:02 +0100 (CET)
X-Yow: Yow!  I like my new DENTIST...
In-Reply-To: <4B324327.5010809@gmail.com> (Kai NODA's message of "Thu, 24 Dec
	2009 01:19:51 +0900")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.1.90 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/135623>

"NODA, Kai" <nodakai@gmail.com> writes:

> Here I wonder whether "head -1" is generally correct or not when I want
> the oldest tag.

Since the output of git tag is sorted by name, generally not.

Andreas.

-- 
Andreas Schwab, schwab@linux-m68k.org
GPG Key fingerprint = 58CA 54C7 6D53 942B 1756  01D3 44D5 214B 8276 4ED5
"And now for something completely different."
