From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PULL] git-svn URL canonicalization fixes for 2.8
Date: Wed, 16 Mar 2016 14:14:36 -0700
Message-ID: <CAPc5daVA3puby+LcTcFzinCEh96i9crnM64tB9LQ4cX8+nC23A@mail.gmail.com>
References: <20160316204824.GA1571@dcvr.yhbt.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Adam Dinwoodie <adam@dinwoodie.org>,
	Git Mailing List <git@vger.kernel.org>
To: Eric Wong <normalperson@yhbt.net>
X-From: git-owner@vger.kernel.org Wed Mar 16 22:15:12 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1agImY-0006QI-4Z
	for gcvg-git-2@plane.gmane.org; Wed, 16 Mar 2016 22:15:06 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755816AbcCPVO7 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 16 Mar 2016 17:14:59 -0400
Received: from mail-yw0-f178.google.com ([209.85.161.178]:33902 "EHLO
	mail-yw0-f178.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755778AbcCPVO5 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 16 Mar 2016 17:14:57 -0400
Received: by mail-yw0-f178.google.com with SMTP id h129so77727303ywb.1
        for <git@vger.kernel.org>; Wed, 16 Mar 2016 14:14:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:sender:in-reply-to:references:from:date:message-id
         :subject:to:cc;
        bh=lrigXXOwP/FTLTQQO3OPz/4SRpeh+Lf0REF5U3BmEuA=;
        b=UUqdA3xaBeJ+ZYWebs5+BEf1OW88r5JugHZQcQd4xMaK5sQIWZ0Md4W8L/CceJUmDG
         mqoxwk+RmysCFdUCs8kpJ9Q5Oty2GDf+7HYqePTSlRHsrkoy09F6CkxWt0vaRKWW/7Iq
         6UZXmX7Ngj0wDpcV595IEakKpCx2k7OceJQt5dMw3Q0Ey61sa24zQ7hSbS/d6XO7swXt
         u8GpPFIXZkyC21XClXz0fx+EjwI5Qgncs0rH02mX17+8Ud60Hdk6D0hoVZuxXCzgxK8R
         ZnWjcJJgL09Ne338ma4fINLwu75O8mtO9KW2tTy2o1bB8xuWx6LUDdHrlo5wsVmnMfeM
         kDfw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:sender:in-reply-to:references:from
         :date:message-id:subject:to:cc;
        bh=lrigXXOwP/FTLTQQO3OPz/4SRpeh+Lf0REF5U3BmEuA=;
        b=JzRlxLlsSFiw1iMkwyoVKxqVHUpYGqMzUZ94rdLvWcMU4Q25+ynOcT4MgfGBoEM1k3
         gKguSc03I5Ve1iVzHS8ITryx0R0Jeap89TsRbhDllwA0iZC/bL3WnBkDxBRURYVtymRi
         VBm/QvL1pf7HDaLrIoQZh8tgsRh1I89t/BP0ErPgHljkXJFLQ5+NAw/C0U0N4wsKp80G
         tusqg997EObpcNbF+TuLMFgP+MmDg5ACsXI1beuojaDoJ7h4gkHoxVmZ/DH+wRMSRCGe
         KWo/MtFssWxRmTSK4uQpnRsQUZas2BquAkVRTZGWf3xMz+SsHjGlgU1+1xUMLElWkkY0
         xkWQ==
X-Gm-Message-State: AD7BkJIYEwoW0lJRh+6yN+rV/UbtS8adhm3t2yPJQ0oqjbuhuexqR+3bkutXfI3OdiWAXGG5/Q8E/YhgGTH4Uw==
X-Received: by 10.13.226.20 with SMTP id l20mr2630300ywe.294.1458162896148;
 Wed, 16 Mar 2016 14:14:56 -0700 (PDT)
Received: by 10.129.116.131 with HTTP; Wed, 16 Mar 2016 14:14:36 -0700 (PDT)
In-Reply-To: <20160316204824.GA1571@dcvr.yhbt.net>
X-Google-Sender-Auth: LXdQOYoR__fpIOLZHhRJcljuWXA
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/289040>

On Wed, Mar 16, 2016 at 1:48 PM, Eric Wong <normalperson@yhbt.net> wrote:
>   git://bogomips.org/git-svn.git master
>
> for you to fetch changes up to b557165311f7ed1b94d94a74e7ea3a6e76bbbe88:

Thanks, I was about to tag v2.8-rc3, but will make sure to include this there.
