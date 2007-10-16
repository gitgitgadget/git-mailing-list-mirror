From: "franky" <yinping@kooxoo.com>
Subject: RE: Is there any plan to support partial checkout or submoudule improvement?
Date: Tue, 16 Oct 2007 19:45:59 +0800
Message-ID: <20071016114601.A66DC7E20@mail.kooxoo.com>
References: <8c5c35580710160350h53a7b5c4k374067372d4aac1d@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain;
	charset="US-ASCII"
Content-Transfer-Encoding: 7bit
Cc: <git@vger.kernel.org>
To: "'Lars Hjemli'" <hjemli@gmail.com>
X-From: git-owner@vger.kernel.org Tue Oct 16 13:46:35 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IhksN-0003MX-Ui
	for gcvg-git-2@gmane.org; Tue, 16 Oct 2007 13:46:20 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1759835AbXJPLqH (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 16 Oct 2007 07:46:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1759825AbXJPLqG
	(ORCPT <rfc822;git-outgoing>); Tue, 16 Oct 2007 07:46:06 -0400
Received: from mail.kooxoo.com ([60.28.194.208]:35229 "EHLO mail.kooxoo.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753710AbXJPLqF (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 16 Oct 2007 07:46:05 -0400
Received: from yinping (unknown [124.42.17.129])
	by mail.kooxoo.com (Postfix) with ESMTP id A66DC7E20;
	Tue, 16 Oct 2007 19:46:01 +0800 (CST)
X-Mailer: Microsoft Office Outlook, Build 11.0.5510
In-Reply-To: <8c5c35580710160350h53a7b5c4k374067372d4aac1d@mail.gmail.com>
Thread-Index: AcgP4mFUMxWUvuXeSZWcH7mHcax64wABxDRA
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2900.3198
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/61149>

> The <revspec> can be a tag. So you can easily create a wrapper script
> to allow such things as
> 
> $ ./deploy.sh v1.2.3
> $ ./deploy.sh HEAD
> $ ./deploy.sh master
> $ ./deploy.sh <sha1>
But it is an online services, I must take care, so I prefer the incremental
update to avoid overwriting deployment directory fully each time. Another
consideration, Full update also introduces the busy network traffic.

franky
