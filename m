From: Lex Spoon <lex@lexspoon.org>
Subject: Re: [PATCHv2 3/3] git-p4: fixing --changes-block-size handling
Date: Mon, 8 Jun 2015 12:36:48 -0400
Message-ID: <CALM2Snb9nxT9_shhsGBJ6nuSOninKbKC-+GXKwmd=rkuLuLXzw@mail.gmail.com>
References: <55747A05.3070704@diamand.org>
	<1433712905-7508-1-git-send-email-luke@diamand.org>
	<1433712905-7508-4-git-send-email-luke@diamand.org>
	<CALM2SnZShkETQoQuNc8e0GsPWzODQACzwjh1qCGeajiN+5sjaw@mail.gmail.com>
	<xmqqk2vecho1.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Luke Diamand <luke@diamand.org>, Git Users <git@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon Jun 08 18:37:12 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Z202t-0002a3-7h
	for gcvg-git-2@plane.gmane.org; Mon, 08 Jun 2015 18:37:07 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753319AbbFHQhF (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 8 Jun 2015 12:37:05 -0400
Received: from mail-pa0-f43.google.com ([209.85.220.43]:32964 "EHLO
	mail-pa0-f43.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753241AbbFHQgt (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 8 Jun 2015 12:36:49 -0400
Received: by padev16 with SMTP id ev16so43679323pad.0
        for <git@vger.kernel.org>; Mon, 08 Jun 2015 09:36:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:sender:in-reply-to:references:date:message-id:subject
         :from:to:cc:content-type;
        bh=u0kR2nkZHGcWlIu6nK2w2MQ+E6rKWOtflxk3DleFf3U=;
        b=qweDtk1QM71NDKHduXROu36BhOBOWGn9KdimP6ux65Jk9P3cPHBnG0pBlZoC8j6Cpk
         sB68prx8/xftcl/Zt0RXFYuphHlyKuV1DycXSlpuGv7YSVJtpHdRd9woP9qeGssBfySM
         M6DzgyDiM6UaUq/jejoi4ZXOO4lnaZSNPcUiTnWHbG2yG9MkVXfqLd9fE4T3geBDqaMt
         9erILw2BydQ8wDZZUZczf22cbQymePg5fif/wOicwZN6TWlHIbi+pPfYQkVdBQ6bO7Kv
         K6wJzb1OUSrbS+kTPJGwaledI8A9Tat6lYuEk0OPI0dphnb0+ZAJdaHDZGO9koVqhtVg
         D33g==
X-Received: by 10.66.222.103 with SMTP id ql7mr30597595pac.144.1433781408977;
 Mon, 08 Jun 2015 09:36:48 -0700 (PDT)
Received: by 10.70.25.132 with HTTP; Mon, 8 Jun 2015 09:36:48 -0700 (PDT)
In-Reply-To: <xmqqk2vecho1.fsf@gitster.dls.corp.google.com>
X-Google-Sender-Auth: ZGmuudD1s_U28eouGHbrAkHDktE
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/271070>

Precisely, Junio, that's what I had in mind. The patch with the two
lines deleted LGTM.
