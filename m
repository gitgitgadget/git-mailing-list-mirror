From: "Ping Yin" <pkufranky@gmail.com>
Subject: Re: [PATCH v4 2/5] git-submodule summary: show commit summary
Date: Tue, 11 Mar 2008 01:58:04 +0800
Message-ID: <46dff0320803101058k451d589dl1b3f764e273630f7@mail.gmail.com>
References: <1205171657-16216-1-git-send-email-pkufranky@gmail.com>
	 <1205171657-16216-2-git-send-email-pkufranky@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org, "Ping Yin" <pkufranky@gmail.com>
To: gitster@pobox.com
X-From: git-owner@vger.kernel.org Mon Mar 10 19:01:02 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JYmHv-0003Vo-FA
	for gcvg-git-2@gmane.org; Mon, 10 Mar 2008 18:59:51 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754602AbYCJR6H (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 10 Mar 2008 13:58:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754411AbYCJR6H
	(ORCPT <rfc822;git-outgoing>); Mon, 10 Mar 2008 13:58:07 -0400
Received: from hs-out-0708.google.com ([64.233.178.251]:35263 "EHLO
	hs-out-0708.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754344AbYCJR6F (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 10 Mar 2008 13:58:05 -0400
Received: by hs-out-0708.google.com with SMTP id 4so1515003hsl.5
        for <git@vger.kernel.org>; Mon, 10 Mar 2008 10:58:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        bh=rVXcn6ROWUL/CGJjn9zRXJyPH0nODaGmRWHZYRai4zY=;
        b=tMSahA7hg+tm3XNPPZs5oYLoeXdmasK2gpmMQNQyL+4xLeFEUowwm+bog/296EcPS4Ibgh2ZyeGs9UmXm43NJakWU2TWM2GzPDKC+a2ui3EyMFu3vtFTEaEkeCoOZNL4jMB9PTM6fJ7deKXfEa3ulL1WrpCAUSbqch/9N8zvhW4=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=br8sxjPQGoJs+t/vs2RP4e4b2nOzDD4pPOLvJoWwsQxfJdCzpZoyDA6BdEZQGdhW/XiUIYU5vyQBz9CktTYpLt+N4sLZE088oDYwi8rvYDPxBoQ0mAAqxIRYRQSMCd3/jNsPv1Uae4ynD/x9CHZ8I+SbSq82LDntUwQAz2PIsQs=
Received: by 10.100.119.17 with SMTP id r17mr11495496anc.42.1205171884562;
        Mon, 10 Mar 2008 10:58:04 -0700 (PDT)
Received: by 10.100.5.18 with HTTP; Mon, 10 Mar 2008 10:58:04 -0700 (PDT)
In-Reply-To: <1205171657-16216-2-git-send-email-pkufranky@gmail.com>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/76747>

On Tue, Mar 11, 2008 at 1:54 AM, Ping Yin <pkufranky@gmail.com> wrote:
> This patch does the hard work to show submodule commit summary.
>
>  For a modified submodule, a series of commits will be shown with
>  the following command
>
>         git log --pretty='format:%m %s' --left-right \
>         --first-parent sha1_src...sha1_dst
>

Relative to v3 patch series, there are only two changes in v4:

  1. this patch has minor bug fix
  2. add summary test



-- 
Ping Yin
