From: "Frank Li" <lznuaa@gmail.com>
Subject: question about COMMIT_EDITMSG crlf
Date: Wed, 14 Jan 2009 13:17:19 +0800
Message-ID: <1976ea660901132117l7947157fw2922465a9b3945dc@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Jan 14 06:30:50 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LMyL3-0005Zl-GF
	for gcvg-git-2@gmane.org; Wed, 14 Jan 2009 06:30:49 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754032AbZANF30 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 14 Jan 2009 00:29:26 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754018AbZANF30
	(ORCPT <rfc822;git-outgoing>); Wed, 14 Jan 2009 00:29:26 -0500
Received: from mail-gx0-f26.google.com ([209.85.217.26]:51588 "EHLO
	mail-gx0-f26.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753926AbZANF3Z (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 14 Jan 2009 00:29:25 -0500
X-Greylist: delayed 725 seconds by postgrey-1.27 at vger.kernel.org; Wed, 14 Jan 2009 00:29:25 EST
Received: by gxk7 with SMTP id 7so140297gxk.13
        for <git@vger.kernel.org>; Tue, 13 Jan 2009 21:29:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from:to
         :subject:mime-version:content-type:content-transfer-encoding
         :content-disposition;
        bh=s5ul57yeLaWNjzK5zG3DLs6qnxdL6Vdke798nPZ1Pu4=;
        b=xtjGcmJB51647vd2H89apxwmF+ap2d8Ea4WvIcUv4mgFc/TlWNdjrTDs5EuSkEda9F
         4/98sHo7Mct+u9Y6lgOaRXZYm3x+wb66do/yHAgLFlBeUF7VHgd/ErUYJlgyepknzJn+
         CwRb+KWrxDkUxdPfkJdhcM0UVcMU89JVibZ7I=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:to:subject:mime-version:content-type
         :content-transfer-encoding:content-disposition;
        b=v20L1s7D/QygthUU/6MBeFm3a6T7MiCbXR/kfKwPLlEb3WjRUQ04XuCbUg3kkvHrLQ
         y03GaMPd8I4DyWtfcG/VBkZa7PZyefc3thVW9lp1o34PVpxJKeCbDjrz8kMRGvL/Jd42
         e33jzppnF8da1LoAWk67R2ELu2m91cyJyzNOA=
Received: by 10.150.144.9 with SMTP id r9mr1134251ybd.189.1231910239905;
        Tue, 13 Jan 2009 21:17:19 -0800 (PST)
Received: by 10.151.130.7 with HTTP; Tue, 13 Jan 2009 21:17:19 -0800 (PST)
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/105584>

I want to use notepad replace default vim at commit message editor.
git commit will create COMMIT_EDITMSG at .git directory. This file is
unix text mode.
Is there any config change it to windows text mode?
