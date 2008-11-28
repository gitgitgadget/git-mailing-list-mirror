From: jidanni@jidanni.org
Subject: clean the manual of unnecessary quote marks
Date: Fri, 28 Nov 2008 10:09:32 +0800
Message-ID: <87fxlcwqhv.fsf@jidanni.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Nov 28 03:10:54 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1L5som-0000dj-Fp
	for gcvg-git-2@gmane.org; Fri, 28 Nov 2008 03:10:52 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753320AbYK1CJg (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 27 Nov 2008 21:09:36 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753305AbYK1CJf
	(ORCPT <rfc822;git-outgoing>); Thu, 27 Nov 2008 21:09:35 -0500
Received: from sd-green-bigip-81.dreamhost.com ([208.97.132.81]:35759 "EHLO
	homiemail-a1.g.dreamhost.com" rhost-flags-OK-OK-OK-FAIL)
	by vger.kernel.org with ESMTP id S1753228AbYK1CJf (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 27 Nov 2008 21:09:35 -0500
X-Greylist: delayed 79142 seconds by postgrey-1.27 at vger.kernel.org; Thu, 27 Nov 2008 21:09:35 EST
Received: from jidanni1.jidanni.org (122-127-33-127.dynamic.hinet.net [122.127.33.127])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by homiemail-a1.g.dreamhost.com (Postfix) with ESMTP id 854A6119DCC
	for <git@vger.kernel.org>; Thu, 27 Nov 2008 18:09:34 -0800 (PST)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/101858>

Gentlemen, sorry to be a bore, but in
/usr/share/doc/git-doc/gitcore-tutorial.html
there are examples like
$ git-cat-file "blob" 557db03
which makes it look like the author is an expert in other things, but
not the shell, where
$ git-cat-file blob 557db03
would be fine. Do you really type those extra quotes when nobody else
is looking? Same even with
$ echo "Silly example" >example
Let's see, Of
$ echo Silly example >example
$ echo Silly example>example
$ echo Silly example > example
I'd pick the latter...
