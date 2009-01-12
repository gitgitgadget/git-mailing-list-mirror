From: Ted Pavlic <ted@tedpavlic.com>
Subject: Re: [PATCH] Update bash completions to prevent unbound variable errors.
Date: Mon, 12 Jan 2009 16:37:20 -0500
Message-ID: <496BB810.30503@tedpavlic.com>
References: <496BA0E4.2040607@tedpavlic.com> <200901121435.35547.bss@iguanasuicide.net> <496BB204.2040109@tedpavlic.com> <496BA0E4.2040607@tedpavlic.com> <20090112212544.GA24941@chistera.yi.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Cc: git <git@vger.kernel.org>,
	"Boyd Stephen Smith Jr." <bss@iguanasuicide.net>
To: =?UTF-8?B?QWRlb2RhdG8gU2ltw7M=?= <dato@net.com.org.es>
X-From: git-owner@vger.kernel.org Mon Jan 12 22:38:55 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LMUUg-00034l-OL
	for gcvg-git-2@gmane.org; Mon, 12 Jan 2009 22:38:47 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754146AbZALVhX (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 12 Jan 2009 16:37:23 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754098AbZALVhX
	(ORCPT <rfc822;git-outgoing>); Mon, 12 Jan 2009 16:37:23 -0500
Received: from gallifrey.ece.ohio-state.edu ([164.107.167.66]:34263 "EHLO
	gallifrey.ece.ohio-state.edu" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1753796AbZALVhW (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 12 Jan 2009 16:37:22 -0500
Received: from localhost (localhost.localdomain [127.0.0.1])
	by gallifrey.ece.ohio-state.edu (Postfix) with ESMTP id A347180D802E;
	Mon, 12 Jan 2009 16:31:39 -0500 (EST)
X-Virus-Scanned: amavisd-new at gallifrey.ece.ohio-state.edu
Received: from gallifrey.ece.ohio-state.edu ([127.0.0.1])
	by localhost (gallifrey.ece.ohio-state.edu [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id w+0phioLAUgl; Mon, 12 Jan 2009 16:31:39 -0500 (EST)
Received: from tedbook.mshome.net (tedpc.ece.ohio-state.edu [164.107.164.122])
	by gallifrey.ece.ohio-state.edu (Postfix) with ESMTP id 8AEE980D8022;
	Mon, 12 Jan 2009 16:31:39 -0500 (EST)
User-Agent: Mozilla/5.0 (Macintosh; U; PPC Mac OS X Mach-O; en-US; rv:1.8) Gecko/20051201 Thunderbird/1.5 Mnenhy/0.7.3.0
In-Reply-To: <20090112212544.GA24941@chistera.yi.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/105389>

> Because (from a quick look) their completion script never expands a
> variable which is not known to be set.

They use $1, $2, etc. In fact, they use $1, $2, and $3 in their _hg, 
which is their main completion function. Why would those be defined there?

In fact, it's $1, $2, $3, and $4 that are causing the problemw ith the 
git completions.

--Ted

-- 
Ted Pavlic <ted@tedpavlic.com>

   Please visit my ALS association page:
         http://web.alsa.org/goto/tedpavlic
   My family appreciates your support in the fight to defeat ALS.
