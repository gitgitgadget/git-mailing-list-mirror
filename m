From: Tim Harper <timcharper@gmail.com>
Subject: Git Submodule hooks someone else may find of use
Date: Thu, 2 Jul 2009 09:20:18 -0600
Message-ID: <e1a5e9a00907020820i34fb3127r90f29d06619fe64e@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Jul 02 17:21:00 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MMO5j-0003M0-J2
	for gcvg-git-2@gmane.org; Thu, 02 Jul 2009 17:20:52 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751171AbZGBPUi (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 2 Jul 2009 11:20:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751957AbZGBPUh
	(ORCPT <rfc822;git-outgoing>); Thu, 2 Jul 2009 11:20:37 -0400
Received: from mail-fx0-f218.google.com ([209.85.220.218]:52585 "EHLO
	mail-fx0-f218.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751145AbZGBPUg (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 2 Jul 2009 11:20:36 -0400
Received: by fxm18 with SMTP id 18so1567677fxm.37
        for <git@vger.kernel.org>; Thu, 02 Jul 2009 08:20:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:from:date:message-id
         :subject:to:content-type:content-transfer-encoding;
        bh=JepjEfem/YRE4o6b2KRVXw3fAmuDraWE0q17QG7sYrM=;
        b=dLnUiH0YdBU9CQ2Lf1RgDHu+goJ+K8vFcVNYAZmX6QJ7jo7pKo7Q9YYsC9tBd1Q/4b
         V0p1Zo7LL/ICB0I/Sbm+VEI13CjEcdnFYI5kBldzRkrgw6vSykk0G6N/8RzwYPltnNd1
         9bm/A+hlLXp3gXpx6yhWSWbS272WVWA2DVgNM=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:from:date:message-id:subject:to:content-type
         :content-transfer-encoding;
        b=wbT3cTO3TQHaMqXqJG8VySv/lb9dYkKgyoRYoKYFWx5j6Qt45GvVnCF5U7FhaMBlKz
         99rrsQbx2k5TYLeNnOcTKiipMXgdpMGEK5mpx9MnmChN7Tac1CKtXJv7OlO1AMQpGmsx
         jh9FIPoQM6nykp++aHspzAIllXDciv57H4Rd0=
Received: by 10.239.175.131 with SMTP id n3mr14397hbf.82.1246548038136; Thu, 
	02 Jul 2009 08:20:38 -0700 (PDT)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/122651>

A while ago I started a thread discussing my desires to have
submodules automatically update when I switch branches or pull.  This
I desired to occur only if my submodule revision conformed with the
pointer recorded in the superproject's previous HEAD.  In other words,
if my submodule showed as "modified", and I switch branches, I would
desire that this "modified" state persist exactly the same way an
uncommitted change would.

I've created a local git hook to support this behavior.  If it
interests you, you may find it here, under
'git-post-checkout-submodules'.

http://github.com/timcharper/git-helpers/tree/master

Installation instructions are found at the top of the script.

Feedback welcome.

Tim
