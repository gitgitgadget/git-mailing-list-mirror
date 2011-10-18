From: Howard Miller <howard@e-learndesign.co.uk>
Subject: Problems after deleting submodule
Date: Tue, 18 Oct 2011 12:54:45 +0100
Message-ID: <CAHVO_90UN_nNDbqxM2TkUjo_qfVhLgjUJoZTmYi6rsLnRMOUFg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Oct 18 13:54:51 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RG8Fu-00035V-MO
	for gcvg-git-2@lo.gmane.org; Tue, 18 Oct 2011 13:54:51 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757502Ab1JRLyq (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 18 Oct 2011 07:54:46 -0400
Received: from mail-qy0-f181.google.com ([209.85.216.181]:38063 "EHLO
	mail-qy0-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754791Ab1JRLyp (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 18 Oct 2011 07:54:45 -0400
Received: by qyk27 with SMTP id 27so396611qyk.19
        for <git@vger.kernel.org>; Tue, 18 Oct 2011 04:54:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=mime-version:sender:date:x-google-sender-auth:message-id:subject
         :from:to:content-type;
        bh=2Aygow2SxBPwrVJsYhMaOIxGi69zWLWVLeOJ/waa+QM=;
        b=ISkJL6GFcporKIJoFJNXFk/vHxlvsezgfr620dghPt7lpcWBl+w64B7gpJIKoToAU3
         Vb06AlroVs0OPZaNmqczXZKrvJ5owgVzkkACIwCge73WEMXa6zfm09p14j0e9sEauDhR
         DzSHwgg6eiEiQEDZwPrRK38lvtsh9KMgzQ2E0=
Received: by 10.229.63.132 with SMTP id b4mr455951qci.80.1318938885104; Tue,
 18 Oct 2011 04:54:45 -0700 (PDT)
Received: by 10.229.211.73 with HTTP; Tue, 18 Oct 2011 04:54:45 -0700 (PDT)
X-Google-Sender-Auth: 5AzdZqI3e0lE7tScLdhCKamAYTs
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/183880>

I included a submodule in my project then decided I didn't like
submodules and deleted it again. I followed the advice of delting
.gitmodules, the bit from .git/config and then git rm'ing the
submodule. Seemed to work. I then copied files with the same directory
name into where the submodule was. However, I can't add them.

Doing git add /path/to/old/submodule - does nothing, files are not
staged, no error messages no nothing.
If I try to git rm /path/to/old/submodule - it just says 'did not
match any files'.

It simply does not seem to want to add anything to the old submodule
location. I had a grep around and could not see any obvious references
in the repo.

I'm a bit stuck... any suggestions for things I can try much appreciated.
