From: Michele Ballabio <barra_cuda@katamail.com>
Subject: Re: git-cherry-pick no longer detecting moved files in 1.5.3.4
Date: Wed, 17 Oct 2007 00:35:12 +0200
Message-ID: <200710170035.12482.barra_cuda@katamail.com>
References: <cac9e4380710161517m64ba737dj8711a6ce59b1b69@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Cc: "Richard Quirk" <richard.quirk@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Oct 17 00:31:43 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Ihuwa-0003c6-Ie
	for gcvg-git-2@gmane.org; Wed, 17 Oct 2007 00:31:21 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965867AbXJPWbJ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 16 Oct 2007 18:31:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965762AbXJPWbI
	(ORCPT <rfc822;git-outgoing>); Tue, 16 Oct 2007 18:31:08 -0400
Received: from slim-3c.inet.it ([213.92.5.125]:55715 "EHLO slim-3c.inet.it"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S965707AbXJPWbH (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 16 Oct 2007 18:31:07 -0400
Received: from host160-57-static.104-80-b.business.telecomitalia.it ([::ffff:80.104.57.160]) by slim-3c.inet.it via I-SMTP-5.4.4-547
	id ::ffff:80.104.57.160+wXWuLOUJib8; Wed, 17 Oct 2007 00:31:03 +0200
User-Agent: KMail/1.9.7
In-Reply-To: <cac9e4380710161517m64ba737dj8711a6ce59b1b69@mail.gmail.com>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/61268>

On Wednesday 17 October 2007, Richard Quirk wrote:
> I tried setting diff.renamelimit to -1 but to no
> avail.

It should be 
diff.renamelimit = 0

to set the "unlimited" limit.
