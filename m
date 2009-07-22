From: Scott Chacon <schacon@gmail.com>
Subject: Re: Why is it important to learn git?
Date: Wed, 22 Jul 2009 11:31:00 -0700
Message-ID: <d411cc4a0907221131q28ffb24av8715c4497f50deb3@mail.gmail.com>
References: <e1a5e9a00907212208t10a071d0oe59a39b357a1111a@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: Tim Harper <timcharper@gmail.com>
X-From: git-owner@vger.kernel.org Wed Jul 22 20:31:16 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MTgat-0001bm-F5
	for gcvg-git-2@gmane.org; Wed, 22 Jul 2009 20:31:11 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751443AbZGVSbB convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 22 Jul 2009 14:31:01 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751331AbZGVSbB
	(ORCPT <rfc822;git-outgoing>); Wed, 22 Jul 2009 14:31:01 -0400
Received: from an-out-0708.google.com ([209.85.132.246]:28930 "EHLO
	an-out-0708.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750938AbZGVSbA convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 22 Jul 2009 14:31:00 -0400
Received: by an-out-0708.google.com with SMTP id d40so475680and.1
        for <git@vger.kernel.org>; Wed, 22 Jul 2009 11:31:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :date:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=dYTMKvLzY1Y/lkWDhVZnMnW/yJhERjxwiWQuofHksh8=;
        b=s/PsslkYMEKZFa3ypOFxoKSfPuvGDforNejJ1wMsHSilfNXAaCnZWDRUXFXIUXcx/z
         VrdFyf2CltoCXaYJ1Cxckn6U5MYPVTnCZ9VGbn+cqS1AtgeSXOw3LQz8W7Qc1+b1io1B
         6fc+bRjx3NUSoquKbks1pIj4RQUmVx0nNt85Q=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=ua21KyP8ILfpkiPxLGwkIKC3eEDp4t2gO1A3WjbWtQTbSh4taU6LTPM5jflGxHUfSY
         fQS4qlmZo9wqh4cDwFXtLOaGsNLNpFFkrHjJJXk04PM3GIeQHNtBQoVHyvXT0odN/KpP
         Liqa9fan3TN+cViB2iBAs/InWi/UIug+hjqvk=
Received: by 10.100.121.12 with SMTP id t12mr1636401anc.58.1248287460517; Wed, 
	22 Jul 2009 11:31:00 -0700 (PDT)
In-Reply-To: <e1a5e9a00907212208t10a071d0oe59a39b357a1111a@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/123767>

Hey,

On Tue, Jul 21, 2009 at 10:08 PM, Tim Harper<timcharper@gmail.com> wrot=
e:
> Hi all,
>
> I'm preparing to teach a workshop on git, and would like to know how
> other people benefit from the advanced features of git. =C2=A0So, if =
you're
> feeling kind enough to share a few minutes to respond (which I will
> receive with gratitude):
>
> How has mastering the advanced features of git helped you to be a
> better programmer?

I think the biggest gain Git gives many developers over other VCSs
(even other DVCSs) is the lightweight branching flexibility and easy
merging.  In Git, lightweight branches or topic branches are used in
much the same way that patch queuing tools like Hg's mq extension or
quilt, but I think most users find them much, much easier to use and
understand and often less error prone.  Using branches as silos
dedicated to a single work topic and being able to easily keep them
separated until you are ready to apply them to a main line of work
(such as merging with your master branch) is very powerful and is done
via a very simple and understandable existing paradigm of branches
rather than trying to learn a whole new command set of patching.  This
allows for fast and simple context switching and work unit isolation
that both very definitively changes most developers workflows in ways
that were completely impossible in SVN or Perforce or what-have-you.

Hope that helps.  If you need any material for your workshop, I have a
number of slides (Keynote and PDF) for presentations I have given at:

http://github.com/schacon/git-presentations

You can also get the PDF of the slides of the tutorial I gave at OSCON
yesterday on Git here:

http://en.oreilly.com/oscon2009/public/schedule/detail/7953

Let me know if there is anything else I can do to help.

Thanks,
Scott
