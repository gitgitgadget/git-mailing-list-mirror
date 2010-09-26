From: Avery Pennarun <apenwarr@gmail.com>
Subject: Re: 'git diff' against files outside a git repo
Date: Sun, 26 Sep 2010 02:38:21 -0700
Message-ID: <AANLkTikJ-SN5xmwqhEHcESfQCWvGjSHp3OK1Hi4+0jBL@mail.gmail.com>
References: <AANLkTinR7BJpD-FOS_DShg=r0ucF2C9oE6p-YoZU-5En@mail.gmail.com>
 <AANLkTik4kL8Mao1VM=njNxFSXOY7guwuEZgmpv0UTc8R@mail.gmail.com>
 <AANLkTikpPQM4GyP5O7+aw6_P9_1DdxUjTzpH=WhzW=wK@mail.gmail.com> <7vwrq9m0y0.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Cc: Elijah Newren <newren@gmail.com>,
	Git Mailing List <git@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sun Sep 26 11:38:51 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Oznh4-0004md-PG
	for gcvg-git-2@lo.gmane.org; Sun, 26 Sep 2010 11:38:51 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755480Ab0IZJio (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 26 Sep 2010 05:38:44 -0400
Received: from mail-wy0-f174.google.com ([74.125.82.174]:62884 "EHLO
	mail-wy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754863Ab0IZJin (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 26 Sep 2010 05:38:43 -0400
Received: by wyb28 with SMTP id 28so3060067wyb.19
        for <git@vger.kernel.org>; Sun, 26 Sep 2010 02:38:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:mime-version:received:in-reply-to
         :references:from:date:message-id:subject:to:cc:content-type;
        bh=CzlL+hTYh1O/gLBgfEQinQnvHLSIZbSofCAZsoJvh2g=;
        b=P3vRLSbUFZ7eet7FYK8171e1m6HOO4v2pw1BYWLzUq/dYhp4cxyLuXbKv4Cf5VPiGU
         Qwyp99/AKST2zsjwx9WCyjN3jIEkOLsKyA+Dc67KXfZFm0yABJQE3oXGAuNhx+g2yvDL
         /GMSHPnwShgpiE/C+ZLdRpx7gsqs2dx/FxReg=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        b=iEwUabWbpUuUeWE30VAiBZkiqUKb2tCvR7u0A/o06qjHP33Mn7PGgTeHYuSStwbxs6
         K8k4UqpX68kkQUg3D9z4AVO+oD0+OzHWG53YWCRxpMdvBuPZthH82QodfE2Qf0XYH6M5
         7Ylx/IOm2fltoYJVAUb6q1snBsFP0rlwR7sFY=
Received: by 10.216.71.132 with SMTP id r4mr11474367wed.102.1285493922113;
 Sun, 26 Sep 2010 02:38:42 -0700 (PDT)
Received: by 10.216.165.15 with HTTP; Sun, 26 Sep 2010 02:38:21 -0700 (PDT)
In-Reply-To: <7vwrq9m0y0.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/157215>

On Sun, Sep 26, 2010 at 12:13 AM, Junio C Hamano <gitster@pobox.com> wrote:
> Avery Pennarun <apenwarr@gmail.com> writes:
>
>> Oddly, 'git diff file1 file2' *doesn't* work when file1 and file2 are
>> in a working tree; git tries to diff something, apparently, but I
>> don't know what.
>
> Heh, I thought you've been using git long enough that you sh/would know
> that you are comparing the index and the working tree, using "file1" and
> "file2" as pathspecs.

Ha, of course.  And I do that all the time, so it's silly that I
somehow forgot for the duration of that email.

The real surprise was that this *wasn't* the meaning when I was
outside a git tree :)

Have fun,

Avery
