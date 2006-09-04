From: "Martin Langhoff" <martin.langhoff@gmail.com>
Subject: Re: [PATCH] git-repack: clear out tmp packfiles from $PACKDIR instead of cwd
Date: Mon, 4 Sep 2006 17:48:58 +1200
Message-ID: <46a038f90609032248h5eda61dft4150e13e49f8e59e@mail.gmail.com>
References: <11573485362686-git-send-email-martin@catalyst.net.nz>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Cc: junkio@cox.net
X-From: git-owner@vger.kernel.org Mon Sep 04 07:49:08 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1GK7KU-0001v0-LI
	for gcvg-git@gmane.org; Mon, 04 Sep 2006 07:49:07 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932328AbWIDFtD (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 4 Sep 2006 01:49:03 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932331AbWIDFtC
	(ORCPT <rfc822;git-outgoing>); Mon, 4 Sep 2006 01:49:02 -0400
Received: from nf-out-0910.google.com ([64.233.182.185]:28802 "EHLO
	nf-out-0910.google.com") by vger.kernel.org with ESMTP
	id S932328AbWIDFtA (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 4 Sep 2006 01:49:00 -0400
Received: by nf-out-0910.google.com with SMTP id o25so978762nfa
        for <git@vger.kernel.org>; Sun, 03 Sep 2006 22:48:59 -0700 (PDT)
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=Qqzgd2k164G90b9+tDMcPgsnifRfSzqjRAa+cYJKESC0AzCslMnow8VAT2fKqMRhKbCoQOSwXr5+zgb8bRmMTYqXMb/JdxqN2ydBQX8VFR6U/s0GIhKWhWMy8REOtASj0+m9o63KcWkMO/Syw4LLzUIyNUSyrF3ACFAsHchGWRI=
Received: by 10.48.162.15 with SMTP id k15mr6257008nfe;
        Sun, 03 Sep 2006 22:48:58 -0700 (PDT)
Received: by 10.49.6.16 with HTTP; Sun, 3 Sep 2006 22:48:58 -0700 (PDT)
To: git@vger.kernel.org
In-Reply-To: <11573485362686-git-send-email-martin@catalyst.net.nz>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/26400>

On 9/4/06, Martin Langhoff <martin@catalyst.net.nz> wrote:
> Temp packfiles should never be created in cwd anyway ;-)

Note! Applies after "git-repack: create new packs inside $PACKDIR, not cwd"

> VGER BF report: U 0.983488

Hilarious!


m

-- 
VGER BF report: U 0.569396
