From: Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: Status of the svn remote helper project (Nov, 2010)
Date: Mon, 8 Nov 2010 00:11:40 -0600
Message-ID: <20101108061140.GB29738@burratino>
References: <20101107112129.GA30042@burratino>
 <6A74D35D-A065-44B7-8DA4-6CA78DE067CF@cordelta.com>
 <201011081456.26618.david.barr@cordelta.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Ramkumar Ramachandra <artagnon@gmail.com>,
	Sverre Rabbelier <srabbelier@gmail.com>,
	Sam Vilain <sam@vilain.net>, Stephen Bash <bash@genarts.com>,
	Tomas Carnecky <tom@dbservice.com>
To: David Barr <david.barr@cordelta.com>
X-From: git-owner@vger.kernel.org Mon Nov 08 07:12:14 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PFKxi-0001ru-Ad
	for gcvg-git-2@lo.gmane.org; Mon, 08 Nov 2010 07:12:14 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751232Ab0KHGLz (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 8 Nov 2010 01:11:55 -0500
Received: from mail-gy0-f174.google.com ([209.85.160.174]:36791 "EHLO
	mail-gy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750860Ab0KHGLz (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 8 Nov 2010 01:11:55 -0500
Received: by gyh4 with SMTP id 4so3137797gyh.19
        for <git@vger.kernel.org>; Sun, 07 Nov 2010 22:11:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:date:from:to:cc:subject
         :message-id:references:mime-version:content-type:content-disposition
         :in-reply-to:user-agent;
        bh=WFvElEmFRohj+uINlneCWEDm8zC0AyqFH5xSSEGdiHI=;
        b=h1pT55v/U2Mvq3SzTGSWvExZ7CkYhU0acW+jiRP4rvhHQh+FKnmuJU+HfXBclW6Cr8
         h4SOTuNGqXQMDD8oBMBj08nf9wIhCXnzJvEF9yRWu6bnCvWVdBWpIw+BoWXoSj+GFkO3
         IilODmJIJRWQYqWIYI7o7HDX6tFrKVXLZQtxI=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        b=QrplfxFhdTGySg0ztt++Vv+da7e4PbmMP4Lt9E1sbZFOQRlpLHQglySPe+WXMDi2BS
         2UpAENwzPYj3rrDZZptjiOwEpMUmOuA5uRZdc5KL9sZXuKhqKJ2b8XuwumDqwXN6/v2o
         e4M+hV4pLBMnAVHOdJLtiC539ujmtPXbF7BiI=
Received: by 10.100.226.20 with SMTP id y20mr2224964ang.46.1289196714483;
        Sun, 07 Nov 2010 22:11:54 -0800 (PST)
Received: from burratino (adsl-68-255-106-176.dsl.chcgil.ameritech.net [68.255.106.176])
        by mx.google.com with ESMTPS id d8sm392286ana.22.2010.11.07.22.11.52
        (version=SSLv3 cipher=RC4-MD5);
        Sun, 07 Nov 2010 22:11:53 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <201011081456.26618.david.barr@cordelta.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/160910>

David Barr wrote:

>>> [Cooking]
>>> * jn/svndiff0 (2010-11-06) 24 commits
[...]
> I've successfully tested this series against the ASF repository
> (940,166 revisions) and 5,636,613 blobs were faithfully reproduced.

Thanks!  Was that using svn-fe, test-svn-fe -d, or some other program
using the vcs-svn lib?

Jonathan
