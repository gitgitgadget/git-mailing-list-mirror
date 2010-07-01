From: Tim Visher <tim.visher@gmail.com>
Subject: Print last time and committer a file was touched by for a whole repo
Date: Thu, 1 Jul 2010 15:05:26 -0400
Message-ID: <AANLkTikRElk07ZqK0TOM2WD31t-H5RVngvHNU9KM7e9D@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
To: Git Mailing List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Thu Jul 01 21:05:55 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OUP59-0005ol-Cp
	for gcvg-git-2@lo.gmane.org; Thu, 01 Jul 2010 21:05:55 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753107Ab0GATFs (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 1 Jul 2010 15:05:48 -0400
Received: from mail-qw0-f46.google.com ([209.85.216.46]:63855 "EHLO
	mail-qw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751031Ab0GATFr (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 1 Jul 2010 15:05:47 -0400
Received: by qwi4 with SMTP id 4so38804qwi.19
        for <git@vger.kernel.org>; Thu, 01 Jul 2010 12:05:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:mime-version:received:from:date
         :message-id:subject:to:content-type;
        bh=ANQaBXmJYVZUUBTtLoKgfPnLep8l/MvwTGrPS3cwJMk=;
        b=J+Y4A7YIeL5vlOleMK5qmEJcdR77Dd+vzHlT2C5oECUBjhOxNYqjsANYrR8eX+GEAa
         wKDdIAQMAPEks9mUJogMMJ3lt75d3ivxS9UhRxWDBu7luGBfaRplDrQpmEX4ZkJf9xOy
         drmJaOW0Plcv/loJrDDbw6wKo9dExLjt9GUMY=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:from:date:message-id:subject:to:content-type;
        b=q55fSBMCIXJkRxj/enNlpm30lQNiEIiCKi3vU3IuqrHXoOqcyDOn4VhG2gvOH8ds/d
         dyzz/nDHK0unMUsEbZIvNc1WidJZs3uzl618qOdOe41hgHzfj6rV+jp/q0f1h0/zjj0w
         g4ZsSCJ4j6sR3F6dPaGJsPb5cX9JetXyZI9PM=
Received: by 10.224.53.79 with SMTP id l15mr7982284qag.33.1278011146206; Thu, 
	01 Jul 2010 12:05:46 -0700 (PDT)
Received: by 10.224.6.134 with HTTP; Thu, 1 Jul 2010 12:05:26 -0700 (PDT)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/150063>

Hi everyone,

I need to get a listing of the entire contents of my current repo (as
in, I don't need deleted files or anything like that, just the current
snapshot) with the time the file was committed and who committed it.

Thoughts on how to do that?

-- 

In Christ,

Timmy V.

http://burningones.com/
http://five.sentenc.es/ - Spend less time on e-mail
