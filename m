From: Sverre Rabbelier <srabbelier@gmail.com>
Subject: Re: git checkout -b origin/mybranch origin/mybranch
Date: Thu, 12 Mar 2009 12:40:21 +0100
Message-ID: <fabb9a1e0903120440x78b296fbka1ddcf370f5b8df@mail.gmail.com>
References: <43d8ce650903120436u261cb7e3p838e4a12e7b54d7d@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Git List <git@vger.kernel.org>
To: John Tapsell <johnflux@gmail.com>
X-From: git-owner@vger.kernel.org Thu Mar 12 12:41:52 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LhjIN-000300-KZ
	for gcvg-git-2@gmane.org; Thu, 12 Mar 2009 12:41:52 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755781AbZCLLkZ convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 12 Mar 2009 07:40:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755132AbZCLLkZ
	(ORCPT <rfc822;git-outgoing>); Thu, 12 Mar 2009 07:40:25 -0400
Received: from mail-bw0-f178.google.com ([209.85.218.178]:58208 "EHLO
	mail-bw0-f178.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754696AbZCLLkY convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 12 Mar 2009 07:40:24 -0400
Received: by bwz26 with SMTP id 26so143702bwz.37
        for <git@vger.kernel.org>; Thu, 12 Mar 2009 04:40:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :date:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=XdFzXvEl2EDUmxNJ2HdmfLSToIv51i1UNkq6VWTVgWg=;
        b=IY7kdAE1cJxB800r9hgBuXfhL0JMmFYuJoPxKfSM6pPsQViJQOfI33NvzgisEhS43i
         Z0gMPUVt/2MXkKi6feiucKmguAhTx6XZlrIReASYQmdZInzviucZzSVzUPr3gVbjmGYW
         LV6KRIyh96m6S9U0EBebojU2mvtVEJFcTgmgY=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=vlzEOzDSISZFwtLGNB1tBuYwYt5T+c/5/1+FVaSAt8iCUPqY1wk96TteNM6RpgU+w0
         guruKMeYWHQ/LyVa3sPViIdYYBJd6JfDnDctuveqK2sect6APjFLw1iNAg5fuOUBycPy
         dGSlrffCwphC24IQX3g54DULZZBTSktUYB2Es=
Received: by 10.103.228.7 with SMTP id f7mr4281565mur.0.1236858021509; Thu, 12 
	Mar 2009 04:40:21 -0700 (PDT)
In-Reply-To: <43d8ce650903120436u261cb7e3p838e4a12e7b54d7d@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/113046>

Heya,

On Thu, Mar 12, 2009 at 12:36, John Tapsell <johnflux@gmail.com> wrote:
> =A0git complained that they need to specify the name with -b. =A0So t=
hey did:
>
> git checkout -b origin/somebranch origin/somebranch

Slight unrelated, do they know about -t?

$ git checkout -t origin/somebranch

It will automagically create a branch named 'somebranch' tracking
'origin/somebranch'!

--=20
Cheers,

Sverre Rabbelier
