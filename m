From: Mikael Magnusson <mikachu@gmail.com>
Subject: Re: git push stages original version on server
Date: Fri, 11 Sep 2009 13:11:18 +0200
Message-ID: <237967ef0909110411u34010660w2fda90d5bba1e9dc@mail.gmail.com>
References: <D7E5118C-AE88-4C4B-8D8A-5AF16ECF731D@roalddevries.nl>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: git@vger.kernel.org
To: Roald de Vries <rdv@roalddevries.nl>
X-From: git-owner@vger.kernel.org Fri Sep 11 13:11:26 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Mm42H-0004Nc-FW
	for gcvg-git-2@lo.gmane.org; Fri, 11 Sep 2009 13:11:25 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752501AbZIKLLR (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 11 Sep 2009 07:11:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752160AbZIKLLR
	(ORCPT <rfc822;git-outgoing>); Fri, 11 Sep 2009 07:11:17 -0400
Received: from mail-bw0-f219.google.com ([209.85.218.219]:35462 "EHLO
	mail-bw0-f219.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751920AbZIKLLQ (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 11 Sep 2009 07:11:16 -0400
Received: by bwz19 with SMTP id 19so698929bwz.37
        for <git@vger.kernel.org>; Fri, 11 Sep 2009 04:11:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :date:message-id:subject:from:to:cc:content-type;
        bh=aJSSPuyH3js+0IaqqNL5yNne5Ma1xAaMPML1ZAFifuw=;
        b=yH4wh+Bg7ATAHKbnrMxc+evZueqoiHtmnJCZmgWwDr3gI+yilHu24vfo9mwiZagRCO
         veiC+OdZSQO7YJnFGqkZw+mCoCxj+I7guN8xGMfuFc+nLFzO6vtZdoxCvgrMRfw5oR6d
         k37p/nIpJCe0Rbb4Bnf9iYG4yHrJTPuk2oh5I=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        b=httj+FCdWCSc2HYGQuNRqkpNv8Qbd6B4x7VojrI23temAyXkrMsC7E6jv3Jl/L75MI
         ZJFBsmwesKXCQjbM5Tzn0EhAA3Nbl7CV+/6mYeKiIgPzgGIMADT+B2PRmeb/IExffrrV
         IO+/BIFGe34t6UAkNXNPmPEkp7sKkDi9N3cfE=
Received: by 10.204.151.210 with SMTP id d18mr1951225bkw.203.1252667478545; 
	Fri, 11 Sep 2009 04:11:18 -0700 (PDT)
In-Reply-To: <D7E5118C-AE88-4C4B-8D8A-5AF16ECF731D@roalddevries.nl>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/128188>

2009/9/11 Roald de Vries <rdv@roalddevries.nl>:
> Hi all,
>
> There's a thing I don't understand: I have a repository on a server from/to
> which I pull/push. But when I push to it, and do a checkout on the server,
> the pushed changes are not visible. It appears that the changed file is
> added to the index on the server automatically. Why is this? It seems
> dangerous. If I do a commit on the server, the changes from the client will
> be lost.
>
> There's also a thing I'm not sure exists: I use a git server/client setup
> for developing a website. I would like git-pushes to appear immediately
> online (without having to ssh to the server and checking out manually). Is
> this possible?
>
> My questions are:
> - Why does git work like this?
> - Can I change its behaviour (if I still want that after the answer to the
> previous question)?
> - How can I have git automatically checkout pushed changes on the server?
>
> Thanks in advance.
>
> Kind regards,
>
> Roald

http://git.or.cz/gitwiki/GitFaq#Whywon.27tIseechangesintheremoterepoafter.22gitpush.22.3F

-- 
Mikael Magnusson
