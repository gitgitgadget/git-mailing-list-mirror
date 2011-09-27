From: Johan Herland <johan@herland.net>
Subject: Re: [PATCH] notes_merge_commit(): do not pass temporary buffer to
 other function
Date: Tue, 27 Sep 2011 09:12:40 +0200
Message-ID: <CALKQrgcO20am0nU7W=hmbMYVjjGi0-REB8=Xko5NtXjjG4UZag@mail.gmail.com>
References: <1317098813-30839-1-git-send-email-mhagger@alum.mit.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>
To: Michael Haggerty <mhagger@alum.mit.edu>
X-From: git-owner@vger.kernel.org Tue Sep 27 09:31:39 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1R8S8e-0008Mr-1R
	for gcvg-git-2@lo.gmane.org; Tue, 27 Sep 2011 09:31:36 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751854Ab1I0Hbb (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 27 Sep 2011 03:31:31 -0400
Received: from locusts.copyleft.no ([178.255.144.241]:54362 "EHLO
	mail.mailgateway.no" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751713Ab1I0Hbb (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 27 Sep 2011 03:31:31 -0400
X-Greylist: delayed 1125 seconds by postgrey-1.27 at vger.kernel.org; Tue, 27 Sep 2011 03:31:30 EDT
Received: from mail-iy0-f174.google.com ([209.85.210.174])
	by mail.mailgateway.no with esmtpsa (TLSv1:RC4-SHA:128)
	(Exim 4.72 (FreeBSD))
	(envelope-from <johan@herland.net>)
	id 1R8RqO-000NC0-7H
	for git@vger.kernel.org; Tue, 27 Sep 2011 09:12:44 +0200
Received: by iaqq3 with SMTP id q3so5390183iaq.19
        for <git@vger.kernel.org>; Tue, 27 Sep 2011 00:12:40 -0700 (PDT)
Received: by 10.42.132.10 with SMTP id b10mr8884652ict.76.1317107560820; Tue,
 27 Sep 2011 00:12:40 -0700 (PDT)
Received: by 10.231.15.7 with HTTP; Tue, 27 Sep 2011 00:12:40 -0700 (PDT)
In-Reply-To: <1317098813-30839-1-git-send-email-mhagger@alum.mit.edu>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/182216>

On Tue, Sep 27, 2011 at 06:46, Michael Haggerty <mhagger@alum.mit.edu> wrote:
> It is unsafe to pass a temporary buffer as an argument to
> read_directory().
>
> Signed-off-by: Michael Haggerty <mhagger@alum.mit.edu>

ACK.

...Johan

-- 
Johan Herland, <johan@herland.net>
www.herland.net
