From: James Blackburn <jamesblackburn@gmail.com>
Subject: git rebase fails with: Patch does not have a valid e-mail address.
Date: Thu, 8 Sep 2011 12:47:04 +0100
Message-ID: <CACyv8dckmRxgb9_FDTW+=1Y9bS27b3XZQCHnhjpfHiJig5p6wg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Sep 08 13:47:13 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1R1d4a-00046X-QA
	for gcvg-git-2@lo.gmane.org; Thu, 08 Sep 2011 13:47:13 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758333Ab1IHLrH (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 8 Sep 2011 07:47:07 -0400
Received: from mail-vw0-f43.google.com ([209.85.212.43]:35811 "EHLO
	mail-vw0-f43.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758325Ab1IHLrF (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 8 Sep 2011 07:47:05 -0400
Received: by vws10 with SMTP id 10so1046036vws.2
        for <git@vger.kernel.org>; Thu, 08 Sep 2011 04:47:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=mime-version:date:message-id:subject:from:to:content-type;
        bh=X4vLjk4sErKiDsos8NnfH6ZKDSHLvy+foUruFghXrZY=;
        b=ndWPTlerMuYegknbWcT/TllnHdwE/wMDjR3vq5pcz5uSQSaWP3vVZ5XdvRrKc6riEM
         u1tqA8MBM7Di/sW6E7PVg+TwCuozcQSaLa3fHmPqCbO7NmFlgkn0GYsUrxABGT10a9cM
         lCQnLRJrxg7rO0VemRJpKsedqS0rfqzT+qOv8=
Received: by 10.52.67.168 with SMTP id o8mr554319vdt.30.1315482425022; Thu, 08
 Sep 2011 04:47:05 -0700 (PDT)
Received: by 10.220.202.12 with HTTP; Thu, 8 Sep 2011 04:47:04 -0700 (PDT)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/180965>

Hi,

I'm trying to rewrite some history and git's telling me:

-bash:jamesb:lc-cam-025:33079> git rebase
7f58969b933745d4cb9bb128bbd3fa8d441cdb92
First, rewinding head to replay your work on top of it...
Patch does not have a valid e-mail address.

Now it's true there isn't an email address for the author - the author
no longer works for the company, and the email address was removed
during the conversion.  Therefore the repo contains "Author <>".

Given git doesn't ordinarily complain about this, should this prevent
rebase from working?

Cheers,
James
