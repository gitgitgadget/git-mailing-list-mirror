From: Ramkumar Ramachandra <artagnon@gmail.com>
Subject: Re: [PATCH 5/5] git-diff.txt: fix ordering of the [--no-index] form
Date: Wed, 24 Apr 2013 23:59:54 +0530
Message-ID: <CALkWK0kaFc8cj-=1NbEwC_61U7qUCye70d9MZR66TpKB3i9XyA@mail.gmail.com>
References: <1366821216-20868-1-git-send-email-artagnon@gmail.com>
 <1366821216-20868-6-git-send-email-artagnon@gmail.com> <7vmwsndbve.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Git List <git@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Apr 24 20:30:42 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UV4So-0007Ru-7o
	for gcvg-git-2@plane.gmane.org; Wed, 24 Apr 2013 20:30:42 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756824Ab3DXSag (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 24 Apr 2013 14:30:36 -0400
Received: from mail-ie0-f176.google.com ([209.85.223.176]:38193 "EHLO
	mail-ie0-f176.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756550Ab3DXSaf (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 24 Apr 2013 14:30:35 -0400
Received: by mail-ie0-f176.google.com with SMTP id x14so2514810ief.21
        for <git@vger.kernel.org>; Wed, 24 Apr 2013 11:30:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=x-received:mime-version:in-reply-to:references:from:date:message-id
         :subject:to:cc:content-type;
        bh=RzhIlYUPfgq4301x5NmnUyGqV27Nao1ncAlYBa6JtwM=;
        b=njf10FiSaChKazOn6DD4A6EPso1QQmfgzRk8zhNTHu1vmSJo5cpowbuYMSGNAnI7SA
         daDuJ6r6Rl4KyxLDPPEX5W7c1+lYbyx/iz+BilZPvo1sQPBX9qB6yNOeDfuYsKelkPJy
         ShYLa5eEGUbR8APwEt6D273ZSzUSca9iYWH4MyMgewtsiIgxzLztfSPbsdbIDCcm5gpm
         u4OGiNJIEmo4Sol9aX1GivYS+eiBv0+sGD7tTUnhXne2SSWRrm3cTGA0X1DT4YdCksxw
         fRhSynUmiaSgDxhV6lR2t/cmJVDWsjbxK6anVmxbCu9vqDYdo2ptqJPz7LY9QuBoxaWu
         abmA==
X-Received: by 10.50.57.200 with SMTP id k8mr28874973igq.44.1366828235111;
 Wed, 24 Apr 2013 11:30:35 -0700 (PDT)
Received: by 10.64.46.1 with HTTP; Wed, 24 Apr 2013 11:29:54 -0700 (PDT)
In-Reply-To: <7vmwsndbve.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/222289>

Junio C Hamano wrote:
> The "--no-index" mode was a hack to allow "git diff" goodies to be
> used outside the context of "git", and a proper execution of it
> should have been to send patches to GNU or BSD diff maintainers, not
> to add the "--no-index" option that is unrelated to "git" to our
> code.

Yeah, I know.  I use it instead of diff all the time.

> I think it is more correct to list it as a footnote and list
> separately from the main text, which is what the original SYNOPSIS
> section does.

I was trying to be more "correct" here.  The form is a special case of
the first form where the number of paths are limited to two.  Besides,
isn't that how the DESCRIPTION section explains it now?
