From: Junio C Hamano <gitster@pobox.com>
Subject: Re: Building git 2.4.5 on AIX 6.1 problems
Date: Thu, 09 Jul 2015 22:09:51 -0700
Message-ID: <xmqq1tggmwdc.fsf@gitster.dls.corp.google.com>
References: <516b832bd9db48e4bdb486d63b2a3977@imap.force9.net>
	<xmqqwpy9uqth.fsf@gitster.dls.corp.google.com>
	<a4eee6a136cafece6be5dbd5ee934f7a@imap.force9.net>
Mime-Version: 1.0
Content-Type: text/plain
Cc: <git@vger.kernel.org>
To: John Norris <john@norricorp.f9.co.uk>
X-From: git-owner@vger.kernel.org Fri Jul 10 07:10:02 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZDQZT-0004ze-Uk
	for gcvg-git-2@plane.gmane.org; Fri, 10 Jul 2015 07:10:00 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751869AbbGJFJ4 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 10 Jul 2015 01:09:56 -0400
Received: from mail-ig0-f172.google.com ([209.85.213.172]:37555 "EHLO
	mail-ig0-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751772AbbGJFJz (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 10 Jul 2015 01:09:55 -0400
Received: by igpy18 with SMTP id y18so5505403igp.0
        for <git@vger.kernel.org>; Thu, 09 Jul 2015 22:09:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version:content-type;
        bh=dBJH2vK6dELV/VxN8JzqtMY0+joDX23cL8tlx0ZbasY=;
        b=ISUZTHWo3Sjom5YujnyWxH+23JlctP/t8Q5xZL7mQd4t4+lqty0DQoBxYlZYoVojeO
         SkX+4TPVyEkpfVFVFC3eeLNiRMDuyYIWdUGbM0vbClMXAHDesmI9bc4BLp9zoC3ebNJ4
         EvtZtR55c94bJCjnPECLpGyY64jrAsQ6LlbJCL/g0R78MyVj9Z7gcYPtgcPW+sdjfmPB
         Ag+M5dsmnrAh+YEbXSAXq8JPb6ok1BDV0nFpGX9GRZf1ZOVYyZ3GyahxlC+HHqOlptRG
         YMsCBn7klIEG9euJlKm/FvfpsqH3Yr0+nBLB2QAkS3eFjDMM/oe4HyDFDd0KDmUZdDZi
         aRAw==
X-Received: by 10.50.114.40 with SMTP id jd8mr1385860igb.47.1436504994549;
        Thu, 09 Jul 2015 22:09:54 -0700 (PDT)
Received: from localhost ([2620:0:10c2:1012:647a:d824:a8a3:7bb0])
        by smtp.gmail.com with ESMTPSA id n30sm5751068ioi.38.2015.07.09.22.09.52
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Thu, 09 Jul 2015 22:09:53 -0700 (PDT)
In-Reply-To: <a4eee6a136cafece6be5dbd5ee934f7a@imap.force9.net> (John Norris's
	message of "Fri, 10 Jul 2015 04:32:37 +0000")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/273803>

John Norris <john@norricorp.f9.co.uk> writes:

> But there are a few archive commands before I get to linking
> credentials-store. Is there something special about credentials store?
> And is the collect2 an AIX library or general library used by git?

Wow, that's a blast from the past.  My recollection is vague, as it
has at least been 15 years since I had to hear that name causing
trouble the last time ;-), but collect2 is a gcc thing that is used
on a platform, where the native linker cannot be directly used to
link gcc output with libraries, as "ld" replacement/wrapper.

 
