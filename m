From: Fredrik Gustafsson <iveqy@iveqy.com>
Subject: Re: ssh admin git accidentally deleted
Date: Wed, 8 Jul 2015 07:38:46 +0200
Message-ID: <20150708053846.GB7613@paksenarrion.iveqy.com>
References: <CAF1FN5CDnUYxjChO2PZFrDnPRUiuqXhko=iDo=tuqwvJJdUg5A@mail.gmail.com>
 <20150707134942.GA7613@paksenarrion.iveqy.com>
 <CAF1FN5BMTTatfTmVYjpKcqczefur3ETjbqyEk1vSmdruY82quw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Fredrik Gustafsson <iveqy@iveqy.com>, git@vger.kernel.org
To: agnes retnaningsih <agnes.monest@gmail.com>
X-From: git-owner@vger.kernel.org Wed Jul 08 07:38:57 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZCi4P-0005Sn-3O
	for gcvg-git-2@plane.gmane.org; Wed, 08 Jul 2015 07:38:57 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758100AbbGHFix (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 8 Jul 2015 01:38:53 -0400
Received: from mail-la0-f53.google.com ([209.85.215.53]:33604 "EHLO
	mail-la0-f53.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757370AbbGHFiv (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 8 Jul 2015 01:38:51 -0400
Received: by laar3 with SMTP id r3so218393086laa.0
        for <git@vger.kernel.org>; Tue, 07 Jul 2015 22:38:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        bh=SqVkruy22/3wDAAwgSV8UUsp+zGA5sfVTB2m+1084mw=;
        b=eOtT+K0tK3rwmZlN+s7Vu90ciyk4dxmvEv/+tbd2aRtJYl9z94r1oKC7yO6NizxIq8
         5p0AMWnodckXysuTYilq0/bwnrDl6CB1wyiL3ukyVw943A2SQfiGmcCscKW3vNNJSOJN
         KXbGkpf3bIwuj+o3Hz9R9mNoQ4NEeRplaY/nb3zbZq5qHkBSdgc9vb4sgGdiWg2nNlrd
         YbIctM/1VP3ax6ssZu6yEig5oyuyOnb6pLyoku3IKc+TR8PTQYejMHak0WbABZAOmMvo
         OOaIK/KjnJZyhH0wZcMbqkLVaX1PcAENTLTUPWPf/IJ1U35pbY6SpL6Soi5By0ugvZhB
         sl4w==
X-Received: by 10.112.118.137 with SMTP id km9mr7559812lbb.28.1436333930268;
        Tue, 07 Jul 2015 22:38:50 -0700 (PDT)
Received: from paksenarrion.paks.iveqy.com (c83-249-17-125.bredband.comhem.se. [83.249.17.125])
        by smtp.gmail.com with ESMTPSA id rp10sm280967lbb.8.2015.07.07.22.38.48
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 07 Jul 2015 22:38:48 -0700 (PDT)
Received: from iveqy by paksenarrion.paks.iveqy.com with local (Exim 4.84)
	(envelope-from <iveqy@paksenarrion.iveqy.com>)
	id 1ZCi4F-00038i-Br; Wed, 08 Jul 2015 07:38:47 +0200
Content-Disposition: inline
In-Reply-To: <CAF1FN5BMTTatfTmVYjpKcqczefur3ETjbqyEk1vSmdruY82quw@mail.gmail.com>
User-Agent: Mutt/1.5.23 (2014-03-12)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/273639>

On Wed, Jul 08, 2015 at 12:32:42AM +0700, agnes retnaningsih wrote:
> I use gitolite on linux.
> he2nk is account that I delete on server where gitolite-admin is repository
> to change gitolite configuration. I still can make editing such as add user
> to access gitolite-admin  but when I push it, it error ( file attached), I
> think it because the he2nk has been deleted.
> 
> 
> he2nk is ssh that I have deleted and push it to the server.
> 
> 
> So, if there anyway to revert the change I pushed?? so that I can make a
> change on gitolite admin.
> 


So from what I understand he2nk is a gitolite account and not a linux
account. And you deleted he2nk from your gitolite-admin repository.

Yes you can revert this and you can also add he2nk again, whatever you
like. But as you've seen you can't do this with gitolite. You've to do
this directly on the server since you don't have access to edit the
gitolite-admin repository (if I guess correct).

Please don't forget to CC the git-list.


-- 
Fredrik Gustafsson

phone: +46 733-608274
e-mail: iveqy@iveqy.com
website: http://www.iveqy.com
