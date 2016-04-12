From: Nikola =?ISO-8859-1?Q?Forr=F3?= <nforro@redhat.com>
Subject: Re: [PATCH] difftool/mergetool: make the form of yes/no questions
 consistent
Date: Tue, 12 Apr 2016 15:53:12 +0200
Organization: Red Hat
Message-ID: <1460469192.3214.17.camel@redhat.com>
References: <1460465982.3214.7.camel@redhat.com>
	 <20160412132737.GB11013@serenity.lan>
Reply-To: nforro@redhat.com
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org, gitster@pobox.com
To: John Keeping <john@keeping.me.uk>
X-From: git-owner@vger.kernel.org Tue Apr 12 15:53:26 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1apykw-0005fW-3y
	for gcvg-git-2@plane.gmane.org; Tue, 12 Apr 2016 15:53:26 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756248AbcDLNxQ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 12 Apr 2016 09:53:16 -0400
Received: from mx1.redhat.com ([209.132.183.28]:52991 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756176AbcDLNxQ (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 12 Apr 2016 09:53:16 -0400
Received: from int-mx09.intmail.prod.int.phx2.redhat.com (int-mx09.intmail.prod.int.phx2.redhat.com [10.5.11.22])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id A12A77F6B0;
	Tue, 12 Apr 2016 13:53:15 +0000 (UTC)
Received: from unused-4-132.brq.redhat.com (unused-4-132.brq.redhat.com [10.34.4.132])
	by int-mx09.intmail.prod.int.phx2.redhat.com (8.14.4/8.14.4) with ESMTP id u3CDrD5s000454
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
	Tue, 12 Apr 2016 09:53:14 -0400
In-Reply-To: <20160412132737.GB11013@serenity.lan>
X-Scanned-By: MIMEDefang 2.68 on 10.5.11.22
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/291261>

On Tue, 2016-04-12 at 14:27 +0100, John Keeping wrote:
> I think the case in these two is correct as-is.  The "Y" is capitalised
> because it is the default and will take effect if the user just presses
> ENTER.

Thanks John, I'm aware of that. That's why the patch doesn't change
the case. Maybe I should have mention that explicitly in the commit
message.
