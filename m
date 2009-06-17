From: John Tapsell <johnflux@gmail.com>
Subject: Re: git rebase --interactive squash/squish/fold/rollup
Date: Wed, 17 Jun 2009 21:50:50 +0100
Message-ID: <43d8ce650906171350l52256149m4e7f9cd5cd946ad8@mail.gmail.com>
References: <e1868cfe0906170506o37a75c35m47f9456bf8ae47c1@mail.gmail.com>
	 <43d8ce650906170555m644564b3v3722168f7217c326@mail.gmail.com>
	 <7vvdmurfao.fsf@alter.siamese.dyndns.org>
	 <1245258351.24610.32.camel@cp-jk-linux.corp.on2.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Cc: Junio C Hamano <gitster@pobox.com>,
	"git@vger.kernel.org" <git@vger.kernel.org>
To: john.koleszar@on2.com
X-From: git-owner@vger.kernel.org Wed Jun 17 22:51:03 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MH260-0004mO-Sa
	for gcvg-git-2@gmane.org; Wed, 17 Jun 2009 22:51:01 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752058AbZFQUuu (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 17 Jun 2009 16:50:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751419AbZFQUut
	(ORCPT <rfc822;git-outgoing>); Wed, 17 Jun 2009 16:50:49 -0400
Received: from mail-gx0-f214.google.com ([209.85.217.214]:40413 "EHLO
	mail-gx0-f214.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751120AbZFQUut (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 17 Jun 2009 16:50:49 -0400
Received: by gxk10 with SMTP id 10so960294gxk.13
        for <git@vger.kernel.org>; Wed, 17 Jun 2009 13:50:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :date:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=1ylfQmCRsjLmfd7E5hU0ZrcdSspNH9pSlRCB56neo4k=;
        b=hPACt4avS6Cn4KmTji99bmzBXQhwWKuWGFdoRSDrfhnfDlCRpzTlJheAax0RubeukB
         wp8pWdaKXcWXphaHKjJGn7A+aSKqJmNzFXuGa6BET/My3fbbnH+s53txhRTPp6JXz6Fz
         cXSuqRl9gMZxg78DUFJzWpBLDvNExERZyfsmA=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=BnhC2oZn4Gw3ejBNk4cnk9tiY1HXAVkgFXIUX7df2lXgKouYigAGdK8TvGGmpDRnmG
         2bA5QlpNADqQXnT4x6fwAL6XZQ+gn+Gjtlw1oKvLz9ammfrKpmk1Ir3VS0pbqOfGXxrh
         4FiOPlYqiUeADAtspC+4V83xDyL1b0TsuA9WA=
Received: by 10.151.9.17 with SMTP id m17mr2019023ybi.23.1245271850804; Wed, 
	17 Jun 2009 13:50:50 -0700 (PDT)
In-Reply-To: <1245258351.24610.32.camel@cp-jk-linux.corp.on2.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/121773>

> I wonder if a better approach might be to add an operator to squash
> rather than another verb. "squash!" maybe? This has the nice property
> that future verbs that have both interactive and non-interactive modes
> could be made consistent with squash easily, rather than having to think
> of another synonym.


We could also have   edit!  to just straight the commit message stage,
and then automatically continue.
