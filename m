From: Dennis Kaarsemaker <dennis@kaarsemaker.net>
Subject: Re: Reading remote reflogs
Date: Fri, 29 Mar 2013 23:56:20 +0100
Message-ID: <1364597780.30202.7.camel@localhost>
References: <1364595928.30202.4.camel@localhost>
	 <7vd2uhn7u1.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri Mar 29 23:56:58 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ULiE7-0000ow-V4
	for gcvg-git-2@plane.gmane.org; Fri, 29 Mar 2013 23:56:52 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757239Ab3C2W4Y (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 29 Mar 2013 18:56:24 -0400
Received: from mail-ee0-f46.google.com ([74.125.83.46]:33209 "EHLO
	mail-ee0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757227Ab3C2W4X (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 29 Mar 2013 18:56:23 -0400
Received: by mail-ee0-f46.google.com with SMTP id e49so382891eek.19
        for <git@vger.kernel.org>; Fri, 29 Mar 2013 15:56:22 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=x-received:message-id:subject:from:to:cc:date:in-reply-to
         :references:content-type:x-mailer:mime-version
         :content-transfer-encoding:x-gm-message-state;
        bh=vQQL7d0ul8cn0m8doR7cMcV3P7aHt2bSzKZK20/CDbA=;
        b=pmiMm7gW7Hq3nSLmenIpvUtEl2SxZEqgsZqOqQ8dA5mIKc+Infx/1nOq0AjwT4xIY/
         G/QzOK5AhVPuNWW0+dXhJ9AMqfIOnbhZrt1JiTlayi+tmYwvLW//BA6P4NkLoVd+8R6b
         haVQUeAOGTqFYxnAF0E5AvjT4LFFlPGnSgmHXCZqgkVmwwC4KGEvU9kqJ1dsW2JQX4m6
         fS3SOCw0crIn0TSaIwXkU6MqHBp7//IFtCkhY2BLspbkjN/oggYxvuO+r99/T1XfaNS7
         ZYYnWfjbz4/bKb3xPYmoUp0fNug9/zeBSBvcmTMNiZh7nR+xMLnfy3QK1GS2jHoePwoA
         WRLQ==
X-Received: by 10.14.200.137 with SMTP id z9mr12150553een.20.1364597782100;
        Fri, 29 Mar 2013 15:56:22 -0700 (PDT)
Received: from [10.42.1.4] (82-168-11-8.ip.telfort.nl. [82.168.11.8])
        by mx.google.com with ESMTPS id ca4sm6711293eeb.15.2013.03.29.15.56.21
        (version=TLSv1 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Fri, 29 Mar 2013 15:56:21 -0700 (PDT)
In-Reply-To: <7vd2uhn7u1.fsf@alter.siamese.dyndns.org>
X-Mailer: Evolution 3.6.2-0ubuntu0.1 
X-Gm-Message-State: ALoCoQnqD8LAXsD3eqrVYMiYWk+dg2U8+3WR9S2P0w7k0xhmMTdYbdT2Pj0lv51ei9wfzydS4YJo
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/219537>

On vr, 2013-03-29 at 15:45 -0700, Junio C Hamano wrote:
> Dennis Kaarsemaker <dennis@kaarsemaker.net> writes:
> 
> > ... Mirrored repositories don't
> > maintain a reflog, even with core.logAllRefUpdates = true,...
> 
> Are you sure about this?  When log_all_ref_updates is not set, by
> default we do not log for bare repositories, but other than that, we
> do not do anything special with respect to reflogs.

I was, as I tried the recipe below, though with a different repo. Must
have goofed something up, as it works now. Thanks for the braincheck :)

That gives me a reasonable approximation of distinct pushes if I pull
the mirror often enough. It's always going to be an approximation
though, so the original question still stands.
-- 
Dennis Kaarsemaker
www.kaarsemaker.net
