From: Pekka Enberg <penberg@gmail.com>
Subject: Re: [PATCH GIT 0.6] make use of register variables & size_t
Date: Mon, 25 Apr 2005 16:07:20 +0300
Message-ID: <84144f02050425060763f92b7@mail.gmail.com>
References: <426CD1F1.2010101@tiscali.de> <20050425123236.GC26665@pasky.ji.cz>
Reply-To: Pekka Enberg <penberg@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Cc: Matthias-Christian Ott <matthias.christian@tiscali.de>,
	Linus Torvalds <torvalds@osdl.org>, git@vger.kernel.org,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
X-From: git-owner@vger.kernel.org Mon Apr 25 15:03:19 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DQ3EM-0007yK-W7
	for gcvg-git@gmane.org; Mon, 25 Apr 2005 15:02:31 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262603AbVDYNHZ (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 25 Apr 2005 09:07:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262605AbVDYNHZ
	(ORCPT <rfc822;git-outgoing>); Mon, 25 Apr 2005 09:07:25 -0400
Received: from wproxy.gmail.com ([64.233.184.192]:61209 "EHLO wproxy.gmail.com")
	by vger.kernel.org with ESMTP id S262603AbVDYNHV convert rfc822-to-8bit
	(ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 25 Apr 2005 09:07:21 -0400
Received: by wproxy.gmail.com with SMTP id 68so1520873wri
        for <git@vger.kernel.org>; Mon, 25 Apr 2005 06:07:21 -0700 (PDT)
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:reply-to:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=iv+TPhuD2/KfpOFmXKNtSjSlzN81aFkXaW0QnFuy3QHLDLLCy+ltZ0yfiKlFYFY1JIlEB3JuPA9bJheNSnnOSM8kALSy4maMaOIjpYrNqpZkU3Nk2IyJM8WVAKtjQXamkZNXBwrvD7/jbVdCRZn2elSCFnovkZQER7vUZUHsiHQ=
Received: by 10.54.23.51 with SMTP id 51mr1911575wrw;
        Mon, 25 Apr 2005 06:07:20 -0700 (PDT)
Received: by 10.54.66.8 with HTTP; Mon, 25 Apr 2005 06:07:20 -0700 (PDT)
To: Petr Baudis <pasky@ucw.cz>
In-Reply-To: <20050425123236.GC26665@pasky.ji.cz>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

Hi,

On 4/25/05, Petr Baudis <pasky@ucw.cz> wrote:
> Honestly, I don't think using the register keyword helps anything but to
> make the code less readable.

Indeed. The use of 'register' keyword blindly can actually make the
generated code _worse_ as it taking away one register from the
compiler's register allocator.

                        Pekka
