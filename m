From: Alex Riesen <raa.lkml@gmail.com>
Subject: Re: git ls-files handles paths differently in Windows and Mac
 (probably Linux)
Date: Tue, 12 Oct 2010 17:25:22 +0200
Message-ID: <AANLkTi=6nJAYKB_MTjXL3oftcWtr_wtdHaULYzRcP6oP@mail.gmail.com>
References: <3C33A244-2449-4A3C-A8B5-2060CE61EE04@jetbrains.com>
	<AANLkTimB6s_yt6L59xpqsWO_yBsZxuVCiExFoSm9FcN1@mail.gmail.com>
	<C29949EA-5717-4BA3-936E-354FCB107877@jetbrains.com>
	<38052CF8-66F3-40FD-8D2D-8FD58A622F7B@jetbrains.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: git@vger.kernel.org
To: Kirill Likhodedov <Kirill.Likhodedov@jetbrains.com>
X-From: git-owner@vger.kernel.org Tue Oct 12 17:25:31 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1P5gjJ-0000yt-CR
	for gcvg-git-2@lo.gmane.org; Tue, 12 Oct 2010 17:25:29 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757392Ab0JLPZY (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 12 Oct 2010 11:25:24 -0400
Received: from mail-qy0-f174.google.com ([209.85.216.174]:49270 "EHLO
	mail-qy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757347Ab0JLPZX (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 12 Oct 2010 11:25:23 -0400
Received: by qyk5 with SMTP id 5so887041qyk.19
        for <git@vger.kernel.org>; Tue, 12 Oct 2010 08:25:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:received:in-reply-to
         :references:date:message-id:subject:from:to:cc:content-type;
        bh=+3bmyn8/R+D6GG7OKzMZx99xdPtXDyOcHCXjxjUvgg0=;
        b=pZQyyKDE6VcrysBm4VC/l8M6VOIi7ywt5s1e2geBq4snFfScwyHkzVAJZLD+DJaa7i
         73nrbUlkKvKgrse3GFc9fJme+FFT+Xujitv6rF1l08uEI6CZXPlrnsmCuNgjvvWg/FjH
         Pntz9jqL2QpFM0B/WMRw9uWIwkpY6j8Jo2bZI=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        b=j7ScewZ2RfdOC0ydmCv9AqnKniFwOeNH3wpEzu+WUfLesLRT2t0K78lxwYxaGZQgZm
         ej5Hrmbvo4hK1vCLSs9Qpi4DbU4AXs3DoM+H+3pyNaNaoa8uAxdUxaA8hSd6N3dMZHX1
         HUBXYRbc18un77e8u2zpdlABWuz4D4wPhMZlw=
Received: by 10.224.67.74 with SMTP id q10mr1932021qai.17.1286897122994; Tue,
 12 Oct 2010 08:25:22 -0700 (PDT)
Received: by 10.229.87.212 with HTTP; Tue, 12 Oct 2010 08:25:22 -0700 (PDT)
In-Reply-To: <38052CF8-66F3-40FD-8D2D-8FD58A622F7B@jetbrains.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/158856>

On Tue, Oct 12, 2010 at 15:52, Kirill Likhodedov
<Kirill.Likhodedov@jetbrains.com> wrote:
> And also "git diff --name-status" doesn't show unversioned files.
> As I've found, "git ls-files" is the only command which shows unversioned files (except git status), isn't it?

Yes, you're right. What are you trying to do, BTW?
