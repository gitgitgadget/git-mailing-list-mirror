From: Timo Hirvonen <tihirvon@gmail.com>
Subject: Re: Autoconf/Automake
Date: Thu, 15 Jun 2006 02:18:32 +0300
Message-ID: <20060615021832.4f07a694.tihirvon@gmail.com>
References: <1150324030.23268.12.camel@dv>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Jun 15 01:18:23 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1Fqecw-0003eW-AA
	for gcvg-git@gmane.org; Thu, 15 Jun 2006 01:18:22 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965013AbWFNXST (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 14 Jun 2006 19:18:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965026AbWFNXST
	(ORCPT <rfc822;git-outgoing>); Wed, 14 Jun 2006 19:18:19 -0400
Received: from nf-out-0910.google.com ([64.233.182.188]:60627 "EHLO
	nf-out-0910.google.com") by vger.kernel.org with ESMTP
	id S965013AbWFNXSS (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 14 Jun 2006 19:18:18 -0400
Received: by nf-out-0910.google.com with SMTP id g2so155410nfe
        for <git@vger.kernel.org>; Wed, 14 Jun 2006 16:18:17 -0700 (PDT)
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:date:from:to:cc:subject:message-id:in-reply-to:references:x-mailer:mime-version:content-type:content-transfer-encoding;
        b=RAAoA7d9dPdlqCy5S5l/0SRL4tjoMcA67XT/HRxTSXruYP6GQKCiCE6l25Zb/MfSnTsrDuPOsurC/nwWwJOXEmGs3IRbm8WVpQOPFprXmJcsVYzjNwHz4+22gnAbkMQG+9Js53arksvWudCEEGxWYNxj10NeeNcOPlmHxwzyW9I=
Received: by 10.49.68.20 with SMTP id v20mr949155nfk;
        Wed, 14 Jun 2006 16:18:17 -0700 (PDT)
Received: from garlic.home.net ( [82.128.201.71])
        by mx.gmail.com with ESMTP id k9sm1203871nfc.2006.06.14.16.18.16;
        Wed, 14 Jun 2006 16:18:17 -0700 (PDT)
To: proski@gnu.org
In-Reply-To: <1150324030.23268.12.camel@dv>
X-Mailer: Sylpheed version 2.2.6 (GTK+ 2.8.18; i686-pc-linux-gnu)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/21872>

Pavel Roskin <proski@gnu.org> wrote:

> Hello!
> 
> Is there any interest in converting the build system used by git to
> Autoconf and Automake?  The ad-hoc configuration in Makefile is getting
> too big.  As for nice features like remembering $prefix, wouldn't it be
> better to add them to Automake instead of limiting them to just one
> project?
> 
> Other goodies from Automake are "make distcheck" and automatic
> dependency tracking.  Compatibility with non-GNU make could earn us some
> respect from BSD folks.
> 
> I converted several projects to the GNU build system, including qgit.
> It may be hard to get right, but then it just works for any
> configuration without giving any trouble.

Autotools almost drove me crazy so I had to write my own configure
system:

   http://onion.dynserv.net/~timo/tconf.html

It is really easy to use and quite flexible.</shameless plug>

Personally I don't think git needs autoconf/tconf/whatever. The current
makefile is good enough.

-- 
http://onion.dynserv.net/~timo/
