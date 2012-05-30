From: Felipe Contreras <felipe.contreras@gmail.com>
Subject: 'git merge tag' not working as before
Date: Wed, 30 May 2012 20:06:15 +0200
Message-ID: <CAMP44s1bry3=W8hJPP9mJLzHmXFZug58aimGHhCSzwS9+Q-yWw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed May 30 20:06:53 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SZnIK-0002IW-0m
	for gcvg-git-2@plane.gmane.org; Wed, 30 May 2012 20:06:52 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757322Ab2E3SGS (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 30 May 2012 14:06:18 -0400
Received: from mail-lpp01m010-f46.google.com ([209.85.215.46]:56040 "EHLO
	mail-lpp01m010-f46.google.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1757311Ab2E3SGR (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 30 May 2012 14:06:17 -0400
Received: by lahd3 with SMTP id d3so77755lah.19
        for <git@vger.kernel.org>; Wed, 30 May 2012 11:06:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:date:message-id:subject:from:to:content-type;
        bh=PKFOtej8zJp12BT7pZgBqugXMFMZXBo9T2FLEMO2ojs=;
        b=cH9tsrEKcg29IJs/+qWsHoXPbyYa8D8VhRjNzqgIyttv29ZSPMAxHZ6ymnOSQrY13q
         j8GC1rUGKk6x78dFqLMesIAGZIPLN2LuCWynApoiVLmBaakh34ZlsNJFR+whP4KcWRzw
         5PLkyP08YylMgqaS0IkRvmr6kr8IT81f8hy/GH+ejXNtkCOIa7SyzmqS7lgXJpftA/O+
         s+Yz875wRPC+MEbtvcqWmmAhcXSybn4A++CFgvQLNxkUQ4YXwTKVH8DA+6flXzxGOPIg
         xhTBB1f0ccIAqEBCmzIOff9EbdBKHXE44zxXnkMTlGt9Y4m99jhh2v/it6Zf79mXXOM7
         fZXQ==
Received: by 10.152.112.138 with SMTP id iq10mr16679936lab.13.1338401175703;
 Wed, 30 May 2012 11:06:15 -0700 (PDT)
Received: by 10.112.107.65 with HTTP; Wed, 30 May 2012 11:06:15 -0700 (PDT)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/198828>

Hi,

I used to do things like 'git merge v1.7.10.3' (from v1.7.10.2) but
even though it's ff it tries to create a merge commit.

Seems like now I have to run 'git merge v1.7.10.3^0', I don't see why
that would be desirable.

I think this is a bug and a regression.

Cheers.

-- 
Felipe Contreras
