From: Luben Tuikov <ltuikov@yahoo.com>
Subject: Re: [PATCH 2/4] gitweb: bugfix: git_commit and git_commitdiff parents
Date: Fri, 4 Aug 2006 17:53:55 -0700 (PDT)
Message-ID: <20060805005355.41970.qmail@web31805.mail.mud.yahoo.com>
References: <7vzmekgigm.fsf@assigned-by-dhcp.cox.net>
Reply-To: ltuikov@yahoo.com
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Aug 05 02:54:05 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1G9AQR-0005SA-Jz
	for gcvg-git@gmane.org; Sat, 05 Aug 2006 02:54:00 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1422684AbWHEAx5 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 4 Aug 2006 20:53:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1422686AbWHEAx5
	(ORCPT <rfc822;git-outgoing>); Fri, 4 Aug 2006 20:53:57 -0400
Received: from web31805.mail.mud.yahoo.com ([68.142.207.68]:57701 "HELO
	web31805.mail.mud.yahoo.com") by vger.kernel.org with SMTP
	id S1422684AbWHEAx4 (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 4 Aug 2006 20:53:56 -0400
Received: (qmail 41972 invoked by uid 60001); 5 Aug 2006 00:53:55 -0000
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
  s=s1024; d=yahoo.com;
  h=Message-ID:Received:Date:From:Reply-To:Subject:To:Cc:In-Reply-To:MIME-Version:Content-Type:Content-Transfer-Encoding;
  b=0ZquUiZiP1b8JVQcL+ziiua7zMe3P/bQzQsmkfdXLZHJ5d9gLxNPkvWOzpqi1SIsX7AJGBnISAeL8m3Kz0xufmnFFLYEFeLp8YynPlFD91lZzMAUOpYMpEOnZY+28/2KyYB4Jizyp3xR7pOH6LLCz9A75XqgxthJqjh/8aYifxE=  ;
Received: from [64.215.88.90] by web31805.mail.mud.yahoo.com via HTTP; Fri, 04 Aug 2006 17:53:55 PDT
To: Junio C Hamano <junkio@cox.net>
In-Reply-To: <7vzmekgigm.fsf@assigned-by-dhcp.cox.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/24872>

--- Junio C Hamano <junkio@cox.net> wrote:
> Luben Tuikov <ltuikov@yahoo.com> writes:
> 
> > In git_commit() the hash base of $from_id is $parent, not
> > $hash:
> >  - If status is "D", then action blob for $from_id wants
> >    $parent, not $hash.  History needs $parent too.
> >  - If status is "R", then action blob for $from_id wants
> >    $parent, not $hash.
> >
> > In git_commitdiff() the hash base of $from_id is
> > $hash_parent, not $hash:
> >  - If status is "D".
> >  - If status is "M".
> 
> ... stopped in mid sentence???

Sorry.  The meaning is the same as for git_commit() and as
the paragraph text ("In git_commitdiff() the hash base of ...").

   Luben
