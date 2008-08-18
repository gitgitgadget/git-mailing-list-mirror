From: "Martin Langhoff" <martin.langhoff@gmail.com>
Subject: Re: Call Me Gitless
Date: Mon, 18 Aug 2008 12:40:09 +1200
Message-ID: <46a038f90808171740ncfa74fg99c546abc6dd65d0@mail.gmail.com>
References: <4b6f054f0808171702q10d89dfey98afa65634d26e91@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: "Git Mailing List" <git@vger.kernel.org>
To: Trans <transfire@gmail.com>
X-From: git-owner@vger.kernel.org Mon Aug 18 02:41:19 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KUso8-0001Ud-TA
	for gcvg-git-2@gmane.org; Mon, 18 Aug 2008 02:41:17 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752203AbYHRAkM (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 17 Aug 2008 20:40:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752172AbYHRAkL
	(ORCPT <rfc822;git-outgoing>); Sun, 17 Aug 2008 20:40:11 -0400
Received: from wf-out-1314.google.com ([209.85.200.168]:32842 "EHLO
	wf-out-1314.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751786AbYHRAkK (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 17 Aug 2008 20:40:10 -0400
Received: by wf-out-1314.google.com with SMTP id 27so2796663wfd.4
        for <git@vger.kernel.org>; Sun, 17 Aug 2008 17:40:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from:to
         :subject:cc:in-reply-to:mime-version:content-type
         :content-transfer-encoding:content-disposition:references;
        bh=/D/ExJ44ZkiGH9BOFJomcre2TTzEyRKxggT/31ygaDA=;
        b=N5r9jtc0ePP8tad4b//FlOF0hGv8I6LSIDe+Cc2/82D5Pp544sVXfkzSLzJ1ccJi8k
         CvnZGzWJotVSH2O3o9TfONtqbfVUn1d6d4FNbehbdUQZgt7QwXh7akx/w8dqFy65UATZ
         Kp38B9PMMEUlyJPrwin/3wZMsJdSZywIQ6yVE=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:to:subject:cc:in-reply-to:mime-version
         :content-type:content-transfer-encoding:content-disposition
         :references;
        b=tf0uHcYlBVPOM+VShkyIBYdKrNfqk9dNJzqvcngw+XqvtLgYP6Z8mQkczsJ7gn+3ae
         oIH+dY8vL6KCfvgBZSROHjwjdiHX/kRMkW8hOOMYRpTDb0B8KwvoZlNf5uz+YEM+VFGb
         /JtZlndiYw4SZC0qT2jZcMYZ9K9NJhb2ZsPkg=
Received: by 10.142.174.8 with SMTP id w8mr1841157wfe.4.1219020009410;
        Sun, 17 Aug 2008 17:40:09 -0700 (PDT)
Received: by 10.142.43.6 with HTTP; Sun, 17 Aug 2008 17:40:09 -0700 (PDT)
In-Reply-To: <4b6f054f0808171702q10d89dfey98afa65634d26e91@mail.gmail.com>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/92675>

On Mon, Aug 18, 2008 at 12:02 PM, Trans <transfire@gmail.com> wrote:
> Well, after a few days of using git, I've decide Linus is too smart to
> be designing end-user interfaces.

I think you'll find all the current DSCMs have converged to a similar
core set of commands. Commit/diff/log are in the same place as anyone
would expect. The main difference from the svn/cvs world is the
push/pull pair. The only really new thing that git brings to bear is
that we have an index and our doco is slightly more jargon-laden (but
several of the intros that abound 'round the net are fantastic).

In any case, have safe travels. A lot of people have found Hg to be
almost the same but simpler, and a good part of them have later come
back to git. Others have had a similar experience with BazaarNG.
Things are far from settled.

DSCMs have mostly sane storage models, so it's possible to write
lossless importers/exporters. So you can transform your git repos into
hg, and do the reverse trip if/when you want to try git again.

enjoy,


m
-- 
 martin.langhoff@gmail.com
 martin@laptop.org -- School Server Architect
 - ask interesting questions
 - don't get distracted with shiny stuff - working code first
 - http://wiki.laptop.org/go/User:Martinlanghoff
