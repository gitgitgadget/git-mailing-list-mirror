From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: Help! My ISP blocks repo.or.cz. How to push changes?
Date: Tue, 13 Jan 2009 00:39:47 +0100
Message-ID: <200901130039.48340.jnareb@gmail.com>
References: <200901120246.28364.jnareb@gmail.com> <200901121213.45858.jnareb@gmail.com> <alpine.DEB.2.00.0901120324490.18989@vellum.laroia.net>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Cc: Alex Riesen <raa.lkml@gmail.com>, git@vger.kernel.org
To: Asheesh Laroia <asheesh@asheesh.org>
X-From: git-owner@vger.kernel.org Tue Jan 13 00:41:26 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LMWPM-0005SL-Q1
	for gcvg-git-2@gmane.org; Tue, 13 Jan 2009 00:41:25 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752764AbZALXj6 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 12 Jan 2009 18:39:58 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752559AbZALXj6
	(ORCPT <rfc822;git-outgoing>); Mon, 12 Jan 2009 18:39:58 -0500
Received: from mail-ew0-f17.google.com ([209.85.219.17]:42800 "EHLO
	mail-ew0-f17.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751163AbZALXj5 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 12 Jan 2009 18:39:57 -0500
Received: by ewy10 with SMTP id 10so11791025ewy.13
        for <git@vger.kernel.org>; Mon, 12 Jan 2009 15:39:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:subject:date
         :user-agent:cc:references:in-reply-to:mime-version:content-type
         :content-transfer-encoding:content-disposition:message-id;
        bh=3+Gp9u2/DfW/zeUr6lSjl/f/MsTs8YBglCxlLMcWIcg=;
        b=Cxaw2RycvPv+Jzbup2+mazi5cgtzh8CueXpz15BhLrwHN0Ww5M7zGmmbDdXGlG3dS4
         bU4zaYuTL2EXvgD5kJeUNrZlbc6KWtQtGCXNjs5YhVemRP4LNJy/giuyzdtOtK4aGsW8
         /gaWIHhWl/gX0PbF5eADzJqQB8y/0sAqNxsg4=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:subject:date:user-agent:cc:references:in-reply-to
         :mime-version:content-type:content-transfer-encoding
         :content-disposition:message-id;
        b=NNUuA7JjaIoxqWvcFKfs2hjBJX1lh4VAjhftSXu869myL65KYQwfWyP+qGxGMksFk+
         BGSSbgV9mWyJ1vd5DR7y3u3CA4459Z2SVOuwxZFhPxA4MnftJ4U4VdUwVNBadDGy8gjz
         jo2dUVfrHHRW9PsEBENODk8DVWD9WdjkAko7U=
Received: by 10.210.142.6 with SMTP id p6mr34820601ebd.100.1231803595826;
        Mon, 12 Jan 2009 15:39:55 -0800 (PST)
Received: from ?192.168.1.11? (abvj184.neoplus.adsl.tpnet.pl [83.8.207.184])
        by mx.google.com with ESMTPS id 28sm168050eyg.14.2009.01.12.15.39.53
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Mon, 12 Jan 2009 15:39:53 -0800 (PST)
User-Agent: KMail/1.9.3
In-Reply-To: <alpine.DEB.2.00.0901120324490.18989@vellum.laroia.net>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/105415>

Asheesh Laroia wrote:
> On Mon, 12 Jan 2009, Jakub Narebski wrote:
> 
> > But I have to run
> >
> > $ ssh -f -N -L 2222:repo.or.cz:22 jnareb@host.example.com
> >
> > first. Is there any way to automate this?
> 
> Check out 'gstm' or 'autossh'.

I don't know about gSTM (Gnome SSH Tunnel Manager), but autossh
does only provide reconnect in the case the gateway host closes
connection. I still have to run it, perhaps from startup script.

-- 
Jakub Narebski
Poland
