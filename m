From: Michael Witten <mfwitten@gmail.com>
Subject: Re: Ability to edit message from git rebase --interactive.
Date: Fri, 10 Apr 2009 07:41:48 -0500
Message-ID: <b4087cc50904100541h2dfb0902jf38f3254394afad0@mail.gmail.com>
References: <200903171953.23650.ogoffart@kde.org>
	 <alpine.DEB.1.00.0903172329480.10279@pacific.mpi-cbg.de>
	 <200904101417.56422.ogoffart@kde.org>
	 <b4087cc50904100537j64e8fef1u157c717fe4d8207b@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	git@vger.kernel.org
To: Olivier Goffart <ogoffart@kde.org>
X-From: git-owner@vger.kernel.org Fri Apr 10 14:43:26 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LsG4o-0001zt-KV
	for gcvg-git-2@gmane.org; Fri, 10 Apr 2009 14:43:23 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S938466AbZDJMlw (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 10 Apr 2009 08:41:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S938447AbZDJMlv
	(ORCPT <rfc822;git-outgoing>); Fri, 10 Apr 2009 08:41:51 -0400
Received: from qw-out-2122.google.com ([74.125.92.24]:37306 "EHLO
	qw-out-2122.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S938475AbZDJMlt (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 10 Apr 2009 08:41:49 -0400
Received: by qw-out-2122.google.com with SMTP id 8so1259582qwh.37
        for <git@vger.kernel.org>; Fri, 10 Apr 2009 05:41:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :date:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=CsNX0SxPCSP193k9vpHRXdp4E2P9HP29nIreQ/MUA60=;
        b=WoL9g4lQ7s5+jfvU7nm/xJYIlyGPI8t1IpOa1DfyDlCHlN307tLo7ZaKGHwVtjpiOW
         5otsoHg0xg5QXZqNJZKvEURIbF1g3deEOuRNJk+i1ZVIi4z5JJkPG6Rr+oSI5NbvMwrE
         EEWZnLc2K76JR7qjE4GFZtoJB2KS/DRAlzQ4w=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=OTOwk5osHkBzFl13Q2N/yR6kxbX4+PzrhyeXuTKCCeMNGypStKlw4ZJX3/GzEwp6jT
         OR5XGPxgz0Yged/N7tqLJymaQX07KFHC16mD5/Xk6JBK2wvBv8XEQpU9MC0T0aHkDfm+
         V7886FG17ahNyXCGf8qHTTzBZUZEVOAZSEVXg=
Received: by 10.224.2.130 with SMTP id 2mr3899368qaj.303.1239367308607; Fri, 
	10 Apr 2009 05:41:48 -0700 (PDT)
In-Reply-To: <b4087cc50904100537j64e8fef1u157c717fe4d8207b@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/116258>

On Fri, Apr 10, 2009 at 07:37, Michael Witten <mfwitten@gmail.com> wrote:
> How about 'a' for an immediate [a]mend?

However, rebase still seems overkill for most situations. I'd bet that
usually people want to amend just 1 or 2 commit messages. Perhaps
git-commit's --amend could take optional arguments and then run rebase
appropriately behind the scene.
