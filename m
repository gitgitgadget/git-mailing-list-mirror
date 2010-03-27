From: Jon Seymour <jon.seymour@gmail.com>
Subject: Re: git gui: merge conflict display is misleading since it hides 
	non-conflicting remote hunks [edit]
Date: Sat, 27 Mar 2010 14:34:11 +1100
Message-ID: <2cfc40321003262034m7b543b16xbc281899dc7beba2@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
To: Git Mailing List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Sat Mar 27 04:34:30 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1NvMn8-0001Zy-6H
	for gcvg-git-2@lo.gmane.org; Sat, 27 Mar 2010 04:34:30 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752636Ab0C0DeN (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 26 Mar 2010 23:34:13 -0400
Received: from mail-pw0-f46.google.com ([209.85.160.46]:36660 "EHLO
	mail-pw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751240Ab0C0DeN (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 26 Mar 2010 23:34:13 -0400
Received: by pwi5 with SMTP id 5so5570318pwi.19
        for <git@vger.kernel.org>; Fri, 26 Mar 2010 20:34:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:date:received:message-id
         :subject:from:to:content-type;
        bh=q/Cc/h8HKX4Zy2+C4nsHFU1Mqw2ETYa9GEZMmTPe5Yw=;
        b=w3Jb6/lIiB277EAgHZZYt0dmUZ/ddJAySv8MCTmejkvUVJ+Rsi2pKwd/W5ipcMdjPZ
         h3NwDoqB1uRkb7/7uKArmpo4JMZ9SQp8RmxSe3mLXeSGMErNLhRfYiwfaekXk0yWwa1N
         c04oql4vJ9LheEFl/qLzB0JdMeo1qFfAmTYNY=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:date:message-id:subject:from:to:content-type;
        b=nWCx4c+JV5quAQgzcYnh8jBFI/XJpEUaggOrCD6ecJbSa2O+pqmWpg46iOoXaghLeo
         YmOsiw/O3/WzyUEPNKFtv9fpFdIxYflVTo5eTeRafwNi1Eha2yPmWyWU5g69665hjkf2
         fvjmtGjm+Oo3YsGgWmr/eeaZT17nRC9LY0i64=
Received: by 10.115.89.7 with HTTP; Fri, 26 Mar 2010 20:34:11 -0700 (PDT)
Received: by 10.114.187.19 with SMTP id k19mr2232295waf.20.1269660851992; Fri, 
	26 Mar 2010 20:34:11 -0700 (PDT)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/143315>

| changed conflict --> __change___
>
> As a result, the user thinks that the only __change__ is the import
> statement, and elects to resolve the commit in favour of the local
> commit. This is the wrong thing to do because the remote hunk is then
> lost to the history.
>
