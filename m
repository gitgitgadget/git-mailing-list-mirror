From: "Philip Oakley" <philipoakley@iee.org>
Subject: definition for _attribute() in remote.c
Date: Mon, 25 Apr 2016 22:02:38 +0100
Organization: OPDS
Message-ID: <D7C0C4062A7242B6912E56480CBB06F4@PhilipOakley>
Reply-To: "Philip Oakley" <philipoakley@iee.org>
Mime-Version: 1.0
Content-Type: text/plain;
	format=flowed;
	charset="iso-8859-1";
	reply-type=original
Content-Transfer-Encoding: 7bit
Cc: "Jeff King" <peff@peff.net>
To: "Git List" <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Mon Apr 25 23:02:51 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aunec-0000SI-N1
	for gcvg-git-2@plane.gmane.org; Mon, 25 Apr 2016 23:02:51 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965008AbcDYVCm (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 25 Apr 2016 17:02:42 -0400
Received: from smtp-out-2.talktalk.net ([62.24.135.66]:56488 "EHLO
	smtp-out-2.talktalk.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S964911AbcDYVCm (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 25 Apr 2016 17:02:42 -0400
Received: from PhilipOakley ([92.22.74.182])
	by smtp.talktalk.net with SMTP
	id uneQanZnoGr60uneQaioaw; Mon, 25 Apr 2016 22:02:39 +0100
X-Originating-IP: [92.22.74.182]
X-Spam: 0
X-OAuthority: v=2.2 cv=WYJOUApX c=1 sm=1 tr=0 a=/ihZocdjyYGcUybBdHAawQ==:117
 a=/ihZocdjyYGcUybBdHAawQ==:17 a=8nJEP1OIZ-IA:10 a=NEAV23lmAAAA:8
 a=eRSwc81RkNHOmlkM9DkA:9
X-Priority: 3
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook Express 6.00.2900.5931
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2900.6157
X-CMAE-Envelope: MS4wfAFMxbS/27/ZxjQg05cOhougxjmlilAQlnBjniOGZsR8yBFX0wDv1UTL2OtjfWL7ZDftVgW+r0ho9J6bn49tGPwbE+bE37oiTv22sz0R+OU7fyFBxa3z
 sKowfezDpnHI98x/g2PF71liLELl1xKBVVNYue8AhqLhCg1p7J+hlBqt0oD6ceSFNO8cirC/ymaZFw==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/292556>

Hi,

I'm looking at getting Git for Windows to compile via Visual Studio 
(https://github.com/git-for-windows/git/pull/256).

However the use of __attribute() in remote.c at L1662 
(https://github.com/git-for-windows/git/blob/master/remote.c#L1662) has got 
me confused in that I can't see how the regular definition of __attribute() 
is #included in this case. A definition is given in 
git\compat\regex\regex_internal.h but doesn't appear to be on remote.c's 
include path.

The line was introduced by 3a429d0 (remote.c: report specific errors from 
branch_get_upstream, 2015-05-21) which appears to be later than the previous 
MSVC testers had looked at.

Any guidance on what is happening in this case would be welcomed as this is 
the last compile error I'm seeing.

--

Philip
