From: "Nikolai Weibull" <now@bitwi.se>
Subject: Re: Thoughts on adding another hook to git
Date: Tue, 13 Jun 2006 17:26:34 +0200
Message-ID: <dbfc82860606130826jd9ba61fx26d0b3e42d68c93a@mail.gmail.com>
References: <448DB201.5090208@shlrm.org>
	 <f36b08ee0606121206k62242354k13671f95da6b1418@mail.gmail.com>
	 <448DBC2B.1070807@shlrm.org>
	 <f36b08ee0606121218s6cdcfec2i42482ed5284a45e3@mail.gmail.com>
	 <448DBEEB.3000308@shlrm.org>
	 <dbfc82860606122329w77c566evb94ca79081a0a057@mail.gmail.com>
	 <448EB7B6.4020708@shlrm.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Cc: "Yakov Lerner" <iler.ml@gmail.com>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Jun 13 17:26:49 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FqAms-0005lO-3h
	for gcvg-git@gmane.org; Tue, 13 Jun 2006 17:26:38 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932138AbWFMP0f (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 13 Jun 2006 11:26:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932139AbWFMP0f
	(ORCPT <rfc822;git-outgoing>); Tue, 13 Jun 2006 11:26:35 -0400
Received: from wx-out-0102.google.com ([66.249.82.199]:37904 "EHLO
	wx-out-0102.google.com") by vger.kernel.org with ESMTP
	id S932138AbWFMP0e (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 13 Jun 2006 11:26:34 -0400
Received: by wx-out-0102.google.com with SMTP id h28so1013331wxd
        for <git@vger.kernel.org>; Tue, 13 Jun 2006 08:26:34 -0700 (PDT)
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:sender:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references:x-google-sender-auth;
        b=gWSgD1C7rQP5qls0oID88Kwe+WewlPWo1N7lp4v67V3ypTpIs3O8/hE8vTruFr630J0uBgn9RqYq3M+4W9BOf7jpyS9jtz0RX60JTVEoPoXIvBFlYf2qcCSey8OwUnsozujez3k36m7BRHrYkusPWZVDWzCsAanyiPkRbWfsuAM=
Received: by 10.70.65.11 with SMTP id n11mr2614484wxa;
        Tue, 13 Jun 2006 08:26:34 -0700 (PDT)
Received: by 10.70.63.4 with HTTP; Tue, 13 Jun 2006 08:26:34 -0700 (PDT)
To: "David Kowis" <dkowis@shlrm.org>
In-Reply-To: <448EB7B6.4020708@shlrm.org>
Content-Disposition: inline
X-Google-Sender-Auth: 49e0642bd64d92f0
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/21780>

On 6/13/06, David Kowis <dkowis@shlrm.org> wrote:
> I'm using vim.

>   1 # Explicit paths specified without -i nor -o; assuming --only paths...
>   2 #
>   3 # Updated but not checked in:
>   4 #   (will commit)
>   5 #
>   6 #   modified: mail/abook/DETAILS
>   7 #   modified: mail/abook/HISTORY
>
> What I'd like to be able to do is have that "abook" directory name
> automatically added to the top of my commit message before it gets into
> the editor. I can do this with a script (echo ${PWD##*/}) but it'd need
> to be a hook before the editor shows up.

autocmd BufRead .git/COMMIT_MSG call setline(1, expand('%:p:h:h:t'))

But that will of course do that for all commit-messages, so your point
is still valid.

  nikolai
