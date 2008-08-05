From: "Alex Riesen" <raa.lkml@gmail.com>
Subject: Re: [PATCH] git-p4: chdir now properly sets PWD environment variable in msysGit
Date: Wed, 6 Aug 2008 00:23:54 +0200
Message-ID: <81b0412b0808051523q71c4ca6ap719f3603aa7b44d4@mail.gmail.com>
References: <bad7471c0808011250v569ffaaby9e20a5ba1f971927@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Cc: simon@lst.de, shausman@trolltech.com, marius@trolltech.com,
	hanwen@google.com, gitster@pobox.com, git@vger.kernel.org
To: "Robert Blum" <rob.blum@gmail.com>
X-From: git-owner@vger.kernel.org Wed Aug 06 00:25:03 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KQUxe-000803-Ij
	for gcvg-git-2@gmane.org; Wed, 06 Aug 2008 00:24:59 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756482AbYHEWX5 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 5 Aug 2008 18:23:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756363AbYHEWX5
	(ORCPT <rfc822;git-outgoing>); Tue, 5 Aug 2008 18:23:57 -0400
Received: from yw-out-2324.google.com ([74.125.46.29]:62697 "EHLO
	yw-out-2324.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753942AbYHEWXz (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 5 Aug 2008 18:23:55 -0400
Received: by yw-out-2324.google.com with SMTP id 9so1586168ywe.1
        for <git@vger.kernel.org>; Tue, 05 Aug 2008 15:23:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from:to
         :subject:cc:in-reply-to:mime-version:content-type
         :content-transfer-encoding:content-disposition:references;
        bh=wqEuN1hZVwSjXT7d83dunMgrlikjy/yce1Ipl7nAIkM=;
        b=jxXK7Fe8YPTCd94NY+EC3xSFCkCY4vMH7P+aEB6nTanfiGfoXjEmt0zj83Gxz3eVOn
         KKumuw1/HIVJMnp0omB6iMRgQU6PvsRDxAXLIcHR0e9AvROTeYqGqdVUjEJQM4wsgf9O
         Vz2fGE5Gx9vBf4uR1fbFAk5c4e+UWST+AF54g=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:to:subject:cc:in-reply-to:mime-version
         :content-type:content-transfer-encoding:content-disposition
         :references;
        b=vy72cBomYJ+LyG1N0F53G59Wha1YyrQ9wcFeILyzdSPIZTBhKFdjIkWCVLsuB3HayW
         fwbI+b9D8UAmDMpooGRmigMqwFrkquI5keanfhPKWuWM2sopGWVEjAzcc8yuzTaqDFbR
         qf19DQ5YHLHdrI5ibm7IVa1Y0HgqY8cV6C0tQ=
Received: by 10.150.12.10 with SMTP id 10mr2203016ybl.160.1217975034843;
        Tue, 05 Aug 2008 15:23:54 -0700 (PDT)
Received: by 10.150.143.21 with HTTP; Tue, 5 Aug 2008 15:23:54 -0700 (PDT)
In-Reply-To: <bad7471c0808011250v569ffaaby9e20a5ba1f971927@mail.gmail.com>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/91467>

2008/8/1 Robert Blum <rob.blum@gmail.com>:
> P4 on Windows expects the PWD environment variable to be set to the
> current working dir, but os.chdir in python doesn't do that by default

Try just removing it (if you can). It worked for me (in bash of cygwin).
