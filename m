From: =?UTF-8?Q?Roger_Pau_Monn=C3=A9?= <roger.pau@entel.upc.edu>
Subject: Git an case-insensitive Mac OS X filesystem
Date: Tue, 11 Sep 2012 10:21:16 +0100
Message-ID: <CAPLaKK71O3RzavOqY2uVC1tUsbs+W6WxJRWuLBDFUvTwojAN-g@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Sep 11 11:21:29 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TBMes-0007i8-QQ
	for gcvg-git-2@plane.gmane.org; Tue, 11 Sep 2012 11:21:27 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756963Ab2IKJVT (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 11 Sep 2012 05:21:19 -0400
Received: from mail-lb0-f174.google.com ([209.85.217.174]:63669 "EHLO
	mail-lb0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755158Ab2IKJVS (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 11 Sep 2012 05:21:18 -0400
Received: by lbbgj3 with SMTP id gj3so215658lbb.19
        for <git@vger.kernel.org>; Tue, 11 Sep 2012 02:21:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:sender:date:x-google-sender-auth:message-id:subject
         :from:to:content-type;
        bh=AVnLDMQxZ4SH9d5hZU1sCAQ25/gkm1qjhk0nriWK6hQ=;
        b=u8CoEazPTX/bAMgBpZBgHzPD5+gkz1vS4ZCoNTIw/erd5Mxqytm7lXA66KbwLscdy0
         Mfco4Ee17NSMYidSqvH1UOw6Cg2Z0/e7eashZmmjhNdLwHzBg9/2IfAdn9hR3X8CgW+9
         7Atl9wt7xA6TH5EAUO5IMpTNKOpdxNvM4SesqKBeOSmOw4+I03dzQrYOlZhe0j5Zz5EU
         9QTQlDtWKOfaqFEzosqTqBtw3nOG/ooL7c9IZAzpV4azHnokPAo81+jHrRALSVS9pDeQ
         hyRSEiPTNQF9zejIdVNcYr0geZGCQrs9UazDW42KaBVUxgWON48lenv2RLxamJHtwOY9
         9/tA==
Received: by 10.152.131.68 with SMTP id ok4mr15199561lab.47.1347355276677;
 Tue, 11 Sep 2012 02:21:16 -0700 (PDT)
Received: by 10.114.0.20 with HTTP; Tue, 11 Sep 2012 02:21:16 -0700 (PDT)
X-Google-Sender-Auth: qLk7vf3rZ4Wfickfs714ozk1tUk
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/205210>

Hello,

I'm using git for all my projects, and I usually work under Mac OS X
with the default filesystem (that's case-insensitive, but
case-preserving). I'm currently working on a project that has several
branches, and two of them are called origin/DHCPCD and origin/dhcpcd
respectively, that's unfortunate, but I cannot do anything about it.
This completely breaks the git repository, because
.git/refs/remotes/origin/DHCPD and .git/refs/remotes/origin/dhcpd are
actually the same file, so when I try to update my repository
performing a git pull I get the following error:

error: Ref refs/remotes/origin/dhcpcd is at
6b371783de2def2d6e3ec2680ba731f7086067ee but expected
79f701ce599a27043eed8343f76406014963278a

So I was wondering if anyone has stumbled upon this issue, and what's
the best approach to fix it.

Thanks, Roger.
