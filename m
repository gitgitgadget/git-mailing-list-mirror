From: Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: git: Wrong parsing of ssh urls with IPv6 literals ignores port
Date: Tue, 12 Jun 2012 15:29:53 -0500
Message-ID: <20120612202953.GG9764@burratino>
References: <20111022001704.3115.87464.reportbug@hejmo>
 <20120610090516.GA30177@burratino>
 <4FD78EA0.2090306@lsrfire.ath.cx>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Eduardo =?utf-8?Q?Tr=C3=A1pani?= <etrapani@gmail.com>,
	git@vger.kernel.org, YOSHIFUJI Hideaki <yoshfuji@linux-ipv6.org>
To: =?utf-8?B?UmVuw6k=?= Scharfe <rene.scharfe@lsrfire.ath.cx>
X-From: git-owner@vger.kernel.org Tue Jun 12 22:30:07 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SeXj1-0000Or-2P
	for gcvg-git-2@plane.gmane.org; Tue, 12 Jun 2012 22:30:03 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752463Ab2FLU37 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 12 Jun 2012 16:29:59 -0400
Received: from mail-gg0-f174.google.com ([209.85.161.174]:64605 "EHLO
	mail-gg0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751729Ab2FLU36 convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 12 Jun 2012 16:29:58 -0400
Received: by gglu4 with SMTP id u4so3816452ggl.19
        for <git@vger.kernel.org>; Tue, 12 Jun 2012 13:29:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=x+Ph1o18UUeItX4Z0Xwo9ceRCW7NjpVODOfpPgOonQ4=;
        b=DpTUjCGY7nDS9eew4KQwcmyYjIQgQohZ9iiJ5Cevpm+KAH4BY3/cVXg3uT/ZcbiT5t
         zXJYrG+1wnMDrjzc9jNpuNmTQdsHfYU2Wk/pviE9RSF3P2Z8j/jn1FXl7cS92YNvtvQP
         3rpOwPdkJkNI9bR5G4EcLchw6yHtulzg7qdJLAP7ctjcxGxviowuK1P0ExAHRDcBf1JF
         BABqL3tDCsIesBpREr5JU40k0rJcFKLAtkZw/NVhJy9qO+jk7KpJxlu9fHMlMpjrg8AW
         vdeqgn+sQFFWg+XrJPXf0sOVoiT1OcbrTuuCEv16fMvAhd3A1tD3uRMjL87iQKNY8LFA
         EHDw==
Received: by 10.236.173.135 with SMTP id v7mr29055075yhl.19.1339532998115;
        Tue, 12 Jun 2012 13:29:58 -0700 (PDT)
Received: from burratino (cl-1372.chi-02.us.sixxs.net. [2001:4978:f:55b::2])
        by mx.google.com with ESMTPS id g22sm1357305yhh.20.2012.06.12.13.29.56
        (version=SSLv3 cipher=OTHER);
        Tue, 12 Jun 2012 13:29:57 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <4FD78EA0.2090306@lsrfire.ath.cx>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/199849>

Ren=C3=A9 Scharfe wrote:

> How about this instead?

Looks good to me.  Though it would be nice to see

	proto://[::1]trailing-nonsense/

diagnosed on top, too.
