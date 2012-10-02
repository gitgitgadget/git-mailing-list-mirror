From: Jens Hausherr <Jens.Hausherr@xing.com>
Subject: Re: Deletion of remote branches
Date: Tue, 2 Oct 2012 06:57:21 +0000
Message-ID: <CC905CB7.E8B%jens.hausherr@xing.com>
References: <7vhaqdc4ap.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Cc: "git@vger.kernel.org" <git@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>,
	Philip Oakley <philipoakley@iee.org>
X-From: git-owner@vger.kernel.org Tue Oct 02 09:05:46 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TIwY2-0004gV-9N
	for gcvg-git-2@plane.gmane.org; Tue, 02 Oct 2012 09:05:42 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751519Ab2JBHFc (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 2 Oct 2012 03:05:32 -0400
Received: from mx2-2.xing.com ([109.233.156.97]:60402 "EHLO mx2-2.xing.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751431Ab2JBHFb convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 2 Oct 2012 03:05:31 -0400
X-Greylist: delayed 487 seconds by postgrey-1.27 at vger.kernel.org; Tue, 02 Oct 2012 03:05:31 EDT
Received: from localhost (localhost [127.0.0.1])
	by mx2-2.xing.com (Postfix) with ESMTP id 01C641B68;
	Tue,  2 Oct 2012 08:57:24 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=xing.com; h=
	mime-version:content-transfer-encoding:content-id:content-type
	:content-type:user-agent:content-language:accept-language
	:in-reply-to:message-id:date:date:subject:subject:from:from
	:received:received:received; s=main; t=1349161043; bh=0R8/p5ItQY
	Rh0uaNF384RU3DIdKXzfmiS+dUOwiMadg=; b=mkMw+FRszZ9GOtiklnZs7JB5zx
	NoPYcfckow4TDWj9z3YKwDWT+w2qS/YPpLh1Z7GpvvooQ66ez8HogRs/qmGJ1Isf
	vDyxKm+fVpOs2tMkfNT4NWAx/JpWvUnGLzlGGoGaYv2zKkPlYrC2TJ5DodRzGMMm
	3X0vtmT+krpmONKbQ=
X-Virus-Scanned: Debian amavisd-new at mx2-2.mail.fra2.xing.com
Received: from mx2-2.xing.com ([127.0.0.1])
	by localhost (mx2-2.mail.fra2.xing.com [127.0.0.1]) (amavisd-new, port 10030)
	with ESMTP id o44yQXAAbP6A; Tue,  2 Oct 2012 08:57:23 +0200 (CEST)
Received: from XING-EXCHSVR01.xing.hh (unknown [172.20.1.16])
	(using TLSv1 with cipher AES128-SHA (128/128 bits))
	(No client certificate requested)
	by mx2-2.xing.com (Postfix) with ESMTPS id ACCFE3F9F;
	Tue,  2 Oct 2012 08:57:22 +0200 (CEST)
Received: from XING-EXCHSVR02.xing.hh ([fe80::c94c:f7e0:c93d:de5f]) by
 XING-EXCHSVR01.xing.hh ([fe80::4110:9584:97c1:27a9%22]) with mapi id
 14.02.0298.004; Tue, 2 Oct 2012 08:57:22 +0200
Thread-Topic: Deletion of remote branches
Thread-Index: AQHNn9fX2dpkrvRfQk201KJe1aLYK5ektPgIgAAxDaSAAATthIAAq76A
In-Reply-To: <7vhaqdc4ap.fsf@alter.siamese.dyndns.org>
Accept-Language: de-DE, en-US
Content-Language: de-DE
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Microsoft-MacOutlook/14.2.4.120824
x-originating-ip: [172.29.0.21]
Content-ID: <3927D45187661E40AC802BA2424D5477@xing.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/206784>

Ok, thanks for clarifying this.


"Philip Oakley" <philipoakley@iee.org> writes:

>All of the above are expected and working as designed.  Remote
>tracking branches are local _copies_ of what you have over there at
>the remote repository. The latter is the authoritative version, and
>you asked "ls-remote" to go over the network to view them.
