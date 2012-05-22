From: Simon Perrat <simon.perrat@gmail.com>
Subject: Re: Working on MediaWiki-to-Git contrib
Date: Tue, 22 May 2012 17:27:54 +0200
Message-ID: <CA+hdvHi+ovbCTu-QxNfhrWQ6vfcHHvnnX0Wh8S8z4y50jkNHag@mail.gmail.com>
References: <CA+hdvHjbF-xPBLwmCdMByhN96pk=naeGUrMo0TcgmzrebxARHg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Cc: matthieu.moy@imag.fr, julien.khayat@ensimag.fr,
	simon.cathebras@ensimag.fr, charles.roussel@ensimag.fr,
	Guillaume Sasdy <guillaume.sasdy@gmail.com>,
	kim-thuat.nguyen@ensimag.fr, pavel.volek@ensimag.fr,
	javier.roucher-iglesias@ensimag.fr
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue May 22 17:28:26 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SWr0Z-00060C-Ig
	for gcvg-git-2@plane.gmane.org; Tue, 22 May 2012 17:28:23 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1759209Ab2EVP2S (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 22 May 2012 11:28:18 -0400
Received: from mail-ob0-f174.google.com ([209.85.214.174]:51973 "EHLO
	mail-ob0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752889Ab2EVP2P (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 22 May 2012 11:28:15 -0400
Received: by obbtb18 with SMTP id tb18so9732369obb.19
        for <git@vger.kernel.org>; Tue, 22 May 2012 08:28:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        bh=lqakHDiIbecQrzXdPx0nwz3vZqnN96cmJxU4beROgp0=;
        b=zxsCin4fRSnIJssRiN8wp57bbVB0V7DrSRtnm1tlo/sV/DyjGc65N3qhvlKFcUHwta
         p75376YKKpTi6Ks/KP2dr3KTQen8m0zYp7mexJiw5HkPpPqxs3Q1pSKNTMNn5q6d1Ksi
         wjSxcJt3OWDld0JDNHIQoiAYl5FKarme9pElBv3iX1DINr6HgsKyPYzDc3SaH4b7O1kk
         5bZtavq2HZe/YkO0uDlMd933DdNd/IatVcb22KzfKo3PcwVGtnIrQztMKXD3zzhfFjVi
         RlwbOZnJ1To6x1U2QWX9AYIvP3vpfNnKod0s+lZykN+y20K5qWFRWbAwJvR5A3+nXnvU
         uBvA==
Received: by 10.182.46.36 with SMTP id s4mr22673267obm.58.1337700494587; Tue,
 22 May 2012 08:28:14 -0700 (PDT)
Received: by 10.60.169.107 with HTTP; Tue, 22 May 2012 08:27:54 -0700 (PDT)
In-Reply-To: <CA+hdvHjbF-xPBLwmCdMByhN96pk=naeGUrMo0TcgmzrebxARHg@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/198201>

Hi,

Last year, a group of students from Ensimag, institute of technology
in Grenoble, France, contributed to Git: they developed a bridge
between Git and Mediawiki, meaning you could edit wikis using your
favorite version control system. You can have a view of their work
here: https://github.com/Bibzball/Git-Mediawiki/wiki

This year, we are two groups of students which get down to the work
again. Matthieu Moy is mentoring us.

Group 1: Simon Cathebras, Julien Khayat, Simon Perrat, Charles Roussel
and Guillaume Sasdy. Our first goal is to develop a comprehensive
testing environment for this project; afterwards we will jump on to
the development of new functionalities.

Group 2: Javier Roucher Iglesias, Kim Thuat Nguyen, Pavel Volek. Our
goal is to develop some new functionalities for the bridge
git-mediawiki and improve the functionalities which are incomplete.

First functionality:
Basically, we want to manage MediaWiki attachments (i.e. File:...
pages): allow git-remote-mediawiki to export local files to MediaWiki
attachments, and vice-versa.

Second functionality:
We want to use another procedure to save the login and the password
without saving it in a local file. Is it possible to use the "Git
Credential Helper"? Or is there another way to save this information?

If you've had the occasion to use this tool and have some feedback, or
have any suggestion of improvement, we'd be grateful to hear your
comments.

Best regards, we hope to make a good job ;)
