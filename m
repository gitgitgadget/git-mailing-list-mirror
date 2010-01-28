From: Michael Ludwig <michael.ludwig@xing.com>
Subject: Re: git status showing phantom modifications
Date: Thu, 28 Jan 2010 09:45:54 +0100
Message-ID: <707C3CA1-8016-411A-AB98-5BAC15E81024@xing.com>
References: <9B3C1167-7667-4B1F-BEE5-F47FE89F8692@xing.com>
 <be6fef0d1001250303p2c12381ao7d3a8a1d48eebb56@mail.gmail.com>
 <4017EB11-4B29-4599-B19A-91BC39632BBF@xing.com>
 <59B5C4C4-6E95-4BAA-9351-B88B6309E022@xing.com>
 <be6fef0d1001262114r137ba8ddi60a3a3468950c5ce@mail.gmail.com>
 <4B5FE925.4000300@viscovery.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
To: "git@vger.kernel.org" <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Thu Jan 28 09:46:09 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1NaQ0q-0000Ui-KN
	for gcvg-git-2@lo.gmane.org; Thu, 28 Jan 2010 09:46:04 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755920Ab0A1Ip6 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 28 Jan 2010 03:45:58 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755899Ab0A1Ip6
	(ORCPT <rfc822;git-outgoing>); Thu, 28 Jan 2010 03:45:58 -0500
Received: from mail43-3.xing.com ([62.96.140.163]:39149 "EHLO
	mail43-3.xing.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753913Ab0A1Ip5 convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 28 Jan 2010 03:45:57 -0500
Received: from localhost (localhost [127.0.0.1])
	by mail43-3.xing.com (Postfix) with ESMTP id 3483C30007B8E
	for <git@vger.kernel.org>; Thu, 28 Jan 2010 09:45:56 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=xing.com; h=
	mime-version:content-transfer-encoding:content-type
	:content-language:accept-language:in-reply-to:references
	:message-id:subject:date:from:received:received:received:
	x-virus-scanned; s=main; t=1264668356; bh=bZiZGHY+qLAygD7lzlsXiZ
	txVbfUSLXci20CnZ9fAog=; b=wpqAexnikrw9TwjVEombu2OLZUobX8rw8gv1zY
	gk0YudCMy1eoYqB8QsNuBVtFOQ3d1Tj+HFm5Vi4adIJpxTWwAHxdbp1cWh2Paq+x
	rSKVItLjoJdnkUbcZoHmsXNB7mpV5GQlPbtUHi/vbxoeNLui/PJoXaBdgdd6g9GT
	Y1axA=
X-Virus-Scanned: Debian amavisd-new at obc-mail43-3.rz.xing.com
Received: from mail43-3.xing.com ([127.0.0.1])
	by localhost (obc-mail43-3.rz.xing.com [127.0.0.1]) (amavisd-new, port 10030)
	with ESMTP id t3uClaotbtCW for <git@vger.kernel.org>;
	Thu, 28 Jan 2010 09:45:56 +0100 (CET)
Received: from luftpostix.xing.hh (unknown [172.20.1.5])
	(using TLSv1 with cipher RC4-MD5 (128/128 bits))
	(No client certificate requested)
	by mail43-3.xing.com (Postfix) with ESMTPS id 1D90830000781
	for <git@vger.kernel.org>; Thu, 28 Jan 2010 09:45:56 +0100 (CET)
Received: from luftpostix.xing.hh ([172.20.1.5]) by luftpostix.xing.hh
 ([172.20.1.5]) with mapi; Thu, 28 Jan 2010 09:45:56 +0100
Thread-Topic: git status showing phantom modifications
Thread-Index: Acqf9k37htdnDZmnQh6zEcoXR+BK+Q==
In-Reply-To: <4B5FE925.4000300@viscovery.net>
Accept-Language: de-DE
Content-Language: de-DE
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
acceptlanguage: de-DE
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/138227>

Am 27.01.2010 um 08:20 schrieb Johannes Sixt:

> One more thing to try is:
> 
>  core.ignorecygwinfstricks = false
> 
> This turns off some stat() optimizations on Cygwin.


The above setting causes the phantom modifications to disappear,
regardless of an *explicit* setting of core.filemode as reported
in one of my previous mails on this thread.

So thanks, it works okay for me. Still, it's not clear what's
happening.
-- 
Michael.Ludwig (#) XING.com
