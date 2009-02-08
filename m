From: Jonas Fonseca <fonseca@diku.dk>
Subject: Re: [ANNOUNCE] tig-0.14
Date: Sun, 8 Feb 2009 11:13:42 +0100
Message-ID: <2c6b72b30902080213v48b8420do2d53ddf6fda09aa1@mail.gmail.com>
References: <20090205204436.GA6072@diku.dk>
	 <20090206191511.GD19494@coredump.intra.peff.net>
	 <2c6b72b30902061410l64c98c33g19b97f656d347c83@mail.gmail.com>
	 <m3r62buqiv.fsf@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: Jeff King <peff@peff.net>, git@vger.kernel.org
To: Jakub Narebski <jnareb@gmail.com>
X-From: git-owner@vger.kernel.org Sun Feb 08 11:15:12 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LW6gx-0003Sz-LR
	for gcvg-git-2@gmane.org; Sun, 08 Feb 2009 11:15:12 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752995AbZBHKNq (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 8 Feb 2009 05:13:46 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752999AbZBHKNp
	(ORCPT <rfc822;git-outgoing>); Sun, 8 Feb 2009 05:13:45 -0500
Received: from mail-fx0-f20.google.com ([209.85.220.20]:36286 "EHLO
	mail-fx0-f20.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752931AbZBHKNo (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 8 Feb 2009 05:13:44 -0500
Received: by fxm13 with SMTP id 13so2066808fxm.13
        for <git@vger.kernel.org>; Sun, 08 Feb 2009 02:13:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:sender:received:in-reply-to
         :references:date:x-google-sender-auth:message-id:subject:from:to:cc
         :content-type:content-transfer-encoding;
        bh=lPjaH7pNwZp4f+RnuYIwyjUKkSbMw2/Sq5mbBL/nzO4=;
        b=An3gIL490VGA+KvzoqKhYalGaKJ0wX9+tWhX6VNqmr29eSjLxmhA3m23IMnwdiwNJl
         9luEic2uOH+cHfvAv9haA4alQNmYXhAdLu3nySpJHX8v5Ol3pj0aQ84DPRXkbv2I8bn0
         bGfYSpLdkb4kF1rBCKAETvBDo7nD0/5yqsinw=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:sender:in-reply-to:references:date
         :x-google-sender-auth:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        b=e5oa6enkoyQw4sbEkRFmV2NATsbN/XWx01mfk69aaz9oeMfm+j7cOceFJcjSaY7HXh
         BqezolkKStBNhuZYv+UP6q4f7/0909IDroVhQFYp5HtMQvy78UqX+2dNi/76XJTg/mIY
         kAdx/TcJJvXFhWAmM9ZUh01pfh8922JdgXYm8=
Received: by 10.181.61.18 with SMTP id o18mr1357463bkk.66.1234088022642; Sun, 
	08 Feb 2009 02:13:42 -0800 (PST)
In-Reply-To: <m3r62buqiv.fsf@localhost.localdomain>
X-Google-Sender-Auth: 5a1c664e577d5c02
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/108946>

On Fri, Feb 6, 2009 at 23:53, Jakub Narebski <jnareb@gmail.com> wrote:
> Jonas Fonseca <fonseca@diku.dk> writes:
>> It should be possible to find the
>> original line number either by making git-blame also honor
>> --show-number for the --incremental output or by using the "porcelain"
>> version:
>>
>>   git blame --show-number -L <line>,<line> <rev> <file>
>
> Errr... you are wrong.  There are three line numbers when browsing
> blame output.  Original line number, line number in _blamed_ commit
> (shown with --show-number, --porcelain, --incremental), and line
> number in _parent_ of blamed commit... which we don't know, and
> which I don't think it is easy to find...

Yes, I was not aware of the original line number being there. Anyway,
tig now uses this to jump to the right line when the user requests to
show blame for specific commit.

-- 
Jonas Fonseca
