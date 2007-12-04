From: David Kastrup <dak@gnu.org>
Subject: Re: git help error
Date: Tue, 04 Dec 2007 20:50:41 +0100
Message-ID: <863auiw86m.fsf@lola.quinscape.zz>
References: <cc723f590712040826o7ca36bfg35b8cb4d64ee8d2d@mail.gmail.com> <7v1wa25oqc.fsf@gitster.siamese.dyndns.org> <874pey9uow.fsf@osv.gnss.ru> <7vr6i245b4.fsf@gitster.siamese.dyndns.org> <20071204194754.GB30780@bit.office.eurotux.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Dec 04 20:52:00 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IzdoB-0005Ei-Ba
	for gcvg-git-2@gmane.org; Tue, 04 Dec 2007 20:51:55 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751369AbXLDTvL (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 4 Dec 2007 14:51:11 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751904AbXLDTvK
	(ORCPT <rfc822;git-outgoing>); Tue, 4 Dec 2007 14:51:10 -0500
Received: from main.gmane.org ([80.91.229.2]:56809 "EHLO ciao.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751369AbXLDTvI (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 4 Dec 2007 14:51:08 -0500
Received: from list by ciao.gmane.org with local (Exim 4.43)
	id 1IzdnA-0003qH-G8
	for git@vger.kernel.org; Tue, 04 Dec 2007 19:50:52 +0000
Received: from pd95b0fdb.dip0.t-ipconnect.de ([217.91.15.219])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Tue, 04 Dec 2007 19:50:52 +0000
Received: from dak by pd95b0fdb.dip0.t-ipconnect.de with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Tue, 04 Dec 2007 19:50:52 +0000
X-Injected-Via-Gmane: http://gmane.org/
X-Complaints-To: usenet@ger.gmane.org
X-Gmane-NNTP-Posting-Host: pd95b0fdb.dip0.t-ipconnect.de
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/23.0.50 (gnu/linux)
Cancel-Lock: sha1:UQvx1gji2Zl2K+cf5wMgA71UTXI=
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/67077>

Luciano Rocha <strange@nsk.no-ip.org> writes:

> On Tue, Dec 04, 2007 at 11:40:15AM -0800, Junio C Hamano wrote:
>
>> Having said that, I do not mind accepting a patch that prepends the
>> nonlocal path to MANPATH in help.c::show_man_page().
>
> Actually, current man utilities locate the manual page by looking where
> the executable is, if MANPATH isn't defined (tested in Linux and
> Darwin).
>
> So, "unset MANPATH; man git-add" should be sufficient.

That only works for paths registered in /etc/manpath.config (or an
equivalent config file depending on system/distribution).

-- 
David Kastrup
