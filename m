From: Kevin Ballard <kevin@sb.org>
Subject: Re: [PATCH] Fallback on _NSGetExecutablePath to get the executable path if using argv[0] fails
Date: Mon, 29 Nov 2010 15:13:22 -0800
Message-ID: <7534C13D-A52A-4BA4-B8C5-14E17CFA0351@sb.org>
References: <051964C9-0507-4CCB-A111-55CA36652F00@apple.com> <AANLkTimwRJqje1-HhzKj-L-5-2CvhTC0+Pr0Cvj7d_kc@mail.gmail.com> <20101129171211.GL8037@burratino>
Mime-Version: 1.0 (Apple Message framework v1082)
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Cc: Thiago Farina <tfransosi@gmail.com>,
	Jeremy Huddleston <jeremyhu@apple.com>, git@vger.kernel.org
To: Jonathan Nieder <jrnieder@gmail.com>
X-From: git-owner@vger.kernel.org Tue Nov 30 00:13:32 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PNCuY-0007Dm-Gu
	for gcvg-git-2@lo.gmane.org; Tue, 30 Nov 2010 00:13:30 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753830Ab0K2XN0 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 29 Nov 2010 18:13:26 -0500
Received: from mail-pw0-f46.google.com ([209.85.160.46]:60871 "EHLO
	mail-pw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753453Ab0K2XNZ (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 29 Nov 2010 18:13:25 -0500
Received: by pwj3 with SMTP id 3so835221pwj.19
        for <git@vger.kernel.org>; Mon, 29 Nov 2010 15:13:25 -0800 (PST)
Received: by 10.142.174.12 with SMTP id w12mr6317815wfe.14.1291072405084;
        Mon, 29 Nov 2010 15:13:25 -0800 (PST)
Received: from [10.8.0.89] ([69.170.160.74])
        by mx.google.com with ESMTPS id f5sm8104853wfg.2.2010.11.29.15.13.23
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Mon, 29 Nov 2010 15:13:24 -0800 (PST)
In-Reply-To: <20101129171211.GL8037@burratino>
X-Mailer: Apple Mail (2.1082)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/162450>

On Nov 29, 2010, at 9:12 AM, Jonathan Nieder wrote:

> The section "2) #ifdefs are ugly" of
> linux-2.6/Documentation/SubmittingPatches explains the rationale.

Might this be worth pulling into git.git/Documentation/CodingGuidelines?

-Kevin Ballard
