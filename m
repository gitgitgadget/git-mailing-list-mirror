From: Gmail <eratos2000@gmail.com>
Subject: Re: Git send-email fail on Mac OS X Lion
Date: Sat, 12 Oct 2013 12:40:24 -0500
Message-ID: <194068D5-0134-48CA-89E0-484CD296BD83@gmail.com>
References: <04374E86-02D8-4E76-A7F5-7DEE34F25C7F@gmail.com> <20131012134711.GG79408@vauxhall.crustytoothpaste.net>
Mime-Version: 1.0 (1.0)
Content-Type: text/plain;
	charset=us-ascii
Content-Transfer-Encoding: 8BIT
Cc: "git@vger.kernel.org" <git@vger.kernel.org>
To: "brian m. carlson" <sandals@crustytoothpaste.net>
X-From: git-owner@vger.kernel.org Sat Oct 12 19:40:34 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VV3B1-0001jn-Iv
	for gcvg-git-2@plane.gmane.org; Sat, 12 Oct 2013 19:40:31 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753253Ab3JLRk1 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 12 Oct 2013 13:40:27 -0400
Received: from mail-oa0-f53.google.com ([209.85.219.53]:51626 "EHLO
	mail-oa0-f53.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752720Ab3JLRk1 convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Sat, 12 Oct 2013 13:40:27 -0400
Received: by mail-oa0-f53.google.com with SMTP id i7so3396566oag.12
        for <git@vger.kernel.org>; Sat, 12 Oct 2013 10:40:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=references:mime-version:in-reply-to:content-type
         :content-transfer-encoding:message-id:cc:from:subject:date:to;
        bh=NbVB2zPSqx62FbJQzcKWA16fyY9EdQ6IrP81iIdVlg0=;
        b=L5kVd+Ja7dahKz0GMzQS3mIoCENQcrnnVk6AUyescHJwcpRi5O3vfZfp0TPXnI9x2r
         aPLUHCdpgT6zfU7YOEy4Iuf9L6FSgFAHDobRveBTWk5iRYpZSXYyE9HbHyt8oCfOmNMp
         drNLIn/B1BZThjQ5F2kB0vLIFOCma6ADBGMYI+bvoVOgVrjWSR2HmwPSBqaQ3d4Vh+bV
         9wO1r66yx4vn08DnuEQZ8MrraUQTvM/p1RWB4iOvMTg2tbXrmqOTGgAUJXoko8lKqogM
         hD+HL07PcpkXdr7BCuGTi+orMvn06JxVmmAnRXTtm6fIXZ09OivvpxVD5h7d+mmPVyLE
         V7rw==
X-Received: by 10.60.44.193 with SMTP id g1mr541450oem.47.1381599626426;
        Sat, 12 Oct 2013 10:40:26 -0700 (PDT)
Received: from [192.168.2.146] (ip70-180-90-249.no.no.cox.net. [70.180.90.249])
        by mx.google.com with ESMTPSA id tz10sm31140037obc.10.1969.12.31.16.00.00
        (version=TLSv1 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Sat, 12 Oct 2013 10:40:25 -0700 (PDT)
In-Reply-To: <20131012134711.GG79408@vauxhall.crustytoothpaste.net>
X-Mailer: iPhone Mail (11A501)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/236053>

Brian,

I already tried to reinstall with cpan/m using -f -i options.  I even removed the PERL5LIB location and reinstalled the packages from scratch to no avail.

Nando

Sent from my iPhone

> On Oct 12, 2013, at 8:47 AM, "brian m. carlson" <sandals@crustytoothpaste.net> wrote:
> 
>> On Fri, Oct 11, 2013 at 11:06:17PM -0500, Fernando Ortiz (e2k) wrote:
>> I'm getting the following error when I do:
>> 
>> git send-email --compose --from Fernando Ortiz <eratos2000@gmail.com> --to fortiz2k@gmail.com --cc fortiz2k@gmail.com 0001-Change-zcat-to-gzcat-to-fix-build-restore-steps.patch
>> 
>> Net::SSLeay version 1.46 required--this is only version 1.36 at /Users/fortiz/perl5/perlbrew/perls/perl-5.14.4/lib/site_perl/5.14.4/IO/Socket/SSL.pm line 17.
> 
> Here's your answer: Net::SSLeay is too old for IO::Socket::SSL.  You
> either need to use cpan or cpanm to install a newer Net::SSLeay, and
> then it will work.
> 
> -- 
> brian m. carlson / brian with sandals: Houston, Texas, US
> +1 832 623 2791 | http://www.crustytoothpaste.net/~bmc | My opinion only
> OpenPGP: RSA v4 4096b: 88AC E9B2 9196 305B A994 7552 F1BA 225C 0223 B187
