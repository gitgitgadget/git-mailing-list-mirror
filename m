From: A Large Angry SCM <gitzilla@gmail.com>
Subject: Re: libexec path
Date: Wed, 04 Feb 2009 21:17:20 -0500
Message-ID: <498A4C30.5030308@gmail.com>
References: <86293c1a0902041553s26e74a50kbf5e8f71aad557a5@mail.gmail.com>
Reply-To: gitzilla@gmail.com
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Charles <hobbesc7@gmail.com>
X-From: git-owner@vger.kernel.org Thu Feb 05 03:18:59 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LUtpS-0003cg-1h
	for gcvg-git-2@gmane.org; Thu, 05 Feb 2009 03:18:58 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756930AbZBECR0 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 4 Feb 2009 21:17:26 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756526AbZBECR0
	(ORCPT <rfc822;git-outgoing>); Wed, 4 Feb 2009 21:17:26 -0500
Received: from yx-out-2324.google.com ([74.125.44.29]:62240 "EHLO
	yx-out-2324.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754528AbZBECRZ (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 4 Feb 2009 21:17:25 -0500
Received: by yx-out-2324.google.com with SMTP id 8so1761yxm.1
        for <git@vger.kernel.org>; Wed, 04 Feb 2009 18:17:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id
         :disposition-notification-to:date:from:reply-to:user-agent
         :mime-version:to:cc:subject:references:in-reply-to:content-type
         :content-transfer-encoding;
        bh=zl3/W+B5CumiLztwQ9zSVgYbDVHjchcBGxntOHoAcCA=;
        b=DCJNOyxl+MsJ0/Ez7KztC4W7MWoSywRc6upB6+0TrQGmfGEzIMtFLHi5P5i64Skp2q
         +Xv5dypBa/U+sNXvoMFLvKOJ+kKq4WGx2L2fEzn6ERcvST1FlS+JiEvCzbhRfDqNeKdv
         pm6LbXBq8XmfRk19EA/SWoYUuOKivlheOazKE=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:disposition-notification-to:date:from:reply-to
         :user-agent:mime-version:to:cc:subject:references:in-reply-to
         :content-type:content-transfer-encoding;
        b=jcEajPPVW+JHSx7K6oXJp92EAJDddI5xkvLzaeYw/XzOm4KfmxY1TcfX+2tMvyZsn5
         vl1/FxJSZhRY+4P2iENRCTQYgp0b6nH1aGPQYHFA2HAmXA3S1088sqNZE8qe0IH+xG7O
         Fq92WWPP5znbseAE3iXlZnih329sjsa6Tvb4Q=
Received: by 10.100.3.4 with SMTP id 4mr13060anc.27.1233800243214;
        Wed, 04 Feb 2009 18:17:23 -0800 (PST)
Received: from ?10.0.0.6? (c-66-177-19-100.hsd1.fl.comcast.net [66.177.19.100])
        by mx.google.com with ESMTPS id d12sm11969242and.44.2009.02.04.18.17.21
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Wed, 04 Feb 2009 18:17:22 -0800 (PST)
User-Agent: Thunderbird 1.5.0.10 (X11/20060911)
In-Reply-To: <86293c1a0902041553s26e74a50kbf5e8f71aad557a5@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/108492>

Charles wrote:
> How come in git-gui/GIT-GUI-VARS
> 
> gitexecdir is set to '/usr/local//usr/local/
> libexec/git-core/'
> 
> when my configure prefix is "/usr/local" ?
> 
> Everything else ends up in /usr/local as it should, but libexec ends
> up in /usr/local/usr/local
> 
> I'm cloning from the latest stuff.

This is the same symptom as the Makefile breakage I email the list about 
over the weekend.
