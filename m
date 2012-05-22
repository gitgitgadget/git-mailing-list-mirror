From: Christian Couder <chriscool@tuxfamily.org>
Subject: Re: [PATCH 2/7] sequencer: release a strbuf used in save_head()
Date: Tue, 22 May 2012 22:30:45 +0200 (CEST)
Message-ID: <20120522.223045.876953043846314069.chriscool@tuxfamily.org>
References: <20120521143309.1911.94302.chriscool@tuxfamily.org>
	<20120521145610.1911.61154.chriscool@tuxfamily.org>
	<20120522141735.GA6660@burratino>
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Cc: gitster@pobox.com, git@vger.kernel.org, artagnon@gmail.com,
	nbowler@elliptictech.com
To: jrnieder@gmail.com
X-From: git-owner@vger.kernel.org Tue May 22 22:31:07 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SWvjO-0004hk-7c
	for gcvg-git-2@plane.gmane.org; Tue, 22 May 2012 22:30:58 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932466Ab2EVUay (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 22 May 2012 16:30:54 -0400
Received: from smtp3-g21.free.fr ([212.27.42.3]:35964 "EHLO smtp3-g21.free.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932374Ab2EVUax (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 22 May 2012 16:30:53 -0400
Received: from localhost (unknown [82.243.130.161])
	by smtp3-g21.free.fr (Postfix) with ESMTP id 523E2A6281;
	Tue, 22 May 2012 22:30:46 +0200 (CEST)
In-Reply-To: <20120522141735.GA6660@burratino>
X-Mailer: Mew version 6.3 on Emacs 23.3 / Mule 6.0 (HANACHIRUSATO)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/198243>

From: Jonathan Nieder <jrnieder@gmail.com>
>
>> +	strbuf_release(&buf);
> 
> Makes good sense.  Actually, I'm not sure why this allocation is
> needed in the first place.  Would something like the following work?

Ok, I will use your patch in the next iteration.

Thanks,
Christian.
