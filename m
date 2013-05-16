From: Felipe Contreras <felipe.contreras@gmail.com>
Subject: Re: [PATCH 0/3] Support for old:new remote-helper push
Date: Thu, 16 May 2013 04:15:59 -0500
Message-ID: <CAMP44s1eNPQggd7UJ0XZ+JX0ywa6rDiN-HQQLx+bCp1mrmpEgA@mail.gmail.com>
References: <1368063095-22861-1-git-send-email-felipe.contreras@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
	Elijah Newren <newren@gmail.com>,
	Sverre Rabbelier <srabbelier@gmail.com>,
	Felipe Contreras <felipe.contreras@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu May 16 11:16:08 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UcuI9-0004Qz-VO
	for gcvg-git-2@plane.gmane.org; Thu, 16 May 2013 11:16:06 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751107Ab3EPJQC (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 16 May 2013 05:16:02 -0400
Received: from mail-lb0-f173.google.com ([209.85.217.173]:34024 "EHLO
	mail-lb0-f173.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751072Ab3EPJQA (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 16 May 2013 05:16:00 -0400
Received: by mail-lb0-f173.google.com with SMTP id t10so2884765lbi.18
        for <git@vger.kernel.org>; Thu, 16 May 2013 02:15:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:x-received:in-reply-to:references:date:message-id
         :subject:from:to:cc:content-type;
        bh=CjCG5Cpb1FRZtuPQ7s26jDvQNAsA3v2cBw94KSlPKOM=;
        b=k0/BstkgQPAySDW/W8dHAQcQ7O40fhw5odQpTqqLO0IZciiPyODnqqFV4Ugp2yxng6
         1tuzuQZZ5Ig9cKt4E6tBQqSLN4RxKHkXe0KkTDRTcnX3kib4UMX0Fl6ElS1m8lppjMvk
         e28ne3KJLF5rHijDdJiNV/FW+O/nDKPmZFWzv9I2vdJOQVLQ34b7SDs5LqOuxa6ero+Q
         wDf3bKK96iqDiJMhPOGxxEt4jpMNgdx3Tf5eAGoruUzEIrDIpCbFYlbhcR3IMPRAyLI9
         c21M94Z9hmzA00F67k6vI79EDnaeCJq06vEYp6SvXRf8frPx1fR3w/L3gyLJI3Mr3D0E
         5nZA==
X-Received: by 10.112.145.72 with SMTP id ss8mr19754300lbb.12.1368695759191;
 Thu, 16 May 2013 02:15:59 -0700 (PDT)
Received: by 10.114.184.3 with HTTP; Thu, 16 May 2013 02:15:59 -0700 (PDT)
In-Reply-To: <1368063095-22861-1-git-send-email-felipe.contreras@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/224518>

On Wed, May 8, 2013 at 8:31 PM, Felipe Contreras
<felipe.contreras@gmail.com> wrote:

> In order to support pushing old:new refspecs in remote-helpers, the best way to
> do what is to add an option to fast-export to rename the refs in the stream, so
> here it is:

I'm not going to work on this series any more.

-- 
Felipe Contreras
