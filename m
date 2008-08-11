From: Matthias Kestenholz <mk@spinlock.ch>
Subject: Re: [PATCH] git-submodule - Add 'foreach' subcommand
Date: Mon, 11 Aug 2008 12:11:32 +0200
Message-ID: <1218449492.21750.2.camel@localhost>
References: <7vsktczebg.fsf@gitster.siamese.dyndns.org>
	 <1218409804-1556-1-git-send-email-mlevedahl@gmail.com>
	 <489FDC29.5090503@iksz.hu>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Cc: Mark Levedahl <mlevedahl@gmail.com>, gitster@pobox.com,
	git@vger.kernel.org, johan@herland.net
To: Balazs Nagy <js@iksz.hu>
X-From: git-owner@vger.kernel.org Mon Aug 11 12:12:52 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KSUOO-0004bc-DR
	for gcvg-git-2@gmane.org; Mon, 11 Aug 2008 12:12:48 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751218AbYHKKLi (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 11 Aug 2008 06:11:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751184AbYHKKLi
	(ORCPT <rfc822;git-outgoing>); Mon, 11 Aug 2008 06:11:38 -0400
Received: from fg-out-1718.google.com ([72.14.220.159]:42360 "EHLO
	fg-out-1718.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751108AbYHKKLh (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 11 Aug 2008 06:11:37 -0400
Received: by fg-out-1718.google.com with SMTP id 19so980523fgg.17
        for <git@vger.kernel.org>; Mon, 11 Aug 2008 03:11:35 -0700 (PDT)
Received: by 10.86.80.5 with SMTP id d5mr7707581fgb.26.1218449495243;
        Mon, 11 Aug 2008 03:11:35 -0700 (PDT)
Received: from ?192.168.1.15? ( [83.78.83.70])
        by mx.google.com with ESMTPS id l19sm8695629fgb.7.2008.08.11.03.11.33
        (version=SSLv3 cipher=RC4-MD5);
        Mon, 11 Aug 2008 03:11:33 -0700 (PDT)
In-Reply-To: <489FDC29.5090503@iksz.hu>
X-Mailer: Evolution 2.22.3.1 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/91925>

On Mon, 2008-08-11 at 08:28 +0200, Balazs Nagy wrote:
> Hi,
> 
> Sorry for being a bit late, but what if we would have --all for all
> submodule commands instead of having another command?
> 
> Rgds,

This would not be very smart. The example in the documentation part of
the patch would be impossible only with --all switches (or, you'd need
to duplicate all git commands in git-submodule instead of reusing them
with git submodule foreach)
