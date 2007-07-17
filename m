From: "H. Peter Anvin" <hpa@zytor.com>
Subject: Character set for the HTML documentation
Date: Tue, 17 Jul 2007 16:31:55 -0700
Message-ID: <469D516B.6030806@zytor.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
To: Git Mailing List <git@vger.kernel.org>,
	Junio C Hamano <junkio@cox.net>
X-From: git-owner@vger.kernel.org Wed Jul 18 01:32:15 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IAwWZ-0007Yk-7B
	for gcvg-git@gmane.org; Wed, 18 Jul 2007 01:32:11 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1762424AbXGQXcF (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 17 Jul 2007 19:32:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1758430AbXGQXcE
	(ORCPT <rfc822;git-outgoing>); Tue, 17 Jul 2007 19:32:04 -0400
Received: from terminus.zytor.com ([198.137.202.10]:57278 "EHLO
	terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757402AbXGQXcD (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 17 Jul 2007 19:32:03 -0400
Received: from mail.hos.anvin.org (c-67-169-144-158.hsd1.ca.comcast.net [67.169.144.158])
	(authenticated bits=0)
	by terminus.zytor.com (8.13.8/8.13.8) with ESMTP id l6HNVxdA021209
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
	Tue, 17 Jul 2007 16:32:00 -0700
Received: from tazenda.hos.anvin.org (tazenda.hos.anvin.org [172.27.0.16])
	by mail.hos.anvin.org (8.13.8/8.13.8) with ESMTP id l6HNVxkU006399;
	Tue, 17 Jul 2007 16:31:59 -0700
Received: from tazenda.hos.anvin.org (localhost.localdomain [127.0.0.1])
	by tazenda.hos.anvin.org (8.13.8/8.13.6) with ESMTP id l6HNVvL8005108;
	Tue, 17 Jul 2007 16:31:58 -0700
User-Agent: Thunderbird 2.0.0.0 (X11/20070419)
X-Enigmail-Version: 0.95.0
X-Virus-Scanned: ClamAV 0.88.7/3689/Tue Jul 17 05:02:12 2007 on terminus.zytor.com
X-Virus-Status: Clean
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/52812>

I just got the following email:

> The Git documentation at
> <http://www.kernel.org/pub/software/scm/git/docs/user-manual.html> is
> encoded in ISO 8859-1, but it is being served with a content-type header
> of "text/plain; charset=UTF-8".
> 
> The content-type header overrides the value declared in the <meta> tag
> of the HTML document, so this causes browsers to render the
> documentation incorrectly.
> 
> Apologies if this is a well known issue and you get a lot of mail like
> this BTW, just don't LART me too hard. ;)

The fact that browsers behave this way is of course a bug, but it's a
common one.  Can we switch the documentation over to UTF-8, this is 2007
after all...?

	-hpa
