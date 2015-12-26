From: "Philip Oakley" <philipoakley@iee.org>
Subject: RE: incorrect ssl directory set on git-scm
Date: Sat, 26 Dec 2015 18:31:15 -0000
Message-ID: <000401d1400b$9b322df0$d19689d0$@iee.org>
References: <loom.20151226T143541-907@post.gmane.org>
Reply-To: <philipoakley@iee.org>
Mime-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 7bit
Cc: <git-for-windows@googlegroups.com>
To: "'joe'" <joezeve@openmailbox.org>, <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Sat Dec 26 19:31:46 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aCtd3-0001WO-Pl
	for gcvg-git-2@plane.gmane.org; Sat, 26 Dec 2015 19:31:46 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751103AbbLZSbK (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 26 Dec 2015 13:31:10 -0500
Received: from out1.ip03ir2.opaltelecom.net ([62.24.128.239]:18972 "EHLO
	out1.ip03ir2.opaltelecom.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1750968AbbLZSbJ (ORCPT
	<rfc822;git@vger.kernel.org>); Sat, 26 Dec 2015 13:31:09 -0500
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-Anti-Spam-Result: A2DYCADP235WPKeyYwJeGQEBAQEPAQEBAYMKUolGpUiRDCKFZwQCAoEOTQEBAQEBAQcBAQEBQT+ENAEBAQECAQgCHhIcIwUIAwIGA0YZIAoGAQ0CBAEdBYgXDAqwPYp5AQEBBwEBAQEBGgSGVoR/iT0FjTmJTQGBNYQKlwyOO4RvPoVkAQEB
X-IPAS-Result: A2DYCADP235WPKeyYwJeGQEBAQEPAQEBAYMKUolGpUiRDCKFZwQCAoEOTQEBAQEBAQcBAQEBQT+ENAEBAQECAQgCHhIcIwUIAwIGA0YZIAoGAQ0CBAEdBYgXDAqwPYp5AQEBBwEBAQEBGgSGVoR/iT0FjTmJTQGBNYQKlwyOO4RvPoVkAQEB
X-IronPort-AV: E=Sophos;i="5.20,482,1444690800"; 
   d="scan'208";a="580317262"
Received: from host-2-99-178-167.as13285.net (HELO HousePC) ([2.99.178.167])
  by out1.ip03ir2.opaltelecom.net with ESMTP; 26 Dec 2015 19:01:16 +0000
In-Reply-To: <loom.20151226T143541-907@post.gmane.org>
X-Mailer: Microsoft Outlook 15.0
Thread-Index: AQMvu9b99fK72Gt47KD3qV/WtgXJdpwgnAWA
Content-Language: en-gb
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/282999>

> From Jo zeve
> 
> git-scm comes with ca-bundle.trust.crt and cert.pem, it currently (2.6.4)
> assumes that they are stored in
> 
> <dir name>\mingw32\libexec\ssl\certs
> <dir name>\mingw32\libexec\ssl
> 
> which is not true, they are in
> 
> <dir name>\mingw32\ssl\certs
> <dir name>\mingw32\ssl
> 

The location of the CA certs is discussed in
https://github.com/git-for-windows/git/issues/425 among others (do have a
search through the issues for the other discussions).

As I understand it from watching the discussions go by, Windows and *nix
have different perspectives on where they should be stored.

If you can help with a suitable patch / Pull request that would be great.
Especially as it looks like you desire the 32 bitness version.

--

Philip
