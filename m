From: "Whit Armstrong" <armstrong.whit@gmail.com>
Subject: Re: t3900-i18n-commit.sh problem on Solaris
Date: Tue, 4 Mar 2008 12:15:21 -0500
Message-ID: <8ec76080803040915m3ea11ae6te4379bff05df9402@mail.gmail.com>
References: <8ec76080803040751y4bf808f9ma83a9faa4f857039@mail.gmail.com>
	 <e2b179460803040811y38e639b6wa83857c49b55aa05@mail.gmail.com>
	 <8ec76080803040814l694a0a11i6aa8e2c9f608413c@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: "Mike Ralphson" <mike.ralphson@gmail.com>
X-From: git-owner@vger.kernel.org Tue Mar 04 18:16:20 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JWakF-00082S-NW
	for gcvg-git-2@gmane.org; Tue, 04 Mar 2008 18:16:04 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755320AbYCDRP0 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 4 Mar 2008 12:15:26 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751461AbYCDRP0
	(ORCPT <rfc822;git-outgoing>); Tue, 4 Mar 2008 12:15:26 -0500
Received: from wr-out-0506.google.com ([64.233.184.230]:16527 "EHLO
	wr-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751342AbYCDRPZ (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 4 Mar 2008 12:15:25 -0500
Received: by wr-out-0506.google.com with SMTP id 50so1354067wra.13
        for <git@vger.kernel.org>; Tue, 04 Mar 2008 09:15:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        bh=NgdaJUj8PozNJruQ0xMJ8LlppLEVX83OB/Xnmvo7kdY=;
        b=TYzvnY8ySkc//zuBPIO1BG7wlasjA72eoJrmyPxbLtdy6TfwFbW1L4pCNIQoF9oYy+96T2KuyJGwNXAZAv595Mc4N8YCJWCtYM2ZKDHFyvpNCFqRutS9kxz+BiwbqRnHIazx5Xr9SqCZZDvqk7wx1Q2HOHdrF12hWxeXB5cLqe8=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=k4MTuUaKvrvFkP1pq42LXAGP9eNJIJi2jKg88QbvBtGbGT8qTZ15WbWdzpMSsIt3Z+on2O0YBhh+IjHpZLlLKjLdXbz1UrPDOKiD7kO5GqncU99583uzSAsReE2aHozQrJi/Be8LSgePPHfboX7DzYOdH99u440ASkjSNITnVME=
Received: by 10.141.115.6 with SMTP id s6mr786310rvm.47.1204650921310;
        Tue, 04 Mar 2008 09:15:21 -0800 (PST)
Received: by 10.141.201.19 with HTTP; Tue, 4 Mar 2008 09:15:21 -0800 (PST)
In-Reply-To: <8ec76080803040814l694a0a11i6aa8e2c9f608413c@mail.gmail.com>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/76121>

I still got the same failure after using: ./configure
--with-iconv=/home/warmstro/bin

which is where I put GNU inconv.

Is it possible to make sure that configure used that version?

I tried ldd on the git executable, but I didn't find it.

xs5-trd-p1.grn:warmstro> ldd git
        libcurl.so.3 =>  /usr/local/misc/lib/libcurl.so.3
        libz.so =>       /usr/local/subversion/lib/libz.so
        libsocket.so.1 =>        /usr/lib/libsocket.so.1
        libnsl.so.1 =>   /usr/lib/libnsl.so.1
        libc.so.1 =>     /usr/lib/libc.so.1
        libdl.so.1 =>    /usr/lib/libdl.so.1
        libz.so.1 =>     /usr/local/subversion/lib/libz.so.1
        libz.so.1 (SUNW_1.1) =>  (version not found)
        libgcc_s.so.1 =>         /usr/local/subversion/lib/libgcc_s.so.1
        libmp.so.2 =>    /usr/lib/libmp.so.2
        /usr/platform/SUNW,Sun-Fire-V240/lib/libc_psr.so.1


Thanks,
Whit



On Tue, Mar 4, 2008 at 11:14 AM, Whit Armstrong
<armstrong.whit@gmail.com> wrote:
> will give that a try and come back.
>
>
>
>  On Tue, Mar 4, 2008 at 11:11 AM, Mike Ralphson <mike.ralphson@gmail.com> wrote:
>  > On 04/03/2008, Whit Armstrong <armstrong.whit@gmail.com> wrote:
>  >  > this is with git latest: c95b3ad9ea310ec89e31a21edecaaf2c374e2c46
>  >  >  (GIT_VERSION = 1.5.4.3.447.gc95b3)
>  >  >
>  >  >
>  >  >  xs5-trd-p1.grn:warmstro> sh t3900-i18n-commit.sh -i -v
>  >  >  ...
>  >  >  ...
>  >  >  ...
>  >
>  > >  * FAIL 22: ISO-2022-JP should be shown in EUCJP now
>  >  >
>  >
>  > >  Is this a Solaris problem?
>  >
>  >  Could be. Some builtin iconv() functions / libiconv implementations
>  >  don't seem to have support for all of the character encodings git
>  >  expects.
>  >
>  >  Are you able to link against a current GNU libiconv instead?
>  >
>  >  Mike
>  >
>
