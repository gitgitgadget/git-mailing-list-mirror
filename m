From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: [PATCH] gitweb: tree view: eliminate redundant "blob"
Date: Sun, 1 Oct 2006 20:41:14 +0200
Message-ID: <200610012041.15296.jnareb@gmail.com>
References: <efc2no$eti$2@sea.gmane.org> <20060926213236.79160.qmail@web31815.mail.mud.yahoo.com> <7v64f9hku2.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Cc: Luben Tuikov <ltuikov@yahoo.com>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Oct 01 20:41:18 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1GU6FV-0007zu-Hi
	for gcvg-git@gmane.org; Sun, 01 Oct 2006 20:41:13 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932171AbWJASlI (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 1 Oct 2006 14:41:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932176AbWJASlH
	(ORCPT <rfc822;git-outgoing>); Sun, 1 Oct 2006 14:41:07 -0400
Received: from ug-out-1314.google.com ([66.249.92.175]:492 "EHLO
	ug-out-1314.google.com") by vger.kernel.org with ESMTP
	id S932171AbWJASlE (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 1 Oct 2006 14:41:04 -0400
Received: by ug-out-1314.google.com with SMTP id o38so440192ugd
        for <git@vger.kernel.org>; Sun, 01 Oct 2006 11:41:03 -0700 (PDT)
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:from:to:subject:date:user-agent:cc:references:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:message-id;
        b=QA1j+SFfRLuz0hvwFkrM6Y7/cBgbLEXpk/kolD8hhNHXI8E70cSfug572mfvOV4bxB8KndCyMQKlbBgDVgijRu83gRF/jhuVNge1NwbgU3AObQh5AMZbP0WvzK9Wew5/GiSGB0981EUEec6nsNakwGVGvVjXpGpYHLfm2izmg70=
Received: by 10.67.117.18 with SMTP id u18mr2136760ugm;
        Sun, 01 Oct 2006 11:41:03 -0700 (PDT)
Received: from host-81-190-17-45.torun.mm.pl ( [81.190.17.45])
        by mx.gmail.com with ESMTP id 29sm1909912uga.2006.10.01.11.41.02;
        Sun, 01 Oct 2006 11:41:02 -0700 (PDT)
To: Junio C Hamano <junkio@cox.net>
User-Agent: KMail/1.9.3
In-Reply-To: <7v64f9hku2.fsf@assigned-by-dhcp.cox.net>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/28185>

On Wed, 27 Sep 2006, Junio C Hamano wrote:
> If the only objection is that it is harder to realize that the
> remaining one (the other one that did not get removed by this
> redundancy elimination) is clickable, maybe that is what needs
> to be fixed.

But that is plain impossible without compromising interface usability.
Let me explain. 

In the case of tree view (directory listing) we have blobs (files and 
symlinks) and trees (directories). To mark item unequivocably as link 
it has to have default link color (blue) and default link decoration 
(underline). That means that we cannot distinguish really well (at 
least color) between tree and blob entries. I'd rather have redundant 
"blob"/"tree" (self)links, clearly marked as links, and tree entries 
using link decoration (blue, underlined) while blob entries have 
default text decoration (black, no underline).

In the case of shortlog/log/history/heads/tags view, to clearly mark 
subject/title of a commit or tag as link, we would have to use default 
link decoration. Let's for a while abandon link-within-link, i.e. using 
some of committags also in commit title (in shortlog/history view)...
But underlined text is harder to read, and blue underlined text even 
more so (as for example it is hard to read italics, commonly used for 
emphasis). I'd rather have additional "commit" link, clearly marked as 
link, and leave subject as is, as hidden link, as a shortcut.

I think that redundancy in a visual interface (and not only visual, as 
seen in the example of Perl programming language) is a good idea, 
contrary to the redundancy in code or data (database).
-- 
Jakub Narebski
Poland
