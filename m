From: Alex K <spaceoutlet@gmail.com>
Subject: Re: date change of commit?
Date: Thu, 29 Oct 2009 12:55:36 +0000
Message-ID: <e4a904790910290555n61bca296g3624c1aced50ed85@mail.gmail.com>
References: <e4a904790910250435p3ff50dcfv5c0c6a86c13d17b@mail.gmail.com>
	 <vpq1vkrqttt.fsf@bauges.imag.fr>
	 <e4a904790910270241g4a165023o30438c5d000b5de4@mail.gmail.com>
	 <20091027122156.GD6115@genesis.frugalware.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Cc: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>, git@vger.kernel.org
To: Miklos Vajna <vmiklos@frugalware.org>
X-From: git-owner@vger.kernel.org Thu Oct 29 13:56:01 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1N3UXZ-0002Wn-SQ
	for gcvg-git-2@lo.gmane.org; Thu, 29 Oct 2009 13:55:46 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752571AbZJ2Mzd (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 29 Oct 2009 08:55:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752541AbZJ2Mzd
	(ORCPT <rfc822;git-outgoing>); Thu, 29 Oct 2009 08:55:33 -0400
Received: from qw-out-2122.google.com ([74.125.92.24]:32843 "EHLO
	qw-out-2122.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752420AbZJ2Mzc (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 29 Oct 2009 08:55:32 -0400
Received: by qw-out-2122.google.com with SMTP id 9so471675qwb.37
        for <git@vger.kernel.org>; Thu, 29 Oct 2009 05:55:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:sender:received:in-reply-to
         :references:date:x-google-sender-auth:message-id:subject:from:to:cc
         :content-type;
        bh=WIdEKcFWh31/vCdtNa6wjjKiSmrYLShDDBnvVxBPRX0=;
        b=Tb7dKtR0ZIePPQRm1ShieO+A5Qfh64Wyoe+gEC1VeoO9Y0W35vSdvbZucz7vjeWIGn
         1bUpoJZpSvqP1HiiZKNDmu5XY+vuM9YFqawirQwraxadIn45RGFOKGYo0o26HgkFAdkT
         cwhiced3C50zXwkoJFIdLYs6tPCuyvH4XuM2Q=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:sender:in-reply-to:references:date
         :x-google-sender-auth:message-id:subject:from:to:cc:content-type;
        b=NulQS+zWAQH07QqekVmq57qMhlBdhzJd/qtxp57sA/rwH1OnaOHLLh5kIgDKyDuRc8
         NjOHUNwJ4lMGhB1tGEjJaCRMa3jPzyy52o34pcP9bf7gSvC6H1vIhCANh7h6z/hp+do+
         ZwaQOjzEDKxYh/wq7eiqNoctb4/opLGojnCa8=
Received: by 10.229.59.215 with SMTP id m23mr3618qch.4.1256820936736; Thu, 29 
	Oct 2009 05:55:36 -0700 (PDT)
In-Reply-To: <20091027122156.GD6115@genesis.frugalware.org>
X-Google-Sender-Auth: 9be9b5fad7edd89c
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/131588>

And how do you actually set those variables? Sorry to ask such a
trivial question but it's been an hour that i'm going through the doc
for such a simple feature. I thought those were environment variables
... but they are not seen under git var -l. Thank you.

2009/10/27 Miklos Vajna <vmiklos@frugalware.org>:
> On Tue, Oct 27, 2009 at 10:41:47AM +0100, Alex K <spaceoutlet@gmail.com> wrote:
>> Thank you. And how would you use git-filter-branch to create another
>> branch with a different time stamp? Is it possible to commit under a
>> different time stamp than the one provided by your default local time?
>
> You can set GIT_AUTHOR_DATE and GIT_COMMITTER_DATE. Both expect a format
> like: "1112911993 -0700" (unix timestamp + timezone info).
>
