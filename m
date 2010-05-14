From: Pavan Kumar Sunkara <pavan.sss1991@gmail.com>
Subject: Re: [PATCHv3 GSoC] gitweb: Move static files into seperate 
	subdirectory
Date: Fri, 14 May 2010 21:45:35 +0530
Message-ID: <AANLkTimlfiIulCUGf9WHMU2f4wlR3in83VR9UkP0-vi6@mail.gmail.com>
References: <p2ze72faaa81005090656j593c3464v9ee1bb6432461efc@mail.gmail.com>
	 <201005120127.55971.jnareb@gmail.com> <4BEA5E2F.9070608@gmail.com>
	 <201005131054.01262.chriscool@tuxfamily.org>
	 <4BEBC001.10803@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Jakub Narebski <jnareb@gmail.com>, Git List <git@vger.kernel.org>,
	Petr Baudis <pasky@ucw.cz>
To: Christian Couder <chriscool@tuxfamily.org>
X-From: git-owner@vger.kernel.org Fri May 14 18:15:44 2010
connect(): No such file or directory
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OCxY7-0003Do-VJ
	for gcvg-git-2@lo.gmane.org; Fri, 14 May 2010 18:15:44 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755504Ab0ENQPj convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 14 May 2010 12:15:39 -0400
Received: from mail-gw0-f46.google.com ([74.125.83.46]:44188 "EHLO
	mail-gw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755462Ab0ENQPg convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 14 May 2010 12:15:36 -0400
Received: by gwj19 with SMTP id 19so1372508gwj.19
        for <git@vger.kernel.org>; Fri, 14 May 2010 09:15:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:received:in-reply-to
         :references:date:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=hKnDtRta9srTD8OuMEf+q5sY6hZJL7IHHprTFIjq2E4=;
        b=u2ILXi/nT+W/My+2YIs2JFc1NhuuGD2TuaxoAjsgU+pkp+63Cg+9s9sdw/WqOFdT0B
         k8ZyOmg9IxRbwQZ22oJ32zjxO0IhBlf60NfQ+ss9EgdKwqcCPwSL4OAvKDntfs4jS+4e
         H14DgXq2WoBdIi1JF4scTlZZg0QgK/bGzrVCg=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=QuOE7hegy3Eoz76ZhYTglv//Z0aB7AR/+eSY5RfZiI/jH9B5NDa48Nf2zM3sFPrUMB
         c7ohpyVunYcJt2IEqjWT7tUkjG14DHWZpgM2iwAU3OS94ALbxtt4Px90znqtNMSNhJA/
         Sx8gQWJghHB+zALBYy4u2hXnivQOaHjodj6KI=
Received: by 10.91.19.34 with SMTP id w34mr1048247agi.179.1273853735309; Fri, 
	14 May 2010 09:15:35 -0700 (PDT)
Received: by 10.90.84.5 with HTTP; Fri, 14 May 2010 09:15:35 -0700 (PDT)
In-Reply-To: <4BEBC001.10803@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/147098>

Jakub, I would like to know the status of this patch.

On Thu, May 13, 2010 at 2:31 PM, Pavan Kumar Sunkara
<pavan.sss1991@gmail.com> wrote:
>
>>> =A0 First you have to generate gitweb.cgi from gitweb.perl using
>>> -"make gitweb", then copy appropriate files (gitweb.cgi, gitweb.js,
>>> -gitweb.css, git-logo.png and git-favicon.png) to their destination=
=2E
>>> -For example if git was (or is) installed with /usr prefix, you can=
 do
>>> +"make gitweb", then "make install-gitweb" appropriate files
>>>
>
> Sorry about that.
>
> - Pavan
>
