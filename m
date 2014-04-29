From: Felipe Contreras <felipe.contreras@gmail.com>
Subject: Re: Reference to a commit inside a commit message
Date: Tue, 29 Apr 2014 02:57:30 -0500
Message-ID: <535f5b6a41ff6_45e485b3087b@nysa.notmuch>
References: <20140428183552.GA9709@workstation.Belkin>
 <20140429034128.GD11979@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: 7bit
To: Jeff King <peff@peff.net>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Apr 29 10:08:17 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Wf35M-0002sf-59
	for gcvg-git-2@plane.gmane.org; Tue, 29 Apr 2014 10:08:16 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756160AbaD2III (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 29 Apr 2014 04:08:08 -0400
Received: from mail-ob0-f176.google.com ([209.85.214.176]:62727 "EHLO
	mail-ob0-f176.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756115AbaD2IIF (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 29 Apr 2014 04:08:05 -0400
Received: by mail-ob0-f176.google.com with SMTP id wp4so8406489obc.7
        for <git@vger.kernel.org>; Tue, 29 Apr 2014 01:08:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=date:from:to:message-id:in-reply-to:references:subject:mime-version
         :content-type:content-transfer-encoding;
        bh=yRReNhSjLZxo2ahUharNAFi+7iJAUSOz59JZBbu4z+c=;
        b=u7yBmwIJfYyiT20NQL0e1VEJsvQlZi9qT4gsTCMN3j348Nvv4k60Augx6B3HeK/Rmr
         GvBF+ERnLVOZM0bY57dFmvIBrnB7c2OgXSgd/PTeAZ6W4499CQQOscwa8YVFrgVYq0wn
         4ZOgGmIzbhWKeiRssRWxXKaMGKkMPfuA5z/vLgBFAAh3C7587xB0RmIOZuSSKSNm81p6
         uCmtDm+bUQEHUj0K7GNlPcMQqAe/gyPMEpWUdbpW31gxORs8rdOYOzCZCWlvoBD/6ZUO
         GvJ4bDwfZJOv+6ucAnqoLKSz+b6IadABHNkqfWqZn0OF3oJPyeKSsf5JEHQETudSHRxL
         Gz0w==
X-Received: by 10.60.37.166 with SMTP id z6mr26468089oej.22.1398758884082;
        Tue, 29 Apr 2014 01:08:04 -0700 (PDT)
Received: from localhost (189-211-224-40.static.axtel.net. [189.211.224.40])
        by mx.google.com with ESMTPSA id bj8sm42491426obb.7.2014.04.29.01.08.02
        for <multiple recipients>
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 29 Apr 2014 01:08:03 -0700 (PDT)
In-Reply-To: <20140429034128.GD11979@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/247528>

Jeff King wrote:

> [1] I do not know about others, but I typically cut and paste from
>     another terminal, and use the following alias in my config:
> 
>       [alias]
>       ll = "!git --no-pager log -1 --pretty='tformat:%h (%s, %ad)' --date=short"

I have:

  [alias]
  short = show --quiet --format='%C(auto)%h (%s)%C(reset)'

-- 
Felipe Contreras
