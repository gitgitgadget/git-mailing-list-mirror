From: Mark Levedahl <mlevedahl@gmail.com>
Subject: Re: [PATCH] git-bundle: fix pack generation.
Date: Tue, 06 Mar 2007 22:17:30 -0500
Message-ID: <45EE2ECA.60403@gmail.com>
References: <45ECEB40.4000907@gmail.com>	<7vejo2stlw.fsf@assigned-by-dhcp.cox.net> <45EE1242.8080405@gmail.com> <7vhcsxkb8n.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Cc: Johannes.Schindelin@gmx.de, Git Mailing List <git@vger.kernel.org>
To: Junio C Hamano <junkio@cox.net>
X-From: git-owner@vger.kernel.org Wed Mar 07 04:17:34 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HOmek-00020D-8b
	for gcvg-git@gmane.org; Wed, 07 Mar 2007 04:17:34 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030782AbXCGDRb (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 6 Mar 2007 22:17:31 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030783AbXCGDRb
	(ORCPT <rfc822;git-outgoing>); Tue, 6 Mar 2007 22:17:31 -0500
Received: from wx-out-0506.google.com ([66.249.82.232]:9661 "EHLO
	wx-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1030782AbXCGDRa (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 6 Mar 2007 22:17:30 -0500
Received: by wx-out-0506.google.com with SMTP id h31so24745wxd
        for <git@vger.kernel.org>; Tue, 06 Mar 2007 19:17:29 -0800 (PST)
DKIM-Signature: a=rsa-sha1; c=relaxed/relaxed;
        d=gmail.com; s=beta;
        h=domainkey-signature:received:received:message-id:date:from:user-agent:mime-version:to:cc:subject:references:in-reply-to:content-type:content-transfer-encoding;
        b=OpGtAiJSPL8VKS3lpKFITjsGYflbB8qjKJe3XobRjXBzYTpBBNEPdpZqDI5hnbdmdcJd9szT12qX3KuoZ8h1EPPQ8CHfJf7oFDNx39qCw3oHAM0icXvESFk1D264+bRMj/jsR3+Ezm6vvQwMASILRTaSwlPtSxx6vetRhim1+E4=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=beta;
        h=received:message-id:date:from:user-agent:mime-version:to:cc:subject:references:in-reply-to:content-type:content-transfer-encoding;
        b=laL+Hok/2aa43BXucTrwmJwYdPk7oX0m5lM3fJHvV6kIpVOkcXZz/8PzMTVp/3bAf1qvWdJWhLUkky1/T8300f1QFN3U0SmRQtDMd3xRH4/S7t361wJqGpawdeuSe3UR5dbN9T29njoGDfEbp4p50E4TKtLZQA9FLJ5cEUcSXfY=
Received: by 10.70.67.10 with SMTP id p10mr9171535wxa.1173237449703;
        Tue, 06 Mar 2007 19:17:29 -0800 (PST)
Received: from ?192.168.100.117? ( [71.246.235.75])
        by mx.google.com with ESMTP id i33sm168145wxd.2007.03.06.19.17.28;
        Tue, 06 Mar 2007 19:17:29 -0800 (PST)
User-Agent: Thunderbird 1.5.0.10 (Windows/20070221)
In-Reply-To: <7vhcsxkb8n.fsf@assigned-by-dhcp.cox.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/41646>

Junio C Hamano wrote:
> That one is caused by the broken revision traversal in 'master'
> and being worked on in 'next'.  Care to try the one from 'next'
> instead?
using next as just pulled from kernel.org 
(09890a9bce0bc27182bc1f74a34b53) ...

git>git bundle create test.bdl HEAD~1..HEAD
error: rev-list died 255

I have not found any  rev-args set that avoids that error.

Mark
