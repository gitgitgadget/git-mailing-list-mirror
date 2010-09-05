From: Jens Lehmann <Jens.Lehmann@web.de>
Subject: Re: [PATCH/RFC] Restructure some of the checkout opts.
Date: Sun, 05 Sep 2010 14:24:09 +0200
Message-ID: <4C838BE9.5000006@web.de>
References: <9f6f4947af20df9dc0ebd8915dcdb9b5f756d35d.1283688482.git.jaredhance@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Jared Hance <jaredhance@gmail.com>
X-From: git-owner@vger.kernel.org Sun Sep 05 14:24:46 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OsEH3-0005qM-Do
	for gcvg-git-2@lo.gmane.org; Sun, 05 Sep 2010 14:24:41 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753251Ab0IEMYg (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 5 Sep 2010 08:24:36 -0400
Received: from fmmailgate01.web.de ([217.72.192.221]:42292 "EHLO
	fmmailgate01.web.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753088Ab0IEMYf (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 5 Sep 2010 08:24:35 -0400
Received: from smtp06.web.de  ( [172.20.5.172])
	by fmmailgate01.web.de (Postfix) with ESMTP id 37D8316763922;
	Sun,  5 Sep 2010 14:24:15 +0200 (CEST)
Received: from [93.246.57.186] (helo=[192.168.178.29])
	by smtp06.web.de with asmtp (WEB.DE 4.110 #24)
	id 1OsEGd-0006n3-00; Sun, 05 Sep 2010 14:24:15 +0200
User-Agent: Mozilla/5.0 (X11; U; Linux i686; de; rv:1.9.2.8) Gecko/20100802 Thunderbird/3.1.2
In-Reply-To: <9f6f4947af20df9dc0ebd8915dcdb9b5f756d35d.1283688482.git.jaredhance@gmail.com>
X-Sender: Jens.Lehmann@web.de
X-Provags-ID: V01U2FsdGVkX1+xp+mliQnmtsSiGhZT+FcvBJiTAJ9c4tJHvZ8L
	l17F7sXtwkItd+ycepaGg52G0xctGxQDggU08EeyBzWLwxry4e
	ZggF61HYAxxKQEEBLwEw==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/155453>

Am 05.09.2010 14:09, schrieb Jared Hance:
> Previously, most opts in `builtin.checkout.c' had been an instance of
> `struct checkout_opts'. It appears that some of the opts that were
> perhaps added later were not in the struct. Move them into the struct
> in order to maintain consistency.

Hm, they aren't used outside of cmd_checkout() (as the other members
are), so maybe it is ok that they aren't in the struct?
