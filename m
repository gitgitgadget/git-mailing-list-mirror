From: jeff millar <wa1hco@adelphia.net>
Subject: How stop tracking a file?
Date: Sun, 22 May 2005 12:48:59 -0400
Message-ID: <4290B7FB.5070708@adelphia.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
X-From: git-owner@vger.kernel.org Sun May 22 18:48:12 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DZtcE-00075P-Kc
	for gcvg-git@gmane.org; Sun, 22 May 2005 18:47:50 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261827AbVEVQtC (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 22 May 2005 12:49:02 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261830AbVEVQtC
	(ORCPT <rfc822;git-outgoing>); Sun, 22 May 2005 12:49:02 -0400
Received: from mta10.adelphia.net ([68.168.78.202]:58262 "EHLO
	mta10.adelphia.net") by vger.kernel.org with ESMTP id S261827AbVEVQtA
	(ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 22 May 2005 12:49:00 -0400
Received: from [192.168.2.4] (really [24.52.167.181]) by mta10.adelphia.net
          (InterMail vM.6.01.04.01 201-2131-118-101-20041129) with ESMTP
          id <20050522164859.EFFA17140.mta10.adelphia.net@[192.168.2.4]>
          for <git@vger.kernel.org>; Sun, 22 May 2005 12:48:59 -0400
User-Agent: Mozilla Thunderbird 1.0.2-1.3.3 (X11/20050513)
X-Accept-Language: en-us, en
To: git@vger.kernel.org
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

cg-rm does two things
   rm -f "$@"
   git-update-cache --remove -- "$@"

Does cg support a way to stop tracking a file without deleting it? 
The idea was to cg-init an entire directory (such as /etc/ or some
existing software project) and then selectivly stop tracking files,
such as *.o, selected binaries, ld.so.cache, etc. as they turned up.

thanks,

jeff
