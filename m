From: Rostislav Svoboda <rostislav.svoboda@gmail.com>
Subject: cvs2git migration - cloning CVS repository
Date: Mon, 2 Feb 2009 15:24:56 +0100
Message-ID: <286817520902020624y7f4c2942l34fafc0fe0fa0b48@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Feb 02 15:26:26 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LTzko-0003bh-3r
	for gcvg-git-2@gmane.org; Mon, 02 Feb 2009 15:26:26 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752600AbZBBOZA (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 2 Feb 2009 09:25:00 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751729AbZBBOY7
	(ORCPT <rfc822;git-outgoing>); Mon, 2 Feb 2009 09:24:59 -0500
Received: from mail-ew0-f21.google.com ([209.85.219.21]:49809 "EHLO
	mail-ew0-f21.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751995AbZBBOY6 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 2 Feb 2009 09:24:58 -0500
Received: by ewy14 with SMTP id 14so1869330ewy.13
        for <git@vger.kernel.org>; Mon, 02 Feb 2009 06:24:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:date:message-id:subject
         :from:to:content-type:content-transfer-encoding;
        bh=1Y+jsU0/MUqJ4abWG7D8+7/sdWv+riZ0hVAFrqJv5yk=;
        b=AYbGbgmXuWxRHGK7XgjIS+quY3S5IACgftVfzex6vKnKlmvB1qBRmN3akfWvAnILix
         PKUaSxXLoOE8kBkaQY/0gDNhfWRacEO9hLFupFlkanpgX1Mgz7SeUvhjfZiIevsq7SQE
         krxMrqq+4p1WWd/fyHjkxeuzuO5t+Szqt4dAk=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:date:message-id:subject:from:to:content-type
         :content-transfer-encoding;
        b=KlJIV7GXrAaJPQArDmRFawKLC8oOhIvckv/F2Nflyx8c3Sjk+KAuJb0jLchRM8WHQy
         9PiY7XDUEfH+3bJOUTjZzbZc+b7afANN0NVHN/HR0FPLdXw81mmlka5v33FeGGQe9Emx
         OooNIk1TKur24uPTrQnIkp9YZEGGt0uHroQpw=
Received: by 10.210.43.11 with SMTP id q11mr4852967ebq.56.1233584696332; Mon, 
	02 Feb 2009 06:24:56 -0800 (PST)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/108088>

Hi everyone

I'd like to clone a CVS repository to a local machine in order to
prepare it for a migration to git. I tried:

$git cvsimport -p x -v -d
:pserver:mylogin@cvs-server:/cvs/cvsrepository cvsmodule
AuthReply: I HATE YOU
$git cvsimport -p x -v -d
:pserver:anonymous@cvs-server:/cvs/cvsrepository cvsmodule
AuthReply: E Fatal error, aborting.

I haven't found much info concerning the 'I HATE YOU'. So I'd like to
ask you if I'm right:
(I can't talk about this with my cvs-server administrator. He's a kind of dumb)

- git cvsimport works only using 'anonymous' account. So my real login
name won't work?
- 'AuthReply: E Fatal error, aborting.' means that the cvs-server does
not accept anonymous connections?

Is there any other way how to get the cvs repository to my local machine?

thx a lot

Bost
