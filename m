From: Ramkumar Ramachandra <artagnon@gmail.com>
Subject: Re: [PATCH v7 12/12] cherry-pick: copy notes and run hooks
Date: Thu, 24 Apr 2014 19:04:34 -0400
Message-ID: <CALkWK0k3OTsvaqxrpJzhGNwSHg8tZ2tuhiO8Rd-AsHLp6WOL9A@mail.gmail.com>
References: <1398307491-21314-1-git-send-email-felipe.contreras@gmail.com> <1398307491-21314-13-git-send-email-felipe.contreras@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Git List <git@vger.kernel.org>,
	Jonathan Nieder <jrnieder@gmail.com>,
	Martin von Zweigbergk <martinvonz@gmail.com>
To: Felipe Contreras <felipe.contreras@gmail.com>
X-From: git-owner@vger.kernel.org Fri Apr 25 01:05:28 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WdShs-0001V8-5c
	for gcvg-git-2@plane.gmane.org; Fri, 25 Apr 2014 01:05:28 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754714AbaDXXFT (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 24 Apr 2014 19:05:19 -0400
Received: from mail-ie0-f175.google.com ([209.85.223.175]:62719 "EHLO
	mail-ie0-f175.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754553AbaDXXFO (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 24 Apr 2014 19:05:14 -0400
Received: by mail-ie0-f175.google.com with SMTP id to1so3104125ieb.34
        for <git@vger.kernel.org>; Thu, 24 Apr 2014 16:05:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        bh=vLnwvnGXO5PlgJJorItml3TiT4BVfJ5GJPxfvVVcAqs=;
        b=kdNXY4xQ4PBcN+CZPp5SIqbiZwnRfB8opz2hrtuzPBHYkD0XLc3xc/0a5FBSF3yTkW
         29QbxAzHj+FvyCacTV7zXMqpS/qOyPDQxk9c+bDUFCNN5PpOtgtLWn43Vfr+KSMPYmhb
         R01T+ENB1w9aP2NKD5s6LPEJCckvLfCJLPHgXH5m76Pp5CJV24qeRhZ4CPL2KnVPu+ks
         tpKE/P0CkAl2cGGCUnzTEryhsCHhKsuBbn6d7iI9DzAJ7x4HLv8X8gZm4l+hQ2rZydwk
         n9c0AGf2jqrPmeR6RVTkzTI5Ezd7B6L70LOKX7rfaK8OUBohllMsvbJyB7N3H9YlxXD9
         TKfQ==
X-Received: by 10.42.50.3 with SMTP id y3mr4514795icf.12.1398380714167; Thu,
 24 Apr 2014 16:05:14 -0700 (PDT)
Received: by 10.64.10.39 with HTTP; Thu, 24 Apr 2014 16:04:34 -0700 (PDT)
In-Reply-To: <1398307491-21314-13-git-send-email-felipe.contreras@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/247021>

Felipe Contreras wrote:
> If no action-name is specified, nothing is done.

Why? Is it because git-rebase implements its own notes-copy-on-rewrite logic?

Otherwise, I agree with the goal of making notes.rewrite.<command>
work for cherry-pick.
