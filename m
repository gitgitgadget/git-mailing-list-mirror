From: Robin Rosenberg <robin.rosenberg.lists@dewire.com>
Subject: Re: [PATCH] fix crash in path.c on Windows
Date: Thu, 5 Feb 2009 21:41:00 +0100
Message-ID: <200902052141.00999.robin.rosenberg.lists@dewire.com>
References: <498A1E1E.8010901@lsrfire.ath.cx> <498A9C01.6020602@viscovery.net> <498B1862.5070703@lsrfire.ath.cx>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-15
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Johannes Sixt <j.sixt@viscovery.net>,
	Git Mailing List <git@vger.kernel.org>,
	Junio C Hamano <gitster@pobox.com>
To: =?iso-8859-15?q?Ren=E9_Scharfe?= <rene.scharfe@lsrfire.ath.cx>
X-From: git-owner@vger.kernel.org Thu Feb 05 21:42:35 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LVB3S-0005KR-GJ
	for gcvg-git-2@gmane.org; Thu, 05 Feb 2009 21:42:34 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751584AbZBEUlH convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 5 Feb 2009 15:41:07 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751731AbZBEUlF
	(ORCPT <rfc822;git-outgoing>); Thu, 5 Feb 2009 15:41:05 -0500
Received: from mail.dewire.com ([83.140.172.130]:2937 "EHLO dewire.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751554AbZBEUlE convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 5 Feb 2009 15:41:04 -0500
Received: from localhost (localhost [127.0.0.1])
	by dewire.com (Postfix) with ESMTP id 1BC71147E880;
	Thu,  5 Feb 2009 21:41:02 +0100 (CET)
X-Virus-Scanned: by amavisd-new at dewire.com
Received: from dewire.com ([127.0.0.1])
	by localhost (torino.dewire.com [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id YlRdDiZa8TJN; Thu,  5 Feb 2009 21:41:01 +0100 (CET)
Received: from sleipner.localnet (unknown [10.9.0.2])
	by dewire.com (Postfix) with ESMTP id 9F2C2147E7FF;
	Thu,  5 Feb 2009 21:41:01 +0100 (CET)
User-Agent: KMail/1.10.4 (Linux/2.6.27-11-generic; KDE/4.1.4; i686; ; )
In-Reply-To: <498B1862.5070703@lsrfire.ath.cx>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/108612>

torsdag 05 februari 2009 17:48:34 skrev Ren=E9 Scharfe:
> Is is_absolute_path() too forgiving on Windows, i.e. should it stop
> classifying paths starting with a slash as absolute on that platform?

//server/share/file is an absolute path.

-- robin
