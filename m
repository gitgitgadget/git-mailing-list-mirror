From: Bert Wesarg <bert.wesarg@googlemail.com>
Subject: Re: Any way to get complete diff up to a tag?
Date: Thu, 6 May 2010 11:42:09 +0200
Message-ID: <AANLkTim3MnUdYDfMuIC-jPcgzvMJuRqupVaaGPmJyPjP@mail.gmail.com>
References: <A612847CFE53224C91B23E3A5B48BAC74482E50D9F@xmail3.se.axis.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: "git@vger.kernel.org" <git@vger.kernel.org>
To: Peter Kjellerstedt <peter.kjellerstedt@axis.com>
X-From: git-owner@vger.kernel.org Thu May 06 11:42:19 2010
connect(): No such file or directory
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1O9xb0-0001YY-8B
	for gcvg-git-2@lo.gmane.org; Thu, 06 May 2010 11:42:18 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756568Ab0EFJmM (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 6 May 2010 05:42:12 -0400
Received: from mail-iw0-f197.google.com ([209.85.223.197]:41938 "EHLO
	mail-iw0-f197.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751534Ab0EFJmL (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 6 May 2010 05:42:11 -0400
Received: by iwn35 with SMTP id 35so7640899iwn.21
        for <git@vger.kernel.org>; Thu, 06 May 2010 02:42:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=gamma;
        h=domainkey-signature:mime-version:received:received:in-reply-to
         :references:date:message-id:subject:from:to:cc:content-type;
        bh=KdwOBA/iM5Owgd90FiZgtCN6E2qrO1kRTGKY8HgG06M=;
        b=BAlKm4HTfpPwtSBcQh1Tgb+XsiiJG6bDozXh9GHKsx7J3hOsp8JMPnXS2cmjo1TBce
         RWCMo8wmEmn0mtMpN8yWYhnIysFlDlwN9MpJu6qO72jdu+L01K9DyQteunJSaQnm/PdK
         UIzl/oNvij9/CMhxijos0dBnmTUJy57i05rZE=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=googlemail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        b=khur/0NThqycsRAFgTL4evl933tq1+zgdSoGC1wVxdNyKElJqltR5cKmq5mr4IvB9z
         Bs9+t05pZH5dj3p3HCGnSnn/qNL4gVDoVKv7sdF0TL/Uavs+bXKz2sCvM3WqeHp8plwE
         Ti+pZ1JuVPFOMQ3LeuaBFx1bkqlcvnzyX4FcE=
Received: by 10.231.160.195 with SMTP id o3mr1421683ibx.32.1273138929905; Thu, 
	06 May 2010 02:42:09 -0700 (PDT)
Received: by 10.231.39.205 with HTTP; Thu, 6 May 2010 02:42:09 -0700 (PDT)
In-Reply-To: <A612847CFE53224C91B23E3A5B48BAC74482E50D9F@xmail3.se.axis.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/146469>

On Thu, May 6, 2010 at 11:27, Peter Kjellerstedt
<peter.kjellerstedt@axis.com> wrote:
> I almost get what I want, but the initial commit is still missing.
> Is there any way to get that initial commit included in the diff?

git diff-tree -p 4b825dc642cb6eb9a060e54bf8d69288fbee4904 v1.7.1^{tree}

Bert
