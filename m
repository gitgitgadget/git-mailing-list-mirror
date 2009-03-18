From: Gustaf Gunnarsson <gustaf.gunnarsson@gmail.com>
Subject: Git-shell do not work when git is not installed in PATH
Date: Wed, 18 Mar 2009 14:16:37 +0100
Message-ID: <e58a26890903180616k4f71bdc7s98016caaa3f03c@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Mar 18 14:18:14 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Ljveu-0004vo-4k
	for gcvg-git-2@gmane.org; Wed, 18 Mar 2009 14:18:12 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754161AbZCRNQm (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 18 Mar 2009 09:16:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754155AbZCRNQl
	(ORCPT <rfc822;git-outgoing>); Wed, 18 Mar 2009 09:16:41 -0400
Received: from mail-fx0-f158.google.com ([209.85.220.158]:43585 "EHLO
	mail-fx0-f158.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752931AbZCRNQl (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 18 Mar 2009 09:16:41 -0400
Received: by fxm2 with SMTP id 2so45432fxm.37
        for <git@vger.kernel.org>; Wed, 18 Mar 2009 06:16:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:date:message-id:subject
         :from:to:content-type:content-transfer-encoding;
        bh=pFESXNesZ/6RD8qPfOnHx4FVIaqzQdGv7ZNrZMp4//M=;
        b=IjPkp+vg60XMtAkxAEuZcu+LEG/jAoL0VxdtVYem5ygYP8vJfW1oKkWlFRmVV82rlP
         b5V69mdJRrMa95t7Fab+A4k4dgKAPqzhLStDFy41k1HWh4m+lHw1nU3tX65Izvw2O1j1
         I9wjO/O1O0KVSabd7pnqgne8JcBhOuGiY23j0=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:date:message-id:subject:from:to:content-type
         :content-transfer-encoding;
        b=Xjt39GH2Cuow5ZZ4028Z9u536wEXrn+rC1MLRg/NWhWL7BuCSg+cI4rqhqiFDt6CAT
         goavZY5vGgVQmsEtkyzE7VgR3UnQLqzajf317HEbaRRpBfQjMle3+hlqbRTqarywdp3R
         o8j+FwkDWEUULQz3Jbkqnyo3nTw57Iz7gn05c=
Received: by 10.204.117.136 with SMTP id r8mr406622bkq.188.1237382197778; Wed, 
	18 Mar 2009 06:16:37 -0700 (PDT)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/113614>

Hi,
git-shell is unable to spawn git-receive-pack, git-upload-pack and
git-cvsserver when git is not installed in PATH.

As far as I understund it is impossible to get
git_extract_argv0_path() to work when using git-shell and the only
path the actually works to use is GIT_EXEC_PATH. Hence, could the
defaults be changed so that git is also installed in GIT_EXEC_PATH or
is there some better solution?

//Gustaf
