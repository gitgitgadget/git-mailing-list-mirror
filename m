From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [RFC] Change handling of RelNotes
Date: Thu, 30 Aug 2007 19:21:23 -0700
Message-ID: <7vejhk5tr0.fsf@gitster.siamese.dyndns.org>
References: <316a20a40708301835hc4236d4tdb289b6f705ab86@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: "Stephen Cuppett" <cuppett@gmail.com>
X-From: git-owner@vger.kernel.org Fri Aug 31 04:21:36 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IQw8e-0000tG-6E
	for gcvg-git@gmane.org; Fri, 31 Aug 2007 04:21:36 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755309AbXHaCVd (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 30 Aug 2007 22:21:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752282AbXHaCVc
	(ORCPT <rfc822;git-outgoing>); Thu, 30 Aug 2007 22:21:32 -0400
Received: from rune.sasl.smtp.pobox.com ([208.210.124.37]:57815 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754874AbXHaCVc (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 30 Aug 2007 22:21:32 -0400
Received: from pobox.com (ip68-225-240-77.oc.oc.cox.net [68.225.240.77])
	(using TLSv1 with cipher AES128-SHA (128/128 bits))
	(No client certificate requested)
	by rune.sasl.smtp.pobox.com (Postfix) with ESMTP id 4576812B52E;
	Thu, 30 Aug 2007 22:21:52 -0400 (EDT)
In-Reply-To: <316a20a40708301835hc4236d4tdb289b6f705ab86@mail.gmail.com>
	(Stephen Cuppett's message of "Thu, 30 Aug 2007 21:35:36 -0400")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/57106>

"Stephen Cuppett" <cuppett@gmail.com> writes:

> I went to clone git onto a memory stick today.  The default fs on the
> sticks doesn't support symlinks.  After looking a little bit, the only
> symlink I can see in the source tree is RelNotes.  It appears when
> going to a new release the file gets created in /Documentation and the
> symlink updated.

Well, I hope you do not compile nor checkout git onto a memory
stick but use it as just a sneakernet medium.

If that is the case why should it matter if the contents tracked
has symlinks?
