From: Christian Couder <chriscool@tuxfamily.org>
Subject: Re: [PATCH] Helper function to shell quote all arg values at once.
Date: Sun, 20 Aug 2006 20:32:40 +0200
Message-ID: <200608202032.40737.chriscool@tuxfamily.org>
References: <20060820080749.e31276dd.chriscool@tuxfamily.org>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Aug 20 20:27:31 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1GEs1A-0006vk-VN
	for gcvg-git@gmane.org; Sun, 20 Aug 2006 20:27:29 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751122AbWHTS1Z (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 20 Aug 2006 14:27:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751128AbWHTS1Z
	(ORCPT <rfc822;git-outgoing>); Sun, 20 Aug 2006 14:27:25 -0400
Received: from smtp1-g19.free.fr ([212.27.42.27]:64934 "EHLO smtp1-g19.free.fr")
	by vger.kernel.org with ESMTP id S1751122AbWHTS1Z (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 20 Aug 2006 14:27:25 -0400
Received: from bureau.boubyland (gre92-7-82-243-130-161.fbx.proxad.net [82.243.130.161])
	by smtp1-g19.free.fr (Postfix) with ESMTP id 3789790E81;
	Sun, 20 Aug 2006 20:27:24 +0200 (CEST)
To: Junio Hamano <junkio@cox.net>
User-Agent: KMail/1.9.3
In-Reply-To: <20060820080749.e31276dd.chriscool@tuxfamily.org>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/25761>

I forgot to sign this patch off :

> The new sq_quote_argv function is used to refactor the
> tracing code in "git.c" and "exec_cmd.c".
> This function allocates memory and fills it with a string
> containing the quoted argument values. Then it returns a
> pointer to this memory that must be freed afterwards.

Signed-off-by: Christian Couder <chriscool@tuxfamily.org>

Christian.
