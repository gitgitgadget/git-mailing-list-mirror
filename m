From: "Nikolai Weibull" <now@bitwi.se>
Subject: Re: Thoughts on adding another hook to git
Date: Tue, 13 Jun 2006 08:29:00 +0200
Message-ID: <dbfc82860606122329w77c566evb94ca79081a0a057@mail.gmail.com>
References: <448DB201.5090208@shlrm.org>
	 <f36b08ee0606121206k62242354k13671f95da6b1418@mail.gmail.com>
	 <448DBC2B.1070807@shlrm.org>
	 <f36b08ee0606121218s6cdcfec2i42482ed5284a45e3@mail.gmail.com>
	 <448DBEEB.3000308@shlrm.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Cc: "Yakov Lerner" <iler.ml@gmail.com>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Jun 13 08:29:17 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1Fq2Om-0002kn-J9
	for gcvg-git@gmane.org; Tue, 13 Jun 2006 08:29:13 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932920AbWFMG3E (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 13 Jun 2006 02:29:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932922AbWFMG3E
	(ORCPT <rfc822;git-outgoing>); Tue, 13 Jun 2006 02:29:04 -0400
Received: from wx-out-0102.google.com ([66.249.82.197]:56892 "EHLO
	wx-out-0102.google.com") by vger.kernel.org with ESMTP
	id S932920AbWFMG3B (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 13 Jun 2006 02:29:01 -0400
Received: by wx-out-0102.google.com with SMTP id h28so948526wxd
        for <git@vger.kernel.org>; Mon, 12 Jun 2006 23:29:01 -0700 (PDT)
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:sender:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references:x-google-sender-auth;
        b=tdXRJMtvi1ankNmNB8qY6Lya4g1qG8xSe7bKrE1+QmROEcnJ0TKFQpgoCAh731D7bKjCwuilvX368amTwjC45j6TyuXC6s2XBmigXmgISglI9YIjPWvg7jKhr86Q2+Ey3w9IqFrpvqQhxsXAhyHYxEIbiqFNhETBgSOSZKVGwyc=
Received: by 10.70.103.17 with SMTP id a17mr7298413wxc;
        Mon, 12 Jun 2006 23:29:00 -0700 (PDT)
Received: by 10.70.63.4 with HTTP; Mon, 12 Jun 2006 23:29:00 -0700 (PDT)
To: "David Kowis" <dkowis@shlrm.org>
In-Reply-To: <448DBEEB.3000308@shlrm.org>
Content-Disposition: inline
X-Google-Sender-Auth: bc031378fc9bd66c
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/21770>

On 6/12/06, David Kowis <dkowis@shlrm.org> wrote:
> Yakov Lerner wrote:

> > git-commit sure creates those temp files with
> > specific naming in specific dir. You could check for
> > that in EDITOR script. In the script, you could even check
> > the name of the parent process.

> This is true. However, I'd be running that script every time something
> invoked $EDITOR. And some people may not like that solution. I'm
> thinking that more than just I will like to use this pre-edit hook.
> Especially in the distro I'm helping develop.

Perhaps you could tell us what editor you are using.  That way we may
provide additional solutions.

  nikolai
