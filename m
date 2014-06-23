From: Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: [RFC/PATCH V2] alias.c: replace git_config with
 git_config_get_string
Date: Mon, 23 Jun 2014 15:38:25 -0700
Message-ID: <20140623223825.GC4445@google.com>
References: <1403520105-23250-1-git-send-email-tanayabh@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Ramkumar Ramachandra <artagnon@gmail.com>,
	Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
To: Tanay Abhra <tanayabh@gmail.com>
X-From: git-owner@vger.kernel.org Tue Jun 24 00:38:39 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WzCsj-0000x1-0v
	for gcvg-git-2@plane.gmane.org; Tue, 24 Jun 2014 00:38:33 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751242AbaFWWi3 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 23 Jun 2014 18:38:29 -0400
Received: from mail-pb0-f50.google.com ([209.85.160.50]:56624 "EHLO
	mail-pb0-f50.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751147AbaFWWi2 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 23 Jun 2014 18:38:28 -0400
Received: by mail-pb0-f50.google.com with SMTP id rp16so6376792pbb.23
        for <git@vger.kernel.org>; Mon, 23 Jun 2014 15:38:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        bh=Afn1nHD9TJocThzp1DSGj+LXeU8IirnBSBv9OItdv6Y=;
        b=vXH+f/+G8PNCFpOGC3xQyUmIiQpai/vp0Gf39yC0Seerrg0ERz7XVEPkewcflIY7yo
         vGnnCFhPNoGawWdwkKcsj/JgPJ+nC4A3Lj6BkDpNtZgJ6HongVyrdpGF+/9JlW7Kjt8M
         T9Qiig9htdqi4fkKnruAMQLCDmur8MIP9Ed4zuHXuG7vNduQEF7kyDYneqILe7xsDk8Q
         jhculR825De0lFrQhb8E87RQxNiTuAGl/OQuZeyaPUW4fNtSvGsAJNeU9wIm4ypVptBz
         Vrgeh0TGOO/kt8It9YqPa867txgr+JttOyqTaDd6PDQwjchxlu4QyFELMqxvzN9sJej8
         NnhQ==
X-Received: by 10.68.90.68 with SMTP id bu4mr30134335pbb.5.1403563108328;
        Mon, 23 Jun 2014 15:38:28 -0700 (PDT)
Received: from google.com ([2620:0:1000:5b00:b6b5:2fff:fec3:b50d])
        by mx.google.com with ESMTPSA id tr2sm100053838pab.26.2014.06.23.15.38.27
        for <multiple recipients>
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Mon, 23 Jun 2014 15:38:27 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <1403520105-23250-1-git-send-email-tanayabh@gmail.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/252373>

Tanay Abhra wrote:

>  alias.c | 28 ++++++++++------------------
>  1 file changed, 10 insertions(+), 18 deletions(-)

What commit are these patches against?  Are they a continuation
of the "git config cache & special querying api" series?

Thanks,
Jonathan
