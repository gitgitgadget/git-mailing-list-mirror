From: bain <bain@devslashzero.com>
Subject: Re: git-commit does not signoff using name supplied by --author
Date: Fri, 17 Oct 2008 03:31:44 -0700 (PDT)
Message-ID: <0f761673-f0ec-4689-b1f1-8019d4540b0c@i20g2000prf.googlegroups.com>
References: <6a7ddf4e-8fcb-4a39-b4c5-1396cf702c8b@f40g2000pri.googlegroups.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Oct 17 12:33:01 2008
connect(): Connection refused
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Kqmdg-0002Jr-0h
	for gcvg-git-2@gmane.org; Fri, 17 Oct 2008 12:33:00 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751658AbYJQKbq (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 17 Oct 2008 06:31:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751763AbYJQKbq
	(ORCPT <rfc822;git-outgoing>); Fri, 17 Oct 2008 06:31:46 -0400
Received: from mail-gx0-f62.google.com ([209.85.217.62]:36330 "EHLO
	mail-gx0-f62.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750912AbYJQKbp (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 17 Oct 2008 06:31:45 -0400
Received: by gxk22 with SMTP id 22so483980gxk.21
        for <git@vger.kernel.org>; Fri, 17 Oct 2008 03:31:44 -0700 (PDT)
Received: by 10.151.103.2 with SMTP id f2mr26578ybm.6.1224239504416; Fri, 17 
	Oct 2008 03:31:44 -0700 (PDT)
In-Reply-To: <6a7ddf4e-8fcb-4a39-b4c5-1396cf702c8b@f40g2000pri.googlegroups.com>
X-IP: 203.193.154.151
User-Agent: G2/1.0
X-HTTP-UserAgent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.9.0.1) 
	Gecko/2008070206 Firefox/3.0.1,gzip(gfe),gzip(gfe)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/98469>

> If i use git-commit --author "A U Thor <author.example.net>" -s it
> still uses my global author.name and author.email to add signoff
> message.
>
> Is this expected behavior?

Never mind...

Looking at the code i found out commiter name/email is used to
signoff, which is correct and can be different than author.

BAIN
