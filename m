From: Jon Seymour <jon.seymour@gmail.com>
Subject: git ls-tree -r reports error but exits with zero?
Date: Sat, 23 Jul 2011 20:06:46 +1000
Message-ID: <CAH3Anro74AHu+_ziskT6Wmxjqmi4JrU3p8KThagEtevuhAHF=Q@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
To: Git Mailing List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Sat Jul 23 12:06:52 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QkZ6i-0003xG-FP
	for gcvg-git-2@lo.gmane.org; Sat, 23 Jul 2011 12:06:52 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752586Ab1GWKGs (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 23 Jul 2011 06:06:48 -0400
Received: from mail-vx0-f174.google.com ([209.85.220.174]:34857 "EHLO
	mail-vx0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752449Ab1GWKGr (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 23 Jul 2011 06:06:47 -0400
Received: by vxh35 with SMTP id 35so2037915vxh.19
        for <git@vger.kernel.org>; Sat, 23 Jul 2011 03:06:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=mime-version:date:message-id:subject:from:to:content-type;
        bh=OF4ZAOEfUvzMfyEfYrbHLpEVMlDTQTcecfV2m9bCN78=;
        b=vwbiNEBTPCNZep6qnPwDvXS0xbFNPfebxBgWsakQ84CRSpaUj+iCqPNsa+Ldpqbg/Y
         wth+mGYpDmxIYFecX9QePw2Asb3EAEdSU61TEM5T2QnUdXjfz5flEZBLC96c0N7JPm+n
         JiW/A+6Zzx+j3KRheBkSGbpa8gSi6OyU7LMPI=
Received: by 10.52.21.194 with SMTP id x2mr2494430vde.39.1311415606701; Sat,
 23 Jul 2011 03:06:46 -0700 (PDT)
Received: by 10.52.183.41 with HTTP; Sat, 23 Jul 2011 03:06:46 -0700 (PDT)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/177685>

Is this expected?

$ git ls-tree -r cbe968356e26e371ff64ccb3c619d00b9808f186 >/dev/null
error: Could not read 8277223234f15b362a78203d04f4d3404682be73
$ echo $?
0

jon.
