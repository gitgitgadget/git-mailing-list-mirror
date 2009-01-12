From: "Ping Yin" <pkufranky@gmail.com>
Subject: Re: [RFC PATCH 1/3] Add "vcs" config option in remotes
Date: Mon, 12 Jan 2009 09:29:01 +0800
Message-ID: <46dff0320901111729y3869db2bxcc2b66a7be247d0b@mail.gmail.com>
References: <alpine.LNX.1.00.0901110332580.19665@iabervon.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org, "Junio C Hamano" <gitster@pobox.com>
To: "Daniel Barkalow" <barkalow@iabervon.org>
X-From: git-owner@vger.kernel.org Mon Jan 12 02:30:28 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LMBdL-0006QH-TD
	for gcvg-git-2@gmane.org; Mon, 12 Jan 2009 02:30:28 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751907AbZALB3F (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 11 Jan 2009 20:29:05 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751707AbZALB3E
	(ORCPT <rfc822;git-outgoing>); Sun, 11 Jan 2009 20:29:04 -0500
Received: from wa-out-1112.google.com ([209.85.146.181]:29777 "EHLO
	wa-out-1112.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751308AbZALB3B (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 11 Jan 2009 20:29:01 -0500
Received: by wa-out-1112.google.com with SMTP id v27so5468666wah.21
        for <git@vger.kernel.org>; Sun, 11 Jan 2009 17:29:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from:to
         :subject:cc:in-reply-to:mime-version:content-type
         :content-transfer-encoding:content-disposition:references;
        bh=0NaDuEJ9QNWdS4vFlizdCQSPKHDc3pAvJFu4X8WixYw=;
        b=Suc4RtJukMWXAwXYvWfe3D12YN0hpZXtA33OagVFVqzH06aj7C9UoXmzqm1hiO9VXy
         FTUpuaHyzcs1aw4itVkBMF1eLkk4sYTddz05LIubR+ot4neLv+vwr85VLhT1G2uBE95q
         Ps5Kjrw+O1DaCVvgb1B+va+xlewSPyOnO5GFE=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:to:subject:cc:in-reply-to:mime-version
         :content-type:content-transfer-encoding:content-disposition
         :references;
        b=epkCZfwxG96LqvelUgmnwuQGf3fFgosiCzuiwCQdAAB/nYOhXBgGLnnml3TPHoBZoI
         oY2X6CZB/0TFldvM59jvpKFOi9j59JogEw1DmtWMUEwzWuGZPNpJ0XdecvEBVoxcWV/g
         IXIM/9RhQmbrU4k0YpwqauG9pauaucFQS7UF0=
Received: by 10.114.161.11 with SMTP id j11mr18707848wae.164.1231723741327;
        Sun, 11 Jan 2009 17:29:01 -0800 (PST)
Received: by 10.115.93.12 with HTTP; Sun, 11 Jan 2009 17:29:01 -0800 (PST)
In-Reply-To: <alpine.LNX.1.00.0901110332580.19665@iabervon.org>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/105268>

On Mon, Jan 12, 2009 at 4:12 AM, Daniel Barkalow <barkalow@iabervon.org> wrote:
> This will indicate to programs using the remote that it should be
> accessed through a VCS helper. Until programs support it, have them
> fail it the option is set.

s/it/if/ ?
