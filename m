From: "Catalin Marinas" <catalin.marinas@gmail.com>
Subject: Re: Bug in StackedGit
Date: Tue, 15 Apr 2008 12:13:27 +0100
Message-ID: <b0943d9e0804150413h5268532ey2f2ee33fca1be783@mail.gmail.com>
References: <6efe08af0804150301t9f4a1dbte564902736ebc302@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: "Vitaly V. Ch" <vitaly.v.ch@gmail.com>
X-From: git-owner@vger.kernel.org Tue Apr 15 13:14:18 2008
connect(): Connection refused
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Jlj78-00073S-5n
	for gcvg-git-2@gmane.org; Tue, 15 Apr 2008 13:14:14 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756119AbYDOLN2 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 15 Apr 2008 07:13:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756107AbYDOLN2
	(ORCPT <rfc822;git-outgoing>); Tue, 15 Apr 2008 07:13:28 -0400
Received: from wf-out-1314.google.com ([209.85.200.172]:53672 "EHLO
	wf-out-1314.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755965AbYDOLN1 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 15 Apr 2008 07:13:27 -0400
Received: by wf-out-1314.google.com with SMTP id 28so1919578wff.4
        for <git@vger.kernel.org>; Tue, 15 Apr 2008 04:13:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        bh=8XvbhiNUVmb8fMRHsbVV3wufazLZDzdF4mXFHJ0bSG0=;
        b=jixBOeHwwg3smEaZanlAVvLhRmITno5dtLGnsrwi5tSjTABUO0JBHQ3LULKsE/qs9urPLE5F+7fGFoWRAioSit3xqQnR3hkcYzBCOWuFMSU2zHALQMSJlhimBY2q/Sji+bnoq2Fr0qTjiL5xHWNi8JtIjb4l62O9Cws9NjKj/+k=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=d6pvRzPogwbqX9MeJMcyS8/x51nefj+od5wuwiHtWxGXsq7tyEIvYv7t8IWujP5oGyWjq+oeSuJ3aQVJQFUmVUrl59MvkUTERrgTlG/XSFskfaADoho3SDM2dfo7fN9KnBdVNwmfWu64I4BbRO0M2IaZI7ZE0V9oBEDfe67dQ1E=
Received: by 10.143.9.20 with SMTP id m20mr1327316wfi.252.1208258007494;
        Tue, 15 Apr 2008 04:13:27 -0700 (PDT)
Received: by 10.142.125.9 with HTTP; Tue, 15 Apr 2008 04:13:27 -0700 (PDT)
In-Reply-To: <6efe08af0804150301t9f4a1dbte564902736ebc302@mail.gmail.com>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/79584>

On 15/04/2008, Vitaly V. Ch <vitaly.v.ch@gmail.com> wrote:
> after stg commit all patch history is loss. It's sucks.

Why do you need the patch history after "stg commit"? This command is
meant to take the patches out of StGIT control and freeze them in the
Git repository history.

-- 
Catalin
