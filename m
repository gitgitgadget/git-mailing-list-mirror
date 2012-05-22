From: Christian Couder <chriscool@tuxfamily.org>
Subject: Re: [PATCH 1/7] sequencer: fix leaked todo_list memory
Date: Tue, 22 May 2012 22:24:31 +0200 (CEST)
Message-ID: <20120522.222431.25966410445815006.chriscool@tuxfamily.org>
References: <20120521143309.1911.94302.chriscool@tuxfamily.org>
	<20120521145610.1911.87598.chriscool@tuxfamily.org>
	<20120521205701.GD28331@burratino>
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Cc: gitster@pobox.com, git@vger.kernel.org, artagnon@gmail.com,
	nbowler@elliptictech.com
To: jrnieder@gmail.com
X-From: git-owner@vger.kernel.org Tue May 22 22:24:52 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SWvdM-00071a-H8
	for gcvg-git-2@plane.gmane.org; Tue, 22 May 2012 22:24:44 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932495Ab2EVUYk (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 22 May 2012 16:24:40 -0400
Received: from smtp3-g21.free.fr ([212.27.42.3]:36580 "EHLO smtp3-g21.free.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932296Ab2EVUYj (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 22 May 2012 16:24:39 -0400
Received: from localhost (unknown [82.243.130.161])
	by smtp3-g21.free.fr (Postfix) with ESMTP id A29D1A60F2;
	Tue, 22 May 2012 22:24:32 +0200 (CEST)
In-Reply-To: <20120521205701.GD28331@burratino>
X-Mailer: Mew version 6.3 on Emacs 23.3 / Mule 6.0 (HANACHIRUSATO)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/198240>

From: Jonathan Nieder <jrnieder@gmail.com>
> 
> So for what it's worth, I like this change as long as it is done
> consistently (meaning "in all code paths that return from the
> function, not just the success case").

Ok, I will do that.

Thanks,
Christian.
