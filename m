From: <com.git-scm@io7m.com>
Subject: Re: What's "wrong" with this fast-import?
Date: Mon, 14 Dec 2015 16:20:38 +0000
Organization: io7m.com
Message-ID: <20151214162038.23aaa1ab@viper.int.arc7.info>
References: <20151212192540.4ba49fea@viper.int.arc7.info>
	<1449968019-9570-1-git-send-email-szeder@ira.uka.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: SZEDER =?UTF-8?B?R8OhYm9y?= <szeder@ira.uka.de>
X-From: git-owner@vger.kernel.org Mon Dec 14 17:26:25 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1a8VxB-0005V8-16
	for gcvg-git-2@plane.gmane.org; Mon, 14 Dec 2015 17:26:25 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752909AbbLNQ0O convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 14 Dec 2015 11:26:14 -0500
Received: from ftx-008-i703.relay.mailchannels.net ([50.61.143.3]:42573 "EHLO
	ftx-008-i703.relay.mailchannels.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752796AbbLNQ0M convert rfc822-to-8bit
	(ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 14 Dec 2015 11:26:12 -0500
X-Greylist: delayed 318 seconds by postgrey-1.27 at vger.kernel.org; Mon, 14 Dec 2015 11:26:11 EST
X-Sender-Id: wwwh|x-authuser|com.git-scm+io7m.com@bs3-dallas.accountservergroup.com
Received: from relay.mailchannels.net (localhost [127.0.0.1])
	by relay.mailchannels.net (Postfix) with ESMTP id 5E9125067;
	Mon, 14 Dec 2015 16:20:51 +0000 (UTC)
Received: from bs3-dallas.accountservergroup.com (ip-10-220-9-73.us-west-2.compute.internal [10.220.9.73])
	by relay.mailchannels.net (Postfix) with ESMTPA id 69F5C50B4;
	Mon, 14 Dec 2015 16:20:50 +0000 (UTC)
X-Sender-Id: wwwh|x-authuser|com.git-scm+io7m.com@bs3-dallas.accountservergroup.com
Received: from bs3-dallas.accountservergroup.com (bs3-dallas.accountservergroup.com [10.205.13.55])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA)
	by 0.0.0.0:2500 (trex/5.6.1);
	Mon, 14 Dec 2015 16:20:51 +0000
X-MC-Relay: Neutral
X-MailChannels-SenderId: wwwh|x-authuser|com.git-scm+io7m.com@bs3-dallas.accountservergroup.com
X-MailChannels-Auth-Id: wwwh
X-MC-Loop-Signature: 1450110050552:225325364
X-MC-Ingress-Time: 1450110050552
Received: from dsl78-143-196-24.in-addr.fast.co.uk ([78.143.196.24]:53214 helo=viper.int.arc7.info)
	by bs3-dallas.accountservergroup.com with esmtpsa (TLSv1:AES128-SHA:128)
	(Exim 4.85)
	(envelope-from <com.git-scm@io7m.com>)
	id 1a8Vrl-0001KU-7O; Mon, 14 Dec 2015 10:20:49 -0600
In-Reply-To: <1449968019-9570-1-git-send-email-szeder@ira.uka.de>
X-AuthUser: com.git-scm+io7m.com@bs3-dallas.accountservergroup.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/282369>

On 2015-12-13T01:53:39 +0100
SZEDER G=C3=A1bor <szeder@ira.uka.de> wrote:

> All changes
> compared to the first parent (i.e. the addition of that new readme fi=
le
> on the side branch) have to be listed explicitly.
>=20

Apologies for the delay: Thanks for this!

It seems that this issue was actually unintentionally fixed in newer
versions of Fossil, but the schema of repositories created with older
versions had to be updated in order to actually get the benefits of the
fix.

M
