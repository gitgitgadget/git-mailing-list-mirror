From: Michael Witten <mfwitten@gmail.com>
Subject: Re: Ability to edit message from git rebase --interactive.
Date: Fri, 10 Apr 2009 13:50:07 -0500
Message-ID: <b4087cc50904101150i31f1bbfdre73bec44dac580eb@mail.gmail.com>
References: <200903171953.23650.ogoffart@kde.org>
	 <alpine.DEB.1.00.0903172329480.10279@pacific.mpi-cbg.de>
	 <200904101417.56422.ogoffart@kde.org>
	 <b4087cc50904100537j64e8fef1u157c717fe4d8207b@mail.gmail.com>
	 <alpine.DEB.1.00.0904102019250.10279@pacific.mpi-cbg.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: Olivier Goffart <ogoffart@kde.org>, git@vger.kernel.org
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Fri Apr 10 20:51:51 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LsLpI-0000bQ-QQ
	for gcvg-git-2@gmane.org; Fri, 10 Apr 2009 20:51:45 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S938797AbZDJSuL (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 10 Apr 2009 14:50:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S933099AbZDJSuK
	(ORCPT <rfc822;git-outgoing>); Fri, 10 Apr 2009 14:50:10 -0400
Received: from qw-out-2122.google.com ([74.125.92.24]:42525 "EHLO
	qw-out-2122.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1763058AbZDJSuI (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 10 Apr 2009 14:50:08 -0400
Received: by qw-out-2122.google.com with SMTP id 8so1420884qwh.37
        for <git@vger.kernel.org>; Fri, 10 Apr 2009 11:50:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :date:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=/6G/G+Kdm7IdXrOuYZWw09AWVx1oyDHwAm4JMJ665CQ=;
        b=w79QjiBwDP8vp8/Ae2uVX8tDv5y0xgnubYYcX9rfi1xKr6tNmciHHjjU5wSZYJYVlh
         /BstQGTV3V2pGY59ScWtyS+Rn6dObLeDduxGigrrLxXcMIj+xuk8Ow7fiP3aAkGLdHIq
         TpxGyDDsaoqC6YF26e0cwNR4xQBllWN8z0qw0=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=noHUM2nMu7daZge5koQ88EXznyhlLgbGXXJN1qeereVVDqzRqQtT0yoqf6u80cK9lu
         hj+2XIN0iuovrkZQFqpHPKrZcyygLvM5Vg4MiqJxGGNvUPDfvQ1QGECy4juhFg0Ed/EW
         6AnEt2DnXm5r7nvwcMBp7iM43AxJIHn1+pNYk=
Received: by 10.224.29.13 with SMTP id o13mr4358505qac.98.1239389407190; Fri, 
	10 Apr 2009 11:50:07 -0700 (PDT)
In-Reply-To: <alpine.DEB.1.00.0904102019250.10279@pacific.mpi-cbg.de>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/116273>

On Fri, Apr 10, 2009 at 13:21, Johannes Schindelin
<Johannes.Schindelin@gmx.de> wrote:
>>> I still think this feature to edit the message in git rebase -i is really
>>> usefull. =A0So 'm' is really taken, what about 'r' for 'rephrase'?
>>>
>>> or maybe 'rephrase' is something different?
>>
>> How about 'a' for an immediate [a]mend?
>
> git commit --amend lets you amend the modifications in addition to the
> message, so I think it would be too ambiguous.

How about edit-message|edit-m|em ?

Also, I still like the idea of being able to write:

    git commit --amend HEAD~5 HEAD^

and then have the rebase setup and started for me.

How about:

    git commit --amend-message ...

for just the commit message?

P.S.

Sorry for the duplicate, Johannes.
