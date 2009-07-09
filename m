From: Henrik Nilsson <henrik30000@gmail.com>
Subject: Re: New Bzr to Git migration tool
Date: Thu, 9 Jul 2009 20:06:33 +0000
Message-ID: <d51232210907091306n46c0cda6g49bf9880d701f2e0@mail.gmail.com>
References: <37B936CB-2B2F-49DB-B282-EAD6C87E9A63@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Jul 09 22:06:44 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MOztC-0006A2-Dq
	for gcvg-git-2@gmane.org; Thu, 09 Jul 2009 22:06:42 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754179AbZGIUGg convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 9 Jul 2009 16:06:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754073AbZGIUGf
	(ORCPT <rfc822;git-outgoing>); Thu, 9 Jul 2009 16:06:35 -0400
Received: from mail-ew0-f226.google.com ([209.85.219.226]:59347 "EHLO
	mail-ew0-f226.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754030AbZGIUGf convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 9 Jul 2009 16:06:35 -0400
Received: by ewy26 with SMTP id 26so538592ewy.37
        for <git@vger.kernel.org>; Thu, 09 Jul 2009 13:06:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :date:message-id:subject:from:to:content-type
         :content-transfer-encoding;
        bh=AmAobNdPjnqpnktqLHa6M/5GETi2qobj59cg0w2dzig=;
        b=uV955gAyHhSPWfQKFkY/pYpkJJPvRJ2rQIfCDQayBLrN1x52QO4svDF+aPyfKkOuyO
         LqEPeofCDHK5TADizmnZwPCzU2muISwNfvJbw6ImVUJvgG4pJ7Fz/Xz47hElQc+pE0BD
         MQrPJijamXImHbV81VbxkOFXd7D48amIgDCEw=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :content-type:content-transfer-encoding;
        b=EkY0mh19/c3pjsI9NlQxUir5yIMcJ08Q9PHViVddTMx9IJjegz/ky6hL/utQWqppNk
         Rr0DYhgAQQzpJvevySLs5ByWbhEWBRG5EVa4sgTNZu9tdG5jex12UlAQj71V4aeytz5U
         wJuluiuFEhrDOY0LvbJPN6l88eF8HEelCSDTo=
Received: by 10.216.36.84 with SMTP id v62mr325525wea.128.1247169993193; Thu, 
	09 Jul 2009 13:06:33 -0700 (PDT)
In-Reply-To: <37B936CB-2B2F-49DB-B282-EAD6C87E9A63@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/123004>

2009/7/9 David Reitter <david.reitter@gmail.com>:
> Henrik Nilsson wrote on git@vger.kernel.org:
>
>> I recently wrote a Bzr to Git migration tool and thought I'd share i=
t
>> with anyone who might be interested.
>> It's written in shell-script and iterates through the Bzr commits
>> while adding those changes to a new Git repository.
>
> This is interesting to me, as my use case will involve extending an e=
xisting
> git repository iteratively from the bzr commits.
> Looking at the technique, this should be possible that way.
>
> I am missing support for converting all branches of the repository. =A0=
More
> importantly, don't merges get lost? =A0All your git side commits seem=
 to have
> a single parent.
>
>
>

Yes I suppose they do.
The Bzr repository I was working on when I wrote this script has not
been dealing with any branches.

I should have mentioned that I am not looking for feedback to work
further on this, unless I have any need for it myself, but you are
very welcome to build upon it. :)

Henrik Nilsson
