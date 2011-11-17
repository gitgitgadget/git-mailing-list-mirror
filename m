From: Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: [PATCH 3/3] rename git_path() to git_path_unsafe()
Date: Thu, 17 Nov 2011 01:03:07 -0600
Message-ID: <20111117070307.GA18853@elie.hsd1.il.comcast.net>
References: <20111106002645.GE27272@elie.hsd1.il.comcast.net>
 <CALkWK0nGhUshwJM1vmAUhBG9foH+=6+_KFhfTTF6+kNS0Hm2JA@mail.gmail.com>
 <7v7h33oifq.fsf@alter.siamese.dyndns.org>
 <CALkWK0nUuzn2_itdACHLQBpUaVv97tFAjNGdVBEhWC7a6Rp75w@mail.gmail.com>
 <20111115095225.GB23139@elie.hsd1.il.comcast.net>
 <7v7h31wduv.fsf@alter.siamese.dyndns.org>
 <CALkWK0kOrGzjcGNcf2qPahJSgkvCsQwSrEfAA3wj6PqnMzDBVQ@mail.gmail.com>
 <20111116075955.GB13706@elie.hsd1.il.comcast.net>
 <20111116080716.GE13706@elie.hsd1.il.comcast.net>
 <7vzkfvo88i.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Ramkumar Ramachandra <artagnon@gmail.com>,
	Git List <git@vger.kernel.org>,
	=?utf-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41j?= Duy <pclouds@gmail.com>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Nov 17 08:03:29 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RQw0N-0000rO-Rs
	for gcvg-git-2@lo.gmane.org; Thu, 17 Nov 2011 08:03:28 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754785Ab1KQHDX (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 17 Nov 2011 02:03:23 -0500
Received: from mail-gx0-f174.google.com ([209.85.161.174]:59449 "EHLO
	mail-gx0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751709Ab1KQHDW (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 17 Nov 2011 02:03:22 -0500
Received: by ggnb2 with SMTP id b2so675007ggn.19
        for <git@vger.kernel.org>; Wed, 16 Nov 2011 23:03:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        bh=M7ohmRUYG3m958uK0x6i4QGsPK35pGKa27lvZ+FKpfM=;
        b=Mf/Xo31RXSlm27+DwLIIrUT3OwCPqzTEx3/k4U4HIo7Vg9IiYUI11fe6Tu0lVX3G+v
         XqtbpoNyJMXYWh+OqU3RNgwMXXlNHYC9VP6lzFdsLl2uOuvCBkx5vlysYFIdt29/bX+W
         BfAQB8f2jmzO0h5C4ka1RnatOTGM/xxvTMt5E=
Received: by 10.236.184.225 with SMTP id s61mr7134621yhm.80.1321513402284;
        Wed, 16 Nov 2011 23:03:22 -0800 (PST)
Received: from elie.hsd1.il.comcast.net (c-24-1-56-9.hsd1.il.comcast.net. [24.1.56.9])
        by mx.google.com with ESMTPS id b9sm93610763anb.7.2011.11.16.23.03.20
        (version=SSLv3 cipher=OTHER);
        Wed, 16 Nov 2011 23:03:20 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <7vzkfvo88i.fsf@alter.siamese.dyndns.org>
User-Agent: Mutt/1.5.21+46 (b01d63af6fea) (2011-07-01)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/185577>

Junio C Hamano wrote:

> In any case, I do not like seeing many list regulars throwing too many
> non-regression-fix patches during prerelease freeze period on the
> list.

Fine, but what about the buffer overflow (not an incredibly recent
regression, but certainly a fix) addressed in patch 2 of the series?
