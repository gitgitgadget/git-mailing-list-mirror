From: "Lars Hjemli" <hjemli@gmail.com>
Subject: Re: git pull/merge master on other branch
Date: Tue, 13 May 2008 18:08:42 +0200
Message-ID: <8c5c35580805130908h4ee12952sc6581d07391ba73e@mail.gmail.com>
References: <g00nb3$dlm$1@ger.gmane.org> <200805090824.12772.johan@herland.net>
	 <8C649BDA-41CA-4105-86C5-103B4A8BEEC1@sb.org>
	 <4828FB7F.3030907@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org, "Kevin Ballard" <kevin@sb.org>,
	"Johan Herland" <johan@herland.net>
To: "SungHyun Nam" <goweol@gmail.com>
X-From: git-owner@vger.kernel.org Tue May 13 18:10:53 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Jvx4L-00052R-Lf
	for gcvg-git-2@gmane.org; Tue, 13 May 2008 18:09:38 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756362AbYEMQIp (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 13 May 2008 12:08:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755983AbYEMQIp
	(ORCPT <rfc822;git-outgoing>); Tue, 13 May 2008 12:08:45 -0400
Received: from yw-out-2324.google.com ([74.125.46.30]:2629 "EHLO
	yw-out-2324.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756213AbYEMQIp (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 13 May 2008 12:08:45 -0400
Received: by yw-out-2324.google.com with SMTP id 9so1616061ywe.1
        for <git@vger.kernel.org>; Tue, 13 May 2008 09:08:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        bh=ljxyA6BwA814+63Cs/TR89NsbLhtw19i+m6tLMjV6ew=;
        b=cB741yomy5p+O3v4Pwzk6OF4krfgzuBmMvHnR40w2AW4lj4WqzVQfdb/7sHtEshqQ5vG7MbprROzSPktUHmWETJIbUNDd8J3UUS8Ap4i2A899tEezniyMMUqIgXbe7OG8eVswHqJAEWMMM5TeP+6frJycLBQ23EpIpo2bt1tdNc=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=t/dNzxyvsELrI/V5eMENmD1lEH0j4gbSJIFspL++mPL3WrvGvJyZMXokilRi6xslcNFXlEnKge46Rb2kKzlJs8yUc+UFELrPnzCf4KuWH4gkZxVL9lPf09rI82b5yi5/fs4J9HGr9EQiVCEkviLWDkIyxFJPmHyTKAhFVu9mkBE=
Received: by 10.150.78.28 with SMTP id a28mr3700051ybb.161.1210694922106;
        Tue, 13 May 2008 09:08:42 -0700 (PDT)
Received: by 10.151.39.3 with HTTP; Tue, 13 May 2008 09:08:42 -0700 (PDT)
In-Reply-To: <4828FB7F.3030907@gmail.com>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/82032>

On Tue, May 13, 2008 at 4:22 AM, SungHyun Nam <goweol@gmail.com> wrote:
> Kevin Ballard wrote, at 5/10/2008 2:16 AM:
>
>  > If you know the pull will just be a fast-foward, then you can do
>  > something like
>  >
>  >   git fetch origin && git update-ref master origin/master

I belive that should be `update-ref refs/heads/master origin/master`,
otherwise you'll get this error:

>  It seems it worked, but I see a warning message "refname 'master'
>  is ambiguous." Can I fix this warning message?

Try `rm .git/master`.

--
larsh
