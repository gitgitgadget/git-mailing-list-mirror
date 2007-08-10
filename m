From: "Torgil Svensson" <torgil.svensson@gmail.com>
Subject: Re: git on Cygwin: Not a valid object name HEAD
Date: Fri, 10 Aug 2007 08:07:03 +0200
Message-ID: <e7bda7770708092307g49fa9976l5f9972592129fc8e@mail.gmail.com>
References: <f99cem$4a4$1@sea.gmane.org>
	 <30e4a070708071042g5623cb7ak724a8b8e588bd1da@mail.gmail.com>
	 <07BB2580-4406-496F-8ACE-F6A03D1687BE@zib.de>
	 <30e4a070708080650j5de7ee92p4acd7e82de7d9dff@mail.gmail.com>
	 <A2397231-1B81-4AD4-87CB-8FF8FB9BA89C@zib.de>
	 <30e4a070708080941j49b3d58cxc39bbe65f2fee9d5@mail.gmail.com>
	 <Pine.LNX.4.64.0708081810130.14781@racer.site>
	 <75EB313E-807D-44FB-A186-A151F182B47B@zib.de>
	 <Pine.LNX.4.64.0708082228520.21857@racer.site>
	 <76795DDC-29A5-4C7E-B56E-A6316A183C75@zib.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: "Johannes Schindelin" <Johannes.Schindelin@gmx.de>,
	"Git Mailing List" <git@vger.kernel.org>
To: "Steffen Prohaska" <prohaska@zib.de>
X-From: git-owner@vger.kernel.org Fri Aug 10 08:07:38 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IJNep-0004j0-VU
	for gcvg-git@gmane.org; Fri, 10 Aug 2007 08:07:36 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752208AbXHJGHI (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 10 Aug 2007 02:07:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752092AbXHJGHH
	(ORCPT <rfc822;git-outgoing>); Fri, 10 Aug 2007 02:07:07 -0400
Received: from wa-out-1112.google.com ([209.85.146.176]:41250 "EHLO
	wa-out-1112.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752182AbXHJGHF (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 10 Aug 2007 02:07:05 -0400
Received: by wa-out-1112.google.com with SMTP id v27so804161wah
        for <git@vger.kernel.org>; Thu, 09 Aug 2007 23:07:04 -0700 (PDT)
DKIM-Signature: a=rsa-sha1; c=relaxed/relaxed;
        d=gmail.com; s=beta;
        h=domainkey-signature:received:received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=dyyLChoZaIhkOip5QY/LR15GGCEQfI9I3yOkI5K31SZq00thklFE406cgNeMoo/nFFbIJiBANP6W5ZJ3w7A09JFKfnK0HrMgC+q74OiPwSkdnYC4wZnBhMWEB9eT4rCRQhOlGKQaPKiFuzk8f+5TGQYux8bzRw77wwD3yILqAyA=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=beta;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=B0ixsbJFpIcTecf0QscVi1dVC44P0kECv2E+7Q+F0IS8nY69XdHVIV8G1WMRF5t+SNCv3Vpjo2xVaPGgkIwZRFLatvnfVCwZ+bUh0Oa+h7mRXfu6sc5G9wNq9lhodRtlZ1RZAkm8PegE2gpehZI71lYhJK8bWNvk2oBw0DskG08=
Received: by 10.115.77.1 with SMTP id e1mr2197975wal.1186726024124;
        Thu, 09 Aug 2007 23:07:04 -0700 (PDT)
Received: by 10.114.47.7 with HTTP; Thu, 9 Aug 2007 23:07:03 -0700 (PDT)
In-Reply-To: <76795DDC-29A5-4C7E-B56E-A6316A183C75@zib.de>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/55508>

On 8/9/07, Steffen Prohaska <prohaska@zib.de> wrote:

> The next would be a good integration with
> useful tools on Windows, for example git-mergetool should launch
> Windows three-way merge tools.

Do you mean tools included in Windows or tools using the Windows API?


> My goal would be to type 'make windist' in the official repo and
> get a very basic installer (maybe just a zip archive) that contains
> everything needed to run git on Windows. Unpacking this self-contained
> installer on a freshly installed Windows should get you going. There
> should be no need to install Cygwin or something else.
>
> Is this realistic?
> What is needed to get there?
> What would be an estimated timeframe to achieve this goal?
>
> Will all this run on Windows XP 64 bit and Windows Vista 64 bit?

How fast can you type?

Why does it have to be the _official_ repo? Git have submodule
support, so you could do a repo called
"my_excellent_git_environment_for_windows.git" and have the official
repo as submodule (msysgit is done this way).

You could even start with cloning the TortoiseSVN repo using git. Or
maybe even better, since KDE4 will compile on Windows [take on wood],
do it as a kioslave (or whatever mechanism) to have an environment
that works in both Windows and Linux and most OtherOs:es. Aiming for
environments that works on several OSes is a good thing for future
migrations.

//Torgil
