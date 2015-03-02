From: shawn wilson <ag4ve.us@gmail.com>
Subject: Move commits not in origin to a branch
Date: Mon, 2 Mar 2015 08:25:58 -0500
Message-ID: <CAH_OBicENXL967L4LubDzrqq2qxuZSqye3o6SPAq6oKM0=94Og@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
To: Git List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Mon Mar 02 14:26:29 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YSQMd-00015j-Vf
	for gcvg-git-2@plane.gmane.org; Mon, 02 Mar 2015 14:26:28 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752705AbbCBN0W (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 2 Mar 2015 08:26:22 -0500
Received: from mail-yh0-f54.google.com ([209.85.213.54]:43124 "EHLO
	mail-yh0-f54.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750824AbbCBN0V (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 2 Mar 2015 08:26:21 -0500
Received: by yhab6 with SMTP id b6so14514011yha.10
        for <git@vger.kernel.org>; Mon, 02 Mar 2015 05:26:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:from:date:message-id:subject:to:content-type;
        bh=qeGBOBlNLJi0p87ZStdbpY/PO8L3cvToC30DHkWI5oA=;
        b=BzdjSf9RoTjs9uLzqAjoC1P3AYYZ0KGTx7YfNqqreHBF6N+St9zwbAMQ3ObGReQ13f
         fTNr1QOvgtoHKuu3COx3R9MpFvQQuHMkN4b9Z1fRj4+Xglv31084aGsrn5aTI2xouvd4
         pC80jKkWGADgf8beR3hKuMt67khTJuKZ30inAj4N4WGdqpRl1QLfc6C6JLRV0h86IGYK
         W1DLcWohDm73qetVmL0rPHsYRivvcaSK500WLD6lqO2864e1Ub2FzC2qvLMMW8KgaPvs
         aeNfPLgXtV+LuBBLY34j1qDWggjt/vL8ODoGOCoeiDoTtGQhGudIdBZ3NRNEFeAB6qxA
         UTjw==
X-Received: by 10.170.121.204 with SMTP id n195mr27372523ykb.14.1425302778878;
 Mon, 02 Mar 2015 05:26:18 -0800 (PST)
Received: by 10.170.205.210 with HTTP; Mon, 2 Mar 2015 05:25:58 -0800 (PST)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/264593>

How do I move commits I haven't pushed into a new branch?

 % git log origin..master --pretty=format:'%h'
f7d3a19
1f186c9
66d99f6

Which I'd like to be in a new branch.
