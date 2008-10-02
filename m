From: "Mikael Magnusson" <mikachu@gmail.com>
Subject: Re: Help with a tcl/tk gui thing..
Date: Thu, 2 Oct 2008 07:18:15 +0200
Message-ID: <237967ef0810012218i28d41573s6bb7866e0be485f2@mail.gmail.com>
References: <alpine.LFD.2.00.0810011240390.3575@nehalem.linux-foundation.org>
	 <237967ef0810011403i2b18255and988df29a71798bf@mail.gmail.com>
	 <alpine.LFD.2.00.0810011605001.3341@nehalem.linux-foundation.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Cc: "Git Mailing List" <git@vger.kernel.org>
To: "Linus Torvalds" <torvalds@linux-foundation.org>
X-From: git-owner@vger.kernel.org Thu Oct 02 07:19:28 2008
connect(): Connection refused
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KlGb1-0007W3-Ki
	for gcvg-git-2@gmane.org; Thu, 02 Oct 2008 07:19:28 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751941AbYJBFSR (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 2 Oct 2008 01:18:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751552AbYJBFSR
	(ORCPT <rfc822;git-outgoing>); Thu, 2 Oct 2008 01:18:17 -0400
Received: from wa-out-1112.google.com ([209.85.146.182]:48069 "EHLO
	wa-out-1112.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751474AbYJBFSQ (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 2 Oct 2008 01:18:16 -0400
Received: by wa-out-1112.google.com with SMTP id v27so450284wah.21
        for <git@vger.kernel.org>; Wed, 01 Oct 2008 22:18:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from:to
         :subject:cc:in-reply-to:mime-version:content-type
         :content-transfer-encoding:content-disposition:references;
        bh=LgM6dQyLBeNJRN0KvVavYFaOW4TDv+V/tWqld33FMnw=;
        b=VD7d15HRJA2jBRYTgsCi2vwjbltraFhEDwtLUzNPlS44j44J5FbCpNR7vzspRjlZ/0
         BdgKJkhS39MYXE1qapKvu70tRujKBt2mgQIgCxcXTLtUCU0xtHuMB13Qjte/k9TtyhEZ
         Qk352y86kaWi9r1bPWrwToUFDadIP0WqDT/Y4=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:to:subject:cc:in-reply-to:mime-version
         :content-type:content-transfer-encoding:content-disposition
         :references;
        b=n50nFtTFbdtY1/dPGruCTI9qN5XwwKffVgIakX0fsj7i3AuKO2j5XXyhJYeR7+w8xG
         Ez2OvZXWlyQCQ86URRdMbeB87GnS3IT93Z5MhvwEq6tjdTh7daIzEhcHaYc828Pl8e62
         4xpEjggtZEj/ChjRSn7XZ57dsPwMRqTosNZMk=
Received: by 10.115.107.5 with SMTP id j5mr10250675wam.193.1222924695201;
        Wed, 01 Oct 2008 22:18:15 -0700 (PDT)
Received: by 10.114.112.17 with HTTP; Wed, 1 Oct 2008 22:18:15 -0700 (PDT)
In-Reply-To: <alpine.LFD.2.00.0810011605001.3341@nehalem.linux-foundation.org>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/97289>

2008/10/2 Linus Torvalds <torvalds@linux-foundation.org>:
>
>
> On Wed, 1 Oct 2008, Mikael Magnusson wrote:
>>
>> git clone git://mika.l3ib.org/tracker.git
>>
>> I wrote it in pygtk since I know zero to no tcl/tk, hope that's okay.
>> It has a label with the time remaining (simply read from the daemon file),
>> and shows the text in red if less than 10% is remaining. You'll need to
>> change the ./ in cb_function to /var/log/tracker since I forgot to change
>> that and I'm lazy :).
>
> Well, it doesn't do anything at all for me except change the cursor to a
> cross, and if I'm a n00b with tcl/tk, I'm even more of one with pygtk.
>
> I merged the two other suggestions, though. And am open to seeing that
> pygtk thing too as an alternative, but only if it actually works for me ;)

Heh, sorry, I'm an idiot. I forgot to put '#!/usr/bin/python' on the first
line. I was running 'python tracker-ui.py' then did chmod +x just before
committing :). So the cross is coming from running 'import time'.

-- 
Mikael Magnusson
