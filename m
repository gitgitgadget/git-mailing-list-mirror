From: "KwangYul Seo" <kwangyul.seo@gmail.com>
Subject: Git hooks are not called over HTTP
Date: Fri, 17 Oct 2008 15:23:52 +0900
Message-ID: <7beb12420810162323o6dce0a71r897fbed9b9d3e417@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Oct 17 08:25:19 2008
connect(): Connection refused
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Kqilq-0007oR-LD
	for gcvg-git-2@gmane.org; Fri, 17 Oct 2008 08:25:11 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751802AbYJQGX4 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 17 Oct 2008 02:23:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751763AbYJQGXz
	(ORCPT <rfc822;git-outgoing>); Fri, 17 Oct 2008 02:23:55 -0400
Received: from nf-out-0910.google.com ([64.233.182.190]:18853 "EHLO
	nf-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751487AbYJQGXy (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 17 Oct 2008 02:23:54 -0400
Received: by nf-out-0910.google.com with SMTP id d3so223622nfc.21
        for <git@vger.kernel.org>; Thu, 16 Oct 2008 23:23:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from:to
         :subject:mime-version:content-type:content-transfer-encoding
         :content-disposition;
        bh=igMSnQkXeSdBDB+SsjzpnJjzUWjr7t1UGS4P6t9OuAw=;
        b=Mw7q+rJPPHw/WWxA/mTYKkr+c2mAsqYrkMjm8gRfpHB6OZxU4IAy7GFTIAWJ4/BxEA
         /Fkd1CKYDvudanTmWK9SzN+VKmAN+zY+9RDJsfBmav+GJmfJKhSFH3N6s4y6Ezc454Sa
         4PFuwx9DCMBOqbDlcGxKP59zfHmd58NUelrbo=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:to:subject:mime-version:content-type
         :content-transfer-encoding:content-disposition;
        b=JxEMQ/26whh9sTRPF5tjVcsuKglFVu5UkDlqucDwY1SypmJfB7pJH9j5dgkR7bg3cp
         FBPqTTvDOKEnd14kZSJrtXWJuK0YbT6IawyagEwDrcPRRy1UoCVhdNQ3oMZihXSfuQAv
         MxZKBzxfQaIvglHWqHSxuf/rNvqt4hx2h4C8c=
Received: by 10.210.78.16 with SMTP id a16mr3980634ebb.49.1224224632970;
        Thu, 16 Oct 2008 23:23:52 -0700 (PDT)
Received: by 10.210.33.4 with HTTP; Thu, 16 Oct 2008 23:23:52 -0700 (PDT)
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/98448>

Hi,

I have setup a git repository with post-receive and post-update
enabled. I configured hooks.envelopesender and hooks.mailinglist. I
confirmed that it works fine with push from local repositories.
However, hooks are never called when push is done over HTTP. I added
'echo abc' to post-receive to see if it is called or not. With local
push, abc was printed, but with HTTP push it was not printed. What is
the problem here?

BTW, I use Ubuntu hardy.

Regards,
Kwang Yul Seo
