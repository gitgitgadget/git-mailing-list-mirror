From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: [PATCH 2/2] gitweb: Show trailing slash when listing tree entry in tree listing
Date: Tue, 10 Oct 2006 23:00:16 +0200
Message-ID: <200610102300.16935.jnareb@gmail.com>
References: <20061010205238.33892.qmail@web31803.mail.mud.yahoo.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio C Hamano <junkio@cox.net>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Oct 10 22:59:23 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1GXOh4-0005AN-K9
	for gcvg-git@gmane.org; Tue, 10 Oct 2006 22:59:18 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030364AbWJJU7N convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git@m.gmane.org>); Tue, 10 Oct 2006 16:59:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030365AbWJJU7N
	(ORCPT <rfc822;git-outgoing>); Tue, 10 Oct 2006 16:59:13 -0400
Received: from ug-out-1314.google.com ([66.249.92.170]:22727 "EHLO
	ug-out-1314.google.com") by vger.kernel.org with ESMTP
	id S1030364AbWJJU7L (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 10 Oct 2006 16:59:11 -0400
Received: by ug-out-1314.google.com with SMTP id o38so831290ugd
        for <git@vger.kernel.org>; Tue, 10 Oct 2006 13:59:10 -0700 (PDT)
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:from:to:subject:date:user-agent:cc:references:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:message-id;
        b=X0tros0O+yjGKGfIiQwfvua+maHR+k2VfPAcoHARUkJGT0srfjX1+CvvT56fFpnr7c/OeqW3tI9fkejlXBsMtWZzmGz9d18YGX7nvN42MXv6Fq2awIiVS/NFl39/kotw4YGrTMyMnf1mOlxMNEp7chGQvn4qr8JRcD7y3uUROzw=
Received: by 10.66.224.19 with SMTP id w19mr8711851ugg;
        Tue, 10 Oct 2006 13:59:10 -0700 (PDT)
Received: from host-81-190-20-194.torun.mm.pl ( [81.190.20.194])
        by mx.google.com with ESMTP id x33sm1071240ugc.2006.10.10.13.59.09;
        Tue, 10 Oct 2006 13:59:09 -0700 (PDT)
To: Luben Tuikov <ltuikov@yahoo.com>
User-Agent: KMail/1.9.3
In-Reply-To: <20061010205238.33892.qmail@web31803.mail.mud.yahoo.com>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/28669>

Luben Tuikov wrote:
> P.S. Notice how there is a "snapshot" link on each line of
> shortlog, but there is no "snapshot" link in the nav bar
> of a=3Dcommit. =A0The "snapshot" link is next to "tree" down
> in the commit data. =A0There is also a "tree" link which is also
> in the navbar, but "shortlog" is missing.

The problem with snapshot is that we can have snapshot of a commit
(and all links in the top part of navigation bar till now deals with=20
current commit), and snapshot of a tree, which can be subdirectory
(and all links in the bottom part of navigation bar deals with=20
the views/presentations of a current object).
--=20
Jakub Narebski
Poland
