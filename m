From: Thiago Farina <tfransosi@gmail.com>
Subject: 'git am' doubt
Date: Wed, 23 Sep 2009 19:20:53 -0300
Message-ID: <a4c8a6d00909231520s53be6654ibf74d4430e7e82f@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
To: Git Mailing List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Thu Sep 24 00:21:03 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MqaCq-0001CO-Jq
	for gcvg-git-2@lo.gmane.org; Thu, 24 Sep 2009 00:21:00 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751321AbZIWWUv (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 23 Sep 2009 18:20:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751453AbZIWWUu
	(ORCPT <rfc822;git-outgoing>); Wed, 23 Sep 2009 18:20:50 -0400
Received: from mail-fx0-f218.google.com ([209.85.220.218]:45292 "EHLO
	mail-fx0-f218.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751397AbZIWWUu (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 23 Sep 2009 18:20:50 -0400
Received: by fxm18 with SMTP id 18so1002663fxm.17
        for <git@vger.kernel.org>; Wed, 23 Sep 2009 15:20:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:date:message-id:subject
         :from:to:content-type;
        bh=9Y3Y3SQSfuewAZw2Ju8ZfDo1H66V6WT6R8zfLMmreNI=;
        b=EacwiawMvCRJxKaxxrhgWwX7AbESYaabvkSYCLG2fh0urvJ7LEKtbT3b4B27Kg1095
         LQmgkXdFSCB+5z7pvsHwra0a0Xnmhwf7R12FEa6d/nD4PkRTcWXBWDLDBL/EV2LAwgm4
         hX8e732MEMfIpnRj4oPXzMn2iu2vCYqCkbjYo=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:date:message-id:subject:from:to:content-type;
        b=TNVja51wnt1OzMebmSPOMSRTNgNshafNFStgBYeo5yw+4/qF2pupRT4wXxrAHyFrw5
         S0wtUVkgEP6l6rA2L1KnPcunls+A9LWMY6ssNb7Qm3NFUAcx+hR8yA00xfz8ca2ZeTIS
         6TA2CSgc0b5n+sMNYMabvIDiR3CFaNSCy1LcQ=
Received: by 10.103.76.37 with SMTP id d37mr1204248mul.99.1253744453356; Wed, 
	23 Sep 2009 15:20:53 -0700 (PDT)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/129010>

Hi,

I'm trying to apply a patch from the mailing list using 'git am'.

What I'm doing is:

- In gmail:
 - Save original, then I copied the content to a text editor.
- In text editor:
 - Remove the first empty line.
 - Save the file in the same directory where I have the git source.
- In git directory:
 - $ git am -s ./filename.mbox

Of course I'm doing something wrong here, but I don't know what.
The error is:
cat: /home/tfarina/git/.git/rebase-apply/next: No such file or directory
previous rebase directory /home/tfarina/git/.git/rebase-apply still
exists but mbox given.

Sorry if this is already answered before in this mailing list, but I
couldn't find it.

Thanks anyway for the time and help.
