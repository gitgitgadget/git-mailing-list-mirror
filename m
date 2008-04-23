From: Robin Rosenberg <robin.rosenberg.lists@dewire.com>
Subject: Re: What's cooking in git.git (topics)
Date: Wed, 23 Apr 2008 10:47:41 +0200
Message-ID: <200804231047.41315.robin.rosenberg.lists@dewire.com>
References: <7vlk4snpj3.fsf@gitster.siamese.dyndns.org> <46dff0320804221859x7641144fua34df89fcc686aa2@mail.gmail.com> <alpine.WNT.1.10.0804231124270.2728@theodor>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Cc: Ping Yin <pkufranky@gmail.com>,
	Josef Weidendorfer <Josef.Weidendorfer@gmx.de>,
	Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: Fedor Sergeev <Fedor.Sergeev@sun.com>
X-From: git-owner@vger.kernel.org Wed Apr 23 10:52:28 2008
connect(): Connection refused
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Joai8-00074h-Ju
	for gcvg-git-2@gmane.org; Wed, 23 Apr 2008 10:52:17 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754795AbYDWIvY (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 23 Apr 2008 04:51:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754788AbYDWIvY
	(ORCPT <rfc822;git-outgoing>); Wed, 23 Apr 2008 04:51:24 -0400
Received: from [83.140.172.130] ([83.140.172.130]:25576 "EHLO dewire.com"
	rhost-flags-FAIL-FAIL-OK-OK) by vger.kernel.org with ESMTP
	id S1753242AbYDWIvW (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 23 Apr 2008 04:51:22 -0400
Received: from localhost (localhost [127.0.0.1])
	by dewire.com (Postfix) with ESMTP id 7F9AA8026C3;
	Wed, 23 Apr 2008 10:51:20 +0200 (CEST)
X-Virus-Scanned: by amavisd-new at dewire.com
Received: from dewire.com ([127.0.0.1])
	by localhost (torino.dewire.com [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id oGSibSkLWqLf; Wed, 23 Apr 2008 10:51:19 +0200 (CEST)
Received: from [10.9.0.13] (unknown [10.9.0.13])
	by dewire.com (Postfix) with ESMTP id 59E341458901;
	Wed, 23 Apr 2008 10:51:19 +0200 (CEST)
User-Agent: KMail/1.9.9
In-Reply-To: <alpine.WNT.1.10.0804231124270.2728@theodor>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/80200>

onsdagen den 23 april 2008 09.47.57 skrev Fedor Sergeev:
> If one manages to hack on repository one can modify it enormous amount of
> ways, including spoofing on SHA (providing wrong contents for it - does
> git verify that when getting a pack?), utilizing bugs in git etc...

The pack transfer protocol does not transfer the SHA of objects, only the 
contents is transferred. The SHA-1 is (has to be since it is not sent) 
reconstructed on the receiving end.

-- robin
