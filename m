From: Andy Parkins <andyparkins@gmail.com>
Subject: Re: MinGW port - initial work uploaded
Date: Tue, 23 Jan 2007 16:24:40 +0000
Message-ID: <200701231624.41716.andyparkins@gmail.com>
References: <200701192148.20206.johannes.sixt@telecom.at> <200701231506.32396.andyparkins@gmail.com> <Pine.LNX.4.63.0701231614490.22628@wbgn013.biozentrum.uni-wuerzburg.de>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Cc: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Tue Jan 23 17:24:56 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1H9OS6-0007AY-UF
	for gcvg-git@gmane.org; Tue, 23 Jan 2007 17:24:55 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964872AbXAWQYw (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 23 Jan 2007 11:24:52 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964927AbXAWQYw
	(ORCPT <rfc822;git-outgoing>); Tue, 23 Jan 2007 11:24:52 -0500
Received: from nf-out-0910.google.com ([64.233.182.186]:24842 "EHLO
	nf-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S964872AbXAWQYv (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 23 Jan 2007 11:24:51 -0500
Received: by nf-out-0910.google.com with SMTP id o25so302443nfa
        for <git@vger.kernel.org>; Tue, 23 Jan 2007 08:24:49 -0800 (PST)
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=beta;
        h=received:from:to:subject:date:user-agent:cc:references:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:message-id;
        b=S3VQZoese+lAovbtM8T79l/AZzWPtkNgHllLv2jIi4M4OqMWe3YmDei0FGITVjz5DlelyXhREKHAUfjYuNLjLWyRtrUvMs3fwI7I87k30BwZppWsnP1CaBlalyU4VQfiHD2U9ytPO+Q5/7Cli70ZnQn4k5fjHDII4v3bj0A4guU=
Received: by 10.49.19.18 with SMTP id w18mr1358803nfi.1169569488381;
        Tue, 23 Jan 2007 08:24:48 -0800 (PST)
Received: from 360run094l ( [194.70.53.227])
        by mx.google.com with ESMTP id p72sm3154935nfc.2007.01.23.08.24.47;
        Tue, 23 Jan 2007 08:24:47 -0800 (PST)
To: git@vger.kernel.org
User-Agent: KMail/1.9.5
In-Reply-To: <Pine.LNX.4.63.0701231614490.22628@wbgn013.biozentrum.uni-wuerzburg.de>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/37545>

On Tuesday 2007 January 23 15:20, Johannes Schindelin wrote:

> MinGW and cygwin differ in one very important point: cygwin needs an extra
> dll, MinGW does not.
>
> However, the development environment is still console-based, with a bash
> so you can run configure and simple bash scripts. It is definitely more
> catering to Unix types than Windows types.
>
> So yes, there is a bash, and there is a less, and there is perl.

Those are just tools for MinGW though aren't they?  They aren't needed to run 
the final executable object?  MinGW just spits out a native windows .exe - 
i.e. plain windows.  There is no reason to suppose that joe-random-developer 
will have bash, less and perl, even if they do have git.  Which was kind of 
the point I was making - there is no pager to rely on in Windows, so why not 
just drop it.  Okay, so MinGW comes with some nice UNIXy tools, but MinGW is 
the compiler, not the environment.

Am I still misunderstanding?  I'm looking out for the time when

C:\SomePath> git commit -a

will work (I know - it's a long way off yet).  Not for me; I don't care about 
Windows in the slightest; but some of my colleagues use it, and I'd like to 
spread the git-religion as far as I can.

> > That sounds better than I remember.  You'll have talked me into
> > migrating to Windows soon :-)
>
> I don't understand. The command "less" is the default pager of git, so you
> are prone to have used it already.

Of course I have; I was trying (failing) to be amusing.  :-)

Whenever I'm forced to use Windows, it's lack of the most basic of command 
line tools drives me insane, so you saying that less is easily available with 
good pipe support would ease my insanity slightly if were ever to go back to 
the dark place.


Andy

-- 
Dr Andy Parkins, M Eng (hons), MIEE
andyparkins@gmail.com
