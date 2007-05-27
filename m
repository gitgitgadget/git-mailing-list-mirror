From: "Morten Welinder" <mwelinder@gmail.com>
Subject: Re: [PATCH] Add -Wdeclaration-after-statement to CFLAGS to help enforce the instructions in SubmittingPatches
Date: Sun, 27 May 2007 10:58:05 -0400
Message-ID: <118833cc0705270758h1979eea2sc21ce351da03c6d3@mail.gmail.com>
References: <20070520154227.GG5412@admingilde.org>
	 <7vabvyfw7n.fsf@assigned-by-dhcp.cox.net>
	 <Pine.LNX.4.64.0705211347540.6410@racer.site>
	 <200705271639.35267.johan@herland.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org,
	"Johannes Schindelin" <Johannes.Schindelin@gmx.de>,
	"Junio C Hamano" <junkio@cox.net>,
	"Martin Waitz" <tali@admingilde.org>,
	"Shawn O. Pearce" <spearce@spearce.org>
To: "Johan Herland" <johan@herland.net>
X-From: git-owner@vger.kernel.org Sun May 27 16:58:13 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HsKCD-0004lf-7s
	for gcvg-git@gmane.org; Sun, 27 May 2007 16:58:13 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753455AbXE0O6J (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 27 May 2007 10:58:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753131AbXE0O6J
	(ORCPT <rfc822;git-outgoing>); Sun, 27 May 2007 10:58:09 -0400
Received: from ug-out-1314.google.com ([66.249.92.171]:23443 "EHLO
	ug-out-1314.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753455AbXE0O6H (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 27 May 2007 10:58:07 -0400
Received: by ug-out-1314.google.com with SMTP id j3so1453416ugf
        for <git@vger.kernel.org>; Sun, 27 May 2007 07:58:05 -0700 (PDT)
DKIM-Signature: a=rsa-sha1; c=relaxed/relaxed;
        d=gmail.com; s=beta;
        h=domainkey-signature:received:received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=Q/N2pTQKT6Fdpbo9j7yybA/PXS+Om+2qg2uVYnMLwFCQJ9rDSiHxsPrbOBnzZYVUmrC4+w3NfpcFfNg+HmyruYQsiermtJF0oB2L6KVti7bxO00cZyurnEw1u6aACvTAhxCbLJ9HISAjGkXnTsqmVdTr2a6Wq/OmtmyZscDVYXk=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=beta;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=uqpMBFCXiulod/jmuQp4+iOtuB7YXxY/QBq/85bdEuSs2m54cZRhT6T/Y4EbSiobT87KBvKp386TPeQmTiIYjvOlw7q2tHxN/KiZJAxA/tMs8CJJeHKm7HiwvUn+Y2SAkWrXCGMAaAm3lGAsRzQPYSCPyCu+hMpmvJ7/dlUDevg=
Received: by 10.78.201.10 with SMTP id y10mr1446739huf.1180277885645;
        Sun, 27 May 2007 07:58:05 -0700 (PDT)
Received: by 10.78.172.2 with HTTP; Sun, 27 May 2007 07:58:05 -0700 (PDT)
In-Reply-To: <200705271639.35267.johan@herland.net>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/48558>

> Why not automatically enforce it by putting -Wdeclaration-after-statement
> in the Makefile?

Because -Wdeclaration-after-statement regretably is a fairly new thing.

M.
