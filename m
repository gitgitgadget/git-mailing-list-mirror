From: Thomas Braun <thomas.braun@virtuell-zuhause.de>
Subject: [PATCH 0/2] completion: add git status
Date: Wed, 1 Jun 2016 01:41:28 +0200
Message-ID: <91038037-d835-74bd-e976-946d2dd36c02@virtuell-zuhause.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-15
Content-Transfer-Encoding: 7bit
Cc: Ramkumar Ramachandra <artagnon@gmail.com>,
	Junio C Hamano <gitster@pobox.com>,
	John Keeping <john@keeping.me.uk>,
	=?UTF-8?Q?SZEDER_G=c3=a1bor?= <szeder@ira.uka.de>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Jun 01 02:05:15 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1b7tes-0003ZQ-AZ
	for gcvg-git-2@plane.gmane.org; Wed, 01 Jun 2016 02:05:14 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756736AbcFAAFI (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 31 May 2016 20:05:08 -0400
Received: from wp156.webpack.hosteurope.de ([80.237.132.163]:44556 "EHLO
	wp156.webpack.hosteurope.de" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752711AbcFAAFH (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 31 May 2016 20:05:07 -0400
Received: from p4fc87c53.dip0.t-ipconnect.de ([79.200.124.83] helo=[192.168.100.43]); authenticated
	by wp156.webpack.hosteurope.de running ExIM with esmtpsa (TLS1.0:DHE_RSA_AES_128_CBC_SHA1:16)
	id 1b7tML-00085v-Ti; Wed, 01 Jun 2016 01:46:05 +0200
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:45.0) Gecko/20100101
 Thunderbird/45.1.1
X-bounce-key: webpack.hosteurope.de;thomas.braun@virtuell-zuhause.de;1464739506;8b008815;
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/296040>

Hi,

I was suprised to learn that git status does not get completed for bash.

So I thought this has to change, see the following patches.

Thomas Braun (2):
  completion: create variable for untracked file modes
  completion: add git status

 contrib/completion/git-completion.bash | 33
++++++++++++++++++++++++++++++++-
 1 file changed, 32 insertions(+), 1 deletion(-)

-- 
2.8.3.windows.1
