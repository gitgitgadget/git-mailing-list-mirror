From: Timo Hirvonen <tihirvon@gmail.com>
Subject: Re: Proper Publishing of a Repository
Date: Wed, 22 Mar 2006 22:16:30 +0200
Message-ID: <20060322221630.e65baca0.tihirvon@gmail.com>
References: <1143055072.4527.142.camel@cashmere.sps.mot.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-From: git-owner@vger.kernel.org Wed Mar 22 21:21:08 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FM9lJ-0006KR-R3
	for gcvg-git@gmane.org; Wed, 22 Mar 2006 21:16:58 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932650AbWCVUQk (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 22 Mar 2006 15:16:40 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932661AbWCVUQi
	(ORCPT <rfc822;git-outgoing>); Wed, 22 Mar 2006 15:16:38 -0500
Received: from zproxy.gmail.com ([64.233.162.202]:61792 "EHLO zproxy.gmail.com")
	by vger.kernel.org with ESMTP id S932650AbWCVUQf (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 22 Mar 2006 15:16:35 -0500
Received: by zproxy.gmail.com with SMTP id m22so276797nzf
        for <git@vger.kernel.org>; Wed, 22 Mar 2006 12:16:34 -0800 (PST)
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:date:from:to:subject:message-id:in-reply-to:references:x-mailer:mime-version:content-type:content-transfer-encoding;
        b=XbnvVNQMUi9fN0Akd4xpj9tg5Tvx2tthtdyzYmxvMKDhXiYn0QPY4cyEc6gb13/ZGfLHQw2REtABBJYbthl0XRoMRw+BBU79Gxt8OPPXH56ksR8U5/matqOmXwOZD90cKc4HElVYB1T+T4GUSktUi3XM4N5ovBK1jxWNPcrUUEI=
Received: by 10.65.44.13 with SMTP id w13mr983475qbj;
        Wed, 22 Mar 2006 12:16:33 -0800 (PST)
Received: from garlic.home.net ( [82.128.203.119])
        by mx.gmail.com with ESMTP id e13sm124164qbe.2006.03.22.12.16.31;
        Wed, 22 Mar 2006 12:16:33 -0800 (PST)
To: git@vger.kernel.org
In-Reply-To: <1143055072.4527.142.camel@cashmere.sps.mot.com>
X-Mailer: Sylpheed version 2.2.3 (GTK+ 2.8.15; i686-pc-linux-gnu)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/17825>

On Wed, 22 Mar 2006 13:17:52 -0600
Jon Loeliger <jdl@freescale.com> wrote:

> Folks,
> 
> So, I feel like I missed a step in the grand
> "How To Publish A Repository" scheme of things.
> 
> I made a repo visible over on jdl.com.  No problem.
> But cloning it took forever.  So I ran "git-repack"
> on it.  Now cloning only takes hours, not forever.
> 
> All this on the linux kernel over HTTP.

Use git:// protocol (git-daemon) if possible.  It is much faster.

-- 
http://onion.dynserv.net/~timo/
