From: Sebastian Schuberth <sschuberth@gmail.com>
Subject: Re: Same test-path-utils behaves differently on different Windows systems
Date: Thu, 10 Oct 2013 22:47:04 +0200
Message-ID: <CAHGBnuOHD1o1si9EMpi+qi=VDCvAgEQbLfNaVDfOS983E6AKuw@mail.gmail.com>
References: <CAHGBnuNaVWxa2kNqf3n9GmZZxFryLfJqKB5TxmDK5BiG5x53VQ@mail.gmail.com>
	<CAHGBnuORD-nTaYVVMt5WJhFnHU4oj0=5WiLXMAMa2Y4mz-vNXg@mail.gmail.com>
	<5256EA82.7020504@kdbg.org>
	<CAHGBnuO8ATSQu6HpJTm8bBg0akm+LUsZGRFoZPhzs89q7gTWqQ@mail.gmail.com>
	<52570860.3060503@kdbg.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: worldhello.net@gmail.com,
	Thomas Braun <thomas.braun@virtuell-zuhause.de>,
	Git Mailing List <git@vger.kernel.org>,
	msysGit Mailinglist <msysgit@googlegroups.com>
To: Johannes Sixt <j6t@kdbg.org>
X-From: git-owner@vger.kernel.org Thu Oct 10 22:47:21 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VUN8f-00039r-A3
	for gcvg-git-2@plane.gmane.org; Thu, 10 Oct 2013 22:47:17 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755813Ab3JJUrI (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 10 Oct 2013 16:47:08 -0400
Received: from mail-la0-f53.google.com ([209.85.215.53]:60421 "EHLO
	mail-la0-f53.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755336Ab3JJUrH (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 10 Oct 2013 16:47:07 -0400
Received: by mail-la0-f53.google.com with SMTP id el20so2550261lab.40
        for <git@vger.kernel.org>; Thu, 10 Oct 2013 13:47:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        bh=NECX+92Hm3LNOP/8oXDVudcyFzoLunjyUAP2sR8eLyQ=;
        b=lfEWywIRclxb+qtjAG8WbvmviPTyAGRIOvzTZSoWRuH1VtI5DVUxn+pu0oL+qUVrCB
         guJUyCk4gZG+LNMkaF0NRLzq8+VtfP+SXIGKC26ahJQ8rg7V5J1BUe/ZkGAzEWJSc25U
         02/18GsfUh14JnLxzUqgjTKK3MEEVkmvc6aGKkKoxjPLVS57nOShYZVn9R+7R+gAzUD1
         6wBr0C7EAzaPusHJzDCstcTCZi9c1tzI8dXlSdonqNztxiFFAavVqbw1pKuhAd4X6PzG
         7HoA63Nzf7MjTLBMXt602RaxKQ2vuU122Ju01/wdBj3T+bwmUt4d/K+IRbX59FeEYGV9
         mX+w==
X-Received: by 10.152.243.42 with SMTP id wv10mr3168291lac.39.1381438024743;
 Thu, 10 Oct 2013 13:47:04 -0700 (PDT)
Received: by 10.114.5.161 with HTTP; Thu, 10 Oct 2013 13:47:04 -0700 (PDT)
In-Reply-To: <52570860.3060503@kdbg.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/235883>

On Thu, Oct 10, 2013 at 10:04 PM, Johannes Sixt <j6t@kdbg.org> wrote:

>> PS: I'm also quite unhappy about naming the function "mingw_path". The
>> path mangling comes from MSYS, not MinGW, so if at all it should be
>> named msys_path. But as the code for the "mingw_path" function does
>> nothing either MSYS or MinGW related but just prints argv[2] as it was
>> passed to main() it should probably simply called "print_path".
>
> You have a point here. If it were to change, "echo_path" would be my
> preference.

I'll stick to "print_path" as it more closely resembles "pwd", *print*
working directory.

-- 
Sebastian Schuberth
