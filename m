From: Marcus <prima@wordit.com>
Subject: Git push error
Date: Sun, 18 May 2008 08:30:36 +0100
Message-ID: <8345bd80805180030l23f0412du6bd4361450544f92@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun May 18 09:31:40 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JxdMh-00089d-8y
	for gcvg-git-2@gmane.org; Sun, 18 May 2008 09:31:31 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752265AbYERHah (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 18 May 2008 03:30:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752167AbYERHah
	(ORCPT <rfc822;git-outgoing>); Sun, 18 May 2008 03:30:37 -0400
Received: from rv-out-0506.google.com ([209.85.198.239]:6668 "EHLO
	rv-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752075AbYERHah (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 18 May 2008 03:30:37 -0400
Received: by rv-out-0506.google.com with SMTP id l9so867133rvb.1
        for <git@vger.kernel.org>; Sun, 18 May 2008 00:30:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from:sender:to:subject:mime-version:content-type:content-transfer-encoding:content-disposition:x-google-sender-auth;
        bh=DG9k51d4kpve++qtvKWlaFQZ2sNGoczVoal5UR0wqNo=;
        b=TmHHX40CerbtZkq3iZpBH7eUQ1D7u4edDGW4VIw6Af3XOPTOwrq6rCtfB5B3xos/OC6KRDzzl9ngYm63U9nwmnqCNgKNNcB8i0HKnp9PfC1eddiJzDGV2H/xiOhtmsvFSrt/ZJWyVPo5tnjzUtlSlZqOK96CASgko0Ash9JAhQE=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=googlemail.com; s=gamma;
        h=message-id:date:from:sender:to:subject:mime-version:content-type:content-transfer-encoding:content-disposition:x-google-sender-auth;
        b=j4C3VwHJwgVJSuTPlzSW9mQnaKxxdWRl+/pM+GUKNsek5f8B3Xx5tyNDbrVVDrYzgG0gSrZXH48Ff4Uvr3G+zA0Gvjh17MawH0tIh4oK0efhlpYEhHfvD74CZ7JE+y8MmkV86TyFQl30b5z9Vdvsq6b4BjNPVfzBOQvteKLHo7M=
Received: by 10.140.207.2 with SMTP id e2mr2881642rvg.144.1211095836716;
        Sun, 18 May 2008 00:30:36 -0700 (PDT)
Received: by 10.141.212.7 with HTTP; Sun, 18 May 2008 00:30:36 -0700 (PDT)
Content-Disposition: inline
X-Google-Sender-Auth: b81496a4da8442b9
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/82378>

Can anybody tell me what the following error means?

-----------------
sh-3.00# git push ssh://me@git.domain.org/gitroot/project/projectmain.git master
Password:
fatal: exec pack-objects failed.
Broken pipe
-------------------

Thanks,

Marcus
