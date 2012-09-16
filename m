From: Erik Faye-Lund <kusmabite@gmail.com>
Subject: Re: Unable to clone GIT project
Date: Sun, 16 Sep 2012 21:48:43 +0200
Message-ID: <CABPQNSbPF=_a7-+JnojM2DQAkkj7ZLhSnO+n-Ab=LSrHge1dnQ@mail.gmail.com>
References: <0D5A104FDD13FC4C9EE1E66F4FA3ABF60FCFDB65@NOIX10HMNOI01.AMER.DELL.COM>
 <20120916104651.GF32381@localhost.localdomain>
Reply-To: kusmabite@gmail.com
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Cc: Ankush_Aggarwal@dell.com, git@vger.kernel.org
To: Konstantin Khomoutov <flatworm@users.sourceforge.net>
X-From: git-owner@vger.kernel.org Sun Sep 16 21:49:38 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TDKqT-0007LM-Nb
	for gcvg-git-2@plane.gmane.org; Sun, 16 Sep 2012 21:49:34 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752200Ab2IPTtZ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 16 Sep 2012 15:49:25 -0400
Received: from mail-vc0-f174.google.com ([209.85.220.174]:45690 "EHLO
	mail-vc0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752068Ab2IPTtY (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 16 Sep 2012 15:49:24 -0400
Received: by vcbfo13 with SMTP id fo13so5554065vcb.19
        for <git@vger.kernel.org>; Sun, 16 Sep 2012 12:49:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:reply-to:in-reply-to:references:from:date:message-id
         :subject:to:cc:content-type;
        bh=CYxwevjTfVyH0lklX9Uy9SGw/HwCitiesm2i8fOuEck=;
        b=mUHKcKtI1prmRtkscxHgbHTvgn4+4TVxzm7DZNLggCrBFSxv8MWiQwer+tSr3UHkmi
         cVNukft5x2rtnapS2oUMJgqTKsTyn6XWsXL9t6M3kM6UZy3GC1k61GawtShc4tepLeD9
         4hrICwMxSPqXiPWZploeYR4+IQ0n/IMwVQnKUT2Tszl+zCA0bxM5hw1ZzRXr7bTAacYc
         BTtiwYE4jtSbbvZx7tRECuxM0IO/Wxm64Ts3ROAceS20rYAE4bB4UVhqJ07oOTyUE9Rm
         BSf6k4Zvh63GogUKGu3uX5oAYyrFBpvVCj7TYyC5QgkmvStTyXbyhQOVAy4FgROR3OvZ
         YAnA==
Received: by 10.58.32.234 with SMTP id m10mr6372236vei.60.1347824964229; Sun,
 16 Sep 2012 12:49:24 -0700 (PDT)
Received: by 10.58.196.232 with HTTP; Sun, 16 Sep 2012 12:48:43 -0700 (PDT)
In-Reply-To: <20120916104651.GF32381@localhost.localdomain>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/205636>

On Sun, Sep 16, 2012 at 12:46 PM, Konstantin Khomoutov
<flatworm@users.sourceforge.net> wrote:
> On Sun, Sep 16, 2012 at 03:19:25AM +0000, Ankush_Aggarwal@DELL.com wrote:
>
>> I have created a GIT repository on Linux 64 bit machine.
>>
>> When I tried to clone GIT repository on windows 7 machine then I am getting below error.
>>
>> Error:
>> git-upload-pack: error while loading shared libraries: libiconv.so.2: cannot open shared object file: No such file or directory
>> fatal: The remote end hung up unexpectedly
>>
>> anyone please help me resolve the issue.
> See [1] and generally search google for msysgit+libiconv.so.2 as it
> contains links to other approaches to working around this problem.
>
> Note that questions about technical issues with Git for Windows are
> better asked on the msysgit mailing list [2] or in the project bug
> tracker [3] (after searching both places for the relevant information).

No. This is not a Git for Windows issue. The remote end is the one who
isn't able to load libiconv, you can tell from the fact that it
complains about "libiconv.so.2", not "libiconv-2.dll", and from the
fact that the client informs us that the remote end hung up.

Ankush: There's something wrong with the setup on your Linux machine;
most likely something related to the library path set up. What
protocol are you cloning over?
