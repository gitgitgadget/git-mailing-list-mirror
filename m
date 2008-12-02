From: "Caleb Cushing" <xenoterracide@gmail.com>
Subject: Re: more merge strategies : feature request
Date: Tue, 2 Dec 2008 08:46:00 -0500
Message-ID: <81bfc67a0812020546o79906a20jcd04bd42d18dd803@mail.gmail.com>
References: <81bfc67a0811290848m6cb219c0y71a7266001096f2d@mail.gmail.com>
	 <4933AC03.6050300@op5.se>
	 <ee2a733e0812011849l1b319c96u9abbb4e8dd4f53ce@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: "Andreas Ericsson" <ae@op5.se>, git@vger.kernel.org
To: SLONIK.AZ@gmail.com
X-From: git-owner@vger.kernel.org Tue Dec 02 14:47:34 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1L7Vb2-0004My-Jd
	for gcvg-git-2@gmane.org; Tue, 02 Dec 2008 14:47:25 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754198AbYLBNqF (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 2 Dec 2008 08:46:05 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753881AbYLBNqD
	(ORCPT <rfc822;git-outgoing>); Tue, 2 Dec 2008 08:46:03 -0500
Received: from rv-out-0506.google.com ([209.85.198.236]:62144 "EHLO
	rv-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754193AbYLBNqB (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 2 Dec 2008 08:46:01 -0500
Received: by rv-out-0506.google.com with SMTP id k40so2977109rvb.1
        for <git@vger.kernel.org>; Tue, 02 Dec 2008 05:46:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from:to
         :subject:cc:in-reply-to:mime-version:content-type
         :content-transfer-encoding:content-disposition:references;
        bh=RgW9FjHrUJdZEoZ1YcY8gMw04FRwdv1KOYIN2263q3E=;
        b=C/gTk55uTw4soWYbOrl8Wb7tdiCbYTpquopiuh+UyG2NWWow1NvQDFR4YejvqOvzhe
         Ru5sDwNp731Mri5qiMa7RUIK9DdMZN8j2U2GMiKjSeeqSM4Uz6p8AYIyTaPv7raemrYH
         CRVbn34zHMyApJWCQDKbxwYXqgh7G2SeWwxXU=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:to:subject:cc:in-reply-to:mime-version
         :content-type:content-transfer-encoding:content-disposition
         :references;
        b=QkcgDDugIrvZfsAMxCRBP7nPzGtqfwrA3D6STdOnkG9ITMzUNYNatPYHk9mTbWMg8A
         WBCydcOPWWRyFvLCjhykii+6KymffjbWLU1VUMr7n86oM6IaCbNLEXCr/Rzmw+XLvx24
         O8MVcdKD4HN+b6ejCYfOuQkbi+jwIGgObYLYA=
Received: by 10.141.197.21 with SMTP id z21mr5771970rvp.107.1228225560727;
        Tue, 02 Dec 2008 05:46:00 -0800 (PST)
Received: by 10.141.145.7 with HTTP; Tue, 2 Dec 2008 05:46:00 -0800 (PST)
In-Reply-To: <ee2a733e0812011849l1b319c96u9abbb4e8dd4f53ce@mail.gmail.com>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/102133>

> I guess that "no-overwrite" can be achieved by
>
>  git merge -s ours --no-commit

no it doesn't. which is why I called it a bad name. no-overwrite would
still add new lines to the file not in ours (and no-commit isn't
needed in that case) it just wouldn't overwrite conflicting lines, my
understanding of ours is that it will keep the files as is.
Caleb Cushing
