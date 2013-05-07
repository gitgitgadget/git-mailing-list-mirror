From: Felipe Contreras <felipe.contreras@gmail.com>
Subject: Re: [PATCH] remote-bzr: fix for disappeared revisions
Date: Tue, 7 May 2013 18:42:42 -0500
Message-ID: <CAMP44s2j+f9vNu45vo0PSr6KEwhvaLUY+N1SU95PkQvKq6nB+w@mail.gmail.com>
References: <1367969975-4163-1-git-send-email-felipe.contreras@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Junio C Hamano <gitster@pobox.com>,
	Felipe Contreras <felipe.contreras@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed May 08 01:42:51 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UZrWy-0007Jg-RF
	for gcvg-git-2@plane.gmane.org; Wed, 08 May 2013 01:42:49 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753757Ab3EGXmp (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 7 May 2013 19:42:45 -0400
Received: from mail-lb0-f181.google.com ([209.85.217.181]:44316 "EHLO
	mail-lb0-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750989Ab3EGXmo (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 7 May 2013 19:42:44 -0400
Received: by mail-lb0-f181.google.com with SMTP id w10so1338121lbi.12
        for <git@vger.kernel.org>; Tue, 07 May 2013 16:42:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:x-received:in-reply-to:references:date:message-id
         :subject:from:to:cc:content-type;
        bh=QVLoShiMmLoH/J2ymp+8sX2Az6vsat0G3D1VaGl/03I=;
        b=Wn7frX10niniNtlkBzvov6dIETs0dsz+N6K//6yl6a7NQaLMYp5YeClsFQ6c+Hrl63
         zrahBqaqtTOmQ8TZl5w37EYJKUl4vAhO8r5qF5WhwVa9k6uivOHt5i08FTzgJljIdq1x
         w8xSCCRf1WrGlGknCNSumHVGkgRYap+MEdSN3OwkzYQNLJneGrj2xDXtvJ22YfWx379I
         ArYEB728lWgjQkhvxaFCVpwCj/5aS/28Jb/p5yXVZtjuOvfSRstNvitiMzqH+ppFJMP4
         WeVmmkohXocRniRIhQAKdl/AYNwYS0xf5Cd65YgjYGSu7ITyroHNMaqQXI+r/ysZTnhO
         2dFQ==
X-Received: by 10.112.166.101 with SMTP id zf5mr1922769lbb.59.1367970162929;
 Tue, 07 May 2013 16:42:42 -0700 (PDT)
Received: by 10.114.184.3 with HTTP; Tue, 7 May 2013 16:42:42 -0700 (PDT)
In-Reply-To: <1367969975-4163-1-git-send-email-felipe.contreras@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/223630>

On Tue, May 7, 2013 at 6:39 PM, Felipe Contreras
<felipe.contreras@gmail.com> wrote:

> +  (cd gitrepo &&
> +  git fetch &&
> +  git log --format="%an %ad %s" --date=short origin/master > ../actual) &&
> +
> +  test_cmp actual expected

Hmm:

test_cmp expected actual

-- 
Felipe Contreras
