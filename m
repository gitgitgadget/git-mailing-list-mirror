From: Jon Jagger <jon@jaggersoft.com>
Subject: git (commit|tag) atomicity
Date: Tue, 28 Feb 2012 15:40:09 +0000
Message-ID: <CADWOt=j8gJvr88eNAfoYq_qGQvG6M_k-9MCuof_DRrH0sHRVCA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Feb 28 16:40:20 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1S2PA2-00062a-1k
	for gcvg-git-2@plane.gmane.org; Tue, 28 Feb 2012 16:40:18 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965140Ab2B1PkL (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 28 Feb 2012 10:40:11 -0500
Received: from mail-tul01m020-f174.google.com ([209.85.214.174]:52322 "EHLO
	mail-tul01m020-f174.google.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1755732Ab2B1PkK (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 28 Feb 2012 10:40:10 -0500
Received: by obcva7 with SMTP id va7so6915278obc.19
        for <git@vger.kernel.org>; Tue, 28 Feb 2012 07:40:09 -0800 (PST)
Received-SPF: pass (google.com: domain of jrbjagger@googlemail.com designates 10.182.141.9 as permitted sender) client-ip=10.182.141.9;
Authentication-Results: mr.google.com; spf=pass (google.com: domain of jrbjagger@googlemail.com designates 10.182.141.9 as permitted sender) smtp.mail=jrbjagger@googlemail.com; dkim=pass header.i=jrbjagger@googlemail.com
Received: from mr.google.com ([10.182.141.9])
        by 10.182.141.9 with SMTP id rk9mr6887943obb.50.1330443609603 (num_hops = 1);
        Tue, 28 Feb 2012 07:40:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=gamma;
        h=mime-version:sender:date:x-google-sender-auth:message-id:subject
         :from:to:content-type;
        bh=wGV/MegHXrQArW0OMtHQnYiLZaOwHS6Rs0tEi1G/YX0=;
        b=fwyV9RM7HJ9xysaT6eMRIWac0q26Oi0xZVCZX4HCeVrDBJClsf+JaXan77n6f/SHXT
         k68zWucfnTrzoKxbS54WNO9lm1QCeGj7taBMl/lqhQc+YWv9WWunoFDAfm9KaeWGgOPw
         jDTgAN6xbD0EPCWHBHdIHUz3pIK+6cvAcIOS4=
Received: by 10.182.141.9 with SMTP id rk9mr6129917obb.50.1330443609541; Tue,
 28 Feb 2012 07:40:09 -0800 (PST)
Received: by 10.182.133.40 with HTTP; Tue, 28 Feb 2012 07:40:09 -0800 (PST)
X-Google-Sender-Auth: XNiaC0lnKn78KHyQD8lPC6mpoZM
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/191739>

Hi,
I don't know a lot about git - I use it as a tool behind
http://cyber-dojo.com
which is an online coding dojo server.
I have a quick question...
If I do a
   git commit ....
in one thread and a
   git tag | sort -g
in another thread is the output of the git tag guaranteed to be atomic?
That is, the output will be from before the git commit or after it but
not a mixture?
Logically, I assume so but cannot find anything definitive on google
or in my git books or from the lips of my friends.
Thanks for any help
Jon Jagger
