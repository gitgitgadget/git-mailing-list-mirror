From: Dmitry Potapov <dpotapov@gmail.com>
Subject: Re: [PATCH] Allow git-shell to be used as a ssh forced-command
Date: Fri, 17 Apr 2009 20:24:35 +0400
Message-ID: <37fcd2780904170924t61168a49uf1800098cdb1d730@mail.gmail.com>
References: <1239916256-10878-1-git-send-email-mh@glandium.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org, gitster@pobox.com
To: Mike Hommey <mh@glandium.org>
X-From: git-owner@vger.kernel.org Fri Apr 17 18:27:42 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Luqtt-0002LV-LF
	for gcvg-git-2@gmane.org; Fri, 17 Apr 2009 18:26:50 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1761631AbZDQQYi (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 17 Apr 2009 12:24:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1760409AbZDQQYh
	(ORCPT <rfc822;git-outgoing>); Fri, 17 Apr 2009 12:24:37 -0400
Received: from fg-out-1718.google.com ([72.14.220.156]:32912 "EHLO
	fg-out-1718.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1760667AbZDQQYg (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 17 Apr 2009 12:24:36 -0400
Received: by fg-out-1718.google.com with SMTP id e12so336528fga.17
        for <git@vger.kernel.org>; Fri, 17 Apr 2009 09:24:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :date:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=kNMsEwI++D96Uw0Gf6cGMQvldmNgCBuRapZJCLvUSOg=;
        b=ELMExQwojNLDVgcoOzfVEHImu9NVFsjZs1eT2HPrOUHNU6V2JZDy7SEoTOTYstSI5z
         FpgSl+1t/nYMax7ZaY+sb7foEcggF5oFxRuAxrnX4/tAK83bKVrXF/v1j/uscEBO2kel
         zVpgbGXZNGiJ1UZ5hG3ZMYvDK6vDjTBtXeLxA=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=ieLO/7QY/Z30FyR3ofEOg38Jn1v/coVQC1Ib5AKt87yeAx9g0peqoiIZrzWMcUJxIZ
         TQy4egtmR8IjVz57bShBYf9g4QAiu36LqBKCIYDK+VvDnAv86bd4Sfd7KzLR/YiAKX0l
         enZdcuzj7m37DMD3mzh79zlCLq5LJrd4Qcjyg=
Received: by 10.86.59.18 with SMTP id h18mr555453fga.14.1239985475307; Fri, 17 
	Apr 2009 09:24:35 -0700 (PDT)
In-Reply-To: <1239916256-10878-1-git-send-email-mh@glandium.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/116756>

On Thu, Apr 16, 2009 at 11:10:56PM +0200, Mike Hommey wrote:
> When using a forced-command, OpenSSH sets the SSH_ORIGINAL_COMMAND
> variable to what would otherwise be passed to $SHELL -c. When this
> variable is set, we use it instead of the contents of argv.

It would be nice to provide some justification where it can be used.
IOW, why do you want to have the force command where essentially
you execute the original command as it were no force-command?

Dmitry
