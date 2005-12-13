From: Martin Atukunda <matlads@dsmagic.com>
Subject: Re: [PATCH] [COGITO] make cg-tag use git-check-ref-format
Date: Tue, 13 Dec 2005 14:28:45 +0300
Organization: digital Solutions
Message-ID: <200512131428.45273.matlads@dsmagic.com>
References: <11344712912199-git-send-email-matlads@dsmagic.com> <7vy82p9rnb.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
X-From: git-owner@vger.kernel.org Tue Dec 13 12:31:27 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1Em8LF-00023O-6V
	for gcvg-git@gmane.org; Tue, 13 Dec 2005 12:29:11 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750880AbVLML3G (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 13 Dec 2005 06:29:06 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751189AbVLML3F
	(ORCPT <rfc822;git-outgoing>); Tue, 13 Dec 2005 06:29:05 -0500
Received: from mail1.starcom.co.ug ([217.113.72.31]:34844 "EHLO
	mail1.infocom.co.ug") by vger.kernel.org with ESMTP
	id S1750880AbVLML3E (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 13 Dec 2005 06:29:04 -0500
Received: from entandikwa.ds.co.ug ([::ffff:217.113.73.39])
  by mail1.infocom.co.ug with esmtp; Tue, 13 Dec 2005 14:28:55 +0300
  id 000F5CD8.439EB077.00003878
Received: from igloo.ds.co.ug (igloo.ds.co.ug [192.168.129.66])
	by entandikwa.ds.co.ug (Postfix) with ESMTP id 0B8C15173
	for <git@vger.kernel.org>; Tue, 13 Dec 2005 14:30:36 +0300 (EAT)
Received: from matlads by igloo.ds.co.ug with local (Exim 4.60)
	(envelope-from <matlads@dsmagic.com>)
	id 1Em8Kr-0004LS-Bq
	for git@vger.kernel.org; Tue, 13 Dec 2005 14:28:45 +0300
To: git@vger.kernel.org
User-Agent: KMail/1.8.3
In-Reply-To: <7vy82p9rnb.fsf@assigned-by-dhcp.cox.net>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/13576>

On Tuesday 13 December 2005 14:13, Junio C Hamano wrote:
> Martin Atukunda <matlads@dsmagic.com> writes:
> > The egrep pattern used by cg-tag is too restrictive. While it will
> > prevent control characters from being specified as a tag name, it will
> > also reject nearly anything written in a non-English language, as noted
> > by -hpa ...
> > -(echo $name | egrep -qv '[^a-zA-Z0-9_.@!:-]') || \
> > +git-check-ref-format $name || \
> >  	die "name contains invalid characters"
>
> Perhaps you meant to say:
>
> 	git-check-ref-format "$name"
>
Yes. i've just finished preparing a new patch with this exact change. But your 
patch is much better.

- Martin -

-- 
Due to a shortage of devoted followers, the production of great leaders has 
been discontinued.
