From: Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: BUG: [Cosmetic] Commiting a gerrit ChangeId before the commit
 hook was installed
Date: Fri, 17 Jan 2014 12:41:32 -0800
Message-ID: <20140117204132.GB18964@google.com>
References: <CAC9meRKiR+60YaGiuCu4twEt6dyWksEjHSH8YPTEvmD=LoB=aw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, openstack-infra@lists.openstack.org
To: Strainu <strainu10@gmail.com>
X-From: git-owner@vger.kernel.org Fri Jan 17 21:41:43 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1W4GEY-0002VY-KE
	for gcvg-git-2@plane.gmane.org; Fri, 17 Jan 2014 21:41:43 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753335AbaAQUli (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 17 Jan 2014 15:41:38 -0500
Received: from mail-gg0-f178.google.com ([209.85.161.178]:55895 "EHLO
	mail-gg0-f178.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752926AbaAQUlg (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 17 Jan 2014 15:41:36 -0500
Received: by mail-gg0-f178.google.com with SMTP id q2so1425171ggc.23
        for <git@vger.kernel.org>; Fri, 17 Jan 2014 12:41:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        bh=IBqO0WSURp531S3qf9q8Lh4OZEmSLv7YVMSSYPW0IMs=;
        b=IaEVkdAgDEHMxQm+lHnMHQmvyMCNkxtIMaSid4UT8CKQNCIXCSRnoPz0nRpSaeL3wD
         QOvtWMftnOj63d+2pdHkEnCQ/UQ+cbzXO/xqx4TAaEWEDfvyfHp1ghhgq6S59DgnCIKv
         iC3hH7a0JfsRjOjx7qfA4AeN/ZyNXQGa82S9Vmc1ah+orgEdsofRmCQkR4SwW5c3rMQG
         z3KuHtkIE8gxLXvgUQqpRvV8Z/9miWYwonpRsMJ3rhfxvUqiVTh3I14v37ZK+q/EZd7K
         g+EEke3agFfr3sDVg73hF63rDaGzWoM3/uJpVMLs4VvTkce6WYvaKzaWvXi0xG/ZxkAq
         u7eQ==
X-Received: by 10.236.38.168 with SMTP id a28mr3672624yhb.75.1389991295720;
        Fri, 17 Jan 2014 12:41:35 -0800 (PST)
Received: from google.com ([2620:0:1000:5b00:b6b5:2fff:fec3:b50d])
        by mx.google.com with ESMTPSA id m68sm20179805yhj.22.2014.01.17.12.41.34
        for <multiple recipients>
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Fri, 17 Jan 2014 12:41:35 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <CAC9meRKiR+60YaGiuCu4twEt6dyWksEjHSH8YPTEvmD=LoB=aw@mail.gmail.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/240630>

Hi,

Strainu wrote:

> strainu@emily:~/core> git review -f
> Creating a git remote called "gerrit" that maps to:
>         ssh://strainu@gerrit.wikimedia.org:29418/pywikibot/core.git
> Your change was committed before the commit hook was installed.
> Amending the commit to add a gerrit change id.
>
> At this point I ended the transaction, as I was confused by the last
> message: I was afraid the ChangeId would have changed, causing the
> patch to be attached to another review.
>
> I think git should not show this message if the change description
> already has a change id

This message doesn't come from git.  It comes from the git-review
tool (in git_review/cmd.py), so cc-ing the authors in case they
have thoughts on that.

Thanks,
Jonathan
