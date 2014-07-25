From: Monard Vong <travelingsoul86@gmail.com>
Subject: Re: [PATCH] git-svn: Initialize SVN::Client with svn config instead
 of, auth for "git svn branch".
Date: Fri, 25 Jul 2014 11:49:45 +0200
Message-ID: <53D22839.6080400@gmail.com>
References: <53C93611.7090705@gmail.com> <20140723223349.GB14145@dcvr.yhbt.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1;
	format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: unlisted-recipients:; (no To-header on input)
X-From: git-owner@vger.kernel.org Fri Jul 25 11:49:59 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XAc8Q-0002Hd-J9
	for gcvg-git-2@plane.gmane.org; Fri, 25 Jul 2014 11:49:54 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757734AbaGYJtu convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 25 Jul 2014 05:49:50 -0400
Received: from mail-we0-f176.google.com ([74.125.82.176]:44546 "EHLO
	mail-we0-f176.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751220AbaGYJtt (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 25 Jul 2014 05:49:49 -0400
Received: by mail-we0-f176.google.com with SMTP id q58so3967889wes.35
        for <git@vger.kernel.org>; Fri, 25 Jul 2014 02:49:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=message-id:date:from:user-agent:mime-version:cc:subject:references
         :in-reply-to:content-type:content-transfer-encoding;
        bh=byeIvOamdFJ1FcmH73l/51y0MldrspQEQOkOhQaML2A=;
        b=m7lvhR8S4jmIvXi22GPaZXk8mCPwH6OR/Hdyw/+s5aT6BrDvn9IltwCFDSBCEmGTYF
         41J2saLiYuXtVqnkybxw9+nCM/mq3Tkc4caAmSRIZyjuMMGW3lMZR6/r2YRF751ILf8X
         Up+Ana0yHDRx/EnOq87AioqiBYfVWYF4aNEj10RGZQywP/4uCsN/skttA0xf/0JnnM7c
         tNWoWt0456E+McVvCqKMM/Dlu0qsid+zPR4LoxY4eTe86JAYDGSPURhYlshw9NqSv/Hr
         Dwq44CAMPfy91wtFf8D+wV/U6h1nwwhUNuRJvHFYW1LLeRJ3INWoG6bC4HL3fUGCwnDi
         Ir/Q==
X-Received: by 10.180.93.196 with SMTP id cw4mr3381544wib.69.1406281788247;
        Fri, 25 Jul 2014 02:49:48 -0700 (PDT)
Received: from [192.168.59.212] (keyconsulting-31-226.fib.nerim.net. [178.132.31.226])
        by mx.google.com with ESMTPSA id 19sm23839109wjz.3.2014.07.25.02.49.47
        for <git@vger.kernel.org>
        (version=TLSv1 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Fri, 25 Jul 2014 02:49:47 -0700 (PDT)
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:24.0) Gecko/20100101 Thunderbird/24.6.0
In-Reply-To: <20140723223349.GB14145@dcvr.yhbt.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/254201>

Thanks for your reply, I updated commit message and subject, hoping it=20
would be clearer.
However I messed up "message-id" so it appear as a new message and not=20
in the current thread.
Sorry, still learning.


Le 24/07/2014 00:33, Eric Wong a =E9crit :
> Monard Vong <travelingsoul86@gmail.com> wrote:
>> If a client certificate is required to connect to svn, "git svn bran=
ch"
>> always prompt the user for the certificate location and password,
>> even though those parameters are stored in svn file "server"
>> located in svn config dir (generally ~/.subversion).
>> On the opposite, "git svn info/init/dcommit" read the config dir
>> and do not prompt if the parameters are set.
>>
>> This commit initializes for "git svn branch", the SVN::Client with
>> the 'config'
>> option instead of 'auth'. As decribed in the SVN documentation,
>> http://search.cpan.org/~mschwern/Alien-SVN-v1.7.17.1/src/subversion/=
subversion/bindings/swig/perl/native/Client.pm#METHODS
>> the SVN::Client will then read cached authentication options.
>>
>> Signed-off-by: Monard Vong <travelingsoul86@gmail.com>
> Thanks, I do not have a good way to test this, but the idea seems
> correct.
>
> Your patch is whitespace mangled, and the commit message and subject
> needs to be improved (see Documentation/SubmittingPatches on how to
> describe your changes and how to send them without whitespace manglin=
g.)
>
> Thanks again.
