From: Nicolas Cornu <ncornu@aldebaran-robotics.com>
Subject: Re: [PATCH v2] gitk: Add a horizontal scrollbar for commit history
Date: Wed, 30 Oct 2013 13:47:08 +0100
Message-ID: <CAMXp-VMku0eSQmmbdy-NQDedH4VSgZN5XmpTeBHvN8qX1=ersg@mail.gmail.com>
References: <1383130702-4966-1-git-send-email-ncornu@aldebaran-robotics.com>
	<5270F4FC.60900@viscovery.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Cc: git@vger.kernel.org, paulus@samba.org
To: Johannes Sixt <j.sixt@viscovery.net>
X-From: git-owner@vger.kernel.org Wed Oct 30 13:47:15 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VbVB3-0000Qp-Q1
	for gcvg-git-2@plane.gmane.org; Wed, 30 Oct 2013 13:47:14 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753896Ab3J3MrJ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 30 Oct 2013 08:47:09 -0400
Received: from mail-ie0-f169.google.com ([209.85.223.169]:46237 "EHLO
	mail-ie0-f169.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753777Ab3J3MrI (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 30 Oct 2013 08:47:08 -0400
Received: by mail-ie0-f169.google.com with SMTP id ar20so2149132iec.14
        for <git@vger.kernel.org>; Wed, 30 Oct 2013 05:47:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=aldebaran-robotics.com; s=google;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        bh=UUBP4DSdUiVHUCMQERgKWDV1I3XSKktvTOy5mXQygaM=;
        b=jphbAvnfetdZJL7cL4pA+ZJv9wmGDQ6n4Ivdde2Ffg5b7RuSAP5BPxkVpfA/WoADjv
         uv46FwwWtLLIzD0tvv1i4b8e6aguT1q5yN4hMFMef93x9YdH0omksKIqFl0WxaKWVN+E
         Y2vQAgHPFotkKYkLS2Yy6RuTh4wdDiTcRLtp0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:date
         :message-id:subject:from:to:cc:content-type;
        bh=UUBP4DSdUiVHUCMQERgKWDV1I3XSKktvTOy5mXQygaM=;
        b=JX86olSpqBfp7g3iSgpZ6l45T9743mtRs0vMNUMJY7HEDqIKT93z/wH5hoR8/f38SO
         iQ7erVOhsSpmDixIJDZY3yCiC1wsHKbIJnoYbc5x+NFcUPXi2TjcBlIBWxLLGuwQlIlJ
         uUEbHkodcRnLc6fHSgBQzID5dIJWLxNsICHn+2H12t+Bqn8F59tMGOE9sDuiT5W1162a
         +OHgwK9EsFJ3tGMjFW+gjQ2uojO+6Yj376JwS3dHIFdvGdsMm4kCWsSRvUoUdi7VpkGE
         fKSG4B8JmJ6jxDlKG68TbwuoNEdtvyK94hO6PC08OICA1KfENKYDbAlQHRC8hWmucFdj
         +d+g==
X-Gm-Message-State: ALoCoQlB5fFdCceLlAy5vCA9sghYz682mmgpXOEFlH6Nd6VlUSZ0U0XrnBZCx+72XoMG3si3wPlE
X-Received: by 10.43.152.78 with SMTP id kv14mr3026323icc.13.1383137228064;
 Wed, 30 Oct 2013 05:47:08 -0700 (PDT)
Received: by 10.64.25.165 with HTTP; Wed, 30 Oct 2013 05:47:08 -0700 (PDT)
In-Reply-To: <5270F4FC.60900@viscovery.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/237016>

This is useful on all our repos, every times, as we put a tag per day.
If the HEAD didn't move during 150 days, we got 150 tags.
So, it depends, maybe can I put it as an option in Edit > Preferences?

2013/10/30 Johannes Sixt <j.sixt@viscovery.net>:
> Am 10/30/2013 11:58, schrieb Nicolas Cornu:
>> This scrollbar is not optional and is useful if there is a lot of tags or
>> branches.
>
> If this is the "only" case where the scrollbar is useful, i.e., it would
> be handy only once every other week, then it is better to remember that
> you can pan around in the window by moving the mouse with the middle mouse
> button held down. Vertical screen estate in the commit history pane is too
> precious to waste for a scrollbar that is useless most of the time.
>
> -- Hannes
