From: Bo Yang <struggleyb.nku@gmail.com>
Subject: [GSoC 2010] The 6th week
Date: Fri, 2 Jul 2010 23:05:17 +0800
Message-ID: <AANLkTilnO-F3Lnu9mdS9bIUXfvdU0C-cnNC170wE2-yB@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Cc: Jens Lehmann <Jens.Lehmann@web.de>,
	Thomas Rast <trast@student.ethz.ch>
To: Git Mailing List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Fri Jul 02 17:11:00 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OUhtL-0001Ub-G9
	for gcvg-git-2@lo.gmane.org; Fri, 02 Jul 2010 17:10:59 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758761Ab0GBPKx (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 2 Jul 2010 11:10:53 -0400
Received: from mail-gw0-f46.google.com ([74.125.83.46]:42349 "EHLO
	mail-gw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755703Ab0GBPKw (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 2 Jul 2010 11:10:52 -0400
Received: by gwaa18 with SMTP id a18so255433gwa.19
        for <git@vger.kernel.org>; Fri, 02 Jul 2010 08:10:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:received:date:message-id
         :subject:from:to:cc:content-type;
        bh=zn0S4SmSCCJ5xXtKa38p6udVNbNb5+wyDZibAohBFNk=;
        b=YAM63s5aH+Qaox1T+2HaHS0gPNs5EYI/OBiaHC2BdZA2t3WNtXXzM47OzH/njlvd+T
         EYCVITV1ZTiZ+YcspANnl0u8dcDM5FyGj2YLJXw9a8mZt9hJNOoTlm87RvLg9Tk/HkZ8
         xkY9q3C8PfKNZTegCH7nrgB/OUWgxPkjyOuNI=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:date:message-id:subject:from:to:cc:content-type;
        b=rhH96g41KMS6Wn376c/A8YQ3CKKIn3br9/OOsE9mLa9kKfHOGRMkrd7dF58nCpEkot
         WNLkCpmTFQrbZMjprZPC+ROe0lox7NNBD2nriP16YAAW7G1vhSqfCo+1RtjftPUmPcn+
         9MYTq5LWO4TZz1w0mVRonGDkkOLW+mOvnCNXE=
Received: by 10.229.223.129 with SMTP id ik1mr571116qcb.116.1278083117815; 
	Fri, 02 Jul 2010 08:05:17 -0700 (PDT)
Received: by 10.229.79.148 with HTTP; Fri, 2 Jul 2010 08:05:17 -0700 (PDT)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/150137>

Hi,

    A quick update of status.

1. The patch series has pass one round of modification, this include:
     1) The parsing method is changed from a two-pass way to a one-pass way;
     2) A simple code refactoring get done on 'parse_loc' which is
used by both line.c and builtin/blame.c
2. parent rewriting of line level history traversal
    To compose the basic code structure of this and complete part of
the code. You will see it in next week. :)

--
Regards!
Bo
----------------------------
My blog: http://blog.morebits.org
Why Git: http://www.whygitisbetterthanx.com/
