From: Eric Wong <normalperson@yhbt.net>
Subject: Re: [PATCH 0/2] Don't make $GIT_DIR executable
Date: Sat, 15 Nov 2014 07:50:30 +0000
Message-ID: <20141115075030.GA31043@dcvr.yhbt.net>
References: <1416036379-4994-1-git-send-email-mhagger@alum.mit.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Junio C Hamano <gitster@pobox.com>,
	Karsten Blees <karsten.blees@gmail.com>, git@vger.kernel.org
To: Michael Haggerty <mhagger@alum.mit.edu>
X-From: git-owner@vger.kernel.org Sat Nov 15 08:50:43 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XpY83-0001im-1t
	for gcvg-git-2@plane.gmane.org; Sat, 15 Nov 2014 08:50:43 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751811AbaKOHuc (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 15 Nov 2014 02:50:32 -0500
Received: from dcvr.yhbt.net ([64.71.152.64]:52492 "EHLO dcvr.yhbt.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751273AbaKOHub (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 15 Nov 2014 02:50:31 -0500
Received: from localhost (dcvr.yhbt.net [127.0.0.1])
	by dcvr.yhbt.net (Postfix) with ESMTP id 8C460633805;
	Sat, 15 Nov 2014 07:50:30 +0000 (UTC)
Content-Disposition: inline
In-Reply-To: <1416036379-4994-1-git-send-email-mhagger@alum.mit.edu>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Michael Haggerty <mhagger@alum.mit.edu> wrote:
> Michael Haggerty (2):
>   create_default_files(): don't set u+x bit on $GIT_DIR/config
>   config: clear the executable bits (if any) on $GIT_DIR/config

Thanks, I should've noticed this earlier :x
Tested-by: Eric Wong <normalperson@yhbt.net>

Since the damage is done, perhaps removing +x from $GIT_DIR/config on
_any_ git operation would be appropriate.
