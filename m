From: Tomasz Prus <to.prus@gmail.com>
Subject: bad file number
Date: Wed, 13 Apr 2011 14:20:14 +0200
Message-ID: <BANLkTikAATE4B3sK2MecA4ahWefNAZcSDQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Apr 13 14:20:24 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Q9z3X-00028A-4a
	for gcvg-git-2@lo.gmane.org; Wed, 13 Apr 2011 14:20:23 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755904Ab1DMMUQ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 13 Apr 2011 08:20:16 -0400
Received: from mail-bw0-f46.google.com ([209.85.214.46]:46041 "EHLO
	mail-bw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755673Ab1DMMUP (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 13 Apr 2011 08:20:15 -0400
Received: by bwz15 with SMTP id 15so512830bwz.19
        for <git@vger.kernel.org>; Wed, 13 Apr 2011 05:20:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:date:message-id:subject:from:to
         :content-type;
        bh=qh9QLFkTdfL8NNrvLnW4tG/8ALT/mRmDFhMJGm2a9Qk=;
        b=LXwHTfUgzKlfU5CD5ofCTxuj4tIhKFxEr0EtD0614kRZAXjUGyjNMZNGwIdGXRB2zv
         NmWDkg3gLLcrpijHv4Ah980JhFHGZ2F0umcI3/Vxppd475wCdgJoIiQ+egB/Chvsspuo
         JP6Zl/TpuHXrBZnjgB3EJEhwWTd7EHzuiTE/0=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:date:message-id:subject:from:to:content-type;
        b=t0rO0v1CfyImy6WRxRwGH8jblWiK8ttAg59ov34ZfEQ20VP0kGxJYxo9sllk5Zwg0z
         sqLPPCj3iHLpR7XcYciLG26paiy3G7OQYercCdL+RxhYkazZAGKaUQ/U1ESqCLkuz15i
         5KJYcPWa5PQcS4Sp1ZKul/9+PRcfhljFQxobM=
Received: by 10.204.81.213 with SMTP id y21mr6643552bkk.63.1302697214209; Wed,
 13 Apr 2011 05:20:14 -0700 (PDT)
Received: by 10.204.84.101 with HTTP; Wed, 13 Apr 2011 05:20:14 -0700 (PDT)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/171448>

Hi,

sometimes when I try to execute push I get such error and everything
back to normal after a while:

ssh: connect to host <domain here> port 1234: Bad file number
fatal: The remote end hung up unexpectedly

Can You help me? What can cause this, can it be a slow network upload?

Best,
Tomasz Prus
