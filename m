From: "Frans Klaver" <fransklaver@gmail.com>
Subject: Re: [PATCH 5/5] run-command: Error out if interpreter not found
Date: Thu, 26 Jan 2012 00:09:32 +0100
Message-ID: <op.v8nw96iw0aolir@keputer.lokaal>
References: <1327444346-6243-1-git-send-email-fransklaver@gmail.com>
 <1327444346-6243-6-git-send-email-fransklaver@gmail.com>
 <20120124232421.GH8222@burratino> <op.v8moybu10aolir@keputer>
 <4F205028.4060606@kdbg.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed; delsp=yes
Content-Transfer-Encoding: 7bit
Cc: "Jonathan Nieder" <jrnieder@gmail.com>, git@vger.kernel.org,
	"Junio C. Hamano" <gitster@pobox.com>
To: "Johannes Sixt" <j6t@kdbg.org>
X-From: git-owner@vger.kernel.org Thu Jan 26 00:09:40 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RqByF-0000Ew-RB
	for gcvg-git-2@lo.gmane.org; Thu, 26 Jan 2012 00:09:40 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751842Ab2AYXJf (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 25 Jan 2012 18:09:35 -0500
Received: from mail-ey0-f174.google.com ([209.85.215.174]:47162 "EHLO
	mail-ey0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751382Ab2AYXJe (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 25 Jan 2012 18:09:34 -0500
Received: by eaac13 with SMTP id c13so1783215eaa.19
        for <git@vger.kernel.org>; Wed, 25 Jan 2012 15:09:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=content-type:to:cc:subject:references:date:mime-version
         :content-transfer-encoding:from:message-id:in-reply-to:user-agent;
        bh=6GNU+tzxOea5CZtyUjaFQZXFzAzDw7tvayYsv6f4zdc=;
        b=lBj2JC0wWussXEuRMg7PciXP4OETnlhLWHRwfHbLIYKRNxkDN7Kk6XfxG17eG4yNu4
         TIhwK49cRTxhfwQuK/UT5FBryvPMsu0cU2w5/Q6V1P38Kynb+JUv3RkVRjZ6A31A7J/d
         VIWcxBfQwD8E28/9EYAUU8xVeoBMOATDWA424=
Received: by 10.213.35.135 with SMTP id p7mr1764ebd.134.1327532973108;
        Wed, 25 Jan 2012 15:09:33 -0800 (PST)
Received: from keputer.lokaal (82-136-253-149.ip.telfort.nl. [82.136.253.149])
        by mx.google.com with ESMTPS id 40sm7540837ees.10.2012.01.25.15.09.31
        (version=TLSv1/SSLv3 cipher=OTHER);
        Wed, 25 Jan 2012 15:09:32 -0800 (PST)
In-Reply-To: <4F205028.4060606@kdbg.org>
User-Agent: Opera Mail/12.00 (Win32)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/189133>

On Wed, 25 Jan 2012 19:55:36 +0100, Johannes Sixt <j6t@kdbg.org> wrote:

>> I guess it could use similar code to this patch series to tackle
>> all this.
>
> No thanks. IMHO, this is already too much code for too little gain.

That's OK. If it's not only you who feels this way, I'd better spend my  
time on something that does add value.

Thanks for having a look in any case.

Frans
