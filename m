From: =?ISO-8859-1?Q?Tor_Arne_Vestb=F8?= <torarnv@gmail.com>
Subject: Re: [PATCH] Add option -b/--branch to clone for select a new HEAD
Date: Fri, 28 Aug 2009 12:31:15 +0200
Message-ID: <4A97B1F3.5060408@gmail.com>
References: <87praj90n8.wl%catap@catap.ru> <1251228341-29434-1-git-send-email-catap@catap.ru>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Cc: gitster@pobox.com, git@vger.kernel.org, peff@peff.net,
	B.Steinbrink@gmx.de
To: "Kirill A. Korinskiy" <catap@catap.ru>
X-From: git-owner@vger.kernel.org Fri Aug 28 12:31:32 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Mgyjz-0004sQ-O0
	for gcvg-git-2@lo.gmane.org; Fri, 28 Aug 2009 12:31:32 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751514AbZH1KbS (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 28 Aug 2009 06:31:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751451AbZH1KbR
	(ORCPT <rfc822;git-outgoing>); Fri, 28 Aug 2009 06:31:17 -0400
Received: from ey-out-2122.google.com ([74.125.78.27]:2217 "EHLO
	ey-out-2122.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751359AbZH1KbR (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 28 Aug 2009 06:31:17 -0400
Received: by ey-out-2122.google.com with SMTP id 25so406559eya.19
        for <git@vger.kernel.org>; Fri, 28 Aug 2009 03:31:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from
         :user-agent:mime-version:to:cc:subject:references:in-reply-to
         :content-type:content-transfer-encoding;
        bh=0bUzpAHKDyRcLLWn2EjnKMhqV30rPsWSZPYQ6lURInw=;
        b=JsVPrzNWZRZCcsZ7IHzIbvh6EpufqG5mxs7n6aNC93Mh5ueLUEy9BybO4Mchia4KMb
         og2+36l1kUFFysh266WHmUt0Enxbz8FB/vPW/ogeIzoep1vJbESQGYv7bovd162EAfaa
         AB0yrmEr7HdqqPdZkVLr7h+Jt6soOKlvSFI/0=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:user-agent:mime-version:to:cc:subject
         :references:in-reply-to:content-type:content-transfer-encoding;
        b=HU3H/RPOIYhl4HUYfrrGtdxegAVgJkaSfRoNWUBpMEGVucI6cPGkxUb/gIWdfCDzX8
         5VATGI1GrIV2UJ74U79Lm5N8ooegq1ryAKL8htXpN/elaZPLtTcC0FwF8ADFnp2keskk
         nlVybTa57yRanIihjKgvP1s6iwQR1DbssrJPU=
Received: by 10.210.136.1 with SMTP id j1mr62905ebd.74.1251455478499;
        Fri, 28 Aug 2009 03:31:18 -0700 (PDT)
Received: from ?172.24.90.128? ([62.70.27.104])
        by mx.google.com with ESMTPS id 28sm207016eye.28.2009.08.28.03.31.16
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Fri, 28 Aug 2009 03:31:17 -0700 (PDT)
User-Agent: Mozilla/5.0 (Macintosh; U; Intel Mac OS X 10.5; en-US; rv:1.9.1.1) Gecko/20090715 Thunderbird/3.0b3
In-Reply-To: <1251228341-29434-1-git-send-email-catap@catap.ru>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/127287>

On 8/25/09 9:25 PM, Kirill A. Korinskiy wrote:
> Sometimes (especially on production systems) we need to use only one
> remote branch for building software. It really annoying to clone
> origin and then swith branch by hand everytime. So this patch provide
> functionality to clone remote branch with one command without using
> checkout after clone.

Glad to see this topic being revised. Here's the original discussion for 
reference:

http://thread.gmane.org/gmane.comp.version-control.git/114919/

Tor Arne
