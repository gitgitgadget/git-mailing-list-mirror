From: "Aneesh Kumar" <aneesh.kumar@gmail.com>
Subject: git help error
Date: Tue, 4 Dec 2007 21:56:48 +0530
Message-ID: <cc723f590712040826o7ca36bfg35b8cb4d64ee8d2d@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
To: "Git Mailing List" <git@vger.kernel.org>,
	"Junio C Hamano" <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Dec 04 17:27:15 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Izac1-0000nJ-Gm
	for gcvg-git-2@gmane.org; Tue, 04 Dec 2007 17:27:09 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750955AbXLDQ0t (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 4 Dec 2007 11:26:49 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750954AbXLDQ0t
	(ORCPT <rfc822;git-outgoing>); Tue, 4 Dec 2007 11:26:49 -0500
Received: from wa-out-1112.google.com ([209.85.146.179]:7959 "EHLO
	wa-out-1112.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750937AbXLDQ0s (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 4 Dec 2007 11:26:48 -0500
Received: by wa-out-1112.google.com with SMTP id v27so6265295wah
        for <git@vger.kernel.org>; Tue, 04 Dec 2007 08:26:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from:to:subject:mime-version:content-type:content-transfer-encoding:content-disposition;
        bh=3iPGNA0q7FhrLPqOzrARTskt9d/CebJoRnlfpfV9X0g=;
        b=S4S3pXB85tSXeyrfrSeDrDq8IC2WV84ptG1VdHa3S1DFXEpVmozV2yQO/keO3he6Ui7hBLD+MVMfbOQfaN3VUrD4CJ3V5rVGAHVcsdFiGiVbqPeie2XD4Rft0Ujm1b+zMhwgydmVwmefAjM3KClf/bb2h4+b/GKPzvcx4hC93yE=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=received:message-id:date:from:to:subject:mime-version:content-type:content-transfer-encoding:content-disposition;
        b=wCzdx/+VJ8ostWNiOXguYEb2oWrs8SC6GL3mcvo5Lv1BsYI/dv58Dbyy1snsced0PmljjSDl9movVAqm21//AZQ9l9LEbzccnTnjENec6e0gCXM16tfaxiPfXywl7Xng6CJqDZ1kHXfotwFkaSbHQ/TDMgfxdqnEKDGqBW6BYEE=
Received: by 10.114.112.1 with SMTP id k1mr943836wac.1196785608110;
        Tue, 04 Dec 2007 08:26:48 -0800 (PST)
Received: by 10.115.48.17 with HTTP; Tue, 4 Dec 2007 08:26:48 -0800 (PST)
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/67063>

git help gives me the below error.

[master@git]$ git help add
No manual entry for git-add
See 'man 7 undocumented' for help when manual pages are not available.
[master@git]$

I have the git binaries installed via --prefix

./configure --prefix=/home/kvaneesh/bin-local/git/
and to see the man page i have to say

man -M /home/kvaneesh/bin-local/git/share/man/

I guess git-help need to take care of the prefix.

-aneesh
