From: Matthieu Moy <Matthieu.Moy@imag.fr>
Subject: Re: Empty directories...
Date: Wed, 18 Jul 2007 02:39:50 +0200
Message-ID: <vpqfy3m7dex.fsf@bauges.imag.fr>
References: <85lkdezi08.fsf@lola.goethe.zz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: David Kastrup <dak@gnu.org>
X-From: git-owner@vger.kernel.org Wed Jul 18 02:40:18 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IAxaS-0000Ia-G0
	for gcvg-git@gmane.org; Wed, 18 Jul 2007 02:40:16 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753120AbXGRAkN (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 17 Jul 2007 20:40:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755048AbXGRAkN
	(ORCPT <rfc822;git-outgoing>); Tue, 17 Jul 2007 20:40:13 -0400
Received: from imag.imag.fr ([129.88.30.1]:59528 "EHLO imag.imag.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752889AbXGRAkL (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 17 Jul 2007 20:40:11 -0400
Received: from mail-veri.imag.fr (mail-veri.imag.fr [129.88.43.52])
	by imag.imag.fr (8.13.8/8.13.8) with ESMTP id l6I0dogN013644
	(version=TLSv1/SSLv3 cipher=AES256-SHA bits=256 verify=NO);
	Wed, 18 Jul 2007 02:39:50 +0200 (CEST)
Received: from bauges.imag.fr ([129.88.43.5])
	by mail-veri.imag.fr with esmtps (TLS-1.0:RSA_AES_256_CBC_SHA:32)
	(Exim 4.50)
	id 1IAxa2-0006dy-Hy; Wed, 18 Jul 2007 02:39:50 +0200
Received: from moy by bauges.imag.fr with local (Exim 4.63)
	(envelope-from <moy@imag.fr>)
	id 1IAxa2-00065z-FS; Wed, 18 Jul 2007 02:39:50 +0200
Mail-Followup-To: David Kastrup <dak@gnu.org>, git@vger.kernel.org
In-Reply-To: <85lkdezi08.fsf@lola.goethe.zz> (David Kastrup's message of "Wed\, 18 Jul 2007 02\:13\:11 +0200")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.0.97 (gnu/linux)
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-3.0 (imag.imag.fr [129.88.30.1]); Wed, 18 Jul 2007 02:39:50 +0200 (CEST)
X-IMAG-MailScanner-Information: Please contact IMAG DMI for more information
X-IMAG-MailScanner: Found to be clean
X-IMAG-MailScanner-SpamCheck: 
X-IMAG-MailScanner-From: moy@imag.fr
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/52815>

David Kastrup <dak@gnu.org> writes:

> or has somebody a better idea or interface or rationale?  I understand
> that there are use cases where one does not bother about empty
> directories, but for a _content_ tracker, not tracking directories
> because they are empty seems quite serious.

,----[ http://www.spinics.net/lists/git/msg30730.html ]
| From: Linus Torvalds <torvalds@xxxxxxxxxxxxxxxxxxxx>
| 
| I wouldn't personally mind if somebody taught git to just track empty
| directories too.
| 
| There is no fundamental git database reason not to allow them: it's in
| fact quite easy to create an empty tree object. The problems with
| empty directories are in the *index*, and they shouldn't be
| insurmountable.
| 
| [...]
`----

-- 
Matthieu
