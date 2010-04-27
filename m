From: Ming Zhang <blackmagic02881@gmail.com>
Subject: create local branch from svn repos
Date: Tue, 27 Apr 2010 16:53:52 -0400
Message-ID: <x2x93552bad1004271353g31228559k79d8db8c39fc579a@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Apr 27 22:54:01 2010
connect(): No such file or directory
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1O6rn6-0002U8-Qh
	for gcvg-git-2@lo.gmane.org; Tue, 27 Apr 2010 22:54:01 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756867Ab0D0Uxy (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 27 Apr 2010 16:53:54 -0400
Received: from mail-pv0-f174.google.com ([74.125.83.174]:65239 "EHLO
	mail-pv0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755314Ab0D0Uxx (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 27 Apr 2010 16:53:53 -0400
Received: by pvb32 with SMTP id 32so6765pvb.19
        for <git@vger.kernel.org>; Tue, 27 Apr 2010 13:53:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:sender:received:date
         :x-google-sender-auth:message-id:subject:from:to:content-type;
        bh=Z3yvHMgRWlNANfJjJXQsVwMJHbqe5AXGKM8oacxAqN8=;
        b=edlWtNGlqk3mT9eR7b7UeEjkYx1Lq5KKUzuWsIi4NglhJGnAcjy4dIeOde4J4Exdx8
         vqPWaxFwLhbe3aknRryyFGRlAnGlNtwZf3o6m/LlJCOYiMO3TqWcimRyhGqjDuvZgVpC
         mifyOMjVGz5S48FpnnmX7ZbNvcff108qnBslM=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:sender:date:x-google-sender-auth:message-id:subject
         :from:to:content-type;
        b=qwW5GswOngBN74XIhOSdmQyoC4PqG1HrdFcru/OTPn+e/zdY308mR+Wu+2GlSVdGcR
         H45pF3HmObDvpCvNN5oMRURJ6uBhCcDvu0iIAR8y/WXiyV9Ymi/1Jfvl7TvTv0VmEQf6
         qIh9XWjpkyF1IkVzp5a9XvdXZJNugbJEUulto=
Received: by 10.142.122.4 with SMTP id u4mr3667804wfc.202.1272401632939; Tue, 
	27 Apr 2010 13:53:52 -0700 (PDT)
Received: by 10.142.47.8 with HTTP; Tue, 27 Apr 2010 13:53:52 -0700 (PDT)
X-Google-Sender-Auth: 5bfaa26fb23de226
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/145954>

Hi All

I have a svn repos with this layout

trunk
tags
branches-- b1
