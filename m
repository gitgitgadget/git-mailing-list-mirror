From: David Kastrup <dak@gnu.org>
Subject: Re: [PATCH] Make git-archimport log entries more consistent
Date: Thu, 30 Aug 2007 09:47:01 +0200
Message-ID: <86myw9jwga.fsf@lola.quinscape.zz>
References: <617indss2f.fsf@fencepost.gnu.org> <7vmyw9af3q.fsf@gitster.siamese.dyndns.org> <fc339e4a0708292019s3d4f6914h4f9efe6f1172c380@mail.gmail.com> <7vir6xacha.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Aug 30 09:47:50 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IQeki-0001dr-7T
	for gcvg-git@gmane.org; Thu, 30 Aug 2007 09:47:44 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753855AbXH3HrR (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 30 Aug 2007 03:47:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754660AbXH3HrR
	(ORCPT <rfc822;git-outgoing>); Thu, 30 Aug 2007 03:47:17 -0400
Received: from main.gmane.org ([80.91.229.2]:57711 "EHLO ciao.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753101AbXH3HrQ (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 30 Aug 2007 03:47:16 -0400
Received: from list by ciao.gmane.org with local (Exim 4.43)
	id 1IQekD-0001xt-3y
	for git@vger.kernel.org; Thu, 30 Aug 2007 09:47:13 +0200
Received: from pd95b0fdb.dip0.t-ipconnect.de ([217.91.15.219])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Thu, 30 Aug 2007 09:47:13 +0200
Received: from dak by pd95b0fdb.dip0.t-ipconnect.de with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Thu, 30 Aug 2007 09:47:13 +0200
X-Injected-Via-Gmane: http://gmane.org/
X-Complaints-To: usenet@sea.gmane.org
X-Gmane-NNTP-Posting-Host: pd95b0fdb.dip0.t-ipconnect.de
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.1.50 (gnu/linux)
Cancel-Lock: sha1:X5UpD1pAPtVOhn7EEUiGWk5LPPM=
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/57010>

Junio C Hamano <gitster@pobox.com> writes:

> I do not think anybody would doubt that the updated one is nicer
> to the eye.  That's why I said it would have been nicer if the
> message was formatted like that from the beginning.  But I do
> not think you can claim it is _more_ consistent.  It just
> formats under a rule different from the original.  The issue is
> if the "nicer-to-the-eye" outweighs potential breakage the
> reformatting can cause to existing parsers, if any.
>
> That's why I wanted to know if people _rely_ on the current
> behaviour, because I was hoping that everybody would answer "yes
> nicer-to-the-eye is more important and there is no drawback".

There are basically two ways to go forward:

a) keep the ugly behavior for all eternity
b) change it and have people adapt dependent tools

If it is point b), there is not really a migration strategy worth
noting.  One can formally announce one's intent of changing it for a
while before actually doing it, but given that the previous format was
not declared canonical at any point of time, the question is whether
anyone will indeed notice before things break.

-- 
David Kastrup
