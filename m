From: "Weiwei Shu" <shuww1980@gmail.com>
Subject: Re: how to configure Git to treat certain type of ascii files as binary files
Date: Wed, 22 Oct 2008 20:12:50 -0500
Message-ID: <65d12cb10810221812n692f83fl3b822568384f3f34@mail.gmail.com>
References: <65d12cb10810221458j14ef0009u679cdb0f73299d7f@mail.gmail.com>
	 <m3hc74i73a.fsf@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: "Jakub Narebski" <jnareb@gmail.com>
X-From: git-owner@vger.kernel.org Thu Oct 23 03:14:08 2008
connect(): Connection refused
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Ksom6-0000ya-IS
	for gcvg-git-2@gmane.org; Thu, 23 Oct 2008 03:14:07 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754145AbYJWBMw (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 22 Oct 2008 21:12:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752977AbYJWBMw
	(ORCPT <rfc822;git-outgoing>); Wed, 22 Oct 2008 21:12:52 -0400
Received: from rv-out-0506.google.com ([209.85.198.232]:17758 "EHLO
	rv-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752841AbYJWBMv (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 22 Oct 2008 21:12:51 -0400
Received: by rv-out-0506.google.com with SMTP id k40so80902rvb.1
        for <git@vger.kernel.org>; Wed, 22 Oct 2008 18:12:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from:to
         :subject:cc:in-reply-to:mime-version:content-type
         :content-transfer-encoding:content-disposition:references;
        bh=Y97ZnYi/+8fkEY6339UaBYse4630q/g6osgcwpTOWDk=;
        b=DJYBhC3F/8u+79lDNnbjGzoQN8dz72NllescAMTNPUuKvbpx8gm2AW6Pi2Ztjworgt
         dHOCoDvH/1sxNvOh0axgFsDl+gClZLNtgYr6RPyZPWIzVX7UKWhtRsCruK1H1i6340vw
         F4RCawDVwWQpeXJNkUbkfSskoLpNTmplgihw8=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:to:subject:cc:in-reply-to:mime-version
         :content-type:content-transfer-encoding:content-disposition
         :references;
        b=nUp+wNldfI8O2/v/dTZP6Wra/XFk8tRmUDkgYs56+bFLrat8KiMZwCTUhXJYM0mIn0
         rioWxa8+WGu0OHOdk1nxwIKSWFFwznYqVIc4HOK2J0Z1/mttdCspcvPN5TCnVSLi4+E+
         cOvZXNABzDZ4EMokGb/NH7w1CSTdB4en2eiIY=
Received: by 10.114.95.1 with SMTP id s1mr8154596wab.221.1224724370545;
        Wed, 22 Oct 2008 18:12:50 -0700 (PDT)
Received: by 10.114.160.3 with HTTP; Wed, 22 Oct 2008 18:12:50 -0700 (PDT)
In-Reply-To: <m3hc74i73a.fsf@localhost.localdomain>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/98935>

Thanks Jakub. I'll read its manual and try to play with it. Thank all
for replies!

On Wed, Oct 22, 2008 at 5:40 PM, Jakub Narebski <jnareb@gmail.com> wrote:
> "Weiwei Shu" <shuww1980@gmail.com> writes:
>
>> My first post in this mailing list. Could some one direct me to some
>> document/manual pages to setup Git to treat ascii files as binary
>> files? I'm using Git to do circuit schematics (SPICE files)
>> versioning. I will not do any merging or editing stuff with external
>> editors. The only way to change it is to use schematic capture GUIs
>> (Cadence, ADS, etc). So I'd like to treat them as binary files to
>> reduce the possibilities of messing them up.
>>
>> I know it seems a little bit stupid to use Git to do such an easy job.
>> But hey, it's the most eye-catching SCM software, isn't it?
>
> First, git does not modify files unless you have core.crlf set,
> and even then it warns about irreversible transformations
> (core.safecrlf)
>
> Second, using gitattributes you can set diff driver and merge driver;
> one of possibilities is to treat file as binary (binary diff and no
> using 3-way file merge).
>
> --
> Jakub Narebski
> Poland
> ShadeHawk on #git
>



-- 
Weiwei
--Hope Springs Eternal.
