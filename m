From: Felipe Contreras <felipe.contreras@gmail.com>
Subject: Re: What's cooking in git.git (Apr 2014, #09; Tue, 29)
Date: Thu, 08 May 2014 02:56:37 -0500
Message-ID: <536b38b55b7fc_4fa68b32eca@nysa.notmuch>
References: <xmqq7g67iwxc.fsf@gitster.dls.corp.google.com>
 <20140505184546.GB23935@serenity.lan>
 <xmqqoazb944d.fsf@gitster.dls.corp.google.com>
 <536B3259.1050602@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Chris Packham <judge.packham@gmail.com>,
	Junio C Hamano <gitster@pobox.com>,
	John Keeping <john@keeping.me.uk>
X-From: git-owner@vger.kernel.org Thu May 08 10:07:44 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WiJMi-0001RZ-53
	for gcvg-git-2@plane.gmane.org; Thu, 08 May 2014 10:07:40 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752757AbaEHIHb (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 8 May 2014 04:07:31 -0400
Received: from mail-yk0-f176.google.com ([209.85.160.176]:34504 "EHLO
	mail-yk0-f176.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751756AbaEHIH1 (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 8 May 2014 04:07:27 -0400
Received: by mail-yk0-f176.google.com with SMTP id q9so1831116ykb.21
        for <git@vger.kernel.org>; Thu, 08 May 2014 01:07:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=date:from:to:cc:message-id:in-reply-to:references:subject
         :mime-version:content-type:content-transfer-encoding;
        bh=K5w/ID96nfH4s3hDD6GCy7j8V19K0OE0yUJbJCWmbr8=;
        b=U6gkXEqsPF9G54VEwlbtyfwEC7+mllLjLjigq1Fe+XRC1lwjGLZJu4SmqoCyHCoa+f
         z6jBSgVNmyWkVeeaUgxkmsGHbBrHiWVr1Pau+u5QccX7iQYBsfc1gPmgoVKyLZbkQooF
         q2pK+ejnDDgaMWpPl+pz3WEq1MiUt2uBqK2j5Mp4wkuwiSrpNgBEnqzeLYWEPk8W2lbb
         6qL9Ij9WN/RtkvYM4TaJkY+W6nH7iRyBTzO1C1yi8Sc/VGrj18dyFA0JmZYZVJO6pZ2B
         zYHIbEw4nVAS4ZEL285iyOQEk5A7AcXTmTHhQdX0AtU0xbjbJsw7nhdU+hORsgnSIYDP
         YSxA==
X-Received: by 10.236.231.6 with SMTP id k6mr2709455yhq.156.1399536446727;
        Thu, 08 May 2014 01:07:26 -0700 (PDT)
Received: from localhost (189-211-224-40.static.axtel.net. [189.211.224.40])
        by mx.google.com with ESMTPSA id x37sm323467yhn.39.2014.05.08.01.07.22
        for <multiple recipients>
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 08 May 2014 01:07:23 -0700 (PDT)
In-Reply-To: <536B3259.1050602@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/248414>

Chris Packham wrote:
> On 06/05/14 11:50, Junio C Hamano wrote:
> > The same argument would apply to git-svn, git-p4, and git-cvsimport,
> > I would think.
> 
> A bit of a crazy suggestion and a little off-topic. Assuming maintainers
> can be found what about having these foreign vcs interfaces as
> submodules. That way they can be in Junio's tree as well as having their
> own release cycles. The same could apply to git-gui, gitk and gitweb. It
> would also be a chance to eat-our-own-dogfood with submodules.

If submodules were an integral part of Git that would be a possibility,
but they are more like a hack.

-- 
Felipe Contreras
