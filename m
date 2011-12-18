From: Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: [PATCHv2 02/11] git-p4: test debug macro
Date: Sat, 17 Dec 2011 21:26:17 -0600
Message-ID: <20111218032238.GA6368@elie.hsd1.il.comcast.net>
References: <1324147942-21558-1-git-send-email-pw@padd.com>
 <1324147942-21558-3-git-send-email-pw@padd.com>
 <4EED1B06.80007@diamand.org>
 <20111218013651.GA18735@padd.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Luke Diamand <luke@diamand.org>, git@vger.kernel.org
To: Pete Wyckoff <pw@padd.com>
X-From: git-owner@vger.kernel.org Sun Dec 18 04:26:52 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Rc7Om-0008Jp-1T
	for gcvg-git-2@lo.gmane.org; Sun, 18 Dec 2011 04:26:52 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751430Ab1LRD0b (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 17 Dec 2011 22:26:31 -0500
Received: from mail-gy0-f174.google.com ([209.85.160.174]:45690 "EHLO
	mail-gy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751315Ab1LRD03 (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 17 Dec 2011 22:26:29 -0500
Received: by ghbz12 with SMTP id z12so3026242ghb.19
        for <git@vger.kernel.org>; Sat, 17 Dec 2011 19:26:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        bh=6uIAp2IoUNGGTScoPqHtnWzUVjWgWIumSdD3Wg0eVM4=;
        b=g0vb/ppnIxmuVXHFK+R9HcgPYprHliO9gjOuBm9MZfSKVqcsOV5AYSA/VyXtuNKAli
         jOp0sRdM7TGiAOrx91EiOfOKsJRx6ZklZXeyCBHvpghQphDn6GNuydpS3Hs2VJlWy722
         cIn+Pz53x1rux3MD4ZKT1UtRXmkT1EbK2LhfI=
Received: by 10.236.152.102 with SMTP id c66mr73587yhk.75.1324178789356;
        Sat, 17 Dec 2011 19:26:29 -0800 (PST)
Received: from elie.hsd1.il.comcast.net (c-24-1-56-9.hsd1.il.comcast.net. [24.1.56.9])
        by mx.google.com with ESMTPS id w68sm22435710yhe.14.2011.12.17.19.26.27
        (version=SSLv3 cipher=OTHER);
        Sat, 17 Dec 2011 19:26:28 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <20111218013651.GA18735@padd.com>
User-Agent: Mutt/1.5.21+51 (9e756d1adb76) (2011-07-01)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/187411>

Pete Wyckoff wrote:

> +	# 2 is SIGINT, ash/dash does not know symbolic names
> +	trap echo 2

'trap "$cmd" INT' works, and it's even in POSIX. ;)
http://pubs.opengroup.org/onlinepubs/9699919799/utilities/V3_chap02.html#trap
