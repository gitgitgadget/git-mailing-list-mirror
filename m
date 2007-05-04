From: "Alex Riesen" <raa.lkml@gmail.com>
Subject: Re: [PATCH] Have git-revert, git-cherry-pick cleanup ./.msg upon successful completion.
Date: Fri, 4 May 2007 17:28:21 +0200
Message-ID: <81b0412b0705040828k32052538ne667b52ff9f2dd64@mail.gmail.com>
References: <20070504143022.8539.qmail@4071cc1c178e73.315fe32.mid.smarden.org>
	 <20070504143210.8690.qmail@a4171e0dbe98e3.315fe32.mid.smarden.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri May 04 17:28:30 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Hjzhq-0000M6-AP
	for gcvg-git@gmane.org; Fri, 04 May 2007 17:28:26 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933114AbXEDP2X (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 4 May 2007 11:28:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S933127AbXEDP2X
	(ORCPT <rfc822;git-outgoing>); Fri, 4 May 2007 11:28:23 -0400
Received: from an-out-0708.google.com ([209.85.132.244]:23498 "EHLO
	an-out-0708.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S933114AbXEDP2W (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 4 May 2007 11:28:22 -0400
Received: by an-out-0708.google.com with SMTP id b33so865873ana
        for <git@vger.kernel.org>; Fri, 04 May 2007 08:28:21 -0700 (PDT)
DKIM-Signature: a=rsa-sha1; c=relaxed/relaxed;
        d=gmail.com; s=beta;
        h=domainkey-signature:received:received:message-id:date:from:to:subject:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=e236qHDJKt3uYQCT3NSCq39RGQPOif1rkVVrnLLZsXiJYxXbPTuH7kgJKAbgSGiMjdDJ/lqPSBMuOZiulRxhaQ9zC4YKAoZEckLcuRlFlPg/JA0C5bN97qbnKKi4JGDkOT4j7qfB1q6ITvcPHGdltt2pqpY1y7VF1bYgMQxN6vM=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=beta;
        h=received:message-id:date:from:to:subject:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=A+l478uY5PPF9lIyiOtXwPSe71i/IwHC8gUwOvP8hfshOM5YqgGLNr8i6ZqJnbPcL22+4TlvonnPbBu/3waRIMjNV81X969q5yGNpFAM1FSS64Jx73pQkFCDsg/WW+9sdXBaZgUXWPOBXmPmah9TI+pGVqfpwYnY52iJ5obcRKA=
Received: by 10.100.31.2 with SMTP id e2mr2765332ane.1178292501374;
        Fri, 04 May 2007 08:28:21 -0700 (PDT)
Received: by 10.100.86.19 with HTTP; Fri, 4 May 2007 08:28:21 -0700 (PDT)
In-Reply-To: <20070504143210.8690.qmail@a4171e0dbe98e3.315fe32.mid.smarden.org>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/46184>

On 5/4/07, Gerrit Pape <pape@smarden.org> wrote:
> git-revert and git-cherry-pick left behind the commit message file ./.msg,
> have them use the -f option to git-commit to properly cleanup the
> automatically created file.

Could we also have the files in $GIT_DIR instead of in working directory?
