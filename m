From: elf Pavlik <perpetual-tripper@wwelves.org>
Subject: implementing real support for multiple authors of the commit (ex. pair
 programming)
Date: Tue, 11 May 2010 13:33:08 +0200
Organization: world wide elves
Message-ID: <6f772c1ae148f3a9f31c1242516ebf94@imap.brueckenschlaeger.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
To: <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Tue May 11 13:44:00 2010
connect(): No such file or directory
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OBnsW-0006mI-FH
	for gcvg-git-2@lo.gmane.org; Tue, 11 May 2010 13:44:00 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753570Ab0EKLnu (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 11 May 2010 07:43:50 -0400
Received: from mail.brueckenschlaeger.de ([78.46.51.71]:60404 "EHLO
	mail.brueckenschlaeger.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752734Ab0EKLnu (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 11 May 2010 07:43:50 -0400
X-Greylist: delayed 638 seconds by postgrey-1.27 at vger.kernel.org; Tue, 11 May 2010 07:43:49 EDT
Received: from localhost (localhost [127.0.0.1])
	by mail.brueckenschlaeger.de (Postfix) with ESMTP id CA2B4118001D
	for <git@vger.kernel.org>; Tue, 11 May 2010 13:33:08 +0200 (CEST)
Received: from mail.brueckenschlaeger.de ([127.0.0.1])
	by localhost (mail.brueckenschlaeger.de [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 1-1n54TBICtm for <git@vger.kernel.org>;
	Tue, 11 May 2010 13:33:08 +0200 (CEST)
Received: from mail.brueckenschlaeger.de (localhost [127.0.0.1])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.brueckenschlaeger.de (Postfix) with ESMTPSA id B72221180018
	for <git@vger.kernel.org>; Tue, 11 May 2010 13:33:08 +0200 (CEST)
X-Sender: perpetual-tripper@wwelves.org
User-Agent: RoundCube Webmail/0.3-RC1
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/146886>

Hello,

I've found some workarounds for adding multiple people as an author of the
commit. All of them doesn't seem really clear for me. I would like to ask
if someone can elaborate on complexity of adding a genuine support for
multiple authors of the commit?

At this moment it looks like people can specify multiple names for author
field but still only one email, but most applications working with git
repositories (ex. gitorious) use email field to identify a person. I think
at this moment adding possibility of adding more than one email in author
field could help.

I've tried with using something like --author 'Mickey Mouse & Donald Duck
<mickey@mice.net, donald@ducks.net>' and it worked but still I would prefer
using something like:
--authors 'Mickey Mouse <mickey@mice.net>, Donald Duck <donald@ducks.net>'

Adding such support sooner then later could prevent propagation of various
workarounds and enrich git with very significant functionality which
becomes fundamental in development nowadays.

With the committer I think it make sense to have a reference just to one
person who actually commits the code. 

With wishes of fun with social codding,
elf Pavlik
http://wwelves.org/perpetual-tripper
