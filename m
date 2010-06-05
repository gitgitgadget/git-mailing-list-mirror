From: Dario Rodriguez <soft.d4rio@gmail.com>
Subject: Re: Installing on AIX fails
Date: Sat, 5 Jun 2010 18:59:01 -0300
Message-ID: <AANLkTikbAShMuOvFra8bLT2PmU7s_iUQhr4RY7oD3LLa@mail.gmail.com>
References: <AANLkTinKjEBkn-9ajO4QXyHqY0EOQBGPRgNREaC_p_vQ@mail.gmail.com>
	<AANLkTik_FI0CETWZZcu8O8MQQx5oV6YAbt5-X0ozbVmw@mail.gmail.com>
	<AANLkTikkGtRmbsKD3JnQEWrhXQexH7J6SWEd9Aq3iQU_@mail.gmail.com>
	<AANLkTilnFXUI9hnVJlAylCzTUqOStZAFvtgvNrh8Kisj@mail.gmail.com>
	<m3631xr9bm.fsf@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Cc: Tor Arntsen <tor@spacetec.no>, git@vger.kernel.org
To: Jakub Narebski <jnareb@gmail.com>
X-From: git-owner@vger.kernel.org Sat Jun 05 23:59:12 2010
connect(): No such file or directory
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OL1OZ-0003aC-Q9
	for gcvg-git-2@lo.gmane.org; Sat, 05 Jun 2010 23:59:12 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933317Ab0FEV7F (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 5 Jun 2010 17:59:05 -0400
Received: from mail-bw0-f46.google.com ([209.85.214.46]:53097 "EHLO
	mail-bw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S933174Ab0FEV7C (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 5 Jun 2010 17:59:02 -0400
Received: by bwz11 with SMTP id 11so627607bwz.19
        for <git@vger.kernel.org>; Sat, 05 Jun 2010 14:59:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:received:in-reply-to
         :references:date:message-id:subject:from:to:cc:content-type;
        bh=5Di9BfKz+KapOtqmaWEj5MNJqq9m/eXJLABf+VFpX2A=;
        b=NlA4DtxhAy0C4AGf5JLJnAbIae38unrub1Wy9jkqD3eHhFnNNdjBfkleOiO652WNpA
         4dgmu308UzEhL0Vmg+6lonm8hDSGGu8bJrBY77N1WYnIhRwtaYy+VOeCeLXQkmwrhuzd
         0R6tTVr+2rHO1QkfmBhP2ZonglhwjAs0cgQ5c=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        b=LYa4Rf1ln/ZF9jYBfC0hOqUzuKRXm+FkDYOLP+0dmvhRNhQqBnyNdb1XljxUX5F+ak
         Yy6sa+RwawQMhtivq4vXBl2HjREUJRRivOVjH5Kzu+quSqe+9ibR7q/yPfVdDf8bvlT+
         P1cmXjV9ggrx8ATxvld8f83npQlMQ+uPMrxtE=
Received: by 10.204.10.134 with SMTP id p6mr5237886bkp.165.1275775141393; Sat, 
	05 Jun 2010 14:59:01 -0700 (PDT)
Received: by 10.204.18.207 with HTTP; Sat, 5 Jun 2010 14:59:01 -0700 (PDT)
In-Reply-To: <m3631xr9bm.fsf@localhost.localdomain>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/148502>

On Sat, Jun 5, 2010 at 8:44 AM, Jakub Narebski <jnareb@gmail.com> wrote:
> Tor Arntsen <tor@spacetec.no> writes:
>> On Fri, Jun 4, 2010 at 16:22, Dario Rodriguez <soft.d4rio@gmail.com> wrote:
>
>> > I'ill try compiling 'install' (i don't know where the sources are)
>>
>> It's in 'coreutils' these days, but that package includes a lot of stuff.
>>
>> Maybe you could get away with just using the script-version of install
>> which comes with coreutils itself (because it'll need an install tool
>> to use before 'install' itself is installed..).
>>
>> I'm attaching a copy. To use it it should be sufficient to use
>> INSTALL=path-to/install-sh make install
>> or something like that.
>
> I wonder if it would be better to simply include fallback portable
> install-sh in git sources.
>
> BTW. shouldn't we define and use INSTALL_D in Makefile?
>
> --
> Jakub Narebski
> Poland
> ShadeHawk on #git
>

I think so about the install-sh, but about the Makefiles I wonder if
it's not better to reuse current INSTALL, maybe if install-sh is used,
then there is no need for using other 'install' program, excepting the
case in wich the user sets INSTALL commandline.

Blessing,
Dario
