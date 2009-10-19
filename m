From: =?UTF-8?Q?Daniel?= <mjucde@o2.pl>
Subject: =?UTF-8?Q?Which_dates_'git_log_--since=3D_--after=3D'_compare=3F?=
Date: Mon, 19 Oct 2009 12:01:49 +0200
Message-ID: <4c067ee1.a34185.4adc390d.a980c@o2.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Oct 19 12:02:05 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Mzp3z-0005dI-AD
	for gcvg-git-2@lo.gmane.org; Mon, 19 Oct 2009 12:02:03 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754592AbZJSKBr (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 19 Oct 2009 06:01:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754549AbZJSKBr
	(ORCPT <rfc822;git-outgoing>); Mon, 19 Oct 2009 06:01:47 -0400
Received: from mailout1.go2.pl ([193.17.41.11]:38001 "EHLO mailout1.go2.pl"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752512AbZJSKBr convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 19 Oct 2009 06:01:47 -0400
Received: from mailout1.go2.pl (unknown [10.0.0.103])
	by mailout1.go2.pl (Postfix) with ESMTP id CB8F75D514C
	for <git@vger.kernel.org>; Mon, 19 Oct 2009 12:01:50 +0200 (CEST)
Received: from o2.pl (unknown [10.0.0.67])
	by mailout1.go2.pl (Postfix) with SMTP
	for <git@vger.kernel.org>; Mon, 19 Oct 2009 12:01:50 +0200 (CEST)
X-Originator: 153.19.128.10
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/130687>

Hi,

I can see that 'git log --since= --after=' compares commit's dates,
not author's dates.How can I limit commits by Author's date?

$ git log --format="%aD %cD"

Mon, 5 Oct 2009 14:54:57 +0200 Thu, 8 Oct 2009 10:31:40 +0200
Mon, 21 Sep 2009 11:11:35 +0200 Thu, 8 Oct 2009 10:31:40 +0200
Mon, 21 Sep 2009 10:14:41 +0200 Thu, 8 Oct 2009 10:31:40 +0200
Wed, 16 Sep 2009 14:23:30 +0200 Thu, 8 Oct 2009 10:31:40 +0200
Wed, 16 Sep 2009 10:27:39 +0200 Thu, 8 Oct 2009 10:31:38 +0200
Wed, 16 Sep 2009 09:15:32 +0200 Thu, 8 Oct 2009 10:30:31 +0200
Wed, 16 Sep 2009 08:02:23 +0200 Wed, 16 Sep 2009 09:02:29 +0200

$ git log --format="%aD %cD" --since=2009-09-01 --until=2009-10-01
Wed, 16 Sep 2009 08:02:23 +0200 Wed, 16 Sep 2009 09:02:29 +0200

-- 
Daniel
