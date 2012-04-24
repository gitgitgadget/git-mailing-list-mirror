From: Hilco Wijbenga <hilco.wijbenga@gmail.com>
Subject: Re: organizing multiple repositories with dependencies
Date: Tue, 24 Apr 2012 15:11:54 -0700
Message-ID: <CAE1pOi3XuiDA1f-NaBGeGYKcWqnCxNer4Ce-MsfjPD2hXU_mgg@mail.gmail.com>
References: <1334568432.53977.YahooMailNeo@web65906.mail.ac4.yahoo.com>
	<CAPZPVFbHseYHdPOXmbyGxncZmmzSHwY_fJkNRRQAMVtGZBA0CQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Namit Bhalla <namitbhalla@yahoo.com>,
	"git@vger.kernel.org" <git@vger.kernel.org>
To: Eugene Sajine <euguess@gmail.com>
X-From: git-owner@vger.kernel.org Wed Apr 25 00:12:01 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SMnxo-0001uB-TW
	for gcvg-git-2@plane.gmane.org; Wed, 25 Apr 2012 00:12:01 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757354Ab2DXWLz (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 24 Apr 2012 18:11:55 -0400
Received: from mail-yw0-f46.google.com ([209.85.213.46]:41138 "EHLO
	mail-yw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757060Ab2DXWLy (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 24 Apr 2012 18:11:54 -0400
Received: by yhmm54 with SMTP id m54so795647yhm.19
        for <git@vger.kernel.org>; Tue, 24 Apr 2012 15:11:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        bh=s2sXe1D7/zHbZHSnpGBnul0PdYHSO18Ge5+V1C05LbA=;
        b=vDYbiXQHlzFMBdlYH+qYLhVNTT8UI/YVFvuegugfuGCghQZcQ+aBf7fWFlfP7R+LMV
         qCU5zI7Oq8vqum3rLA/BbkYCBp1dNrJ9EBo/9jL3gQb4SculG6Vz6aFA8tN5gvGV4rOy
         RQzHvnRfUSML1ZEWg68Of3zj116Djbld4EP0jNoQTw5/TLsDmLQ+t1tr5GnWFKC7KZ8l
         i367Jyx2NUg6jrn83j5/+rf8nDi+OOWZBvK8HNILJm5MiRJ8/YH9iS6S8xckXROvC74P
         maybjEb/BIY4pcTdO8ZVzPCu7jXSRUkz6u+WIoNFSNaVVyMyiirZWkYTCil8pLg8eG7M
         GQlw==
Received: by 10.236.192.198 with SMTP id i46mr247974yhn.22.1335305514203; Tue,
 24 Apr 2012 15:11:54 -0700 (PDT)
Received: by 10.236.79.98 with HTTP; Tue, 24 Apr 2012 15:11:54 -0700 (PDT)
In-Reply-To: <CAPZPVFbHseYHdPOXmbyGxncZmmzSHwY_fJkNRRQAMVtGZBA0CQ@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/196255>

On 24 April 2012 12:48, Eugene Sajine <euguess@gmail.com> wrote:
> We are working in the environment where we have hundreds (700 + and
> counting) or projects with many of them reused by others.
> We are following strictly one project = one repo rule without any
> subtrees or submodules.
> What you are asking about is "integration" and IMHO has nothing to do
> with git - i.e. should be VCS independent.
> We are using integration on the artifact level and it works amazingly well.
> But we also use pretty strict naming and location convention that
> allows us to script around the whole setup very easily.
>
> In order to track dependencies between projects we use Ivy.
> The project can be compiled locally using local copies of the upstream
> project artifacts built by developer on the same machine or if not
> present, the current production artifacts are used.
> We also have Jenkins CI server that helps with integration. It is very
> simple and straight forward set up without any unnecessary
> complications IMHO.
> Feel free to contact me if you need more info about such set up.

So how do you handle implementing features/changes that involve more
than one project? Surely, you do not manually create topic branches in
each of the involved repos?
