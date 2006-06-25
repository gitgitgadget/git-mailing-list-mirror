From: Timo Hirvonen <tihirvon@gmail.com>
Subject: Re: [PATCH 0/7] Rework diff options
Date: Sun, 25 Jun 2006 14:13:07 +0300
Message-ID: <20060625141307.7f007881.tihirvon@gmail.com>
References: <20060624201843.a5b4f7b9.tihirvon@gmail.com>
	<7vslltopzg.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org, Johannes.Schindelin@gmx.de
X-From: git-owner@vger.kernel.org Sun Jun 25 13:13:21 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FuSYI-00047P-NG
	for gcvg-git@gmane.org; Sun, 25 Jun 2006 13:13:19 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932365AbWFYLNM (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 25 Jun 2006 07:13:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932363AbWFYLNM
	(ORCPT <rfc822;git-outgoing>); Sun, 25 Jun 2006 07:13:12 -0400
Received: from nf-out-0910.google.com ([64.233.182.188]:22228 "EHLO
	nf-out-0910.google.com") by vger.kernel.org with ESMTP
	id S932362AbWFYLNK (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 25 Jun 2006 07:13:10 -0400
Received: by nf-out-0910.google.com with SMTP id m19so460273nfc
        for <git@vger.kernel.org>; Sun, 25 Jun 2006 04:13:09 -0700 (PDT)
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:date:from:to:cc:subject:message-id:in-reply-to:references:x-mailer:mime-version:content-type:content-transfer-encoding;
        b=cSODIYt7sn6kMu/0RRSYNxElwn3wUpltE+hB509gyCSy70NSi/+DB4SPGazf2KauxmXIW4SWl7APMdKpRqwMh1p2d6pIdPsh685CzGY2TnZBvCEhmgP6RrILfWTO3/TauMJPSP8+2//LXCzQ1N8KC15Lz2eNXtXmGTqFl2W9sDk=
Received: by 10.49.19.11 with SMTP id w11mr3996045nfi;
        Sun, 25 Jun 2006 04:13:09 -0700 (PDT)
Received: from garlic.home.net ( [82.128.229.197])
        by mx.gmail.com with ESMTP id x24sm726767nfb.2006.06.25.04.13.08;
        Sun, 25 Jun 2006 04:13:09 -0700 (PDT)
To: Junio C Hamano <junkio@cox.net>
In-Reply-To: <7vslltopzg.fsf@assigned-by-dhcp.cox.net>
X-Mailer: Sylpheed version 2.2.6 (GTK+ 2.8.18; i686-pc-linux-gnu)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/22613>

Junio C Hamano <junkio@cox.net> wrote:

> Here are a few problems I have seen:
> 
>  - "git show --stat HEAD" gives '---' marker as Johannes and you
>    have already discussed (I do not mind this that much though);

The patch I sent as a reply to 2/7 should fix this.

>  - "--cc" seems to be quite broken.  "git show v1.0.0" nor "git
>    diff-tree --pretty --cc v1.0.0" does not give the log
>    message, and gives something quite confused instead.  I think
>    it is showing "-m -p" followed by "--cc".

Sorry about that.  I don't understand the --cc stuff very well but I try
to fix the bug.

-- 
http://onion.dynserv.net/~timo/
