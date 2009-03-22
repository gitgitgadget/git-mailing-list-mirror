From: Peter Harris <git@peter.is-a-geek.org>
Subject: Re: Disallow amending published commits?
Date: Sun, 22 Mar 2009 10:19:41 -0400
Message-ID: <eaa105840903220719g6af88db1xccf9fba20c573570@mail.gmail.com>
References: <885649360903211056u38ff6cabxbe1a17d57faaa0c4@mail.gmail.com>
	 <eaa105840903211146s4ff398e3qa8b570a8d29a83f4@mail.gmail.com>
	 <885649360903211549h751c19e6sbaa0e07a14413d19@mail.gmail.com>
	 <eaa105840903211853p65327ffdvebbe28da5f256871@mail.gmail.com>
	 <885649360903212109v316f441fvea3f498e91c0059e@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Git ML <git@vger.kernel.org>
To: James Pickens <jepicken@gmail.com>
X-From: git-owner@vger.kernel.org Sun Mar 22 15:21:14 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LlOY5-0000v6-BH
	for gcvg-git-2@gmane.org; Sun, 22 Mar 2009 15:21:13 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753344AbZCVOTo convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sun, 22 Mar 2009 10:19:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753291AbZCVOTo
	(ORCPT <rfc822;git-outgoing>); Sun, 22 Mar 2009 10:19:44 -0400
Received: from yx-out-2324.google.com ([74.125.44.29]:37651 "EHLO
	yx-out-2324.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752895AbZCVOTn convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 22 Mar 2009 10:19:43 -0400
Received: by yx-out-2324.google.com with SMTP id 31so1758708yxl.1
        for <git@vger.kernel.org>; Sun, 22 Mar 2009 07:19:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:sender:received:in-reply-to
         :references:date:x-google-sender-auth:message-id:subject:from:to:cc
         :content-type:content-transfer-encoding;
        bh=2rmgiSlwQ305BYTwW3VoAJCeIwWDLq9xguohyyQysKI=;
        b=Veh2Be1tONLEr8LUgo+UJ4c66lMq6ukO5NnTM5q3IC92rtDYUzPUQTg7f6eIqgMen0
         twOisYkcLBcEk7eIJjtlQ1se+lph2RM9xXR6WTRDeDuChFA/ftWOfHp5wYQtQqYSR0aa
         aM7fWA3bIkiiEfmUf4qNnF8uX4cNOFsme8gn0=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:sender:in-reply-to:references:date
         :x-google-sender-auth:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        b=TX7nDywcXiwnztDFJflmwd4rvr2hg9HRkcvrZ411PSJRJPwSIEx780V01/vQy5Xe2/
         77kIUOj8iVeyBOhxyzHZY70VfFm19oYT5gS8P5PasTVcyxeT/FtWGCtYQ8eF9TYkiw+T
         qYCDaYwYHN1HrrbizbzzswcRGvsQ8ml6Ws+8U=
Received: by 10.90.78.14 with SMTP id a14mr278719agb.43.1237731581331; Sun, 22 
	Mar 2009 07:19:41 -0700 (PDT)
In-Reply-To: <885649360903212109v316f441fvea3f498e91c0059e@mail.gmail.com>
X-Google-Sender-Auth: 5c66d955bd3a3602
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/114141>

On Sun, Mar 22, 2009 at 12:09 AM, James Pickens wrote:
> I think you understood the question perfectly, and your comments all =
make
> sense. =A0Perhaps I'm just being paranoid and this won't be a problem=
 at all.
>
> A bit of background might help explain my paranoia: I'm about to pilo=
t Git
> on a fairly large project, where none of the users have Git experienc=
e, and
> many of them don't have much experience with any other version contro=
l
> system either. =A0I had to fight hard to get this pilot approved, and=
 a lot
> of people will be watching to see how it goes, so I'm trying to do an=
ything
> I can to make sure it will be successful.

Ah, yes. I can understand your paranoia.

Most new users will stick to your 'cheat sheet', and never even do
enough research to learn that you can amend existing history, much
less try it. A few will dig through the docs and try everything at
least once. I admit it; I fall into the latter category. :-)

Peter Harris
