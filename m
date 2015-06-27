From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v4 0/6] refs backend preamble
Date: Sat, 27 Jun 2015 11:44:12 -0700
Message-ID: <xmqq1tgxf0ub.fsf@gitster.dls.corp.google.com>
References: <1435379036-30894-1-git-send-email-dturner@twopensource.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: git@vger.kernel.org, mhagger@alum.mit.edu
To: David Turner <dturner@twopensource.com>
X-From: git-owner@vger.kernel.org Sat Jun 27 20:44:21 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Z8v5Q-0001LO-Pt
	for gcvg-git-2@plane.gmane.org; Sat, 27 Jun 2015 20:44:21 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753215AbbF0SoQ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 27 Jun 2015 14:44:16 -0400
Received: from mail-ie0-f177.google.com ([209.85.223.177]:35212 "EHLO
	mail-ie0-f177.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752039AbbF0SoO (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 27 Jun 2015 14:44:14 -0400
Received: by iebrt9 with SMTP id rt9so93749454ieb.2
        for <git@vger.kernel.org>; Sat, 27 Jun 2015 11:44:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version:content-type;
        bh=7FLau37MNdr1yy82su2Zo7zxwunnl4wNqQPm6KTWHso=;
        b=DC03/143bCtjktaAj8mRApQfVMrS1XZL+Db4nrWEHtKj0clB9Vl9lqnWa+8idXSLSq
         M7JvGO8I1zjxul1ImXHtIUGKhwevmRBRsIpxXBfD0Xod5EOjb9iiWcq98ciPqZ4bQnCF
         2+qL5gFp+x0x7bcDwZb4/eqk8zrxbU0xczX6e2oj4HM9r+K0uv4mGLRc4eZlE05lnhNP
         46UNaYduC7kHTjBoCqsik22OoypBNhwVkbt2bmdonpSgS9MXoWvsyNTySXB+rRZWyDP4
         pW6p7p409l8+miX8UqUfIcW5xJY4FVQp6QGuNGmkyg37KWmDz499eCMX8Q/Ql9GeqAb9
         /ELg==
X-Received: by 10.107.157.205 with SMTP id g196mr10414338ioe.57.1435430654030;
        Sat, 27 Jun 2015 11:44:14 -0700 (PDT)
Received: from localhost ([2620:0:10c2:1012:205e:4a52:83c1:a37f])
        by mx.google.com with ESMTPSA id t93sm857873ioe.13.2015.06.27.11.44.13
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Sat, 27 Jun 2015 11:44:13 -0700 (PDT)
In-Reply-To: <1435379036-30894-1-git-send-email-dturner@twopensource.com>
	(David Turner's message of "Sat, 27 Jun 2015 00:23:50 -0400")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/272861>

David Turner <dturner@twopensource.com> writes:

> This version addresses Junio's comments on v3.

The end result makes more sense than the previous one, but did you
screw up when rewriting and/or squashing patches around the new 4/6?

I think that one has two separate changes mixed into one and does a
lot more than "this is just for clarity".  I think they should stay
separate, as the other changes are more impactful and deserve their
own justification and explanation.

Thanks.
