From: =?UTF-8?Q?Vicent_Mart=C3=AD?= <tanoku@gmail.com>
Subject: Re: [PATCH 07/16] compat: add endinanness helpers
Date: Tue, 25 Jun 2013 15:25:14 +0200
Message-ID: <CAFFjANSNagvDgvrFNV1OLg=-4BPyQVjMDnfMPihdhVJR7o0TdQ@mail.gmail.com>
References: <1372116193-32762-1-git-send-email-tanoku@gmail.com>
 <1372116193-32762-8-git-send-email-tanoku@gmail.com> <alpine.DEB.2.00.1306251404510.9929@ds9.cixit.se>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: git@vger.kernel.org
To: Peter Krefting <peter@softwolves.pp.se>
X-From: git-owner@vger.kernel.org Tue Jun 25 15:25:40 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UrTFb-0007xY-D2
	for gcvg-git-2@plane.gmane.org; Tue, 25 Jun 2013 15:25:39 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751256Ab3FYNZf (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 25 Jun 2013 09:25:35 -0400
Received: from mail-ve0-f178.google.com ([209.85.128.178]:57018 "EHLO
	mail-ve0-f178.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750830Ab3FYNZe (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 25 Jun 2013 09:25:34 -0400
Received: by mail-ve0-f178.google.com with SMTP id pb11so10180627veb.9
        for <git@vger.kernel.org>; Tue, 25 Jun 2013 06:25:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        bh=z8wt7H7AuA5DI4atFuqptqFNT2yTkGIra6Iz+tVvfN0=;
        b=dLEsiFaB8qQPUVRxEhb/gFhFlB7U9z//S3yza0iwHpVZnxK03EyFyP45+LoDHCCjzY
         p9zODzT2BriG8TVXHsoHiTPbVALJTwUzO4rxWCyJBQcUPT+C2IaYt79gPZX1sfbj2W37
         R0juq+yuzqFcRqNQPmRpHTMiYzO4agz5ZHof5xdqqO55HixoV+xHs+s2N7H8CDPBX7iL
         B6xMZotJChn60SZWbIWkDArxv5rlqwBmcBXkjZB/hYvcDgJeWheXYO0D+MxR1lHuXNQx
         eoVeoxuZ0DIfhGvk4N+avzNzdUyPDBfHzKkBJHHS2lSvHVNLS9+AXoWrh6bR0zomt0fW
         fCvQ==
X-Received: by 10.220.73.135 with SMTP id q7mr13861597vcj.33.1372166734107;
 Tue, 25 Jun 2013 06:25:34 -0700 (PDT)
Received: by 10.221.45.131 with HTTP; Tue, 25 Jun 2013 06:25:14 -0700 (PDT)
In-Reply-To: <alpine.DEB.2.00.1306251404510.9929@ds9.cixit.se>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/228960>

On Tue, Jun 25, 2013 at 3:08 PM, Peter Krefting <peter@softwolves.pp.se> wrote:
> endian(3) claims that glibc 2.9+ define be64toh() and htobe64() which should
> do what you are looking for. The manual page does mention them being named
> differently across OSes, though, so you may need to be careful with that.

I'm aware of that, but Git needs to build with glibc 2.7+ (or was it
2.6?), hence the need for this compat layer.
