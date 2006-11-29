X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=-3.5 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MSGID_FROM_MTA_HEADER,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
From: "Michael S. Tsirkin" <mst@mellanox.co.il>
Subject: Re: Hyphens and hiding core commands
Date: Wed, 29 Nov 2006 09:14:49 +0200
Message-ID: <20061129071449.GH5061@mellanox.co.il>
References: <7vu00k3pao.fsf@assigned-by-dhcp.cox.net>
Reply-To: "Michael S. Tsirkin" <mst@mellanox.co.il>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
NNTP-Posting-Date: Wed, 29 Nov 2006 07:15:13 +0000 (UTC)
Cc: Theodore Tso <tytso@mit.edu>, Carl Worth <cworth@cworth.org>,
	git@vger.kernel.org
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Content-Disposition: inline
In-Reply-To: <7vu00k3pao.fsf@assigned-by-dhcp.cox.net>
User-Agent: Mutt/1.5.11
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/32619>
Received: from vger.kernel.org ([209.132.176.167]) by ciao.gmane.org with
 esmtp (Exim 4.43) id 1GpJep-0004m7-I5 for gcvg-git@gmane.org; Wed, 29 Nov
 2006 08:15:03 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id
 S934180AbWK2HPA (ORCPT <rfc822;gcvg-git@m.gmane.org>); Wed, 29 Nov 2006
 02:15:00 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S934190AbWK2HPA
 (ORCPT <rfc822;git-outgoing>); Wed, 29 Nov 2006 02:15:00 -0500
Received: from dev.mellanox.co.il ([194.90.237.44]:1923 "EHLO
 dev.mellanox.co.il") by vger.kernel.org with ESMTP id S934180AbWK2HO7 (ORCPT
 <rfc822;git@vger.kernel.org>); Wed, 29 Nov 2006 02:14:59 -0500
Received: from mellanox.co.il ([194.90.237.34]) by dev.mellanox.co.il
 (8.13.1/8.13.1) with SMTP id kAT7EhkC007832; Wed, 29 Nov 2006 09:14:44 +0200
Received: by mellanox.co.il (sSMTP sendmail emulation); Wed, 29 Nov 2006
 09:14:49 +0200
To: Junio C Hamano <junkio@cox.net>
Sender: git-owner@vger.kernel.org

> +------------------------------------------------
> +$ cat >~/.gitconfig
> +[user]
> +	name = Your Name Comes Here
> +	email = you@yourdomain.example.com
> +^D
> +------------------------------------------------

I used to use the ^D convention when explaining git
to beginners and I noticed some people try to cut-and-paste it.

So the following might be a better way to put it:

+$ cat <<EOF >~/.gitconfig
+[user]
+	name = Your Name Comes Here
+	email = you@yourdomain.example.com
+EOF

-- 
