From: Vitor Antunes <vitor.hda@gmail.com>
Subject: Re: [PATCH] git p4 test: Check ignore files with client spec
Date: Sat, 20 Jul 2013 15:59:05 +0100
Message-ID: <CAOpHH-VSGZMNHwto-JwuiEyGHA9zvSRz-2BX=u1YU6CGarbyeg@mail.gmail.com>
References: <1374188693-547-1-git-send-email-vitor.hda@gmail.com> <20130720134837.GB18479@padd.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Cc: Git Mailing List <git@vger.kernel.org>,
	Luke Diamand <luke@diamand.org>
To: Pete Wyckoff <pw@padd.com>
X-From: git-owner@vger.kernel.org Sat Jul 20 16:59:59 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1V0YdX-0005IW-Sg
	for gcvg-git-2@plane.gmane.org; Sat, 20 Jul 2013 16:59:56 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754280Ab3GTO7h (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 20 Jul 2013 10:59:37 -0400
Received: from mail-ie0-f180.google.com ([209.85.223.180]:48909 "EHLO
	mail-ie0-f180.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754221Ab3GTO7g (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 20 Jul 2013 10:59:36 -0400
Received: by mail-ie0-f180.google.com with SMTP id f4so11690915iea.11
        for <git@vger.kernel.org>; Sat, 20 Jul 2013 07:59:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        bh=ZEf43+S/yWdA8B6gngUpxLwGAOX7zcafupS1Ba7NWpw=;
        b=KFRLO/D3c9wBniuD9RTXYreJp0lDRS6M7DevG6RgKGgIuzzrdAlGo1rJRq31PuM2C9
         PxkqQRbTk91HBM4BKFv9br6J8S9xBew4jt7Djc801h6Uo8wiZR+7O5kniMQrDw4GuQta
         mbC0ftYBBxc0OWqadZdCkt0QhDpzzPk+7OoTWQ9eI/Bd+pdxBUQrPYEeRz53Ya6FSB0s
         LacJ46lDOkdMwEeiEtfeHI/K32FsABgGeam+w7Ce5PZiqKj29MYoSwbQUqc4QGefQmfb
         fPe7X39y7HEVMXsPb9EoMqPUu6lwK32XyibJZxAfdn1FKl6YXiI8aQDohg7N1i4f/umw
         iV8g==
X-Received: by 10.50.11.102 with SMTP id p6mr14836822igb.49.1374332375949;
 Sat, 20 Jul 2013 07:59:35 -0700 (PDT)
Received: by 10.64.21.103 with HTTP; Sat, 20 Jul 2013 07:59:05 -0700 (PDT)
In-Reply-To: <20130720134837.GB18479@padd.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/230898>

On Sat, Jul 20, 2013 at 2:48 PM, Pete Wyckoff <pw@padd.com> wrote:
> I'd forgotten during your conversation with Matthieu that we
> did indeed have tests for detect-branches with use-client-spec.
> This test sure seems like it should cover that situation though.

It was good that you had some tests implemented, otherwise it would
have taken me much more time to implement this ;)
