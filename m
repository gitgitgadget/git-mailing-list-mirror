From: Jorge Bastos <mysql.jorge@decimal.pt>
Subject: RE: Newbie to git
Date: Tue, 29 Dec 2009 12:11:40 +0000
Message-ID: <d1d7541ccb528f0345ad2bf15faa8570@192.168.1.222>
References: <1435.87.196.47.196.1261932152.squirrel@webmail.decimal.pt>	 <3a9710ae6b01fabf3b462da607af2534@192.168.1.222>	 <26ae428a0912271212j70857e29m6248f6ec653f7551@mail.gmail.com>	 <0a78ff1d3ae5d236fa45c31f7bb8bd54@192.168.1.222>	 <m27hs8t5b7.fsf@whitebox.home> <540FAB030B18B14B8E672DB4B500635B1769FFD879@UABEXMBS6.ad.uab.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Cc: <git@vger.kernel.org>
To: Shantanu Pavgi <pavgi@uab.edu>
X-From: git-owner@vger.kernel.org Tue Dec 29 13:11:08 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NPaup-00060C-5q
	for gcvg-git-2@lo.gmane.org; Tue, 29 Dec 2009 13:11:07 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751322AbZL2MLA (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 29 Dec 2009 07:11:00 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751237AbZL2MLA
	(ORCPT <rfc822;git-outgoing>); Tue, 29 Dec 2009 07:11:00 -0500
Received: from mailrly03.isp.novis.pt ([195.23.133.213]:46157 "EHLO
	mailrly03.isp.novis.pt" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751051AbZL2MLA (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 29 Dec 2009 07:11:00 -0500
Received: (qmail 20476 invoked from network); 29 Dec 2009 12:10:57 -0000
Received: from unknown (HELO mailfrt14.isp.novis.pt) ([195.23.133.223])
          (envelope-sender <mysql.jorge@decimal.pt>)
          by mailrly03.isp.novis.pt with compressed SMTP; 29 Dec 2009 12:10:57 -0000
Received: (qmail 6268 invoked from network); 29 Dec 2009 12:10:57 -0000
Received: from unknown (HELO web.decimal.pt) (Sent_by_authenticated_user_nm087018@[195.23.114.74])
          (envelope-sender <mysql.jorge@decimal.pt>)
          by mailfrt14.isp.novis.pt with SMTP; 29 Dec 2009 12:10:57 -0000
Received: from webmail.decimal.pt (localhost [127.0.0.1])
	by web.decimal.pt (Postfix) with ESMTP id 406A0EB68;
	Tue, 29 Dec 2009 12:11:41 +0000 (WET)
In-Reply-To: <540FAB030B18B14B8E672DB4B500635B1769FFD879@UABEXMBS6.ad.uab.edu>
X-Sender: mysql.jorge@decimal.pt
User-Agent: RoundCube Webmail
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/135792>

> I remember having similar problem. I think it is with the user
> permissions. Check if the 'push-user' has read-write permissions on
public
> repo. Check out  '--shared' option while initializing bare repo 
(git-init
> --bare) or set appropriate permissions using chown/chmod. Hope this
helps..

Bingo!

Thank you,
Jorge,
