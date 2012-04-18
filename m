From: Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: [PATCH 2/2] var doc: advertise current DEFAULT_PAGER and
 DEFAULT_EDITOR settings
Date: Wed, 18 Apr 2012 15:02:15 -0500
Message-ID: <20120418200215.GB30558@burratino>
References: <20120330002543.2138.91961.reportbug@localhost6.localdomain6>
 <20120330005523.GA28519@burratino>
 <7v398qq1ei.fsf@alter.siamese.dyndns.org>
 <20120331084015.GC4119@burratino>
 <20120331084453.GE4119@burratino>
 <7v1uo8k64l.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: "Rodrigo Silva (MestreLion)" <linux@rodrigosilva.com>,
	git@vger.kernel.org, Ben Walton <bwalton@artsci.utoronto.ca>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Apr 18 22:02:49 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SKb5O-0000sC-Dl
	for gcvg-git-2@plane.gmane.org; Wed, 18 Apr 2012 22:02:42 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755007Ab2DRUCX (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 18 Apr 2012 16:02:23 -0400
Received: from mail-yx0-f174.google.com ([209.85.213.174]:35325 "EHLO
	mail-yx0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754215Ab2DRUCV (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 18 Apr 2012 16:02:21 -0400
Received: by yenl12 with SMTP id l12so3972045yen.19
        for <git@vger.kernel.org>; Wed, 18 Apr 2012 13:02:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        bh=Y6a26wsQZMAmQsRn0LuvGZSnhGu+sJUca40kLwamy5M=;
        b=gN7+jH4t5LX4H6gBbXt6mGbHzlKY2oxGrcHn8K8IWkFbNzS26yB0CbWFACdU5eNbxe
         7geY/ymtodOgrjVFD/5gqzfi4p/4GVL4VQsyBvZQ2hJ6nVNjWp3YEKzvhn+1hhq/jx56
         Zuny01S4vdrmuJJZEG7OaCEzhVH5zUxaghR6qtyByJ98t8RBCBNI/cWejS+V4StcEQ9X
         uZXgqZ9qjqRpyP7im7a/XMz2A2G4TtGxxyw03gNqzxnxMDBpI/aRpp7Obztuv5WJzjZY
         nA3paQd9nnLT1kgsI/9LlqQIeEksfuJevrdmY8oTdvy0xKbgQ6iVBxCpZqa2XNDPS4/T
         RzfA==
Received: by 10.60.4.170 with SMTP id l10mr4851623oel.67.1334779341012;
        Wed, 18 Apr 2012 13:02:21 -0700 (PDT)
Received: from burratino (c-24-1-56-9.hsd1.il.comcast.net. [24.1.56.9])
        by mx.google.com with ESMTPS id b6sm27997783obe.12.2012.04.18.13.02.19
        (version=SSLv3 cipher=OTHER);
        Wed, 18 Apr 2012 13:02:20 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <7v1uo8k64l.fsf@alter.siamese.dyndns.org>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/195892>

Hi Junio,

Junio C Hamano wrote:

> something like:
>
> 	... then the default chosen at compile time, which is usually 'vi'.
> ifdef::git-default-editor[]
> 	The build you are using chose '{git-default-editor}' as the default.
> endif::git-default-editor[]
>
> may be less confusing.

I was not sure if this text would interrupt the flow of reading
before, but I couldn't think of a good alternative so I didn't say
anything.  Sorry about that.  Now I've looked at the built result and
think the new text is good. :)

Thanks,
Jonathan
