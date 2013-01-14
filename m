From: =?UTF-8?B?6YOR5paH6L6JKFRlY2hsaXZlIFpoZW5nKQ==?= 
	<techlivezheng@gmail.com>
Subject: Re: [PATCH/RFC 4/7] contrib/subtree: Code cleaning and refactoring
Date: Mon, 14 Jan 2013 11:30:02 +0800
Message-ID: <CAPYzjrTWJL_FeJVAzSm8fYn7Xw7XW35jLwQCNN+cGzGPO7kM9w@mail.gmail.com>
References: <1358041958-1998-1-git-send-email-techlivezheng@gmail.com> <1358041958-1998-5-git-send-email-techlivezheng@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Cc: apenwarr@gmail.com, greened@obbligato.org,
	Techlive Zheng <techlivezheng@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Jan 14 04:31:15 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TualT-0006AL-5r
	for gcvg-git-2@plane.gmane.org; Mon, 14 Jan 2013 04:31:11 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754736Ab3ANDao (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 13 Jan 2013 22:30:44 -0500
Received: from mail-vb0-f50.google.com ([209.85.212.50]:35610 "EHLO
	mail-vb0-f50.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754137Ab3ANDan (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 13 Jan 2013 22:30:43 -0500
Received: by mail-vb0-f50.google.com with SMTP id ft2so3100834vbb.23
        for <git@vger.kernel.org>; Sun, 13 Jan 2013 19:30:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        bh=uSWyIS8XccpT7fnqpqvrvQsmxL9E8+fvYMC2PzVk65s=;
        b=Rz9LKtbUny6Pserb8IDh37Th8CdLcHngJWGnFfuN4TFJoZ9br0BJUObe+5AC2Lzx21
         0P/pi+TZ2MqO7JLfVzvxIzYp0kQgMU/edD0gR2P++2CwNhB3DDBZOowlDp5IOvSoCGP+
         qSbj/ulLI0kgZ/wUq6H5d3Z/TAEGoFKFLoDGTZ8ZumRjFucCfXxGRIX42hCqRAiX7gwA
         tGEgnTVjwOXVQyagoYALbtv66z1EAlaRGnt33m87T2CfPBt+ujc3WyCVtUSz6AGET3kN
         XjoJVEHPe/D3AISE9KHsJvEO9jFimva+5ifzRjzKPE4sDbuFTCBtLoJ8hkxd4sjRWpKd
         1f7A==
Received: by 10.52.16.17 with SMTP id b17mr87872411vdd.86.1358134242727; Sun,
 13 Jan 2013 19:30:42 -0800 (PST)
Received: by 10.58.106.48 with HTTP; Sun, 13 Jan 2013 19:30:02 -0800 (PST)
In-Reply-To: <1358041958-1998-5-git-send-email-techlivezheng@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/213420>

2013/1/13 Techlive Zheng <techlivezheng@gmail.com>:
> Mostly prepare for the later tests refactoring.
>
> Signed-off-by: Techlive Zheng <techlivezheng@gmail.com>

I am personally a SP-indenting guy, I did not aware of Git's indenting
policy until now, so it is bad that I replaced all the lines initially
indent using HT with SP in the test file of this commit. I will submit
another set of patches with the right indenting.
