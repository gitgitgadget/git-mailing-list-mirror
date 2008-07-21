From: "Jay Soffian" <jaysoffian@gmail.com>
Subject: Re: [RFC variant 2 of 2] "needs update" considered harmful
Date: Mon, 21 Jul 2008 13:27:21 -0400
Message-ID: <76718490807211027t45082c7fs3509c4b9abb571d8@mail.gmail.com>
References: <7vtzelf4mf.fsf@gitster.siamese.dyndns.org>
	 <7v7ibhdmii.fsf@gitster.siamese.dyndns.org>
	 <20080720112957.GE32184@machine.or.cz>
	 <alpine.DEB.1.00.0807201435450.3305@eeepc-johanness>
	 <7v4p6k73s2.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Cc: "Johannes Schindelin" <Johannes.Schindelin@gmx.de>,
	"Petr Baudis" <pasky@suse.cz>, git@vger.kernel.org
To: "Junio C Hamano" <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon Jul 21 19:28:24 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KKzBP-0002rS-Le
	for gcvg-git-2@gmane.org; Mon, 21 Jul 2008 19:28:24 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750875AbYGUR1W (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 21 Jul 2008 13:27:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750784AbYGUR1W
	(ORCPT <rfc822;git-outgoing>); Mon, 21 Jul 2008 13:27:22 -0400
Received: from yx-out-2324.google.com ([74.125.44.29]:11611 "EHLO
	yx-out-2324.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750763AbYGUR1W (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 21 Jul 2008 13:27:22 -0400
Received: by yx-out-2324.google.com with SMTP id 8so249335yxm.1
        for <git@vger.kernel.org>; Mon, 21 Jul 2008 10:27:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from:to
         :subject:cc:in-reply-to:mime-version:content-type
         :content-transfer-encoding:content-disposition:references;
        bh=d3W6tX/fwLa0d821nR0l82yZl4GgSbxmm4bq7HWXI8g=;
        b=bjq4iMRfvLptmpUBwIkgMXyWSVLOdyZBfO4IORxMIHtF3Yio3pnBPYH4ftimHcLLR9
         jvpZcfimVx2+qZdZ7Qq0bEXqXOu8wlx1OFhC+jPb00py+ibxqTBiqCkff43659p88nfo
         RacWBxz4BighAwsb27FeuyaAV3/pvNriSCZXE=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:to:subject:cc:in-reply-to:mime-version
         :content-type:content-transfer-encoding:content-disposition
         :references;
        b=xUuOxck/AU1YlHINHT2E4G71bUljCcsZvz7CEST6Y/KMWVb0is9pvYUus9GILmpVvv
         vOOokLzrWB1omHJHZrnO3BZ0zUhIlL25Cj+CdoToLwFNq2B3nx7XPPibShP+C4mWUV/P
         zlX9V5NokdJgM9qeAGeUe6A1eco/ZM8pMOAP0=
Received: by 10.150.145.20 with SMTP id s20mr4090358ybd.242.1216661241077;
        Mon, 21 Jul 2008 10:27:21 -0700 (PDT)
Received: by 10.150.149.15 with HTTP; Mon, 21 Jul 2008 10:27:21 -0700 (PDT)
In-Reply-To: <7v4p6k73s2.fsf@gitster.siamese.dyndns.org>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/89369>

On Sun, Jul 20, 2008 at 3:29 PM, Junio C Hamano <gitster@pobox.com> wrote:
> I personally think there is nothing wrong if Porcelain and plumbing use
> different languages, by the way.

Do you expect such a clean separation? That a given command is either
plumbing or porcelain but never both? If not, then a command might
want to emit different output depending upon context. Perhaps an
environment variable, along the lines of how one sets locale on Unix,
could indicate to a git command whether it running as plumbing or not.

Just a thought.

j.
