From: Romain Geissler <romain.geissler@gmail.com>
Subject: Re: End year project : minimal Git client based on libgit2
Date: Thu, 19 May 2011 18:15:34 +0200
Message-ID: <D1A000B1-992A-4671-822B-6B8FB2EBF8B3@gmail.com>
References: <BANLkTinGPvekMDT5nmsFQp3SpR_QOYq+UA@mail.gmail.com> <4DD4B648.8040509@op5.se>
Mime-Version: 1.0 (Apple Message framework v1082.1)
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 8BIT
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu May 19 18:15:44 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QN5t1-0003Kq-GB
	for gcvg-git-2@lo.gmane.org; Thu, 19 May 2011 18:15:44 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932733Ab1ESQPi (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 19 May 2011 12:15:38 -0400
Received: from mail-ww0-f44.google.com ([74.125.82.44]:60000 "EHLO
	mail-ww0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753120Ab1ESQPh convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 19 May 2011 12:15:37 -0400
Received: by wwa36 with SMTP id 36so3069426wwa.1
        for <git@vger.kernel.org>; Thu, 19 May 2011 09:15:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:content-type:mime-version:subject:from
         :in-reply-to:date:content-transfer-encoding:message-id:references:to
         :x-mailer;
        bh=IXydFUd0oDLNnoYgEpWX9MTT1u2XWcugeRetYGjasBo=;
        b=VIAue6K/C6I0aU/+7lAG3gcqt3BRln/tjg4ONW0cybxZnXQKQeMjqClZCCj9zuMYIT
         I2S10gd28qRR55v4e2oIRfq/8ZAzXv+IsjOcMj6/0FYyDtNhQZV127QRd4kBgdXaGFI1
         vYdiAzeXa2aGOVXPveiVl+bFqOXfebe/qa/f0=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=content-type:mime-version:subject:from:in-reply-to:date
         :content-transfer-encoding:message-id:references:to:x-mailer;
        b=iYUDihIQ2I+uL8gLzsHe8fukk1BOjloQp4NxAZEorM74aw9I75s3UosbfCwFuvnfns
         JiQuo5B6v7KEs6+2Ahuqh8I50YgwyzawOG/5tNyOKvGJW+R9h3/ird0e96Qvc7eTiRXt
         1A+NpDujbFVhopyVPbHCgZdlcvv/W5o5xkpLE=
Received: by 10.227.201.142 with SMTP id fa14mr3335855wbb.48.1305821736256;
        Thu, 19 May 2011 09:15:36 -0700 (PDT)
Received: from ensi-vpn-36.imag.fr (ensi-vpn-36.imag.fr [129.88.57.36])
        by mx.google.com with ESMTPS id bs4sm1715026wbb.52.2011.05.19.09.15.35
        (version=SSLv3 cipher=OTHER);
        Thu, 19 May 2011 09:15:35 -0700 (PDT)
In-Reply-To: <4DD4B648.8040509@op5.se>
X-Mailer: Apple Mail (2.1082.1)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/173965>

Hello,

It seems that most of the currently scripted commands can't be implemented with libgit2 as it's still not mature enough to handle it (eg the whole merge part is still missing), though we might have missed something.

Thus we've chosen to first focus on two simple plumbings: commit-tree and cat-file as there is the material for it in libgit2 and the command signature is restricted to only a few parameters. When it's done, we'll try to compare the efficiency of this partial port (works well and quickly). Thanks to that background, it might be easier to move on other plumbings.

Romain Geissler

(Sorry for answering you directly, i should have checked the mail recipient before sending it !)