From: Ramkumar Ramachandra <artagnon@gmail.com>
Subject: Re: [PATCH 5/5] git-diff.txt: fix ordering of the [--no-index] form
Date: Thu, 25 Apr 2013 02:15:57 +0530
Message-ID: <CALkWK0=-Bu-x=zg2f-uY7qUkwCp_8AdDAVv6=k0oyV4xYvBuWQ@mail.gmail.com>
References: <1366821216-20868-1-git-send-email-artagnon@gmail.com>
 <1366821216-20868-6-git-send-email-artagnon@gmail.com> <7vmwsndbve.fsf@alter.siamese.dyndns.org>
 <CALkWK0kaFc8cj-=1NbEwC_61U7qUCye70d9MZR66TpKB3i9XyA@mail.gmail.com>
 <20130424190638.GE29963@google.com> <CALkWK0n2zFp1t7qtKp8-Ohoz0QEn4BQrfvxzqt+qwLS5+sNdHQ@mail.gmail.com>
 <20130424191453.GG29963@google.com> <CALkWK0=KWu3=j5sLK3hr=Gx5xLnLaPAY+E=J0_izRCj9YcBTEg@mail.gmail.com>
 <20130424203732.GJ29963@google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Junio C Hamano <gitster@pobox.com>, Git List <git@vger.kernel.org>
To: Jonathan Nieder <jrnieder@gmail.com>
X-From: git-owner@vger.kernel.org Wed Apr 24 22:46:44 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UV6aS-0004YF-B9
	for gcvg-git-2@plane.gmane.org; Wed, 24 Apr 2013 22:46:44 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757739Ab3DXUqk (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 24 Apr 2013 16:46:40 -0400
Received: from mail-ie0-f171.google.com ([209.85.223.171]:39662 "EHLO
	mail-ie0-f171.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757598Ab3DXUqj (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 24 Apr 2013 16:46:39 -0400
Received: by mail-ie0-f171.google.com with SMTP id e11so2725458iej.2
        for <git@vger.kernel.org>; Wed, 24 Apr 2013 13:46:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=x-received:mime-version:in-reply-to:references:from:date:message-id
         :subject:to:cc:content-type;
        bh=fCqWWoF1un441mnyNcf26ijK/76b+kLrCM6P7hAuKuE=;
        b=ighaiM5mxEjT31ID5GT4IrGLypw7reB7Q7Xl6xuFBS9moyLFBznnzyOxWeA4LK8zHA
         08OUtl+JQIpSGCKgJysDKhxKZt/+1gawfrYK7N3UifebB42We7vVFPFjfXcB9cb6F59f
         M7FRz+Q4IQpnt6MiTcQ1QD8pWqv4j3u/SxxS2SW4PRXimE44sWTCFw+CoF5sVhz5akfh
         +pvwLXGZOEzjZc0OUULR8JfEX1aqln6e1Y7UwGpOhG2fLExzF0lJ7OjGNE7uG1VyDhJc
         r/xlpz5Gy2BGULOMQEuDlNMr9fRVKYbRV1fcwR+HNN9ttUcJaBFrdXsATPYuHZQBWQjT
         dDBQ==
X-Received: by 10.50.57.116 with SMTP id h20mr469847igq.49.1366836399219; Wed,
 24 Apr 2013 13:46:39 -0700 (PDT)
Received: by 10.64.46.1 with HTTP; Wed, 24 Apr 2013 13:45:57 -0700 (PDT)
In-Reply-To: <20130424203732.GJ29963@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/222318>

Jonathan Nieder wrote:
>  * hard to document
> [...]

I completely disagree, but we don't have to agree: make it a
configuration variable.  Even if it's turned to "never" by default, I
don't mind having one extra line in my .gitconfig.  But you went all
"Oh please no" when I brought it up.  I thought you were claiming that
nobody finds it useful.  Now, you seem to be claiming that people who
find it useful must suffer.
