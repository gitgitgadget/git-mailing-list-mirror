From: "Giuseppe Bilotta" <giuseppe.bilotta@gmail.com>
Subject: Re: [RFC] Zit: the git-based single file content tracker
Date: Fri, 24 Oct 2008 22:06:44 +0200
Message-ID: <cb7bb73a0810241306i78078298o9483f8f93c238ac2@mail.gmail.com>
References: <gdok16$vh2$1@ger.gmane.org> <4901077A.7050904@gmx.ch>
	 <cb7bb73a0810232355u6de0479cyc260c80227f44e59@mail.gmail.com>
	 <m38wsei8ne.fsf@localhost.localdomain>
	 <7vabct3l1e.fsf@gitster.siamese.dyndns.org>
	 <alpine.DEB.1.10.0810241251490.27333@asgard.lang.hm>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: "Junio C Hamano" <gitster@pobox.com>,
	"Jakub Narebski" <jnareb@gmail.com>,
	"Jean-Luc Herren" <jlh@gmx.ch>, git@vger.kernel.org
To: david@lang.hm
X-From: git-owner@vger.kernel.org Fri Oct 24 22:08:18 2008
connect(): Connection refused
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KtSwy-0005EC-Db
	for gcvg-git-2@gmane.org; Fri, 24 Oct 2008 22:08:00 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752799AbYJXUGr (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 24 Oct 2008 16:06:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752822AbYJXUGq
	(ORCPT <rfc822;git-outgoing>); Fri, 24 Oct 2008 16:06:46 -0400
Received: from yx-out-2324.google.com ([74.125.44.30]:64942 "EHLO
	yx-out-2324.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752265AbYJXUGq (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 24 Oct 2008 16:06:46 -0400
Received: by yx-out-2324.google.com with SMTP id 8so370831yxm.1
        for <git@vger.kernel.org>; Fri, 24 Oct 2008 13:06:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from:to
         :subject:cc:in-reply-to:mime-version:content-type
         :content-transfer-encoding:content-disposition:references;
        bh=m/wNxOv0MYl+q8AYS1mYiqzxregAj0gWdPzUM5uXq4s=;
        b=OeXOForpkFgO93DysfrZtwHg1G0AND/3jiATxR8j4hd9UUvG4VjSjIJlPv4neg7SJ5
         ne8AY+XQsAuR30WrWonB/7VL7li/2yybTYdk///8exiq1vep4n3Wk5XVIekpkuvRUWvJ
         unVCA3lFVPRGZO7XG2K+MqaIVE5IZkLRRvJkE=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:to:subject:cc:in-reply-to:mime-version
         :content-type:content-transfer-encoding:content-disposition
         :references;
        b=NYnsF7WeSLMQJL+fVrIwnhQ8tSyly3DpTLs+gfHVScPUqC8jPPLEflIlAnu+IO/zTi
         3CJVM0DxMbzOyYVccT5lntflEfEGnixO1zjT2uVTCkpilRKo+9JbF5dNo/p8WcFUBS8h
         hM4RRO5K/w5XVqFNxluCA4kLJdcAgcHpnVYI4=
Received: by 10.150.12.10 with SMTP id 10mr6490591ybl.46.1224878804814;
        Fri, 24 Oct 2008 13:06:44 -0700 (PDT)
Received: by 10.150.145.2 with HTTP; Fri, 24 Oct 2008 13:06:44 -0700 (PDT)
In-Reply-To: <alpine.DEB.1.10.0810241251490.27333@asgard.lang.hm>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/99060>

On Fri, Oct 24, 2008 at 9:53 PM,  <david@lang.hm> wrote:
> I just had what's probably a silly thought.
>
> how close is a zit setup to a subproject setup?

Honestly, I haven't the slightest idea how they work. My
understanding, which could be completely wrong, is that they are
full-fledged git repositories, and that additional metadata at the top
level takes care of understanding what ref is needed for each toplevel
project. If this is true, using them wouldn't simplify zit, but rather
make it more complex (and space intensive).

-- 
Giuseppe "Oblomov" Bilotta
