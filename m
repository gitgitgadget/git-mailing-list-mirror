From: Ping Yin <pkufranky@gmail.com>
Subject: Re: How to recover from "reset --hard"
Date: Sat, 22 Aug 2009 14:06:42 +0800
Message-ID: <46dff0320908212306v6b4aec03g761e1ee9035462c4@mail.gmail.com>
References: <46dff0320908211953u2f63cdb4m9cab863266a03df7@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
To: git mailing list <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Sat Aug 22 08:06:52 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Mejka-0005KF-8J
	for gcvg-git-2@lo.gmane.org; Sat, 22 Aug 2009 08:06:52 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933193AbZHVGGl (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 22 Aug 2009 02:06:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S933166AbZHVGGl
	(ORCPT <rfc822;git-outgoing>); Sat, 22 Aug 2009 02:06:41 -0400
Received: from mail-yx0-f175.google.com ([209.85.210.175]:46363 "EHLO
	mail-yx0-f175.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S933104AbZHVGGk (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 22 Aug 2009 02:06:40 -0400
Received: by yxe5 with SMTP id 5so675995yxe.33
        for <git@vger.kernel.org>; Fri, 21 Aug 2009 23:06:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :date:message-id:subject:from:to:content-type
         :content-transfer-encoding;
        bh=R9PjZ+ZDjeKIRxXTl5hqw3BAOzRq4SUPZ6Yvh23Hrfc=;
        b=R4XcTYQ4C97A0T9J2glm/NgkuD0JwUYV+JxHaOSAgDf81R6oVXCKS5eakCkr7NuLEv
         GtG94enEIcodFaUtjuPB94M6jUMg5MBgE3Xj8djMkRKU2sP39uXQR3/I3ek/NvYrU+gE
         jNEOZNsjEOihTQbmLZp/02+zkJvwFnSCVjRGA=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :content-type:content-transfer-encoding;
        b=j5Q4PK3Cq4A8AshgMpxZ4higoY5BOrk3MESjhXnqDgo2kuQKUVKBivmFEEuG7xXSDp
         tnJjESfXKwrzjbUJEompokIPrL5lYAU/O+cVkOzwv0TaFcLwpaeDGScCpTrcckrvYgjx
         YwMVwhq+ShX8lL7GtI4bWxiyTWhSR0oF+6ul0=
Received: by 10.91.78.19 with SMTP id f19mr1642416agl.95.1250921202134; Fri, 
	21 Aug 2009 23:06:42 -0700 (PDT)
In-Reply-To: <46dff0320908211953u2f63cdb4m9cab863266a03df7@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/126798>

On Sat, Aug 22, 2009 at 10:53 AM, Ping Yin<pkufranky@gmail.com> wrote:
> After adding a file to index, i do a "reset --hard", then how do i
> recovery the file?
>
> I want write all lost files to a directory and find it according to
> the file size.
>
> Does "git fsck --lost-found" write this file to .git\lost-found\other ?

It does. I just remembered the wrong size of the file. Sorry for the noise.
