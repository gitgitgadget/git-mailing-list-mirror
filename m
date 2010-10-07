From: Sverre Rabbelier <srabbelier@gmail.com>
Subject: Re: [PATCHv5 1/8] commit.c: prefer get_header() to manual searching
Date: Thu, 7 Oct 2010 23:11:47 +0200
Message-ID: <AANLkTinj5eZ7p8qW7U1iqNcjN4EG6HcftD2+etGvSKPA@mail.gmail.com>
References: <1286478657-61581-1-git-send-email-patnotz@gmail.com> <1286478657-61581-2-git-send-email-patnotz@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: git@vger.kernel.org
To: Pat Notz <patnotz@gmail.com>
X-From: git-owner@vger.kernel.org Thu Oct 07 23:12:17 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1P3xlA-0002pj-DF
	for gcvg-git-2@lo.gmane.org; Thu, 07 Oct 2010 23:12:16 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755716Ab0JGVMK (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 7 Oct 2010 17:12:10 -0400
Received: from mail-yw0-f46.google.com ([209.85.213.46]:37311 "EHLO
	mail-yw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753551Ab0JGVMJ (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 7 Oct 2010 17:12:09 -0400
Received: by ywh1 with SMTP id 1so118217ywh.19
        for <git@vger.kernel.org>; Thu, 07 Oct 2010 14:12:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:mime-version:received:in-reply-to
         :references:from:date:message-id:subject:to:cc:content-type;
        bh=up1/hWBQaXtBoFqhvXs1sGw40tAEwt3vmJa7fHQ3jYQ=;
        b=eDfyZ/qeHo6Md4e9mGIey8j/ULXyAXHPEpIlG4J1NQpDV4xUOmsI6ljDR8WRrZ7EQx
         GV0ewaNFXt0NxQSYIdfbyttUEaKTH7Q+RiMFCbwYvfTzz+5lK/HoWFc03bqgse6IRtX2
         SHBulPALDiVPLON+Lo5pYLeBVDuWmBoJC75kc=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        b=yGyo0lVAElxiFUkVuErRnR2JFMwOr+BSrAzSdsjHsTz7p/SceJ2J58gX8BIcShrlWD
         rOqJ6MUWaeHX4QpSbRBxR5nMZRXxmqW0crJ8EXsqiJj0XVp7R9oIZRXNf6L4pSgnxr/x
         xT4hHgzkRLTaqbrf+0Rzr3GqWUpHcb9XnmUvY=
Received: by 10.151.85.14 with SMTP id n14mr1871683ybl.44.1286485928189; Thu,
 07 Oct 2010 14:12:08 -0700 (PDT)
Received: by 10.151.15.8 with HTTP; Thu, 7 Oct 2010 14:11:47 -0700 (PDT)
In-Reply-To: <1286478657-61581-2-git-send-email-patnotz@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/158457>

Heya,

On Thu, Oct 7, 2010 at 21:10, Pat Notz <patnotz@gmail.com> wrote:
> Signed-off-by: Pat Notz <patnotz@gmail.com>

Cover letter?

-- 
Cheers,

Sverre Rabbelier
