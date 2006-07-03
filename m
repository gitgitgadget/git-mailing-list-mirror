From: "Alex Riesen" <raa.lkml@gmail.com>
Subject: Re: Compression speed for large files
Date: Mon, 3 Jul 2006 14:03:43 +0200
Message-ID: <81b0412b0607030503p63b4ee31v7776bd155d3dab29@mail.gmail.com>
References: <loom.20060703T124601-969@post.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Jul 03 14:04:28 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FxN9X-00069a-OO
	for gcvg-git@gmane.org; Mon, 03 Jul 2006 14:03:48 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750947AbWGCMDp (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 3 Jul 2006 08:03:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751129AbWGCMDp
	(ORCPT <rfc822;git-outgoing>); Mon, 3 Jul 2006 08:03:45 -0400
Received: from ug-out-1314.google.com ([66.249.92.170]:2499 "EHLO
	ug-out-1314.google.com") by vger.kernel.org with ESMTP
	id S1750947AbWGCMDo (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 3 Jul 2006 08:03:44 -0400
Received: by ug-out-1314.google.com with SMTP id m3so1459817ugc
        for <git@vger.kernel.org>; Mon, 03 Jul 2006 05:03:43 -0700 (PDT)
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=P0uV2Lx0ZNfeL3ng+1l5W0LkOilLOw0mLpM/Hj2OyZcZPhHS4gyf9oJXz7MAvN+Jb5Fz4xZPYg30PrDUdk1MpKUXQPBKpq0p8R0qWNK5T/H6Rt0fxyIcKx3EZYf2Dj2JQr9MxErb8E7DwZfEF0uutvfUYiaXXpnxUhMbts++eOQ=
Received: by 10.78.167.12 with SMTP id p12mr2278681hue;
        Mon, 03 Jul 2006 05:03:43 -0700 (PDT)
Received: by 10.78.37.7 with HTTP; Mon, 3 Jul 2006 05:03:43 -0700 (PDT)
To: "Joachim B Haga" <cjhaga@fys.uio.no>
In-Reply-To: <loom.20060703T124601-969@post.gmane.org>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/23172>

On 7/3/06, Joachim B Haga <cjhaga@fys.uio.no> wrote:
> So: is it a good idea to change to faster compression, at least for larger
> files? From my (limited) testing I would suggest using Z_BEST_COMPRESSION only
> for small files (perhaps <1MB?) and Z_DEFAULT_COMPRESSION/Z_BEST_SPEED for
> larger ones.

Probably yes, as a per-repo config option.
