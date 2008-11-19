From: "Constantine Plotnikov" <constantine.plotnikov@gmail.com>
Subject: Re: [PATCH] Retain multiple -q/-v occurrences in git pull
Date: Wed, 19 Nov 2008 14:46:30 +0300
Message-ID: <85647ef50811190346x11aea0fay3a8a7dfd8ddf6abc@mail.gmail.com>
References: <1226959770-4252-1-git-send-email-tuncer.ayaz@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org, gitster@vger.kernel.org
To: "Tuncer Ayaz" <tuncer.ayaz@gmail.com>
X-From: git-owner@vger.kernel.org Wed Nov 19 12:47:49 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1L2lXA-0004Pi-0W
	for gcvg-git-2@gmane.org; Wed, 19 Nov 2008 12:47:48 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751938AbYKSLqc (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 19 Nov 2008 06:46:32 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752197AbYKSLqc
	(ORCPT <rfc822;git-outgoing>); Wed, 19 Nov 2008 06:46:32 -0500
Received: from fk-out-0910.google.com ([209.85.128.185]:3915 "EHLO
	fk-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751657AbYKSLqc (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 19 Nov 2008 06:46:32 -0500
Received: by fk-out-0910.google.com with SMTP id 18so3915424fkq.5
        for <git@vger.kernel.org>; Wed, 19 Nov 2008 03:46:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from:to
         :subject:cc:in-reply-to:mime-version:content-type
         :content-transfer-encoding:content-disposition:references;
        bh=VRHVLccT4TjkcqZ7POnwbeJDA0puCv7xJhI6NvW6Iac=;
        b=IY/TCXWzptQv9uFKXuBLns6gOsnxpW1RV3gvnNpp/MB0VKAQD8mCEsyCGkFoBMgAAY
         +Mx+lsJSrqkM+0QInu48U5yJbnX21Z+TbGKoREDkT9mQmtFBcNDHtEXzLTw8X/2IYv68
         nOq49MJDoMP9QrDH6g7VDxv4RsjsH5KnPgEB0=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:to:subject:cc:in-reply-to:mime-version
         :content-type:content-transfer-encoding:content-disposition
         :references;
        b=gHNcyRoaI5Ad3WD4Xrd0KTz1h/J1/hoJVehyM+/LvsRFvPEYEFPlSbDKp6Lo8Vl5LH
         61mlzoS22Hj1Iq7qWMttbASMQ9D7wpIh2LbSTU2DCy60P8WkWGA8EyLfKIWGsTyeI75P
         HT+1L+NvZ3/Zf6u2RtMFax69Mti4w+Fd4UoQM=
Received: by 10.180.233.15 with SMTP id f15mr289483bkh.188.1227095190250;
        Wed, 19 Nov 2008 03:46:30 -0800 (PST)
Received: by 10.180.230.10 with HTTP; Wed, 19 Nov 2008 03:46:30 -0800 (PST)
In-Reply-To: <1226959770-4252-1-git-send-email-tuncer.ayaz@gmail.com>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/101326>

On Tue, Nov 18, 2008 at 1:09 AM, Tuncer Ayaz <tuncer.ayaz@gmail.com> wrote:
> To support counting -q/-v options in git pull retain
> them by concatenating.
>
[rest of message cut]

By the way, there is yet another way to invoke git fetch. It is "git
remote update". Possibly it should support "-v" and "-q" options for
consistency as well.

Regards,
Constantine
