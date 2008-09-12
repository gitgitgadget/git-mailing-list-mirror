From: "Ciprian Dorin Craciun" <ciprian.craciun@gmail.com>
Subject: Re: configuring git public repository
Date: Fri, 12 Sep 2008 15:33:27 +0300
Message-ID: <8e04b5820809120533o1e7da548l6868660767a5435d@mail.gmail.com>
References: <19449377.post@talk.nabble.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: sagi4 <geetha@angleritech.com>
X-From: git-owner@vger.kernel.org Fri Sep 12 14:34:39 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Ke7rC-0003Iy-Lo
	for gcvg-git-2@gmane.org; Fri, 12 Sep 2008 14:34:39 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753515AbYILMdb (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 12 Sep 2008 08:33:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753464AbYILMdb
	(ORCPT <rfc822;git-outgoing>); Fri, 12 Sep 2008 08:33:31 -0400
Received: from nf-out-0910.google.com ([64.233.182.189]:49246 "EHLO
	nf-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752093AbYILMda (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 12 Sep 2008 08:33:30 -0400
Received: by nf-out-0910.google.com with SMTP id d3so432315nfc.21
        for <git@vger.kernel.org>; Fri, 12 Sep 2008 05:33:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from:to
         :subject:cc:in-reply-to:mime-version:content-type
         :content-transfer-encoding:content-disposition:references;
        bh=R8t9rMdyb+3MsNHIi9Tue4EQ3kez/8ANmgOjvGRhHpE=;
        b=PyOI0r+M0cQXQXWMY0SxvGcXAVbbY62+pA53y7jDqWl8E6v7YpXCKzP8Q3p5Pvni5L
         cXhpALxInRdktmRxdXVPyxoS3UkA8nzV0c1SNmKRdWd/Dwknelq4p68Q4FK8+DuyzHpw
         ZiaAMnnj+CTwM1tGYjC0hIBH8dEN7MSc8WP54=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:to:subject:cc:in-reply-to:mime-version
         :content-type:content-transfer-encoding:content-disposition
         :references;
        b=MMRg25sg2YN0vj9I6Q/ZX3i0iAx55yvPxwt8dK/rky8Pbp9VFLTHv6w+LaFBuiSUHc
         rDzEW9o3sy5X/YkHojDIQgG/l4xoASErqzYoV7zHYU7GzBTEA409SPXZ3RHq9sTK3prk
         r68pLEdL+Vy1j4ctQCQO0tbPlvKjyHyH26bEM=
Received: by 10.210.133.2 with SMTP id g2mr5013437ebd.163.1221222807616;
        Fri, 12 Sep 2008 05:33:27 -0700 (PDT)
Received: by 10.210.117.20 with HTTP; Fri, 12 Sep 2008 05:33:27 -0700 (PDT)
In-Reply-To: <19449377.post@talk.nabble.com>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/95717>

    Hello!

    If I'm correct, you have two major options:
    -- install your own git infrastructure:
        -- by using git-daemon and serving the git repository throught
git://...;
        -- by using gitweb? and serving it as http://...;
        -- by using ssh and serving it as ssh://... (this is
appropriate mostly for private repositories);
    -- using an existing Git hosting service like:
        -- (of course) http://repo.or.cz/
        -- http://github.org/
        -- http://gitorious.org/
        -- see also http://git.or.cz/gitwiki/GitHosting

    For open-source / public repositories I would opt for using an
existing hosting service.

    Hope it's useful for you,
    Ciprian Dorin Craciun.


On Fri, Sep 12, 2008 at 7:47 AM, sagi4 <geetha@angleritech.com> wrote:
>
> Hi all,
>
> I am new git..
>
> I would like to configure git as a public repository for my rails
> application..
>
> Please help me..
>
> Thanks
> Sg..
> --
> View this message in context: http://www.nabble.com/configuring-git-public-repository-tp19449377p19449377.html
> Sent from the git mailing list archive at Nabble.com.
