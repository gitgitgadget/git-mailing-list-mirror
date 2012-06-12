From: jaseem abid <jaseemabid@gmail.com>
Subject: Cover letter for the last patch
Date: Tue, 12 Jun 2012 11:33:52 +0530
Message-ID: <CAH-tXsCn+9t5dAq6ujNTvWL5Gz_Cw5nRLzwVjxw6-t8Hhwg4Aw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Andrew Sayers <andrew-git@pileofstuff.org>,
	=?UTF-8?Q?Jakub_Nar=C4=99bski?= <jnareb@gmail.com>,
	Junio C Hamano <gitster@pobox.com>
To: git mailing list <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Tue Jun 12 08:05:09 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SeKDy-00020p-Du
	for gcvg-git-2@plane.gmane.org; Tue, 12 Jun 2012 08:05:06 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752224Ab2FLGEv (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 12 Jun 2012 02:04:51 -0400
Received: from mail-we0-f174.google.com ([74.125.82.174]:45453 "EHLO
	mail-we0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751496Ab2FLGEe (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 12 Jun 2012 02:04:34 -0400
Received: by weyu7 with SMTP id u7so2585832wey.19
        for <git@vger.kernel.org>; Mon, 11 Jun 2012 23:04:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:from:date:message-id:subject:to:cc:content-type;
        bh=7UnRk/LtnOOxPOIobKO60e9rSdq9UmcBxY1rflg4Nm4=;
        b=B8c048Y4+ptGu1APSUNT+BeIcxhbNmYEd8sykRVGlAbFUwwEVEtLGZYrW7EVjIbakZ
         7hps2P14eumq734GncCjAErNLhBwocCECUTSN4BzjmcdO7Oru94xqA8RoAZtNJKnsl19
         4bCLVoInWkyaCnSbwQHLfz8dI5HxYJ4EbEKeuQA0IbmcpeYlWhzlfyvzD/eO0ZLOBYFi
         u8RRLgtmpOVeOgQwcNgp8bXra8y4NX5Ipwv6rNJKvcKC4qUm6IvX+BauokXOpF4VyBRY
         IsjeTIL2c/LBRU4ms0eHXDYxtiQfZwffnUfE/bfHa032Fon9huOlee06sDEQa6ELuF5x
         zLBg==
Received: by 10.180.80.74 with SMTP id p10mr26462945wix.10.1339481072965; Mon,
 11 Jun 2012 23:04:32 -0700 (PDT)
Received: by 10.227.173.142 with HTTP; Mon, 11 Jun 2012 23:03:52 -0700 (PDT)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/199765>

Dear list,

Sorry,  I think i missed the cover letter for the last patch.

[PATCH/RFC] gitweb: Adding jasmine test suite files for the browser

JavaScript in gitweb is almost completely handwritten.
It is reimplementing things JavaScript library authors did a lot of times
already. Porting the current code to a library version was proposed as a gsoc
project this year. [ So I think I can skip why this patch is relevant]

A common suggestion was to add tests to the new JavaScript code. Deciding the
testing framework took much more time than expected after several discussions.
People wanted tests that could be run in console with TAP so that it will
integrate well with the existing system but since the code is ultimately going
to be run in a browser, tests in the browser was more important.

After a lot of discussions here and on #git-devel, I have used jasmine BDD
framework, nodejs and jasmine TAP reporter to solve the issues. The specs are
written for the browser and a makefile generates t/t9503-gitweb-javascript.js
which can be run in a console to produce TAP output.


This patch series is for review only. If everyone is ok with the new testing
framework, I will be able to send a patch with actual code in a week or 2. This
patch series adds few sample tests to the existing code, and makes it run in a
browser and console.

I have added gitweb/test/README with instructions on the new test.

Please eyeball the changes to t/Makefile as I am not very sure if that is the
best way to do it.

Reviews most welcome.



-- 
Jaseem Abid
http://jaseemabid.github.com
