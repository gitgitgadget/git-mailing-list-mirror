From: Andreas Ericsson <ae@op5.se>
Subject: Re: Who is the 'git' vendor?
Date: Thu, 25 Oct 2012 10:52:44 +0200
Message-ID: <5088FDDC.20404@op5.se>
References: <8F7A9DADB4F4064EB938B0D3EBB63FDC208A5A34@PBNEMBMSX4120.int.Corp.sun>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: 7bit
Cc: "'git@vger.kernel.org'" <git@vger.kernel.org>,
	"'Thor Home (thorlp@hotkey.net.au)'" <thorlp@hotkey.net.au>
To: "PROHASKA, Thor" <Thor.PROHASKA@suncorp.com.au>
X-From: git-owner@vger.kernel.org Thu Oct 25 10:53:08 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TRJBX-00070w-FL
	for gcvg-git-2@plane.gmane.org; Thu, 25 Oct 2012 10:53:03 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S934643Ab2JYIwv (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 25 Oct 2012 04:52:51 -0400
Received: from mail-la0-f46.google.com ([209.85.215.46]:51941 "EHLO
	mail-la0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S933482Ab2JYIwt (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 25 Oct 2012 04:52:49 -0400
Received: by mail-la0-f46.google.com with SMTP id h6so1146347lag.19
        for <git@vger.kernel.org>; Thu, 25 Oct 2012 01:52:47 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=message-id:date:from:user-agent:mime-version:to:cc:subject
         :references:in-reply-to:content-type:content-transfer-encoding
         :x-gm-message-state;
        bh=kI1/v5ddUzAspy561TOJXNifA3GIpU1L8xvkLbX9RqM=;
        b=h/skgv3p6b0UGztPPyWXGMwlzn9KwfdaqTIPRf6qFLMk13xZQ4zgWM8J71bjPP/BZL
         hAANeIcZIWXiJsI4gBnGvZMhF3v6JUc26v7nCTTo3wPSYj3YxRqdu/zM4nxYSLYEeXlY
         uOe7pbf4+FLWJ8hhwzWBmuxE0fcGbUaB3kBv1q5qTFYHCorS6npn2xDUfQ6sBcE3QHn+
         2KIZt+MXLysi3qN4AuvKvYBttxh9UwRd6R2vNT/f3dYHP9fH9I21C+WmtpjBr61V3+Ic
         o8+HlDwUwekONmCwZltYG3LbLjpM47lia185y5Z2F9Gu0o3SQ2dUkWlbqfZcrmz/HHhu
         KklA==
Received: by 10.112.25.161 with SMTP id d1mr7433609lbg.118.1351155167741;
        Thu, 25 Oct 2012 01:52:47 -0700 (PDT)
Received: from vix.int.op5.se (c80-217-218-226.bredband.comhem.se. [80.217.218.226])
        by mx.google.com with ESMTPS id g5sm5662628lbk.7.2012.10.25.01.52.45
        (version=TLSv1/SSLv3 cipher=OTHER);
        Thu, 25 Oct 2012 01:52:46 -0700 (PDT)
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:16.0) Gecko/20121016 Thunderbird/16.0.1
In-Reply-To: <8F7A9DADB4F4064EB938B0D3EBB63FDC208A5A34@PBNEMBMSX4120.int.Corp.sun>
X-Gm-Message-State: ALoCoQnp82UTwRSw+mTnQ5tpM/ayW68aC3dDjtkhjZVQG6ARkcOLhGNB/t1yozabBjaH42QXBFQe
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/208367>

On 10/25/2012 08:43 AM, PROHASKA, Thor wrote:
> Hi,
> 
> The organisation I am currently working for uses 'git'.
> 
> In order to manage all the software used in the organisation we have
> been compiling a list of software that includes the software Vendor's
> name.
> 
> My colleague has listed the vendor of git as being the 'Software
> Freedom Conservancy'. Can you please advise me if this is correct? If
> not, who should the vendor be identified as?
> 

Most likely, you'll want to put "git@vger.kernel.org" as vendor for git,
as the whole vendor concept doesn't really fly with FOSS. There's noone
to go to if it breaks your systems, and unless you purchase a support
contract from somewhere there's noone to turn to except the (excellent)
git community in case you have issues with it.

-- 
Andreas Ericsson                   andreas.ericsson@op5.se
OP5 AB                             www.op5.se
Tel: +46 8-230225                  Fax: +46 8-230231

Considering the successes of the wars on alcohol, poverty, drugs and
terror, I think we should give some serious thought to declaring war
on peace.
