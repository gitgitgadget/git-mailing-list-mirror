From: Ramana Kumar <ramana.kumar@gmail.com>
Subject: recursive aliases
Date: Thu, 23 Sep 2010 16:07:01 +1000
Message-ID: <AANLkTi=VDmyhUDYKc38bOZWLncZ_twQGB2n5KgbgP_tf@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Sep 23 08:07:45 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Oyey4-0004sr-10
	for gcvg-git-2@lo.gmane.org; Thu, 23 Sep 2010 08:07:40 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753383Ab0IWGH0 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 23 Sep 2010 02:07:26 -0400
Received: from mail-qw0-f46.google.com ([209.85.216.46]:38778 "EHLO
	mail-qw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753224Ab0IWGHW (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 23 Sep 2010 02:07:22 -0400
Received: by qwh6 with SMTP id 6so928372qwh.19
        for <git@vger.kernel.org>; Wed, 22 Sep 2010 23:07:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:mime-version:received:from:date
         :message-id:subject:to:content-type;
        bh=2DgQE9eGPitBbQbsEbSjV23lMUCNcejP16fdfwfZur0=;
        b=w7bdGLZv/Vt907P8UIAfe2VAtDyhE9Z9CqRgmJ5dlMmWM2eJY4SNQXNKgigS//pyAo
         5w94jkEU0IwzLnDPuPkOv4xrHzdXQn/BN37DGRNKuZy0OJub37COZvzedR3g1nMXLooY
         aPWbuOL8beVqiR7TMHH/AwOaDsrfPJ30ywwzU=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:from:date:message-id:subject:to:content-type;
        b=FrfZ1W+bJh/3ivZ2aGy2VZRcDGsXa9h2Bm+noFu85IliZMOkx/jaZgaSwpZ1xqREJZ
         6e90tic+dCEcB+fN1ULsc0Ys24jPXmz2lYOBUbZc2OxB08rZ9dMwsBAroT0LWkobfmbu
         X5ZrvK3irjoSwrEBDdNeaZX1cvDRQFZgsxzpY=
Received: by 10.220.158.73 with SMTP id e9mr594907vcx.60.1285222041225; Wed,
 22 Sep 2010 23:07:21 -0700 (PDT)
Received: by 10.220.181.65 with HTTP; Wed, 22 Sep 2010 23:07:01 -0700 (PDT)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/156852>

Are recursive aliases in any way allowed?
What about aliases that don't refer to themselves, but refer to other aliases?

Obviously I can just call git from the shell with a ! alias, but
wondering if there's any better way.
