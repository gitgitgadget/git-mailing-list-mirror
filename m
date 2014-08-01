From: Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: cherry picking and merge
Date: Fri, 1 Aug 2014 15:42:27 -0700
Message-ID: <20140801224227.GU12427@google.com>
References: <51C01AAA-3CFB-4110-BAE9-7D04CA8EE53A@comcast.net>
 <20140801200201.GS12427@google.com>
 <05976673-8F8A-41FE-81C3-606CAA45BC52@comcast.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Mike Stump <mikestump@comcast.net>
X-From: git-owner@vger.kernel.org Sat Aug 02 00:42:35 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XDLX1-0003zT-8q
	for gcvg-git-2@plane.gmane.org; Sat, 02 Aug 2014 00:42:35 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755802AbaHAWmb (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 1 Aug 2014 18:42:31 -0400
Received: from mail-pa0-f53.google.com ([209.85.220.53]:41787 "EHLO
	mail-pa0-f53.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754620AbaHAWmb (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 1 Aug 2014 18:42:31 -0400
Received: by mail-pa0-f53.google.com with SMTP id rd3so6529708pab.26
        for <git@vger.kernel.org>; Fri, 01 Aug 2014 15:42:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        bh=VTRKHg4XV8BpenNNgMviUQLgrNS4zIwUhk0TFl+KVKc=;
        b=vQWXIlYfMPUpB7nW1FlnVlEx9pBOe2ELSFetTXzkixq+AaO6E2ZdoJJS5JRwI+sF8k
         9N7AnVo2/0arSBuJ8MMemXN+4/bvofb+JJXdCWqLcS26lGBvXY0BII1JewlZIbwiUMU5
         AG2ESJvB4WrwgjMVCEDTpdMwEozV1EVDsmVhyuWBdDaKhNegqeZqv11rCz/ZYs5iEW5x
         +o4CzMWfQlyounRD/o0Ky3ZnJk5wTbDgQqrTgErdhBihH5+NCFrjgz6UoWAjViDiPkf5
         4w01M928ojt3DWteQJSeQettGLlyLTo9PIaYTGUlk/vMLJrui1i8/0MLjqaafZznq/ga
         ttZQ==
X-Received: by 10.70.33.102 with SMTP id q6mr9653577pdi.39.1406932950626;
        Fri, 01 Aug 2014 15:42:30 -0700 (PDT)
Received: from google.com ([2620:0:1000:5b00:303c:6b98:896:51f2])
        by mx.google.com with ESMTPSA id z4sm14764953pda.84.2014.08.01.15.42.29
        for <multiple recipients>
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Fri, 01 Aug 2014 15:42:30 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <05976673-8F8A-41FE-81C3-606CAA45BC52@comcast.net>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/254679>

Mike Stump wrote:
> On Aug 1, 2014, at 1:02 PM, Jonathan Nieder <jrnieder@gmail.com> wrote:

>> It isn't, and that's deliberate
>
> Deliberate bugs are still bugs.

Yes, you and I disagree about what the behavior should be.

I actively prefer the current behavior over the one you proposed,
unless I'm misunderstanding the one you proposed.  As I understand it,
there would be no way to undo the mistake of cherry-picking a change
that didn't belong on "maint".

You said that 3-way merge doesn't fit your idea of what a merge is.
It does fit mine.

I'm even slightly against there being an option for the 'git cherry'
based thing.  I think it would be a support burden.  But if someone
else wants to do the work of implementing it, I wouldn't stop them
(and would instead just help make sure the documentation is crystal
clear).

Hoping that clarifies,
Jonathan
