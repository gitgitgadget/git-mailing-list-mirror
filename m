From: "Jakub Narebski" <jnareb@gmail.com>
Subject: Re: [PATCH 3/3] Documentation: convert tutorials to man pages
Date: Fri, 2 May 2008 11:55:10 +0200
Message-ID: <8fe92b430805020255r1a06e169te583c371bde83ade@mail.gmail.com>
References: <20080502053051.c8066c4e.chriscool@tuxfamily.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: "Christian Couder" <chriscool@tuxfamily.org>
X-From: git-owner@vger.kernel.org Fri May 02 11:56:20 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Jrs01-0001bZ-UR
	for gcvg-git-2@gmane.org; Fri, 02 May 2008 11:56:18 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757781AbYEBJzM (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 2 May 2008 05:55:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753590AbYEBJzM
	(ORCPT <rfc822;git-outgoing>); Fri, 2 May 2008 05:55:12 -0400
Received: from rv-out-0506.google.com ([209.85.198.232]:33368 "EHLO
	rv-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751114AbYEBJzK (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 2 May 2008 05:55:10 -0400
Received: by rv-out-0506.google.com with SMTP id l9so74220rvb.1
        for <git@vger.kernel.org>; Fri, 02 May 2008 02:55:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        bh=4iW1BfWSzTS3lnzHzuvOEYwqwmfAY8ZuuLlCveqB5m8=;
        b=TygQFs+Y48W/EzwWinFs+E1VB7fMwS5r3bByM2hm+nPdBSS75R2FdMQtkRHCjlEyKE9+rWWKNuuzX9wmD6Kc8gm9zBAKJVoiU7Mfo/rRbmH6B5T5revauxA4QabWhEYq+6b0M/aP6ThzKY4Ryn9yltjDJyi7C511bs9Pe+PMhKM=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=GaC51raSr4EK6CjjGB8c/Lk1JzjyUfUjvKnA42HV40Ynyp3cqycuzx8tqvyYqRpqnty9VjmtIEM9B0FPHrzNMLpmaz/lLkArnRV+lFbpNXivdndaOTls71T31Knmi7l5COVX4BQ/3DkknMfO1Nfos9JGCubrk1ix7s7q30CF46Q=
Received: by 10.141.197.8 with SMTP id z8mr1261048rvp.285.1209722110613;
        Fri, 02 May 2008 02:55:10 -0700 (PDT)
Received: by 10.141.45.15 with HTTP; Fri, 2 May 2008 02:55:10 -0700 (PDT)
In-Reply-To: <20080502053051.c8066c4e.chriscool@tuxfamily.org>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/80975>

On 5/2/08, Christian Couder <chriscool@tuxfamily.org> wrote:
> This patch renames the following documents and at the same time converts
>  them to the man page format:
>
>  cvs-migration.txt -> gitcvs-migration.txt
>  everyday.txt      -> giteveryday.txt
>  tutorial.txt      -> gittutorial.txt
>  tutorial-2.txt    -> gittutorial-2.txt

I like the rest of the series, but this I have serious doubts about. I think
that manpage format is just not suitable for guides and tutorials (larger
works), especially that we have HTML and beginnings of info versions.

Beside, the filenames looks stupid... githooks would go in a pinch, but
other names...
-- 
Jakub Narebski
