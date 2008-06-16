From: "Frederik Dohr" <f.n.dohr@gmail.com>
Subject: Re: git-svn breaks svn when adding .svn
Date: Mon, 16 Jun 2008 17:09:35 +0100
Message-ID: <af6c748e0806160909t1e6dd22exf8e6d6c47215ec80@mail.gmail.com>
References: <20080606122421.GA1521@denkbrett.schottelius.org>
	 <7v1w38l0el.fsf@gitster.siamese.dyndns.org>
	 <20080616122117.GA14292@denkbrett.schottelius.org>
	 <200806161603.05166.thomas@koch.ro>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: "Nico -telmich- Schottelius" <nico-git-svn-20080616@schottelius.org>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Jun 16 18:11:11 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1K8HHx-0007DK-9P
	for gcvg-git-2@gmane.org; Mon, 16 Jun 2008 18:10:37 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753980AbYFPQJm (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 16 Jun 2008 12:09:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753506AbYFPQJm
	(ORCPT <rfc822;git-outgoing>); Mon, 16 Jun 2008 12:09:42 -0400
Received: from yw-out-2324.google.com ([74.125.46.30]:62859 "EHLO
	yw-out-2324.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753163AbYFPQJl (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 16 Jun 2008 12:09:41 -0400
Received: by yw-out-2324.google.com with SMTP id 9so3138918ywe.1
        for <git@vger.kernel.org>; Mon, 16 Jun 2008 09:09:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from:to
         :subject:cc:in-reply-to:mime-version:content-type
         :content-transfer-encoding:content-disposition:references;
        bh=f9n3CtEkRRfprZBxZ92ikp21tvVk7t9N0EC0WIaohC4=;
        b=WEE0CACzliYn70HZRBxY4owX9+5v83uletXxjpU+z4Wcz9UKJYPdWYF331rEyznVsz
         jxwl+tT495lsw3TSeF+NfIklX9Tb2Tq/NV+bqG33mQ2TDdES0MP+WJQzF2gg4nluqxmd
         AJRDU8nOw1uMSGvBja1hhjdgTxc+A5CYGSKZ8=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:to:subject:cc:in-reply-to:mime-version
         :content-type:content-transfer-encoding:content-disposition
         :references;
        b=Kr+IhQBfNNWiUHa7iBOryzANedKycNHfK6h1j6P7qCykvOUimA8gNj+ibjCdYg9AGT
         3DCX104clOXcC5VNq3TDfYW+wCOAhkNaFU+JVhIFB3y0ci4VYlN3RZ2NHX5qRJap0Yom
         D3hR0rqOeSfVrNdwjepBkjCdl0ZsaHxpR5NcE=
Received: by 10.142.177.7 with SMTP id z7mr2417382wfe.249.1213632575240;
        Mon, 16 Jun 2008 09:09:35 -0700 (PDT)
Received: by 10.142.158.21 with HTTP; Mon, 16 Jun 2008 09:09:35 -0700 (PDT)
In-Reply-To: <200806161603.05166.thomas@koch.ro>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/85201>

> I've reported the exact same problem on 18.04.08 under the subject: "git svn
> should refuse to checkin .svn directories"

Sorry about that - I did search the archives before having this
posted, but that didn't come up with anything (the search
functionality is quite limited though).

>> [...] Add this as the
>> pre-commit hook in .git/hooks (make sure to make it executable).

Not a bad idea - but this still requires manual intervention (and thus
awareness), which doesn't solve the potential destructiveness of this
issue.

> The Git website seems to be currently down, but one of us should search, if
> there is a Bugtracker for GIT and then open an issue for this.

The website is up again.
However, there doesn't seem to be a dedicated bug tracking tool.


-- F.
