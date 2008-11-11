From: "Caleb Cushing" <xenoterracide@gmail.com>
Subject: Re: force a merge conflict
Date: Tue, 11 Nov 2008 12:10:08 -0500
Message-ID: <81bfc67a0811110910ic7f3fa7u77676961b0eac118@mail.gmail.com>
References: <81bfc67a0811090709s483506c1h6f9cb0f96216ef22@mail.gmail.com>
	 <20081109183917.GA18415@euler>
	 <81bfc67a0811091219t393ab1faj8d1c4df6de3c260c@mail.gmail.com>
	 <e32b7bb40811101111o8c4334dj49a0c56c6dac6d15@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: "Deskin Miller" <deskinm@umich.edu>, git@vger.kernel.org
To: "Brett Simmers" <swtaarrs@gmail.com>
X-From: git-owner@vger.kernel.org Tue Nov 11 18:12:28 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Kzwly-0003lb-LP
	for gcvg-git-2@gmane.org; Tue, 11 Nov 2008 18:11:27 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752208AbYKKRKK (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 11 Nov 2008 12:10:10 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752190AbYKKRKK
	(ORCPT <rfc822;git-outgoing>); Tue, 11 Nov 2008 12:10:10 -0500
Received: from rv-out-0506.google.com ([209.85.198.238]:23694 "EHLO
	rv-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751819AbYKKRKJ (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 11 Nov 2008 12:10:09 -0500
Received: by rv-out-0506.google.com with SMTP id f9so1068763rvb.0
        for <git@vger.kernel.org>; Tue, 11 Nov 2008 09:10:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from:to
         :subject:cc:in-reply-to:mime-version:content-type
         :content-transfer-encoding:content-disposition:references;
        bh=TxEW3OYLp9wIW/GdLmcauZZJx8O9oycWfOHdUGOWrPU=;
        b=c75GjN8sdvh+xIUcvsbmWacheY8A9H0mX99RR6FhK7Cpx5yck6DfY8jtxpmi+iif+Z
         URvZp0Or7auHyNowBe0jjSQ79ocaKkxk3sggTc5CUM1rDd2uF+1qrBLxvLQjC+Hb/Ylf
         Hbd2OCYacDQXs3lf5PkyD1kS/7FppgjJbKpzM=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:to:subject:cc:in-reply-to:mime-version
         :content-type:content-transfer-encoding:content-disposition
         :references;
        b=hsfGVB8OOcRe6GHpdcsuY1nHvX0ZI0YC9NZIKP1Gv1REAF7rjfwsyFNjaiFMFKB3x3
         kqCa12EJuyGny5oRo//BdZgOEbaSYMxgmB4kwiJhu8AcyGdfYDFOzI7X2NyF5A1iDciu
         vLXF5SyDqTBhOlJwCOx6sOEvxc3qgNz7jm5KU=
Received: by 10.141.177.2 with SMTP id e2mr4332312rvp.269.1226423408744;
        Tue, 11 Nov 2008 09:10:08 -0800 (PST)
Received: by 10.141.34.3 with HTTP; Tue, 11 Nov 2008 09:10:08 -0800 (PST)
In-Reply-To: <e32b7bb40811101111o8c4334dj49a0c56c6dac6d15@mail.gmail.com>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/100652>

> If you want to be given a chance to edit the result before the merge
>  commit, you probably want 'git merge --no-commit'.

That's the closest to what I need to do... unfortunately it's not what
I need to do. Apparently I'll have to do a vimdiff outside of git
since git doesn't appear to be capable of doing what I need it to do.

-- 
Caleb Cushing
