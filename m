From: Thomas Braun <thomas.braun@virtuell-zuhause.de>
Subject: Creating empty commits with --intent-to-add
Date: Sat, 4 Jun 2016 19:54:33 +0200
Message-ID: <fdf86f73-0885-7191-2932-f10feba0bdfc@virtuell-zuhause.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
To: GIT Mailing-list <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Sat Jun 04 19:55:19 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1b9Fn1-0005Dh-Cu
	for gcvg-git-2@plane.gmane.org; Sat, 04 Jun 2016 19:55:15 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751071AbcFDRyl (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 4 Jun 2016 13:54:41 -0400
Received: from wp156.webpack.hosteurope.de ([80.237.132.163]:33206 "EHLO
	wp156.webpack.hosteurope.de" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751026AbcFDRyl (ORCPT
	<rfc822;git@vger.kernel.org>); Sat, 4 Jun 2016 13:54:41 -0400
Received: from p4fc87c53.dip0.t-ipconnect.de ([79.200.124.83] helo=[192.168.100.43]); authenticated
	by wp156.webpack.hosteurope.de running ExIM with esmtpsa (TLS1.0:DHE_RSA_AES_128_CBC_SHA1:16)
	id 1b9FmQ-0005Ru-6V; Sat, 04 Jun 2016 19:54:38 +0200
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:45.0) Gecko/20100101
 Thunderbird/45.1.1
X-bounce-key: webpack.hosteurope.de;thomas.braun@virtuell-zuhause.de;1465062880;db7bf0e6;
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/296448>

Hi,

the following procedure

mkdir test
cd test
git init
echo 1 >file
git add --intent-to-add file
git commit -m "blurb"

results in a commit. I would have expected that git commit complains,
as I have not pased the --allow-empty option.

Is that intended behaviour?

Tested with 2.8.3.windows.1 and 2.1.4 on linux.

Thomas
