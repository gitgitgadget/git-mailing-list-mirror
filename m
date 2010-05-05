From: Alexander Iljin <ajsoft@yandex.ru>
Subject: Re: Strange git crashing problem
Date: Wed, 5 May 2010 11:22:29 +0700
Message-ID: <634021795.20100505112229@yandex.ru>
References: <89030B4A18ECCD45978A3A6B639D1F2403374EF348@FL01EXMB01.trad.tradestation.com>
Reply-To: =?utf-8?B?0JDQu9C10LrRgdCw0L3QtNGAINCY0LvRjNC40L0=?= 
	  <ajsoft@yandex.ru>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: "git@vger.kernel.org" <git@vger.kernel.org>
To: John Dlugosz <JDlugosz@TradeStation.com>
X-From: git-owner@vger.kernel.org Wed May 05 06:22:54 2010
connect(): No such file or directory
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1O9W8L-0002wR-LS
	for gcvg-git-2@lo.gmane.org; Wed, 05 May 2010 06:22:54 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750904Ab0EEEWs convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 5 May 2010 00:22:48 -0400
Received: from forward15.mail.yandex.net ([95.108.130.119]:60135 "EHLO
	forward15.mail.yandex.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750792Ab0EEEWr (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 5 May 2010 00:22:47 -0400
Received: from smtp14.mail.yandex.net (smtp14.mail.yandex.net [95.108.131.192])
	by forward15.mail.yandex.net (Yandex) with ESMTP id D5AD0445939C;
	Wed,  5 May 2010 08:22:45 +0400 (MSD)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yandex.ru; s=mail;
	t=1273033365; bh=Asel3gnGlo9e/mcUZwuQicHWFFrpB6TNUlqJJOKZp/w=;
	h=Date:From:Reply-To:Message-ID:To:CC:Subject:In-Reply-To:
	 References:MIME-Version:Content-Type:Content-Transfer-Encoding;
	b=qobm16yaATd2sZQj7y25mqwcQrwLa9sIOkbgKgMO7AsbLWdsIXZjC34Xp71VANwZ5
	 JShKA2sJA/41dipFpLshNDAAEEwMXId0B+LEa2+Cy2cRGWauRxCDu1pd3xdwR5g86v
	 bDqCRpuVLdCSEqohEL/oxqpsDrx6YElvzgMoQRYc=
Received: from h88-115-218.sibinet.com (unknown [88.204.115.218])
	by smtp14.mail.yandex.net (Yandex) with ESMTPA id 837C619B808B;
	Wed,  5 May 2010 08:22:45 +0400 (MSD)
X-Priority: 3 (Normal)
In-Reply-To: <89030B4A18ECCD45978A3A6B639D1F2403374EF348@FL01EXMB01.trad.tradestation.com>
X-Yandex-TimeMark: 1273033365
X-Yandex-Spam: 1
X-Yandex-Front: smtp14.mail.yandex.net
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/146370>

Hello!

JD> I'm trying to do an interactive rebase, and after editing the
JD> todo file, the git process just hangs.=A0 I was doing that a lot Fr=
iday and it worked fine.

  There is a known problem similar to yours. Try to do the rebase with
  your current folder being the root of the repo. It is known to fail
  when you do it from a subfolder.

---=3D=3D=3D=3D=3D---
 Alexander
