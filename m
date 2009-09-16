From: Alex Riesen <raa.lkml@gmail.com>
Subject: Re: self contained executable
Date: Wed, 16 Sep 2009 10:13:57 +0200
Message-ID: <81b0412b0909160113t7edf9b4vdd7b79ca0dae762d@mail.gmail.com>
References: <ED42F58A-A814-467B-A37D-B485B2E267ED@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: git@vger.kernel.org
To: Joel Saltzman <saltzmanjoelh@gmail.com>
X-From: git-owner@vger.kernel.org Wed Sep 16 10:14:07 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MnpeQ-0002fw-Mt
	for gcvg-git-2@lo.gmane.org; Wed, 16 Sep 2009 10:14:07 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752656AbZIPIN4 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 16 Sep 2009 04:13:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752011AbZIPIN4
	(ORCPT <rfc822;git-outgoing>); Wed, 16 Sep 2009 04:13:56 -0400
Received: from mail-bw0-f219.google.com ([209.85.218.219]:40045 "EHLO
	mail-bw0-f219.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751238AbZIPINz (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 16 Sep 2009 04:13:55 -0400
Received: by bwz19 with SMTP id 19so3316300bwz.37
        for <git@vger.kernel.org>; Wed, 16 Sep 2009 01:13:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :date:message-id:subject:from:to:cc:content-type;
        bh=fJ21nAoyOvO+LERhhGXD4muItN61a/2Gu2cy9aGbVdc=;
        b=e+0pQ8GWtAEEEP7R4YVdj8/Yr9WO2hht9Qitzpj+qoCRSyKWOhbuu/c5/9iCdjvyy5
         ORyLZxx4ygv9wmBbn0XcJNMoMKfGPpOFN7l+uBRbfdABwbZX4eGw+RLUTk+CpqLIG+dR
         jXnB4Bi/Ourd08gU7AexkSXYRhcethZgLzTwQ=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        b=GTDsEiuT2fT30xvL+CX1tXXJKGxcJ4lyusITPUOXkjEEguXxuwLM43/aE4rmwWTg/z
         q6syNI5FFthPLMgaeghGfuOkgskAHpL3XrnioCpOV0XB52UarPZWHMa+thm6VDHe1eXY
         UOoZWMiC7rpztIRT3V7heUt3ZQeRrnRXi6Mc8=
Received: by 10.204.15.16 with SMTP id i16mr7130634bka.72.1253088837737; Wed, 
	16 Sep 2009 01:13:57 -0700 (PDT)
In-Reply-To: <ED42F58A-A814-467B-A37D-B485B2E267ED@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/128615>

On Wed, Sep 16, 2009 at 09:45, Joel Saltzman <saltzmanjoelh@gmail.com> wrote:
> is it possible to compile git with all its dependencies so I can run it on a
> server that does not have root access?

This is kind of default configuration (the install prefix is $HOME/,
and everthing gets
installed into ~/bin, ~/share, etc). But if you don't have some of the
libraries (libcurl
for http, eventually openssl and iconv) you can always provide them locally and
set the appropriate compile and linking flags in config.mak (but see
the Makefile
for the variables to set).
