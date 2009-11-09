From: Rustom Mody <rustompmody@gmail.com>
Subject: Re: pulling git -- version confusion
Date: Mon, 9 Nov 2009 18:54:52 +0530
Message-ID: <f46c52560911090524l51140858sdde29d76e2cfed49@mail.gmail.com>
References: <f46c52560911082214x81ae8beya139a8bcb3cbcf2a@mail.gmail.com>
	 <fabb9a1e0911082237x462b1203v724b51e309a2d89@mail.gmail.com>
	 <f46c52560911082345y71eb12c9w114b799d70720dc6@mail.gmail.com>
	 <fabb9a1e0911082351o326b205aic205552faae4e4da@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Cc: git@vger.kernel.org
To: Sverre Rabbelier <srabbelier@gmail.com>
X-From: git-owner@vger.kernel.org Mon Nov 09 14:25:01 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1N7UEt-0002Wu-Qv
	for gcvg-git-2@lo.gmane.org; Mon, 09 Nov 2009 14:25:00 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755719AbZKINYs (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 9 Nov 2009 08:24:48 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755680AbZKINYs
	(ORCPT <rfc822;git-outgoing>); Mon, 9 Nov 2009 08:24:48 -0500
Received: from mail-pz0-f188.google.com ([209.85.222.188]:35265 "EHLO
	mail-pz0-f188.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755613AbZKINYr (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 9 Nov 2009 08:24:47 -0500
Received: by pzk26 with SMTP id 26so2086008pzk.4
        for <git@vger.kernel.org>; Mon, 09 Nov 2009 05:24:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :date:message-id:subject:from:to:cc:content-type;
        bh=xJK3kMcWEeYrHXdSqjb3IjxLjl8+aSKdtVYge6jozro=;
        b=CSyIvTnVeG5C2pEC9p33aKjyMBXbPXSKScM+9FpdzpZFxV7UB5HiO7INp9eBO6pwgZ
         u//pbzKPJA7JqIlieJAISkFEBJe6kZ8Dm3Azeo4a+Pqz/9C7Es/laZzzhUeAa87XGW1I
         4rT4KN6oTK5jokdnjptCgfM+cr7m3rGiDHPdA=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        b=SO6ezJcRuxItMqJBGryMOpx5Ad2CLdxZmSQIrw05HCBpdICDRpwqeq7EbCGi4N8wON
         +Etg4BH4/fRgz9Joj7Y+tulp2k7zPPIMCkCc8n9dI+pACoRxOwVR/bwu17LG51nuDRZb
         xi+nZYxTIbr+C5PSiv6LvbKbGX/vzIiDItEdk=
Received: by 10.114.69.17 with SMTP id r17mr13712706waa.42.1257773092893; Mon, 
	09 Nov 2009 05:24:52 -0800 (PST)
In-Reply-To: <fabb9a1e0911082351o326b205aic205552faae4e4da@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/132459>

On Mon, Nov 9, 2009 at 1:21 PM, Sverre Rabbelier <srabbelier@gmail.com> wrote:
> On Mon, Nov 9, 2009 at 08:45, Rustom Mody <rustompmody@gmail.com> wrote:
>> Gives me
>> fatal: ambiguous argument 'origin/master': unknown revision or path
>> not in the working tree.
>> Use '--' to separate paths from revisions
>
> Well, as what remote do you have upstream configured?
>
> What is the output of
> $ git config -l

gives me

core.safecrlf=true
user.email=<my email>
user.name=<my name>
core.repositoryformatversion=0
core.filemode=true
gui.geometry=885x450+0+27 207 192

So theres no remote?
But .git/remotes/origin has

URL: git://git.kernel.org/pub/scm/git/git.git
Pull: refs/heads/master:refs/heads/origin
Pull: refs/heads/maint:refs/heads/maint
Pull: refs/heads/next:refs/heads/next
Pull: refs/heads/html:refs/heads/html
Pull: refs/heads/pu:refs/heads/pu
Pull: refs/heads/todo:refs/heads/todo
Pull: refs/heads/man:refs/heads/man

Also [I just tried this] if I make a fresh repo directly and then do a git pull
it gives a fatal: where do you want to fetch from

But with the git repo pull (seems to be) pulling all sorts of stuff
and not erroring out.
