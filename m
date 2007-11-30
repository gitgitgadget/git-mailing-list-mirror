From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: Adding Git to Better SCM Initiative : Comparison
Date: Fri, 30 Nov 2007 01:18:27 +0100
Message-ID: <200711300118.28145.jnareb@gmail.com>
References: <200711282339.59938.jnareb@gmail.com> <200711290326.13822.jnareb@gmail.com> <20071129200710.GA3314@steel.home>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org,
	Robin Rosenberg <robin.rosenberg.lists@dewire.com>
To: Alex Riesen <raa.lkml@gmail.com>
X-From: git-owner@vger.kernel.org Fri Nov 30 01:19:05 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Ixtav-0006B8-Pl
	for gcvg-git-2@gmane.org; Fri, 30 Nov 2007 01:19:02 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758842AbXK3ASm (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 29 Nov 2007 19:18:42 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1759794AbXK3ASm
	(ORCPT <rfc822;git-outgoing>); Thu, 29 Nov 2007 19:18:42 -0500
Received: from nf-out-0910.google.com ([64.233.182.188]:16627 "EHLO
	nf-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757664AbXK3ASk (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 29 Nov 2007 19:18:40 -0500
Received: by nf-out-0910.google.com with SMTP id g13so2054589nfb
        for <git@vger.kernel.org>; Thu, 29 Nov 2007 16:18:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:subject:date:user-agent:cc:references:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:message-id;
        bh=3zU5XuYMcICgEmNpDN1GYUmChhmgRaKPnxlf+9U1vlw=;
        b=OJWXcbr9QrouF9LZWRCREQEgqqDPWHaW0TcBZgz/msXidNtwQ2oPJaobn9vQM2A1cCyA6EAqdLEbihsNJJEuHfPVbyYMgLv2lI5fFXhVa+BnzM3l3vH0/qCaF9CXYdwyBZeL4rHB2UxrTJ97LpwSHHCf+HTcDBC0ImAVdng8TkM=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=received:from:to:subject:date:user-agent:cc:references:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:message-id;
        b=V7DtlFLdAxcZIkJwMjQgrY83xi9kXWaSmQZaIEfOmAgvwZ03lSVtaNkpmc1uRvLZcM74hhK89b0hbDfde2HkrsgpxmTP16qUbhokxnQ2p8ZC5eSX8RVaTdYAk5UpAqUbO05IZgV1TSwTpcohvNcM6HbPKGem1/zZKYZlWxm0Nic=
Received: by 10.86.72.15 with SMTP id u15mr1756235fga.1196381917762;
        Thu, 29 Nov 2007 16:18:37 -0800 (PST)
Received: from ?192.168.1.11? ( [83.8.205.222])
        by mx.google.com with ESMTPS id d13sm8490034fka.2007.11.29.16.18.35
        (version=SSLv3 cipher=OTHER);
        Thu, 29 Nov 2007 16:18:36 -0800 (PST)
User-Agent: KMail/1.9.3
In-Reply-To: <20071129200710.GA3314@steel.home>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/66574>

On Thu, 29 Nov 2007, Alex Riesen wrote:
> Jakub Narebski, Thu, Nov 29, 2007 03:26:12 +0100:

>> +                <s id="git">
>> +                    Medium. There's Git User's Manual, manpages, some
>> +                    technical documentation and some howtos.  All
>> +                    documentation is also available online in HTML format;
>> +                    there is additional information (including beginnings
>> +                    of FAQ) on git wiki.
>> +                    Nevertheles one of complaints in surveys is insufficient
> 
> "Nevertheless" (two "s").
> 
> BTW, I wouldn't call the level of documentation "Medium" when compared
> to any commercial SCM. How can they earn more than "a little", when
> compared to any opensource program?

Source code is not [user level] documentation.

But perhaps it should be "Good" instead of "Medium", although I think
not "Excellent".
 
>> @@ -894,6 +938,14 @@ TODO:
>>                      to install the subversion perl bindings and a few modules
>>                      from CPAN.
>>                  </s>
>> +                <s id="git">
>> +                    TO DO. RPMs and deb packages for Linux. msysGit and
>> +                    Cygwin for Win32 - Git requires POSIX shell, Perl,
>> +                    and POSIX utilities for some commands (builtin).
> 
> I read this as: "Git requires all these programs for builtin
> commands". Which is a bit confusing. Just drop "(builtin)"?

What I meant to say that some Git commands are scripts in Perl or POSIX
shell, and that those Git commands requires POSIX utilities (which of
those utilities are needed is unfortunately not mentioned explicitely
in the INSTALL file); _but_ that there is ongoing effort to rewrite
matured commands in C (as built-ins).

But this is perhaps too long explanation to put it in this comparison
table.

>> +                    Autoconf to generate Makefile configuration; ready
>> +                    generic configuration for many OS. Compiling docs
>> +                    requires asciidoc and xmlto toolchain, but prebuild.
> 
> "prebuilt" (with "t"). Maybe remove ", but prebuilt" completely?

Gaaah, it should be "but you can get prebuilt docs".
 
>> @@ -1106,6 +1165,10 @@ TODO:
>>                      There exists some HTTP-functionality, but it is quite
>>                      limited.
>>                  </s>
>> +                <s id="git">
>> +                    Good.  Uses HTTPS (with WebDAV) or ssh for push,
>> +                    HTTP, FTP, ssh or custom protocol for fetch.
>> +                </s>
> 
> You forgot bundles (aka SneakerNet).
> Again, compared to everyone else it is "vastly superior" :)

Bundles and patches (peer review!) I think truly move it from "Good"
to "Excellent".

>>                  <s id="mercurial">
>>                      Excellent.  Uses HTTP or ssh.  Remote access also
>>                      works safely without locks over read-only network

By the way, can Git be used with repository on lockless network
filesystem? (Although with distributed SCM it perhaps be better
to just use many distributed repositories...). How does it work
with repository available via SMBFS / CIFS or NFS?

>> @@ -1203,6 +1266,10 @@ TODO:
>>                      Very good. Supports many UNIXes, Mac OS X, and Windows,
>>                      and is written in a portable language.
>>                  </s>
>> +                <s id="git">TO DO.
>> +                    Good.  Portable across all POSIX systems.
>> +                    There exists Win32 binary using MinGW.
>> +                </s>
> 
> "binaries": MinGW and Cygwin. And it is definitely "excellent" by the
> standards of the site.

I'd say excellent on POSIX systems, good on Win32 (there are still
as far as I remember some troubles). I hope that gitbox project would
succeed, and one would need only single binary (plus perhaps wish for
GUI, and DLLs) to use git on MS Windows.

-- 
Jakub Narebski
Poland
