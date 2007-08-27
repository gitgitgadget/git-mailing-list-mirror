From: Johannes Gilger <heipei@hackvalue.de>
Subject: Re: git-import.sh using git-fast-import
Date: Mon, 27 Aug 2007 19:44:44 +0200
Message-ID: <46D30D8C.204@hackvalue.de>
References: <fcaeb9bf0708270913o37b2dbdfw2f5f7d89d9ab1d21@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
To: Git Mailing List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Mon Aug 27 20:39:29 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IPjJZ-0005LN-3T
	for gcvg-git@gmane.org; Mon, 27 Aug 2007 20:27:53 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757507AbXH0S1t (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 27 Aug 2007 14:27:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1757812AbXH0S1t
	(ORCPT <rfc822;git-outgoing>); Mon, 27 Aug 2007 14:27:49 -0400
Received: from avalon.gnuzifer.de ([85.10.199.84]:53444 "EHLO
	avalon.gnuzifer.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756858AbXH0S1s (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 27 Aug 2007 14:27:48 -0400
X-Greylist: delayed 2606 seconds by postgrey-1.27 at vger.kernel.org; Mon, 27 Aug 2007 14:27:48 EDT
Received: from 0-063.vpn.rwth-aachen.de ([134.130.240.63]:52282)
	by avalon.gnuzifer.de with esmtpsa (TLS-1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.63)
	(envelope-from <heipei@hackvalue.de>)
	id 1IPidR-0007FL-Js
	for git@vger.kernel.org; Mon, 27 Aug 2007 19:44:21 +0200
User-Agent: Thunderbird 2.0.0.6 (X11/20070803)
In-Reply-To: <fcaeb9bf0708270913o37b2dbdfw2f5f7d89d9ab1d21@mail.gmail.com>
X-Enigmail-Version: 0.95.2
OpenPGP: id=42F6DE81;
	url=http://pgpkeys.pca.dfn.de/pks/lookup?op=get&search=0x58EEB17842F6DE81
X-SA-Exim-Connect-IP: 134.130.240.63
X-SA-Exim-Mail-From: heipei@hackvalue.de
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/56867>

Hi,

nice of you to share, but i think the policy on this mailing list is to
include patches (and probably shellscripts like your's) in the message
itself rather than create a file attachment. I for one find it much more
convenient.

regards, jojo

Nguyen Thai Ngoc Duy wrote:
> It is not really good. It does not run as fast as git-add &&
> git-commit. But it can swallow big directories that git-add &&
> git-commit can't. So I think I would share. It's also simpler than
> those in contrib/fast-import, making it a good start for
> git-fast-import's new users.
>
> To run it, move inside the directory you want to import then type
> ./git-import.sh master 'your import message'
