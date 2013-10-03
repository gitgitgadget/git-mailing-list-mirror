From: Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: [PATCH] Documentation/Makefile: make AsciiDoc dblatex dir
 configurable
Date: Thu, 3 Oct 2013 12:20:59 -0700
Message-ID: <20131003192059.GB9464@google.com>
References: <6c148f88f6efb7c5d7a9a03f8383b47f939b36ec.1380827852.git.john@keeping.me.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Miklos Vajna <vmiklos@suse.cz>
To: John Keeping <john@keeping.me.uk>
X-From: git-owner@vger.kernel.org Thu Oct 03 21:21:11 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VRoSU-00087I-0d
	for gcvg-git-2@plane.gmane.org; Thu, 03 Oct 2013 21:21:10 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754853Ab3JCTVG (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 3 Oct 2013 15:21:06 -0400
Received: from mail-pa0-f49.google.com ([209.85.220.49]:47891 "EHLO
	mail-pa0-f49.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754562Ab3JCTVE (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 3 Oct 2013 15:21:04 -0400
Received: by mail-pa0-f49.google.com with SMTP id ld10so3045863pab.36
        for <git@vger.kernel.org>; Thu, 03 Oct 2013 12:21:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        bh=sAUZqiXmlO7zThvxfLmZjpTms8Z91jFIBSyP5457k68=;
        b=baCA0TcaGKeqsplBNeAcmx8+H+VNsUayxDIl25gls2CsvWYetXympUSsA1+jLmqPy+
         Nzur8Y0CkOmh7lXxssyfTcShhVjtxTXgLSPyz38NjzehRN3be1mYoSCTonjR21ypZZpP
         nevhi38+prfQNW1kJuxO/w/kq6o1xPbUDDKB48xVlXLv5r03a+u+RZOzzq5xcaMLINsB
         8kgg1JPbdfg12phWyqWHq6ybQRuMPTjQG4lWqS1Kld8Vp7XWO0qMVCve3DBdoR3NQllE
         VPBkYD+HkbvieFlC3oHUycDD1ZyL2dFXQ1VBDuldBy5tCNUR6mG62VDV+EEYqNRSk4vY
         8c6A==
X-Received: by 10.68.13.104 with SMTP id g8mr10347853pbc.33.1380828063539;
        Thu, 03 Oct 2013 12:21:03 -0700 (PDT)
Received: from google.com ([2620:0:1000:5b00:b6b5:2fff:fec3:b50d])
        by mx.google.com with ESMTPSA id kd1sm12523604pab.20.1969.12.31.16.00.00
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Thu, 03 Oct 2013 12:21:02 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <6c148f88f6efb7c5d7a9a03f8383b47f939b36ec.1380827852.git.john@keeping.me.uk>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/235691>

John Keeping wrote:

> On my system this is in /usr/share/asciidoc/dblatex not
> /etc/asciidoc/dblatex.  Extract this portion of the path to a variable
> so that is can be set in config.mak.
>
> Signed-off-by: John Keeping <john@keeping.me.uk>

Thanks.  Looks good.
