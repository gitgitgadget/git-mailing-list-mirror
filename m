From: John Koleszar <john.koleszar@on2.com>
Subject: Re: git rebase --interactive squash/squish/fold/rollup
Date: Wed, 17 Jun 2009 13:05:51 -0400
Organization: On2 Technologies
Message-ID: <1245258351.24610.32.camel@cp-jk-linux.corp.on2.com>
References: <e1868cfe0906170506o37a75c35m47f9456bf8ae47c1@mail.gmail.com>
	 <43d8ce650906170555m644564b3v3722168f7217c326@mail.gmail.com>
	 <7vvdmurfao.fsf@alter.siamese.dyndns.org>
Reply-To: john.koleszar@on2.com
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Cc: John Tapsell <johnflux@gmail.com>,
	"git@vger.kernel.org" <git@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Jun 17 19:06:51 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MGyb4-0002TE-AJ
	for gcvg-git-2@gmane.org; Wed, 17 Jun 2009 19:06:50 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754941AbZFQRGj (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 17 Jun 2009 13:06:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754560AbZFQRGj
	(ORCPT <rfc822;git-outgoing>); Wed, 17 Jun 2009 13:06:39 -0400
Received: from mail.on2.com ([66.162.65.131]:57206 "EHLO on2.com"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S1753651AbZFQRGi (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 17 Jun 2009 13:06:38 -0400
In-Reply-To: <7vvdmurfao.fsf@alter.siamese.dyndns.org>
X-Mailer: Evolution 2.24.5 
X-On2-MailScanner-i: Found to be clean
X-On2-MailScanner-From: john.koleszar@on2.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/121761>

On Wed, 2009-06-17 at 12:33 -0400, Junio C Hamano wrote:
> So I can see why a variant of "squash" that does not change (nor even ask
> for a replacement of) the commit log message from the one that is being
> amended could be useful.  I am tempted to suggest calling that a "fixup"
> operation, but some people may expect "fixup" to mean a variant of "edit"
> that does not bother you by dropping you back to the shell to touch the
> tree that is recorded (i.e. "fixing up the commit log message only"), so
> it is not a very good word.

I wonder if a better approach might be to add an operator to squash
rather than another verb. "squash!" maybe? This has the nice property
that future verbs that have both interactive and non-interactive modes
could be made consistent with squash easily, rather than having to think
of another synonym.
