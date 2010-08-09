From: Richard Bronosky <Richard@Bronosky.com>
Subject: rejected updates/pushes can be found on remote
Date: Mon, 9 Aug 2010 00:54:33 -0400
Message-ID: <AANLkTingxD_VTpmMZ+u=KXtY16DjpksxmGGKuO0B219q@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Aug 09 06:54:43 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OiKNl-0003te-Fc
	for gcvg-git-2@lo.gmane.org; Mon, 09 Aug 2010 06:54:41 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751276Ab0HIEyg (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 9 Aug 2010 00:54:36 -0400
Received: from slice1.bronosky.com ([174.143.204.116]:48435 "EHLO
	slice1.bronosky.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750978Ab0HIEyf (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 9 Aug 2010 00:54:35 -0400
Received: from mail-ww0-f44.google.com (mail-ww0-f44.google.com [74.125.82.44])
	(using TLSv1 with cipher RC4-MD5 (128/128 bits))
	(No client certificate requested)
	by slice1.bronosky.com (Postfix) with ESMTP id 343F317661
	for <git@vger.kernel.org>; Mon,  9 Aug 2010 04:54:35 +0000 (UTC)
Received: by wwj40 with SMTP id 40so11166520wwj.1
        for <git@vger.kernel.org>; Sun, 08 Aug 2010 21:54:33 -0700 (PDT)
Received: by 10.227.156.129 with SMTP id x1mr13362128wbw.178.1281329673355; 
	Sun, 08 Aug 2010 21:54:33 -0700 (PDT)
Received: by 10.216.172.139 with HTTP; Sun, 8 Aug 2010 21:54:33 -0700 (PDT)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/152950>

I don't know if this is evil or not. I just find it interesting. If
you have and update hook on the remote that returns non-zero,
rejecting a push, you can later find the hash (on the remote). I'm
glad it get to the remote because I do "git diff --name-only $2 $3" to
decide whether or not to accept. But, I wonder if most people are
aware that it hangs around until it is garbage collected. This could
potentially be an attack vector, or at least a liability. (Imagine
some IP troll uploading their code to you and subpoenaing your
server.)

-- 
.!# RichardBronosky #!.
