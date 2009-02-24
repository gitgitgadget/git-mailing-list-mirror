From: Brent Goodrick <bgoodr@gmail.com>
Subject: Re: How do I undo a fast-forward merge safely?
Date: Mon, 23 Feb 2009 21:37:38 -0800
Message-ID: <e38bce640902232137s622410cv4506b8e0083bb468@mail.gmail.com>
References: <e38bce640902221115o2dd1c63dv6f7acc374b48d418@mail.gmail.com>
	 <m3fxi6s0vu.fsf@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Jakub Narebski <jnareb@gmail.com>
X-From: git-owner@vger.kernel.org Tue Feb 24 06:39:08 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Lbq0Z-0002pF-Ta
	for gcvg-git-2@gmane.org; Tue, 24 Feb 2009 06:39:08 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752485AbZBXFhm (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 24 Feb 2009 00:37:42 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752376AbZBXFhl
	(ORCPT <rfc822;git-outgoing>); Tue, 24 Feb 2009 00:37:41 -0500
Received: from yw-out-2324.google.com ([74.125.46.28]:17665 "EHLO
	yw-out-2324.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751756AbZBXFhk (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 24 Feb 2009 00:37:40 -0500
Received: by yw-out-2324.google.com with SMTP id 5so979514ywh.1
        for <git@vger.kernel.org>; Mon, 23 Feb 2009 21:37:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :date:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=WUHSvcs+S0QeQkM8KTa2n6L9t8iZN/Vk6Gn5L1K58X0=;
        b=bITe2yMSOQC2S1nc4S3tfYfDGLl+fsj2cVXYjcmT4+HE18qwfebWkEs8VOJCYJ6y4y
         a6Z46SMuIb0yfp9ptMoeJWT+nRAsX6hHmdXKa0zet6fwMqDONedJ6by7Qncs9egsSuQb
         6WWpKZT9AXBosnry5ng8d+4Yhbj5tQ73Fk40g=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=jZamducm2S7o2mYyJ+6awEY4UnZ6O3twjMeEG7VOup9w0sZSQagi9mIrlcKFK7CpEf
         Qsc9hN84ZNL8k3mSY5CyfbPd0R6mkcitI8ft+JYwN1zxKKiC9JScpGsvqjWkshxTYb4t
         sNwmGgz5nkDO/5JLN5H3qdxUM4WZgKiXWO85M=
Received: by 10.90.88.17 with SMTP id l17mr1952857agb.32.1235453858317; Mon, 
	23 Feb 2009 21:37:38 -0800 (PST)
In-Reply-To: <m3fxi6s0vu.fsf@localhost.localdomain>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/111212>

On Sun, Feb 22, 2009 at 11:54 AM, Jakub Narebski <jnareb@gmail.com> wrote:
> > So, what operations, rebase, reset, etc, do I need to do to get this
> > repo back to where it was right before the fast-forward?
>
> Each 'large' operation sets ORIG_HEAD
>
>  $ git reset --hard ORIG_HEAD
>

Thanks Jakub. "git reset --hard ORIG_HEAD" was what I went with and it
worked like a charm!

bg
