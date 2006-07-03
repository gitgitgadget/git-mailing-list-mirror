From: Timo Hirvonen <tihirvon@gmail.com>
Subject: Re: [PATCH 1/4] merge-recursive in C
Date: Mon, 3 Jul 2006 18:46:04 +0300
Message-ID: <20060703184604.59801e4e.tihirvon@gmail.com>
References: <20060630002721.GA22618@steel.home>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org, Johannes.Schindelin@gmx.de, junkio@cox.net
X-From: git-owner@vger.kernel.org Mon Jul 03 17:46:09 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FxQch-0005Jt-Lm
	for gcvg-git@gmane.org; Mon, 03 Jul 2006 17:46:08 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932081AbWGCPqE (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 3 Jul 2006 11:46:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932079AbWGCPqE
	(ORCPT <rfc822;git-outgoing>); Mon, 3 Jul 2006 11:46:04 -0400
Received: from nf-out-0910.google.com ([64.233.182.187]:50083 "EHLO
	nf-out-0910.google.com") by vger.kernel.org with ESMTP
	id S932081AbWGCPqD (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 3 Jul 2006 11:46:03 -0400
Received: by nf-out-0910.google.com with SMTP id k26so450581nfc
        for <git@vger.kernel.org>; Mon, 03 Jul 2006 08:46:02 -0700 (PDT)
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:date:from:to:cc:subject:message-id:in-reply-to:references:x-mailer:mime-version:content-type:content-transfer-encoding;
        b=OPKS2N5bsGCAJ4B37k2y4iJhY7H1LI8MOX9R4OgXQmN4XJT5vq0CuVWpMHAn8Y45LHp9Cq14OqFdgsrDXz6dincVeFmxYx9lYzrfnyvUaOUZtmUb6QhT48rkAxj+iDpyVwC+JCLGCRCdv+nRFhLSemu5YtUtzU+zhaLaBYM9NVQ=
Received: by 10.49.37.10 with SMTP id p10mr2533110nfj;
        Mon, 03 Jul 2006 08:46:02 -0700 (PDT)
Received: from garlic.home.net ( [82.128.203.109])
        by mx.gmail.com with ESMTP id p20sm4719128nfc.2006.07.03.08.46.01;
        Mon, 03 Jul 2006 08:46:02 -0700 (PDT)
To: fork0@t-online.de
In-Reply-To: <20060630002721.GA22618@steel.home>
X-Mailer: Sylpheed version 2.2.6 (GTK+ 2.8.19; i686-pc-linux-gnu)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/23186>

fork0@t-online.de (Alex Riesen) wrote:

> +/* in place */
> +void path_list_union_update(struct path_list *dst, const struct path_list *src)
> +{
> +	char **new_paths;
> +	int i = 0, j = 0, nr = 0, alloc = dst->nr + dst->nr;

It should be alloc = dst->nr + src->nr.

-- 
http://onion.dynserv.net/~timo/
