From: "Richard Hartmann" <richih.mailinglist@gmail.com>
Subject: [RFC] Automagic patch merge ack emails
Date: Mon, 22 Dec 2008 15:07:07 +0100
Message-ID: <2d460de70812220607j7f218ee3r7722bc8147a3dab4@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Dec 22 15:09:33 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LElTI-0006LM-Jc
	for gcvg-git-2@gmane.org; Mon, 22 Dec 2008 15:09:25 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753939AbYLVOHL (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 22 Dec 2008 09:07:11 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754228AbYLVOHK
	(ORCPT <rfc822;git-outgoing>); Mon, 22 Dec 2008 09:07:10 -0500
Received: from rn-out-0910.google.com ([64.233.170.186]:17302 "EHLO
	rn-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753750AbYLVOHJ (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 22 Dec 2008 09:07:09 -0500
Received: by rn-out-0910.google.com with SMTP id k40so1501603rnd.17
        for <git@vger.kernel.org>; Mon, 22 Dec 2008 06:07:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from:to
         :subject:mime-version:content-type:content-transfer-encoding
         :content-disposition;
        bh=8MVj3aIYHVHAe6+R9LB1rMJbq/g+851a8I5i1t6Xl+k=;
        b=wfBiGQU+RBzaALbgIKBgreL1Rte1fzzMPPKPkDLreWmgjCmETNU6kvQ6CogFtuQmG2
         WzQfaVm++FZrqAiSE8VG/mwkbFRPtALaZCTtnbflkykKfHEiWnwJ8OmFnamZTQuURaxJ
         m1MqtkrFobniiMmRWsjvo08L+hYFBTF9m/qNg=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:to:subject:mime-version:content-type
         :content-transfer-encoding:content-disposition;
        b=hnBmOJWFosah7tAc8O1JovLy7lDAG6FSkSAZmo401etl1CnScdIQlk4ADziEbi8lyH
         KoeiR6G9AzDLivB+GJ+N0gBm7Mv0l6sxxSBAidZJJtGOw/yVG/UH3zRKK3DRhuYaWUau
         tInKzDZMWFj/9rQ8zISexdh8nYJg0CKD8LJus=
Received: by 10.100.166.10 with SMTP id o10mr3801600ane.126.1229954827862;
        Mon, 22 Dec 2008 06:07:07 -0800 (PST)
Received: by 10.100.43.19 with HTTP; Mon, 22 Dec 2008 06:07:07 -0800 (PST)
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/103755>

Hi all,

I poked around the docs, but I could not find any option to have git
send email to people who signed off a patch when it's merged.
I only realized the two patches I sent were merged because they were
listed in the RC changelog summary and would have followed up my patch
email in a about a week, asking about its status.

Does anyone else think this is useful? Does anyone else think it should
make it into main so it can be enabled via config, not via a hook that
needs to be imported into each and every repo?


Richard
