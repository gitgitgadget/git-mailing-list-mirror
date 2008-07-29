From: "Martin Langhoff" <martin.langhoff@gmail.com>
Subject: Re: Bizarre missing changes (git bug?)
Date: Tue, 29 Jul 2008 15:15:28 +1200
Message-ID: <46a038f90807282015m7ce3da10h71dfee221c960332@mail.gmail.com>
References: <8502DF7C-5303-49E8-8C67-F837343E2F0C@gmail.com>
	 <200807260512.40088.zippel@linux-m68k.org>
	 <alpine.LFD.1.10.0807261249430.4188@nehalem.linux-foundation.org>
	 <Pine.LNX.4.64.0807270049290.6791@localhost.localdomain>
	 <alpine.LFD.1.10.0807271144520.3486@nehalem.linux-foundation.org>
	 <Pine.LNX.4.64.0807272101470.6791@localhost.localdomain>
	 <alpine.LFD.1.10.0807271613440.3486@nehalem.linux-foundation.org>
	 <Pine.LNX.4.64.0807280141140.6791@localhost.localdomain>
	 <alpine.LFD.1.10.0807272148030.3486@nehalem.linux-foundation.org>
	 <Pine.LNX.4.64.0807281241180.6791@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: "Linus Torvalds" <torvalds@linux-foundation.org>,
	"Tim Harper" <timcharper@gmail.com>, git@vger.kernel.org
To: "Roman Zippel" <zippel@linux-m68k.org>
X-From: git-owner@vger.kernel.org Tue Jul 29 05:16:31 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KNfhO-0003yd-QK
	for gcvg-git-2@gmane.org; Tue, 29 Jul 2008 05:16:31 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752689AbYG2DPa (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 28 Jul 2008 23:15:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752569AbYG2DPa
	(ORCPT <rfc822;git-outgoing>); Mon, 28 Jul 2008 23:15:30 -0400
Received: from wf-out-1314.google.com ([209.85.200.171]:20045 "EHLO
	wf-out-1314.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752565AbYG2DP3 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 28 Jul 2008 23:15:29 -0400
Received: by wf-out-1314.google.com with SMTP id 27so6139647wfd.4
        for <git@vger.kernel.org>; Mon, 28 Jul 2008 20:15:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from:to
         :subject:cc:in-reply-to:mime-version:content-type
         :content-transfer-encoding:content-disposition:references;
        bh=l3UPvJGSDVce4wA2KtLr5JS3KZ6+B3NN8Fjes52vS+s=;
        b=sfFG7Kzw8x/Vg14l4tAKz3WHXGYvw1LwEaTZlc9xQb/0jdxStVqY6s6SXi8eomdAaj
         eGkaEXLQDG5w2PDibgoqw139D1jeIMw4Bwzc7bzNuKqLSHEL47Vd8exRqp0T3+J2Wh77
         /M8OFjQI7ynbIrKepGDgPI0KWxo0SKawvnjvA=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:to:subject:cc:in-reply-to:mime-version
         :content-type:content-transfer-encoding:content-disposition
         :references;
        b=oSP5mhb3b0pPJNyjUbnw6em7EBtVYQKDr6HL9mUrMIpc/vn7Z8S+csc4ivXBQGoHoz
         0roHqNxnOoTpi7oby/e2ZjFiTU7FT1Wrgp3orMoE/nxpt9SIlMuyssE0Yy7bftwum5DM
         +aid8NVK7hwWagx6aDsV78RZpXmcbjJSfRGy8=
Received: by 10.142.229.4 with SMTP id b4mr1854335wfh.241.1217301329131;
        Mon, 28 Jul 2008 20:15:29 -0700 (PDT)
Received: by 10.142.223.21 with HTTP; Mon, 28 Jul 2008 20:15:28 -0700 (PDT)
In-Reply-To: <Pine.LNX.4.64.0807281241180.6791@localhost.localdomain>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/90557>

On Tue, Jul 29, 2008 at 2:59 PM, Roman Zippel <zippel@linux-m68k.org> wrote:
> Can we please get past this and look at what is required to produce the
> correct history?

Roman - correct is --full-history -- any simplification that makes it
easy on your eyes *is* a simplification. And consumers that want to do
nice user-friendly simplification like gitk does can hang off the data
stream.

> it's also possible to update it when merging/pulling new data.

If that's what you want to do, you can prototype it with a hook on
fetch and commit. That is definitely an area that hasn't been explored
- what nicer (but expensive) views on the history we have can be
afforded by pre-computing things on fetch and commit hooks.

cheers,



m
-- 
 martin.langhoff@gmail.com
 martin@laptop.org -- School Server Architect
 - ask interesting questions
 - don't get distracted with shiny stuff - working code first
 - http://wiki.laptop.org/go/User:Martinlanghoff
