From: Markus Hitter <mah@jump-ing.de>
Subject: Re: determine if the tree is dirty
Date: Tue, 3 Nov 2009 22:07:19 +0100
Message-ID: <83B75882-0005-4BB3-BA7C-60A9105BDD5A@jump-ing.de>
References: <799406d60911031057l5dcb4d4fi3705cc66997ff7f7@mail.gmail.com>
Mime-Version: 1.0 (Apple Message framework v753.1)
Content-Type: text/plain; charset=US-ASCII; format=flowed
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Adam Mercer <ramercer@gmail.com>
X-From: git-owner@vger.kernel.org Tue Nov 03 22:06:50 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1N5QaX-0007Ce-I8
	for gcvg-git-2@lo.gmane.org; Tue, 03 Nov 2009 22:06:49 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754431AbZKCVGg (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 3 Nov 2009 16:06:36 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754419AbZKCVGf
	(ORCPT <rfc822;git-outgoing>); Tue, 3 Nov 2009 16:06:35 -0500
Received: from ud03.udmedia.de ([194.117.254.43]:43169 "EHLO
	mail.ud03.udmedia.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753026AbZKCVGf (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 3 Nov 2009 16:06:35 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=simple; d=mail.ud03.udmedia.de; h=
	in-reply-to:references:mime-version:content-type:message-id:cc:
	content-transfer-encoding:from:subject:date:to; q=dns/txt; s=
	beta; bh=fCVpB+fPh9QoGtepNDtj3VZXYST0kA5Ql/IO+XqPQh4=; b=j+ZMkot
	mcHTwtRPkfwLT6wyFVzQiWm97g9bIreNP2zxeYMiL3lzPycc0I+PhYmwmFoJQSct
	Xi7SicPJn6IYM50fIxyouXS8BBsDI80TXzyBhlxIWFBWdsvinrRRTa/4rirYFVsQ
	BbLo/Sr5WAPEnflR1yVRqjCXSSV6IOuIFJYg=
Received: (qmail 8349 invoked from network); 3 Nov 2009 22:06:38 +0100
Received: from unknown (HELO ?10.0.0.50?) (ud03?291p1@95.208.144.124)
  by mail.ud03.udmedia.de with ESMTPA; 3 Nov 2009 22:06:38 +0100
In-Reply-To: <799406d60911031057l5dcb4d4fi3705cc66997ff7f7@mail.gmail.com>
X-Mailer: Apple Mail (2.753.1)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/131995>


Am 03.11.2009 um 19:57 schrieb Adam Mercer:

> As part of a python script I need to determine if a tree has any
> uncommitted changes, so far I am been using:
> [...]
> Does anyone know of a better way to accomplish this?

I'm using

git ls-files -m -o -d --exclude-standard

If it returns anything, your repo is dirty.


Markus

- - - - - - - - - - - - - - - - - - -
Dipl. Ing. Markus Hitter
http://www.jump-ing.de/
