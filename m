From: Jay Soffian <jaysoffian@gmail.com>
Subject: Re: Git, Mac OS X and German special characters
Date: Thu, 20 May 2010 14:22:22 -0400
Message-ID: <AANLkTilIqY0760KpZbGrv3jyZLT1e0CbkvKF3lbYB5la@mail.gmail.com>
References: <4BF4E40B.30205@math.tu-dortmund.de>
	 <AANLkTimYgkv6q6fTXqNOCq1ZbodxgCZ18Fum_NryyiO8@mail.gmail.com>
	 <4BF4F7D7.60002@drmicha.warpmail.net> <4BF4FA89.2040904@gmail.com>
	 <AANLkTil2N2xP1CWj0xxskOn-KCN1JMpJS8d3WpT5Mdg2@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Michael J Gruber <git@drmicha.warpmail.net>,
	=?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>,
	matthias.moeller@math.tu-dortmund.de, git@vger.kernel.org
To: =?UTF-8?Q?Torsten_B=C3=B6gershausen?= <totte.enea@gmail.com>
X-From: git-owner@vger.kernel.org Thu May 20 20:22:34 2010
connect(): No such file or directory
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OFAO8-0006U4-4Q
	for gcvg-git-2@lo.gmane.org; Thu, 20 May 2010 20:22:32 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756311Ab0ETSW0 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 20 May 2010 14:22:26 -0400
Received: from mail-iw0-f174.google.com ([209.85.214.174]:53592 "EHLO
	mail-iw0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754113Ab0ETSWZ convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 20 May 2010 14:22:25 -0400
Received: by iwn6 with SMTP id 6so127767iwn.19
        for <git@vger.kernel.org>; Thu, 20 May 2010 11:22:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:received:in-reply-to
         :references:date:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=GDxNja5ZWppa0arVwF7b+2Rep7vsOHOfpY/ph3VWC6U=;
        b=ICd2bmHM7XcJQhGc7d6iT9ALLF6FFbrv752NSjz31q3CLnNPNvPWM0zkPm6oncYxer
         AbEzL1tNZzOWb9lwP3FnzQsy7RJWUrs+xGi+oMRY0soPMbL3f35kUw09355U88KniN9Z
         eb/qGh0fcHZ4Fb7BW4dXzvyFwqgD5Vl5RFpxA=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=TL8UtNg6Q7YBI4k0txYCPeYLTtafR3x4VYllVPJgrkSWziKwlunZCf/VjFJkBEHlU5
         K4N5MKmJFzrBtEj8vPag+GcMXHlKYGikkKAAsAHrm3maM9RskWvGhvIuR3uN0KfHspXx
         fNEo1BeTz/S+IWzKPDm8Xt9aeCwT3OX7Dd44Y=
Received: by 10.231.176.74 with SMTP id bd10mr427550ibb.38.1274379742367; Thu, 
	20 May 2010 11:22:22 -0700 (PDT)
Received: by 10.231.34.8 with HTTP; Thu, 20 May 2010 11:22:22 -0700 (PDT)
In-Reply-To: <AANLkTil2N2xP1CWj0xxskOn-KCN1JMpJS8d3WpT5Mdg2@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/147405>

On Thu, May 20, 2010 at 11:50 AM, Jay Soffian <jaysoffian@gmail.com> wr=
ote:
> To be consistent, shouldn't we have a core.HFSPlusCompat that can be
> set on non-braindamaged filesystems to prevent filenames which would
> alias on HFS+ from entering the repo?
>
> =C2=A0 http://developer.apple.com/mac/library/technotes/tn/tn1150.htm=
l#UnicodeSubtleties

And here's an implementation (BSD-style license):

  http://src.chromium.org/svn/trunk/src/base/file_path.cc

See GetHFSDecomposedForm and HFSFastUnicodeCompare.

C++ so it'll require adapting.

j.
