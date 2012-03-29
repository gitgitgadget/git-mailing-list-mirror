From: Neal Kreitzinger <nkreitzinger@gmail.com>
Subject: Re: How to setup git repository for internal collaboration, that
 can be rebased easily?
Date: Thu, 29 Mar 2012 10:16:52 -0500
Message-ID: <4F747CE4.9010609@gmail.com>
References: <CANz+fEmN2qm9Nwk4tyg0eCrKPR6WZg4kvqCkhB7TmYw2JKoJJQ@mail.gmail.com> <CANz+fEk0HJBvHM2Z9kA42kXb7Aq-GL9ASQ+HiT3JgRQe_XpJLQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Kumar Pande <pandekumar023@gmail.com>
X-From: git-owner@vger.kernel.org Thu Mar 29 17:17:03 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SDH5y-0001TF-Jd
	for gcvg-git-2@plane.gmane.org; Thu, 29 Mar 2012 17:17:02 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933496Ab2C2PQ5 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 29 Mar 2012 11:16:57 -0400
Received: from mail-gx0-f174.google.com ([209.85.161.174]:45887 "EHLO
	mail-gx0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932370Ab2C2PQ4 (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 29 Mar 2012 11:16:56 -0400
Received: by gghe5 with SMTP id e5so1558663ggh.19
        for <git@vger.kernel.org>; Thu, 29 Mar 2012 08:16:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=message-id:date:from:user-agent:mime-version:to:cc:subject
         :references:in-reply-to:content-type:content-transfer-encoding;
        bh=gAILgpSfqjs2BOvcHIIroWi9GXg9bYvj648k+6Tbvgw=;
        b=ih9ysi2ZdA+De1kpKoNaW4dPK5Ql0TKz3sX2176tJDOpjTDPn7Nt2rX5xFudZG7Vja
         gbas6mpanl9SZtbCEdg8rfU3QShhYXZ5E4LDg0iu+IrRmLNR9DshK/9n8TjTEKvw+TxM
         Ji7EsuRB1LMXmNYVpmrvehKp9/g0hKR6NQgl8PyfRG71B3XH85Z1ML2KD5RcMtXTFNZG
         J80sCqjdJ/aTSV2ZE9IovN2EeZgiBdUYKSxSOkCSuZUr3H6HJD7/j8zHNBbhlh2wPH/q
         /67TWgW9hfmIlxmcNRKplzpK0q+TltA/empZPnQk6bsm8fdHx5sRIYLw9hrpwrb1ghmt
         Y3dw==
Received: by 10.60.1.7 with SMTP id 7mr43699202oei.71.1333034215505;
        Thu, 29 Mar 2012 08:16:55 -0700 (PDT)
Received: from [172.25.2.210] ([67.63.162.200])
        by mx.google.com with ESMTPS id 8sm6343499obv.19.2012.03.29.08.16.53
        (version=TLSv1/SSLv3 cipher=OTHER);
        Thu, 29 Mar 2012 08:16:54 -0700 (PDT)
User-Agent: Mozilla/5.0 (Windows; U; Windows NT 5.1; en-US; rv:1.9.2.28) Gecko/20120306 Thunderbird/3.1.20
In-Reply-To: <CANz+fEk0HJBvHM2Z9kA42kXb7Aq-GL9ASQ+HiT3JgRQe_XpJLQ@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/194260>

On 3/27/2012 12:50 AM, Kumar Pande wrote:
> On Mon, Mar 26, 2012 at 12:08 PM, Kumar Pande<pandekumar023@gmail.com>  wrote:
>
> So this what we have done so far:
>
> git clone --bare --shared
> http://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git
> git config core.sharedrepository 1
>
I don't think git-clone --shared does what you think it does.  You 
should reread the git-clone manpage for --shared.  I haven't used it, 
but from what I'm reading it doesn't seem to make sense in conjunction 
with your cloning of git.kernel.org.  Either way, it comes with a 
warning in the manpage:  http://schacon.github.com/git/git-clone.html
"NOTE: this is a possibly dangerous operation; do not  use it unless you 
understand what it does..."

v/r,
neal
