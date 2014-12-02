From: Duy Nguyen <pclouds@gmail.com>
Subject: Re: [PATCH 00/19] Add git-list-files
Date: Tue, 2 Dec 2014 18:33:13 +0700
Message-ID: <CACsJy8Do1PancG847KYnF-SZ=qq-=ubCG--QohYxm=+kUcMNNg@mail.gmail.com>
References: <1417337767-4505-1-git-send-email-pclouds@gmail.com> <xmqqbnnnp291.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Git Mailing List <git@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Dec 02 12:33:50 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XvliG-0002co-75
	for gcvg-git-2@plane.gmane.org; Tue, 02 Dec 2014 12:33:48 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754510AbaLBLdo (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 2 Dec 2014 06:33:44 -0500
Received: from mail-ie0-f179.google.com ([209.85.223.179]:33715 "EHLO
	mail-ie0-f179.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754171AbaLBLdo (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 2 Dec 2014 06:33:44 -0500
Received: by mail-ie0-f179.google.com with SMTP id rp18so10963141iec.24
        for <git@vger.kernel.org>; Tue, 02 Dec 2014 03:33:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        bh=nkzz/gCJb/nyOmvDGA9l7vWN+0sRT97qpm/Vg+K8GZA=;
        b=drwwDXB7afEoOO0JTf/gPkB1dJ7Fs9yEPn2PC4nVXlkh/85ED24oF1UgSVSyM5c/0L
         q8X+fW2r5S82p0kj4j998v0/jVxU6TrF8CNT0qB2dfsYgnzoXxVjeski1AuyNsSPOuSH
         PZaS2qGbzRclaJ9FAujiCl/UmKkT2UyNy3EWSQMVb9gsdEuI5i6G51/7NWfFMjS/ITGV
         pu8Gm9+Hv1THsoOG1J+18qMbk8kmXGQP+vqJ7aU/sfnWMM5oWy12S6PZK59CM2rX4eFu
         IzleOHvZgQn60SwbyCcX4sAN7jSV2v/7S8weW2ylDcchVLddpUhdUzc5HmOExlr+JXBI
         xsIA==
X-Received: by 10.107.163.142 with SMTP id m136mr55704748ioe.86.1417520023252;
 Tue, 02 Dec 2014 03:33:43 -0800 (PST)
Received: by 10.107.176.3 with HTTP; Tue, 2 Dec 2014 03:33:13 -0800 (PST)
In-Reply-To: <xmqqbnnnp291.fsf@gitster.dls.corp.google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/260553>

On Tue, Dec 2, 2014 at 3:02 AM, Junio C Hamano <gitster@pobox.com> wrote:
> Does this contain a lot of borrowed code or something?  The style
> violation in the patches are unusually high, even compared with your
> other series.

The first one is from coreutils, but I reformatted (and trimmed) to
fit Git. I recall you had a script to spot style violation, right?
Where can I find the script? Else I'll reread CodingGuidlines again
and go through the patch.


> I've tried to fix it up and will push out the result on 'pu' if
> things work OK, but this does not even have tests, so it is unlikely
> that it would break anything but itself ;-)

Heh.. ;) Next version will come with tests. Thanks for the reminder.
-- 
Duy
