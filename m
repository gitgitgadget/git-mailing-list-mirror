From: Antoine Pelisse <apelisse@gmail.com>
Subject: Re: [PATCH 2/3] remote-hg: allow invalid bookmarks in a few edge cases
Date: Wed, 19 Mar 2014 16:18:58 +0100
Message-ID: <CALWbr2xa9pJ5wXJGB8Q6ZL9CWsVCPdhW5n-VbGZpTsmgjd6XhQ@mail.gmail.com>
References: <1395232399-60112-1-git-send-email-max@quendi.de>
	<1395232399-60112-2-git-send-email-max@quendi.de>
	<CALWbr2yb9_Kumm697w2c68xE6JPpkF9OfxvP2acsPjPFq=zboQ@mail.gmail.com>
	<CDB4DDFC-FF7F-4BE0-A0B5-0933A506F690@quendi.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT
Cc: git <git@vger.kernel.org>
To: Max Horn <max@quendi.de>
X-From: git-owner@vger.kernel.org Wed Mar 19 16:19:10 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WQIGo-0001lv-Sm
	for gcvg-git-2@plane.gmane.org; Wed, 19 Mar 2014 16:19:07 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965215AbaCSPTB (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 19 Mar 2014 11:19:01 -0400
Received: from mail-lb0-f172.google.com ([209.85.217.172]:41594 "EHLO
	mail-lb0-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S965001AbaCSPTA convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 19 Mar 2014 11:19:00 -0400
Received: by mail-lb0-f172.google.com with SMTP id c11so6064876lbj.31
        for <git@vger.kernel.org>; Wed, 19 Mar 2014 08:18:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        bh=m8tEtwmBza/HIpmBb0a6ZYE8HmkRH34O/ApADs37fDU=;
        b=bbCkdPiXcQXu4+vdgLuolRE1FKysw3BYXq5PXIZVPzdIjbwDsFEA8LlUR1Wub6Bhvd
         JSphQFuRxjky06aSSdB0lOiLtGMhV1KKvmQ8wRhu77Lt8DxCS9G68aYeqZW5f5XOpY+P
         Ts3BvKvzo5vzwsJWErfg3V7WN8pNsrbjd+IvBS18ERvzwQn+PpYKdjIQQZ/c0X3j50lu
         eSAenTlY6DU/bNFQ8mwFJMMjFoxHvzSHn7J2vzN6uUpRD0B7AbC+f8i8+SVodXClDO76
         xgtIQXLkUc0set72zbtDSSstxwb5f784dgrw7w+shCXtqz//9yC3LvcCkQaZ3Oxu5UJz
         l9AQ==
X-Received: by 10.152.87.14 with SMTP id t14mr1462645laz.52.1395242339035;
 Wed, 19 Mar 2014 08:18:59 -0700 (PDT)
Received: by 10.112.142.68 with HTTP; Wed, 19 Mar 2014 08:18:58 -0700 (PDT)
In-Reply-To: <CDB4DDFC-FF7F-4BE0-A0B5-0933A506F690@quendi.de>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/244452>

On Wed, Mar 19, 2014 at 4:00 PM, Max Horn <max@quendi.de> wrote:
>> Thank you for working on this.
>> I believe it would be fair that you forget about patch 1/3 as you fix
>> it in this patch (2/3).
>> Also, I think it would be best NOT to integrate a patch (mine) that
>> breaks a test, as it
>> would make bisect harder to use.
>
> OK, makes sense. I didn't want to step on anybodies feet by hijacking previously made work (however small or big it might be -- I've been burned by this before). Anyway, so I'll squash the first two commits together (or all three even?), and edit the message. But I'd like to properly attribute that you discovered the issue, so perhaps I can add something like "Reported-by: Antoine Pelisse" or so?

Yes,
I think you can squash all three commits into one, and use the
reported-by line that you mentioned.

Thanks,
Antoine
