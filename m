From: Karsten Blees <karsten.blees@gmail.com>
Subject: Re: [PATCH] environment: enable core.preloadindex by default
Date: Mon, 02 Jun 2014 22:01:43 +0200
Message-ID: <538CD827.5020607@gmail.com>
References: <CACbrTHdoA3UgoXOMVeB2ST_y-JzA2FZM7s8_uwG8C3D29WZK=Q@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
To: Steve Hoelzer <shoelzer@gmail.com>, git <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Mon Jun 02 22:01:49 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WrYQW-0007KW-SM
	for gcvg-git-2@plane.gmane.org; Mon, 02 Jun 2014 22:01:49 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752543AbaFBUBp (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 2 Jun 2014 16:01:45 -0400
Received: from mail-wi0-f178.google.com ([209.85.212.178]:64769 "EHLO
	mail-wi0-f178.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751640AbaFBUBo (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 2 Jun 2014 16:01:44 -0400
Received: by mail-wi0-f178.google.com with SMTP id cc10so5306359wib.17
        for <git@vger.kernel.org>; Mon, 02 Jun 2014 13:01:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=message-id:date:from:user-agent:mime-version:to:subject:references
         :in-reply-to:content-type:content-transfer-encoding;
        bh=0VomPf2Al4ETxJ/LxeZxdodcGznBqF9n9D5Fh6hGvkY=;
        b=D8LGcZvkY/g0PCSNUKXKgpazfPFLeOYB3j3D7QRpiOVxCfYEV+R/kFne/Qy7kMWYXP
         xRBa9T3N0T+ihUUKiHx4z9jMhHauBDU4YmcZE3bz/ZEOxcCpsEfZHIRezYPe4N9gCwsv
         YXpk8ZkezmXNirYUPafN7NdMBeLMf3JhkESUlCwEPq8vru6Ps26xaAmWuyggnhtdDMvd
         gGbHL1HGSDcSLmYASm1e2uUR752xZ6+yId6nKtCA5HdZ9IX3zphU4Sdj9P9GukXNRu4/
         eAvIb6kBvF+Smy3I09UBhSJkk/1FpQowvpG2GvK++lw/TxOaYlAcMNJbMnHFTodfsGNT
         GKvw==
X-Received: by 10.180.76.6 with SMTP id g6mr25277708wiw.34.1401739303406;
        Mon, 02 Jun 2014 13:01:43 -0700 (PDT)
Received: from [10.1.116.52] (ns.dcon.de. [77.244.111.149])
        by mx.google.com with ESMTPSA id l2sm35223305wix.13.2014.06.02.13.01.42
        for <multiple recipients>
        (version=TLSv1 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Mon, 02 Jun 2014 13:01:42 -0700 (PDT)
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:24.0) Gecko/20100101 Thunderbird/24.5.0
In-Reply-To: <CACbrTHdoA3UgoXOMVeB2ST_y-JzA2FZM7s8_uwG8C3D29WZK=Q@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/250590>

Am 02.06.2014 18:43, schrieb Steve Hoelzer:
> There is consensus that the default should change because it will
> benefit nearly all users (some just a little, but some a lot).
> See [1] and replies.

Git for Windows users may want to try core.fscache=true as well [1]. This eliminates the UAC penalties for repositories located on the Windows system drive [2].

[1] https://github.com/msysgit/git/pull/94
[2] https://code.google.com/p/msysgit/issues/detail?id=320
