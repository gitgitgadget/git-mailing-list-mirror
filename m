From: "Alex Riesen" <raa.lkml@gmail.com>
Subject: Re: CFT: merge-recursive in C (updated)
Date: Wed, 28 Jun 2006 16:27:01 +0200
Message-ID: <81b0412b0606280727k2f4d5c26m5d37f2835821c93b@mail.gmail.com>
References: <81b0412b0606270848v2253209aw52466de632ab25c1@mail.gmail.com>
	 <Pine.LNX.4.63.0606271830210.29667@wbgn013.biozentrum.uni-wuerzburg.de>
	 <20060627223249.GA8177@steel.home>
	 <81b0412b0606280234x7d07fbbck7887b5214d98bf91@mail.gmail.com>
	 <Pine.LNX.4.63.0606281202360.29667@wbgn013.biozentrum.uni-wuerzburg.de>
	 <81b0412b0606280435t70ac9957jae2c4d1c10b7681d@mail.gmail.com>
	 <Pine.LNX.4.63.0606281342290.29667@wbgn013.biozentrum.uni-wuerzburg.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Jun 28 16:28:05 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1Fvb0p-0006Eu-Gp
	for gcvg-git@gmane.org; Wed, 28 Jun 2006 16:27:27 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161303AbWF1O1H (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 28 Jun 2006 10:27:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161259AbWF1O1H
	(ORCPT <rfc822;git-outgoing>); Wed, 28 Jun 2006 10:27:07 -0400
Received: from ug-out-1314.google.com ([66.249.92.173]:15668 "EHLO
	ug-out-1314.google.com") by vger.kernel.org with ESMTP
	id S1161303AbWF1O1E (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 28 Jun 2006 10:27:04 -0400
Received: by ug-out-1314.google.com with SMTP id a2so3125841ugf
        for <git@vger.kernel.org>; Wed, 28 Jun 2006 07:27:02 -0700 (PDT)
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=We2qvsZLlvCjMaMh/+um1oJksPwTOXF7jCQHhdtn8bqQBqDFJ5BtXYoPRFVVMcLOY0cs6PG1JEVxUo4nfyUZCBrSKqtHlJtId7CuKT1dySvawxUjyoooOuVOFf+SwhJYX028h1TYcvfa0pcJhHOLORt1FuJQZ84K0VnBH3X6QF4=
Received: by 10.78.122.11 with SMTP id u11mr391486huc;
        Wed, 28 Jun 2006 07:27:01 -0700 (PDT)
Received: by 10.78.37.7 with HTTP; Wed, 28 Jun 2006 07:27:01 -0700 (PDT)
To: "Johannes Schindelin" <Johannes.Schindelin@gmx.de>
In-Reply-To: <Pine.LNX.4.63.0606281342290.29667@wbgn013.biozentrum.uni-wuerzburg.de>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/22808>

On 6/28/06, Johannes Schindelin <Johannes.Schindelin@gmx.de> wrote:
>
> > What stands out next is getRenames (to be renamed into get_renames), a
> > little profiling shows that the renames lists are the culprit this time
> > too.
>
> In my attempts, the path_list did not contain paths, but structs
> containing a path and a void pointer. I think I will resurrect this idea
> for the renames.
>

What was the pointer for?
