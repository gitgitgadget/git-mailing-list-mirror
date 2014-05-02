From: Felipe Contreras <felipe.contreras@gmail.com>
Subject: Re: [PATCH v6 4/7] pull: add --merge option
Date: Fri, 02 May 2014 15:14:44 -0500
Message-ID: <5363fcb47c77d_135215292ec3c@nysa.notmuch>
References: <1398988808-29678-1-git-send-email-felipe.contreras@gmail.com>
 <1398988808-29678-5-git-send-email-felipe.contreras@gmail.com>
 <20140502013753.GE75770@vauxhall.crustytoothpaste.net>
 <536305def1e35_23b2147b2f0bb@nysa.notmuch>
 <20140502193250.GF75770@vauxhall.crustytoothpaste.net>
Mime-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org, Andreas Krey <a.krey@gmx.de>,
	John Keeping <john@keeping.me.uk>, Jeff King <peff@peff.net>,
	Richard Hansen <rhansen@bbn.com>,
	Philip Oakley <philipoakley@iee.org>,
	"W. Trevor King" <wking@tremily.us>
To: "brian m. carlson" <sandals@crustytoothpaste.net>,
	Felipe Contreras <felipe.contreras@gmail.com>
X-From: git-owner@vger.kernel.org Fri May 02 22:25:32 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WgK1Q-0005kp-03
	for gcvg-git-2@plane.gmane.org; Fri, 02 May 2014 22:25:28 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752635AbaEBUZY (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 2 May 2014 16:25:24 -0400
Received: from mail-ob0-f170.google.com ([209.85.214.170]:52220 "EHLO
	mail-ob0-f170.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750841AbaEBUZX (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 2 May 2014 16:25:23 -0400
Received: by mail-ob0-f170.google.com with SMTP id vb8so5841250obc.29
        for <git@vger.kernel.org>; Fri, 02 May 2014 13:25:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=date:from:to:cc:message-id:in-reply-to:references:subject
         :mime-version:content-type:content-transfer-encoding;
        bh=VT+qZvMJuDiPsZ5KYsIELD2cENEEGLS+31MnqHE9b58=;
        b=dWg4B6vAaMEUD9WWknYmpl7lEMNTAT4V0RXNiQBOY1N7Pjr4hCYMLRKFuTo5/7jJ+w
         y9U/1VyrQmcYoCmh+4IFvuXAEMTv336uJbLVy0EJ0FrpYplYmiMaoA7CTUSPckpZ0tQX
         5x2+WfqJMxQWXzwOYvCnwwxhJ3zKB3daHH4q89RIqTcxK0zD6Lu0CGTQ0XnXQhMwRJJp
         hcpvDA5bwh2gUUH+Jl6cQcLkHj1AYvbd6NJO3r19lAZwODdfvjOp6KvWF3NeCF7xhlSa
         x4D9KuMZ9vUSha3h/GBnhV3gFA98ai9jhshVFbpyGfHn8ZFvmV/m4syfktzzpqm1Goac
         Jh5Q==
X-Received: by 10.182.66.202 with SMTP id h10mr17586722obt.38.1399062322900;
        Fri, 02 May 2014 13:25:22 -0700 (PDT)
Received: from localhost (189-211-224-40.static.axtel.net. [189.211.224.40])
        by mx.google.com with ESMTPSA id oz15sm74134oeb.13.2014.05.02.13.25.20
        for <multiple recipients>
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 02 May 2014 13:25:21 -0700 (PDT)
In-Reply-To: <20140502193250.GF75770@vauxhall.crustytoothpaste.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/247967>

brian m. carlson wrote:
> My point is that it's unclear to me what options I need to use to
> retain the current behavior (fast-forward if possible, merge
> otherwise) without a warning.

The current behavior is to always merge (ff or otherwise), just what
`git merge` would do, so `git pull --merge`. I don't see what's
confusing about that.

-- 
Felipe Contreras
