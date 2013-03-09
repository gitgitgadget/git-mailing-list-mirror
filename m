From: Fredrik Gustafsson <iveqy@iveqy.com>
Subject: Re: [PATCH] Replace strcmp_icase with strequal_icase
Date: Sat, 9 Mar 2013 09:57:13 +0100
Message-ID: <20130309085713.GA23639@paksenarrion.iveqy.com>
References: <1362818574-16873-1-git-send-email-iveqy@iveqy.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: gitster@pobox.com, git@vger.kernel.org, pclouds@gmail.com
To: Fredrik Gustafsson <iveqy@iveqy.com>
X-From: git-owner@vger.kernel.org Sat Mar 09 09:57:19 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UEFaf-00051W-FU
	for gcvg-git-2@plane.gmane.org; Sat, 09 Mar 2013 09:57:17 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755917Ab3CII4v convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sat, 9 Mar 2013 03:56:51 -0500
Received: from mail-la0-f51.google.com ([209.85.215.51]:39925 "EHLO
	mail-la0-f51.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755273Ab3CII4u (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 9 Mar 2013 03:56:50 -0500
Received: by mail-la0-f51.google.com with SMTP id fo13so2472213lab.38
        for <git@vger.kernel.org>; Sat, 09 Mar 2013 00:56:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=x-received:sender:date:from:to:cc:subject:message-id:references
         :mime-version:content-type:content-disposition
         :content-transfer-encoding:in-reply-to:user-agent;
        bh=qlwKb3VK+9oJ/ncwJTaoXnE6rINyI/WeyjpVW9R5ddc=;
        b=IvZ3s2alE0XrGBUAIfOcOvaxFzuUXyUz6AqVE43zG/pL81gN03y4gKDT/zRK+greXB
         F3wwbe2cBpLyU1loJ9yGxtrM1wTs9DKCUhj/wuovUqNKl33RORlBriwaqb9NWclI6WPP
         H42hSGpW4jAfGKV7c4p4M8YNjNosmLJ6BPN6PTf1lhmMeJlwwJAof/lU8TKb2DWj0Y8i
         i4YUTogVnvd7M3TgHxpc9yxVtJfvC6+3Au2y8FdYX2GeEYqlZ//d/bjXMdiuIUI+iWsc
         p7VZEUj8As7lWyjaH7H63EqBjywWTQSoqa4EpYaeNVXLE5vd6KIByC1P8jHic+hfvare
         sYVw==
X-Received: by 10.152.144.105 with SMTP id sl9mr4554080lab.4.1362819409309;
        Sat, 09 Mar 2013 00:56:49 -0800 (PST)
Received: from paksenarrion.iveqy.com (c83-250-233-181.bredband.comhem.se. [83.250.233.181])
        by mx.google.com with ESMTPS id j2sm2416299lbd.16.2013.03.09.00.56.47
        (version=TLSv1 cipher=RC4-SHA bits=128/128);
        Sat, 09 Mar 2013 00:56:48 -0800 (PST)
Received: from iveqy by paksenarrion.iveqy.com with local (Exim 4.72)
	(envelope-from <iveqy@paksenarrion.iveqy.com>)
	id 1UEFab-00069T-2h; Sat, 09 Mar 2013 09:57:13 +0100
Content-Disposition: inline
In-Reply-To: <1362818574-16873-1-git-send-email-iveqy@iveqy.com>
User-Agent: Mutt/1.5.20 (2009-06-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/217714>

Please ignore last e-mail. Sorry for the disturbance.

--=20
Med v=E4nliga h=E4lsningar
=46redrik Gustafsson

tel: 0733-608274
e-post: iveqy@iveqy.com
