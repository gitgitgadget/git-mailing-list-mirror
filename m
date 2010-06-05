From: =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>
Subject: Re: [PATCH/RFC] gitweb: Run in FastCGI mode if gitweb script has 
	.fcgi extension
Date: Sat, 5 Jun 2010 21:12:05 +0000
Message-ID: <AANLkTimrD_JkJdHOn6PfKr0LMaGNn3V9_cHOkdjKVke9@mail.gmail.com>
References: <1275772278-14709-1-git-send-email-jnareb@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: git@vger.kernel.org, Sam Vilain <sam.vilain@catalyst.net.nz>
To: Jakub Narebski <jnareb@gmail.com>
X-From: git-owner@vger.kernel.org Sat Jun 05 23:12:30 2010
connect(): No such file or directory
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OL0fL-0003BO-Qb
	for gcvg-git-2@lo.gmane.org; Sat, 05 Jun 2010 23:12:28 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932969Ab0FEVML (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 5 Jun 2010 17:12:11 -0400
Received: from mail-iw0-f174.google.com ([209.85.214.174]:49708 "EHLO
	mail-iw0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932882Ab0FEVMH (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 5 Jun 2010 17:12:07 -0400
Received: by iwn37 with SMTP id 37so2178246iwn.19
        for <git@vger.kernel.org>; Sat, 05 Jun 2010 14:12:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:received:in-reply-to
         :references:date:message-id:subject:from:to:cc:content-type;
        bh=ITy66J14zi21/e/giIS3diu3CAfsDVRY7wc0kQIKw4A=;
        b=ngw6aDRRwQw8r/R+PFc3DQfFLLkddkTcL/dfierOF2/Onu08GbVLLcrALcbgXdxcpC
         LBNIHzZA3uMqsa1Ry0OtHdKT0W8nxIWZBKO1sFxC/k4RNCDUiqvB5RKI6t/9iSk/+4/u
         +2ptZdirvEsWQl4D1pMwznuVDB3RobfQGLdnk=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        b=GNxrBpcNR2KUgyGhoQmblCcpMUKDafNnGDk4tWhKHb1ItpN9rCzp6Go2+oDH1PUkYm
         29QMoyS4HjD8U4civ9vKbCXS8PLqVopvCSeliB2qzS7XU6QfivtTQz6GOj3h4MF8zsxS
         i0qJescoXSOw0rkNbL98fGX+VR3lw18gFhx9g=
Received: by 10.231.178.132 with SMTP id bm4mr15137305ibb.62.1275772325921; 
	Sat, 05 Jun 2010 14:12:05 -0700 (PDT)
Received: by 10.231.171.145 with HTTP; Sat, 5 Jun 2010 14:12:05 -0700 (PDT)
In-Reply-To: <1275772278-14709-1-git-send-email-jnareb@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/148495>

On Sat, Jun 5, 2010 at 21:11, Jakub Narebski <jnareb@gmail.com> wrote:
> If the name of the script ($SCRIPT_NAME or $SCRIPT_FILENAME CGI
> environment variable, or __FILE__ literal) ends with '.fcgi'
> extension, run gitweb in FastCGI mode, as if it was run with
> '--fastcgi' / '--fcgi' option.

Looks good to me, it'll make deploying on e.g. Apache a lot easier,
and doubtless most other web servers too.
