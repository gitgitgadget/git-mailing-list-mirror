From: Kai Hendry <hendry@iki.fi>
Subject: Graph sloc tool for git repos
Date: Sat, 12 Mar 2016 19:00:26 +0800
Message-ID: <1457780426.2632189.547083938.25305E83@webmail.messagingengine.com>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Mar 12 12:00:36 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aehHf-0007G7-Ej
	for gcvg-git-2@plane.gmane.org; Sat, 12 Mar 2016 12:00:35 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753326AbcCLLAa (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 12 Mar 2016 06:00:30 -0500
Received: from out4-smtp.messagingengine.com ([66.111.4.28]:35918 "EHLO
	out4-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1753129AbcCLLA1 (ORCPT
	<rfc822;git@vger.kernel.org>); Sat, 12 Mar 2016 06:00:27 -0500
Received: from compute6.internal (compute6.nyi.internal [10.202.2.46])
	by mailout.nyi.internal (Postfix) with ESMTP id 6E94A209B2
	for <git@vger.kernel.org>; Sat, 12 Mar 2016 06:00:26 -0500 (EST)
Received: from web2 ([10.202.2.212])
  by compute6.internal (MEProxy); Sat, 12 Mar 2016 06:00:26 -0500
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed/relaxed; d=
	messagingengine.com; h=content-transfer-encoding:content-type
	:date:from:message-id:mime-version:subject:to:x-sasl-enc
	:x-sasl-enc; s=smtpout; bh=j7DDAViaM4xRSowk5kG6y1ueOr4=; b=Tvysa
	+sKsOGjMqqyUveodGTIR37Rf1BxjaJt9vxBQOXfFvHAcjHWrL609GhubFqgO63aG
	wEbH2MMnqwCXW4DHtR0JUwrIHDn7QIAf2nEz7HA7syPqXVwLpw+B9Vci7QQQDq/2
	CPpYYo2ZDROrMqDGPVLeSgxFwQdTj9I9Yf4q+c=
Received: by web2.nyi.internal (Postfix, from userid 99)
	id 40337540A84; Sat, 12 Mar 2016 06:00:26 -0500 (EST)
X-Sasl-Enc: QdrMg3/VP59baQjxOm5Ha3ZHOYCoF2RE4bN/Ne36R18P 1457780426
X-Mailer: MessagingEngine.com Webmail Interface - ajax-da7163a6
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/288748>

Hi there,

I penned a script to plot SLOC of a git project using GNUplot & I
thought the fastest way to count code fluctuations was via `git show
--numstat`.

However that requires some awk counting of the lines:
https://github.com/kaihendry/graphsloc/blob/5f31e388e9b655e1801f13885f4311d221663a19/collect-stats.sh#L32

Is there a better way I missed? I think there is bug since my graph was
a factor of 10 out whilst graphing Linux:
https://twitter.com/kaihendry/status/706627679924174848

(Though the shape looks right)

Good news it's generating graphs for smaller projects just fine:
http://s.natalian.org/2016-03-12/dwm-3465bed.csv.svg

Anyway, would love to get your feedback on
https://github.com/kaihendry/graphsloc

Kind regards from Petaling Jaya,
