From: "Avery Pennarun" <apenwarr@gmail.com>
Subject: Re: question about git and remote repositories
Date: Tue, 8 Apr 2008 16:24:03 -0400
Message-ID: <32541b130804081324q7555aff5ia123512db014e24f@mail.gmail.com>
References: <47FBC2C9.6060702@tikalk.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: "Ittay Dror" <ittayd@tikalk.com>
X-From: git-owner@vger.kernel.org Tue Apr 08 22:25:22 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JjKNU-0002wj-QF
	for gcvg-git-2@gmane.org; Tue, 08 Apr 2008 22:25:13 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754415AbYDHUYI (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 8 Apr 2008 16:24:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752299AbYDHUYH
	(ORCPT <rfc822;git-outgoing>); Tue, 8 Apr 2008 16:24:07 -0400
Received: from fg-out-1718.google.com ([72.14.220.157]:42047 "EHLO
	fg-out-1718.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753847AbYDHUYG (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 8 Apr 2008 16:24:06 -0400
Received: by fg-out-1718.google.com with SMTP id l27so2035678fgb.17
        for <git@vger.kernel.org>; Tue, 08 Apr 2008 13:24:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        bh=smKaswwCiq2pWyXXPdQgUOHvKh+9a7y0gapELjn327M=;
        b=QF/3KViDaNCLkDMuiM13aT7eQIoq3F7yQrbFD4E2TI0V5pXlY9vVNcB/vQIKfNrC4IC/8BpWBluzJ22Ae8vfYryaIaaL9sbtgoSfwmXNva7di+B//ckZCOma11WXxYFBu6eMFSeVUn5sAMVl6EBGk7ka/wO5XLtW1u92q55zrws=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=wt3ynBSKy0ABfQVLineh73axPFtHvKxx8D6qKvm9q8zq/wQWG/SRsyyky5pKDTEIOawxmaGk6BjzTgM2Irk/OMkhcT5jwaiM++rckoITsy4mViQ2DG77bPA/LRyAmX9GbB88GVdxXOZj1w+59KJYDw0kXGjWrv7jt0L/VU3CN+E=
Received: by 10.82.159.2 with SMTP id h2mr10645496bue.33.1207686243151;
        Tue, 08 Apr 2008 13:24:03 -0700 (PDT)
Received: by 10.82.100.5 with HTTP; Tue, 8 Apr 2008 13:24:03 -0700 (PDT)
In-Reply-To: <47FBC2C9.6060702@tikalk.com>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/79024>

On Tue, Apr 8, 2008 at 3:08 PM, Ittay Dror <ittayd@tikalk.com> wrote:
> For example, as far as
> I understand, if all I want is to get the latest commit in HEAD, branch from
> it and start working, then all git really needs to have is all objects
> referenced from that commit (commit, trees, blobs) and that's it, right? (as
> long as I don't expect to see full log of past operations)

It can be quite addictive to have the entire revision history of the
entire project sitting locally on your disk.  Once you've tried it,
it's hard to go back. :)

But if you still want only the last few revisions, try using the
--depth option to git-clone.

Have fun,

Avery
