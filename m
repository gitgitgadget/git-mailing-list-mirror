From: "Martin Langhoff" <martin.langhoff@gmail.com>
Subject: Re: [PATCH] gitweb: Adding a `blame' interface.
Date: Mon, 12 Jun 2006 10:02:05 +1200
Message-ID: <46a038f90606111502g607be3cfnf83ce81764a5f909@mail.gmail.com>
References: <11500407193506-git-send-email-octo@verplant.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Jun 12 00:02:19 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FpY0c-0004Zu-9N
	for gcvg-git@gmane.org; Mon, 12 Jun 2006 00:02:14 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750864AbWFKWCL (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 11 Jun 2006 18:02:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751013AbWFKWCL
	(ORCPT <rfc822;git-outgoing>); Sun, 11 Jun 2006 18:02:11 -0400
Received: from wr-out-0506.google.com ([64.233.184.236]:4974 "EHLO
	wr-out-0506.google.com") by vger.kernel.org with ESMTP
	id S1750864AbWFKWCK (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 11 Jun 2006 18:02:10 -0400
Received: by wr-out-0506.google.com with SMTP id i20so1029294wra
        for <git@vger.kernel.org>; Sun, 11 Jun 2006 15:02:10 -0700 (PDT)
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=TOBcl1XuHH98dNeslEdQ+mil4vQNOD5gdoQJH+FAblemJj6l/QVVkgRTttdXZsUMPSKt+Dl5ZCfChT7ii7ygEpNvj1cSIudxYf4Fe02Ly10OncuqcMRAOWQf3K0x/esCUGHFBv4lKqVMRc4tdqC+AE972R/tcCviTQfmzNbwJrU=
Received: by 10.54.93.15 with SMTP id q15mr3192237wrb;
        Sun, 11 Jun 2006 15:02:05 -0700 (PDT)
Received: by 10.54.71.9 with HTTP; Sun, 11 Jun 2006 15:02:05 -0700 (PDT)
To: "Florian Forster" <octo@verplant.org>
In-Reply-To: <11500407193506-git-send-email-octo@verplant.org>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/21671>

Florian,

Looks good! git-blame/git-annotate are quite expensive to run. Do you
think it would make sense making it conditional on a git-repo-config
option (gitweb.blame=1)?

kernel.org is the flagship user for gitweb, so expensive options
should default to off :-/

cheers,



martin
