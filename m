From: Timo Hirvonen <tihirvon@gmail.com>
Subject: Re: [PATCH] compress output of `cd' when installing templates
Date: Sun, 21 May 2006 18:54:21 +0300
Message-ID: <20060521185421.a91bf118.tihirvon@gmail.com>
References: <83mzdbjshd.fsf@skypiea.yi.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun May 21 17:52:48 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FhqEX-0008Fp-IY
	for gcvg-git@gmane.org; Sun, 21 May 2006 17:52:45 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964887AbWEUPwP (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 21 May 2006 11:52:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964889AbWEUPwP
	(ORCPT <rfc822;git-outgoing>); Sun, 21 May 2006 11:52:15 -0400
Received: from nf-out-0910.google.com ([64.233.182.185]:9682 "EHLO
	nf-out-0910.google.com") by vger.kernel.org with ESMTP
	id S964887AbWEUPwP (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 21 May 2006 11:52:15 -0400
Received: by nf-out-0910.google.com with SMTP id c31so301989nfb
        for <git@vger.kernel.org>; Sun, 21 May 2006 08:52:13 -0700 (PDT)
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:date:from:to:cc:subject:message-id:in-reply-to:references:x-mailer:mime-version:content-type:content-transfer-encoding;
        b=qe0zTgqhUovAhpHAEVBC6SCBP7acx1PYIBUxaq4K8cSEB/xwuaxtZGqBb8UY0FElNaO/ctUHCtwxVW+uzzyaEZmqAKDDsRdA8pKq+l0zjiGJLe7BR9tparCOJUN6nvHz9DNURRIBNxLDr6W6RbGrbIFxsnyIjJW37JSBifjDrbA=
Received: by 10.49.78.6 with SMTP id f6mr3031359nfl;
        Sun, 21 May 2006 08:52:13 -0700 (PDT)
Received: from garlic.home.net ( [82.128.200.31])
        by mx.gmail.com with ESMTP id d2sm3961869nfe.2006.05.21.08.52.12;
        Sun, 21 May 2006 08:52:12 -0700 (PDT)
To: Gang Chen <goncha.ml@gmail.com>
In-Reply-To: <83mzdbjshd.fsf@skypiea.yi.org>
X-Mailer: Sylpheed version 2.2.3 (GTK+ 2.8.17; i686-pc-linux-gnu)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/20453>

Gang Chen <goncha.ml@gmail.com> wrote:

> When CDPATH is set in Bash, `cd' writes new working directory to
> stdout, which corrupts output of `tar cf - .'.

Fix bash instead, or just don't export CDPATH.  It is used by bash only
so exporting it is unnecessary.

-- 
http://onion.dynserv.net/~timo/
