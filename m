From: Mehul Jain <mehul.jain2029@gmail.com>
Subject: Re: GSoC 2016: Microproject
Date: Sun, 21 Feb 2016 21:34:18 +0530
Message-ID: <CA+DCAeQWeUodaBtHOdzGB3RTZTQ672ZUSV-=eh-nA+8Bvn4gxw@mail.gmail.com>
References: <CA+DCAeTAmUAciCx33ZHLKReHSy4K-dEeaKSb19qBcQc_U80UJA@mail.gmail.com>
	<vpq37so26oz.fsf@anie.imag.fr>
	<CA+DCAeQLJnvNFdSobDNOGVaHbDRnRy4vm9_4SB+Bw+5N5QMKHA@mail.gmail.com>
	<CAGZ79kbdTFui5Zxmt0+BrgOzxTFsN2n-XZiJBNj4QFD3HPRpBQ@mail.gmail.com>
	<CA+DCAeRTtECCZSAPYUe2=AoQEvc6LRG1B+qYCCj9C6_nyUJrhw@mail.gmail.com>
	<vpq8u2er7ae.fsf@anie.imag.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Stefan Beller <sbeller@google.com>, git@vger.kernel.org
To: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
X-From: git-owner@vger.kernel.org Sun Feb 21 18:56:52 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aXYFU-0003Jc-Vq
	for gcvg-git-2@plane.gmane.org; Sun, 21 Feb 2016 18:56:49 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751681AbcBUR4q (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 21 Feb 2016 12:56:46 -0500
Received: from mail-qk0-f175.google.com ([209.85.220.175]:33978 "EHLO
	mail-qk0-f175.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750832AbcBUR4p (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 21 Feb 2016 12:56:45 -0500
Received: by mail-qk0-f175.google.com with SMTP id x1so48635304qkc.1
        for <git@vger.kernel.org>; Sun, 21 Feb 2016 09:56:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        bh=YbqQYaksNV017dXMb+PU9tVyIPlKedcuoD1i7wd6H6A=;
        b=NAV1mvjcdsnqhWsxpE46yZtEN9zj35zxVkHXbc2BvNKozd0HT6YTibxKMIcSmdVooY
         Siq2mP0ie9+pApWhBg+Izi0Z78cdDmxrdS5u22HJuLAQRseeRN73DYRx6t51GFRU7WlH
         tZe6gBKoSqrTwzZgHhgUtaijqn6MhT6RPWbnEx7/EHKif1F+9M1OLrvU+D4pLBjY3aRM
         Fme9yeKMDpm2rPyyOHJjCETKsEBVFlzCzZ3XfdMakhPNUqqed6OkPH9vzoyFG7YT6f5O
         eJoeY6TdE3tarNDJHF2ZbOl3i9nUI/2Ab6BngfaeSu+2Utgskte0aK9pYN0SJGkGuGtI
         nIhA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:date
         :message-id:subject:from:to:cc:content-type;
        bh=YbqQYaksNV017dXMb+PU9tVyIPlKedcuoD1i7wd6H6A=;
        b=M5emyViNhF5snkrSdxwYUi2fVZ3F1nmHZZYEHPlPg7AxjHsi+c7oKcyLxiobVDKw9X
         Xw8jbXpWF55amFmFHzGImgXX+bYyo7gC2lsGvLtIb0j9EpljKAnL9p3FDnKQXG2vUrxT
         fYBcuROsVrHZJIN3LHzwXKKs1qUYVQJch6f/dUIgrnQ+8AOM9i7iQB5vv8sXckdkFHLl
         lOwHhgWwLaLkSwsRWg6npC0P31xYWdYY7VW+15zrGWnVKh3By4/iX2VtqBkDZro3tFkT
         t1cXUIINB+DkgJGgA4JQGYosjsB+RdhAb3BSsd28H79DGaNPKQFookKKhEgQd2Y1OsQw
         8fcA==
X-Gm-Message-State: AG10YORrK6PG/C5lCTFHbKNspxqRO9cyGcKpjv+RNXN7vcPRWlade0fnbXcjmZb12Im49UIrQ3rjkdeodhIKfg==
X-Received: by 10.55.217.151 with SMTP id q23mr10414627qkl.88.1456070659032;
 Sun, 21 Feb 2016 08:04:19 -0800 (PST)
Received: by 10.55.154.205 with HTTP; Sun, 21 Feb 2016 08:04:18 -0800 (PST)
In-Reply-To: <vpq8u2er7ae.fsf@anie.imag.fr>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/286814>

On Sun, Feb 21, 2016 at 10:25 AM, Matthieu Moy
<Matthieu.Moy@grenoble-inp.fr> wrote:
> Please, don't top-post on this list.

I apologize for top-posting on the list.

> Are you sure that 1) you have no uncommitted change and 2) you have
> compiled what you have in your tree?

1) Yes, I have no uncommited change in the branch(master).
2) Yes, I compiled before testing.

Earlier when I was testing the master branch on my pc, I used "make"
in \t directory, which lead to failure of test #2, #3 in
t5539-fetch-http-shallow.sh .
Afterwards I switched to sudo mode and ran the make command again.
This time all test of  t5539-fetch-http-shallow.sh passed, but test
#32 of file t7300-clean.sh failed. To crosscheck, I ran " sudo sh
./t7300-clean.sh -v --run='1-32' " which gave the following error
message -

Skipping repository baz/boo
Skipping repository foo/
Removing possible_sub1/
Skipping repository repo/
Skipping repository sub2/
Removing to_clean/
File possible_sub1/.git doesn't exist.
not ok 32 - should avoid cleaning possible submodules
#
# rm -fr to_clean possible_sub1 &&
# mkdir to_clean possible_sub1 &&
# test_when_finished "rm -rf possible_sub*" &&
# echo "gitdir: foo" >possible_sub1/.git &&
# >possible_sub1/hello.world &&
# chmod 0 possible_sub1/.git &&
# >to_clean/should_clean.this &&
# git clean -f -d &&
# test_path_is_file possible_sub1/.git &&
# test_path_is_file possible_sub1/hello.world &&
# test_path_is_missing to_clean
#

I haven't made any commits/changes in the master branch. Can you
please suggest where things are going wrong.

Thanks
Mehul Jain
