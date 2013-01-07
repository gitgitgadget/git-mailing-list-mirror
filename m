From: =?UTF-8?B?6YOR5paH6L6JKFRlY2hsaXZlIFpoZW5nKQ==?= 
	<techlivezheng@gmail.com>
Subject: Re: [PATCH 1/8] Use %B for Split Subject/Body
Date: Mon, 7 Jan 2013 23:18:02 +0800
Message-ID: <CAPYzjrT_8g26y-QrYvbQYoySWskGdn15jCX60rz04wQFQ2ikVw@mail.gmail.com>
References: <1357012655-24974-1-git-send-email-greened@obbligato.org>
 <1357012655-24974-2-git-send-email-greened@obbligato.org> <7vtxr1bg4g.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Cc: "David A. Greene" <greened@obbligato.org>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon Jan 07 16:27:35 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TsEbi-0002on-7p
	for gcvg-git-2@plane.gmane.org; Mon, 07 Jan 2013 16:27:22 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753245Ab3AGP1B (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 7 Jan 2013 10:27:01 -0500
Received: from mail-vb0-f45.google.com ([209.85.212.45]:55018 "EHLO
	mail-vb0-f45.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753075Ab3AGP1A (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 7 Jan 2013 10:27:00 -0500
Received: by mail-vb0-f45.google.com with SMTP id p1so19696943vbi.32
        for <git@vger.kernel.org>; Mon, 07 Jan 2013 07:27:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        bh=4ZSLcum+VgZ4/oFPLgZ4PkPXhZK+DMn+b4c8znMpyv8=;
        b=DeIAmxMfXe2Lh0j3SvsN2TU0/hmIe+HZlCwnflYj49O0kEhltFJoECL11oi/qo3rhK
         RCLD1NTbhcR6GdTIRMZrtvU7nfWIQfis1L6vXSEvOJVivr90C3g6JOGGpLvAeaPtrdv1
         +HhJjVr+l1Nw4ZXwPeFxmBdqU+ve8KCY2PTENCPgDz03fwI/9+4LHM75knjY0JObMEL7
         qRxwsGRH8IBQLqo165rSltckG296bLkDlCu3Y3UrnEFPew0NJIOupfsGKMtbDSFpJAzU
         8lJLf9IcMQIhy/LTgnnlET07qYAe83b0JNGsbhyAgFIixYwsgMpwpYEBC0YlOe5UXZBE
         IBLg==
Received: by 10.52.21.107 with SMTP id u11mr72022660vde.101.1357571922340;
 Mon, 07 Jan 2013 07:18:42 -0800 (PST)
Received: by 10.58.106.48 with HTTP; Mon, 7 Jan 2013 07:18:02 -0800 (PST)
In-Reply-To: <7vtxr1bg4g.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/212897>

2013/1/1 Junio C Hamano <gitster@pobox.com>:
> "David A. Greene" <greened@obbligato.org> writes:
>
>> From: Techlive Zheng <techlivezheng@gmail.com>
>>
>> Use %B to format the commit message and body to avoid an extra newline
>> if a commit only has a subject line.
>
> Is this an unconditional improvement, or is it generally an
> improvement but for some users it may be a regression?  I am
> guessing it is the former but am just making sure.

This patch will make sure the commits in the result branch by using
`git-subtree split` stays intact as they were in the original branch.

This patch will break the current existing branch that splitted before
this patch, becuase these branches were splitted with the wrongly
altered commit messages.

Maybe a fallback option should be added to make sure these branches
could still be updated.

Though, this patch defintely should be merged, becuase no one expects
his commit message be altered durging the splitting process.
