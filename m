From: Steven Sroka <sroka.steven@gmail.com>
Subject: git clone problem
Date: Wed, 28 Dec 2011 18:08:31 -0500
Message-ID: <CAKn2qcUBRW6KLbkFDXMYMro4ZMOp3FG-G6xRofvyc0VK7vf_gA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Dec 29 00:09:02 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Rg2cH-0001NJ-3W
	for gcvg-git-2@lo.gmane.org; Thu, 29 Dec 2011 00:09:01 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752938Ab1L1XI5 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 28 Dec 2011 18:08:57 -0500
Received: from mail-we0-f174.google.com ([74.125.82.174]:46882 "EHLO
	mail-we0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752587Ab1L1XIx (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 28 Dec 2011 18:08:53 -0500
Received: by werm1 with SMTP id m1so5942611wer.19
        for <git@vger.kernel.org>; Wed, 28 Dec 2011 15:08:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=mime-version:from:date:message-id:subject:to:content-type;
        bh=ei7RPb0v/DaqKI8DRCIJICfPsi8AeWT36z5S0AviVgU=;
        b=XIiYLojnZSiwitqvrqRONWW0K4FBYUXNMvFjqNaqygAx7CeULbzi9SqFjwjnUMPAfp
         9XSQ9sXwy89buuxbKgcTIASNrNtUFRwAaBjs6z1szJNFgdA0FE4QrRMellWS2vxWF53P
         dxsLg6Wmr/mKPvUScJnK3j+3i6hq1d+653BNA=
Received: by 10.216.136.12 with SMTP id v12mr500309wei.21.1325113732223; Wed,
 28 Dec 2011 15:08:52 -0800 (PST)
Received: by 10.180.97.201 with HTTP; Wed, 28 Dec 2011 15:08:31 -0800 (PST)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/187766>

Hello everyone,

I don't know whether I'm having a git problem or a Gitorious problem,
but when I try to clone a remote repository, I get this error:

[steven@chakra-pc Projects]$ git clone
https://git.gitorious.org/chakra/tribe.git
Cloning into 'tribe'...
error: Could not resolve host: git.gitorious.org; Cannot allocate
memory (curl_result = 6, http_code = 0, sha1 =
19e44a5608b262d81c06a00425db9e4f2d82ca98)
error: Unable to find 91fd634acca7d88abb449b379c7c6730bf0df33d under
https://git.gitorious.org/chakra/tribe.git
Cannot obtain needed tree 91fd634acca7d88abb449b379c7c6730bf0df33d
while processing commit 378b1f6d9bdca8ad3ce957a4f7a83c19691afb04.
error: Fetch failed.

Anyone know what is going one?

-- 
Steven Sroka
(lin-unix)
