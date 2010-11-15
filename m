From: Jay Soffian <jaysoffian@gmail.com>
Subject: Re: [RFC] rebase: use @{upstream} if no upstream specified
Date: Mon, 15 Nov 2010 15:12:17 -0800
Message-ID: <AANLkTikewL5PcUDrmOx9EXRftz4xr4ROjPLxvW7oUJi7@mail.gmail.com>
References: <1289595349-12589-1-git-send-email-martin.von.zweigbergk@gmail.com>
 <EDBF4929-2ECF-4CDD-9F0B-0EE3B6BA68A7@sb.org> <AANLkTi=sEVHTqWqcdztcEv6kTZgscVYZWr-N0SBMRwvc@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Kevin Ballard <kevin@sb.org>, git@vger.kernel.org
To: Martin von Zweigbergk <martin.von.zweigbergk@gmail.com>
X-From: git-owner@vger.kernel.org Tue Nov 16 00:13:14 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PI8EX-0006yR-GP
	for gcvg-git-2@lo.gmane.org; Tue, 16 Nov 2010 00:13:09 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758525Ab0KOXM6 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 15 Nov 2010 18:12:58 -0500
Received: from mail-qy0-f174.google.com ([209.85.216.174]:47565 "EHLO
	mail-qy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755112Ab0KOXMs (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 15 Nov 2010 18:12:48 -0500
Received: by qyk12 with SMTP id 12so4288304qyk.19
        for <git@vger.kernel.org>; Mon, 15 Nov 2010 15:12:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:mime-version:received:in-reply-to
         :references:from:date:message-id:subject:to:cc:content-type;
        bh=sm6nVVq6hUb+XTvb1ORGN1dCDZOyU1jiL+iLnqnihTo=;
        b=ZF/JgF2DWL+iljyuHmLqNpatMY9h8P4UOkMBzhYWIeInFtyIMxjZ9AzXnON/BMqe7U
         kEaKCRmClAXRbjBQQJlC+521LvSuxHqxl6kSm4IClbqUgIwxIWZkaml6eg3hlQw7xvZ3
         l30iOVqlDBe4b5Z38izG5U3kASxYVq8GhB2jc=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        b=f6ILOZES9ayVcwl2XRN7G6I+rW2U1FM+jWnxM75/O6TCAVBxjqTmAuJRgMHcNJt0gk
         ze0R0YaNXuZchFhTbu92xvZfMKG6RDlaqRAeGswTHFZSyGcW94D0NmnsiMF3QuIN1MM1
         HiW8NQ2X5I0fWSZHQX0N2kiJ0JzTTYUvVkq5I=
Received: by 10.224.19.207 with SMTP id c15mr1141092qab.14.1289862767433; Mon,
 15 Nov 2010 15:12:47 -0800 (PST)
Received: by 10.220.183.134 with HTTP; Mon, 15 Nov 2010 15:12:17 -0800 (PST)
In-Reply-To: <AANLkTi=sEVHTqWqcdztcEv6kTZgscVYZWr-N0SBMRwvc@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/161523>

On Mon, Nov 15, 2010 at 3:06 PM, Martin von Zweigbergk
<martin.von.zweigbergk@gmail.com> wrote:
> do you think it is sensible to default to '@{upstream}'?

I certainly do.

j.
