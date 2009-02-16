From: Jay Soffian <jaysoffian@gmail.com>
Subject: Re: [PATCH] builtin-remote: better handling of multiple remote HEADs
Date: Sun, 15 Feb 2009 21:58:48 -0500
Message-ID: <76718490902151858j78c0d06bxa659ffd3bd2dad01@mail.gmail.com>
References: <20090214034345.GB24545@coredump.intra.peff.net>
	 <1234607430-5403-1-git-send-email-jaysoffian@gmail.com>
	 <20090215052740.GA11522@coredump.intra.peff.net>
	 <76718490902150613i79517e6dwcec8e1e40c56bcc8@mail.gmail.com>
	 <7v7i3rglza.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Cc: Jeff King <peff@peff.net>, git@vger.kernel.org,
	barkalow@iabervon.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon Feb 16 04:00:23 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LYtiU-00028e-WE
	for gcvg-git-2@gmane.org; Mon, 16 Feb 2009 04:00:19 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755690AbZBPC6v (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 15 Feb 2009 21:58:51 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755565AbZBPC6v
	(ORCPT <rfc822;git-outgoing>); Sun, 15 Feb 2009 21:58:51 -0500
Received: from rv-out-0506.google.com ([209.85.198.235]:43843 "EHLO
	rv-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755413AbZBPC6t (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 15 Feb 2009 21:58:49 -0500
Received: by rv-out-0506.google.com with SMTP id g37so1372305rvb.1
        for <git@vger.kernel.org>; Sun, 15 Feb 2009 18:58:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :date:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=AC27CyGqeVg+dIZq0GRFqvAqugPi6CeQZ0GEdeXgQTs=;
        b=VMrQgdPealGL8Wll6a8cFf0FEFizMR7UoT6tqoo4PSODaLJySZa292ieTtPheYdAg3
         yMMxYW2fdniRjzBCwyjTeGlk66i7Hxdf/SODBY27f+7Andpbtsvt7yC+3+2qPkg9JM5D
         /xoYfeL3bNi9KvJVipPwzbRYS8IReRCTI2iJQ=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=d7J7FRAK8pSPHq7HBj4C5yaKbK9IOQt+1WFuxf0XAgLEHkSRlxOuDt1rpPyu+lN9vj
         5rDHP/IF8W1CVlbl2QuFP1WVD8gHH1GyJjUPSbPIK51JT4QDsI7VOuAWaIdXxYLEp+qg
         wunGY9KbhmfVZcR8Q0Nt4o8t5ILnGSERhMGSQ=
Received: by 10.141.176.6 with SMTP id d6mr2436024rvp.233.1234753128786; Sun, 
	15 Feb 2009 18:58:48 -0800 (PST)
In-Reply-To: <7v7i3rglza.fsf@gitster.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/110119>

On Sun, Feb 15, 2009 at 9:21 PM, Junio C Hamano <gitster@pobox.com> wrote:
>>               &>word
>>               >&word
> Just to clarify, the above is not a recommendation for shell scripts in
> git project.

Indeed not! My use of it wasn't even intentional, I was a tcsh
(cringe...) user for a long time and I only finally switched to bash
about a year ago. It must've been muscle memory that made me type it,
but a pox on bash for not rejecting it outright -- the bash man page
claims posix'ish compliance when invoked as /bin/sh, so I don't know
why it allows such syntax in its posix'ish mode.

> By the say, does anybody know why bash people recommend &>word form?
>
> Neither &>word nor >&word to send both stderr and stdout to the file is
> from true Bourne, but at least the use of >&word form for this purpose is
> more familiar to people who are used to Csh.

<tongue in cheek>it is exactly because it is familiar to csh people
that they recommend the opposite</tongue in cheek>

j.
