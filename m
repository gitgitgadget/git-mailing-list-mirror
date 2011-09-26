From: Ben Boeckel <mathstuf@gmail.com>
Subject: Re: [BUG?] git fetch -p -t prunes all non-tag refs
Date: Mon, 26 Sep 2011 18:51:31 -0400
Message-ID: <20110926225131.GA3421@erythro.kitwarein.com>
References: <20110926184739.GA11745@erythro.kitwarein.com>
 <7vehz30wdy.fsf@alter.siamese.dyndns.org>
Reply-To: mathstuf@gmail.com
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Sep 27 00:52:01 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1R8K1o-0001oY-7p
	for gcvg-git-2@lo.gmane.org; Tue, 27 Sep 2011 00:52:00 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752574Ab1IZWvz (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 26 Sep 2011 18:51:55 -0400
Received: from mail-yw0-f46.google.com ([209.85.213.46]:39438 "EHLO
	mail-yw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752288Ab1IZWvz (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 26 Sep 2011 18:51:55 -0400
Received: by ywb5 with SMTP id 5so4747847ywb.19
        for <git@vger.kernel.org>; Mon, 26 Sep 2011 15:51:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:reply-to:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        bh=Gqrpg8QqNWZlgGxByazjvYIlHBjYUkj48UT8/KiWtz0=;
        b=iSspl6j4WjsbQqD9oP7H7exe70xNl/9Aw5Kn+5jt59lv9Eo+kSEFrrVp1u8aXKNRSV
         B+AJ5E+v82JAcFetpzKUIhNY4M6pwvURVADdk0rYyCiIrbcDZ0KVqMxEnHJkcUzxBmYV
         yp+QmVO0KBXbNMEI6vUBuHtFbZqYHcKt/3zd0=
Received: by 10.236.181.137 with SMTP id l9mr43138253yhm.56.1317077514742;
        Mon, 26 Sep 2011 15:51:54 -0700 (PDT)
Received: from erythro (66-194-253-20.static.twtelecom.net. [66.194.253.20])
        by mx.google.com with ESMTPS id u45sm31039179yhh.8.2011.09.26.15.51.53
        (version=TLSv1/SSLv3 cipher=OTHER);
        Mon, 26 Sep 2011 15:51:53 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <7vehz30wdy.fsf@alter.siamese.dyndns.org>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/182179>

On Mon, Sep 26, 2011 at 15:30:33 -0700, Junio C Hamano wrote:
> I would call that a bug, and it is not limited to the use of "--tags". For
> example, I suspect that
> 
>     $ git fetch --prune origin refs/heads/master:refs/remotes/origin/master
> 
> would prune remote tracking branches for "origin" other than "master".

Indeed it does. Given that, should --prune be an error when a refspec is
given or when in combination with --tags?

--Ben
