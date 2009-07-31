From: Erik Faye-Lund <kusmabite@googlemail.com>
Subject: Re: Request for benchmarking: x86 SHA1 code
Date: Fri, 31 Jul 2009 14:45:15 +0200
Message-ID: <40aa078e0907310545k64f058b6ja936f583bdaeb120@mail.gmail.com>
References: <40aa078e0907310524x1fe4d84dr858ebc03731ee093@mail.gmail.com>
	 <20090731123203.6160.qmail@science.horizon.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: git@drmicha.warpmail.net, git@vger.kernel.org
To: George Spelvin <linux@horizon.com>
X-From: git-owner@vger.kernel.org Fri Jul 31 14:45:37 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MWrUN-0007F2-9R
	for gcvg-git-2@gmane.org; Fri, 31 Jul 2009 14:45:35 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751701AbZGaMpS (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 31 Jul 2009 08:45:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751171AbZGaMpS
	(ORCPT <rfc822;git-outgoing>); Fri, 31 Jul 2009 08:45:18 -0400
Received: from mail-bw0-f219.google.com ([209.85.218.219]:52347 "EHLO
	mail-bw0-f219.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751097AbZGaMpR (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 31 Jul 2009 08:45:17 -0400
Received: by bwz19 with SMTP id 19so1167936bwz.37
        for <git@vger.kernel.org>; Fri, 31 Jul 2009 05:45:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :date:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=aHeEHqcqmWEgxddQspLONu0CuNX1ZOibATZkyNNJriQ=;
        b=ayGd1lrNHv0da5nlDh5lDuhiZlbgKOLRuV9fddLBiZDtvXE8okJCbYILuuc6GGjv5c
         KifVRLR4oVuxDQ4Q/WRJyEpBrvMeKdTYG0FOocFhISTisKzHHgA5NEPgtr5/4VxzTOSx
         T0tgnjyqY3rohN9bpSxLT6lLj6NqWQ0z+LpR4=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=googlemail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=VOn5hUDvfobpDjTgyhsJWV46rspeTWeyFEAlPJccIW+uwAQOTpSsFE/UgAERgtbNba
         33sI36GxmWh18U0thzV3uqnOrTxbbt/zAs59VSvs/0StbSSUmT6KTrRthXH9kvIWIFWr
         d+69wtwFyFr9NWc9eoIctm1j5zPIQ/mFrY5Sw=
Received: by 10.204.62.136 with SMTP id x8mr2829574bkh.36.1249044315945; Fri, 
	31 Jul 2009 05:45:15 -0700 (PDT)
In-Reply-To: <20090731123203.6160.qmail@science.horizon.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/124556>

On Fri, Jul 31, 2009 at 2:32 PM, George Spelvin<linux@horizon.com> wrote:
> Maybe you need to replace "elf" with "coff"?

That did the trick, thanks!

Best of 6 runs on an Intel Core i7 920 @ 2.67GHz:

before (586test): 1.415
after (x86test): 1.470

-- 
Erik "kusma" Faye-Lund
kusmabite@gmail.com
(+47) 986 59 656
