From: Stephen Boyd <bebarino@gmail.com>
Subject: Re: [PATCH 0/2] jn/gitweb-blame fixes
Date: Thu, 19 Nov 2009 17:00:39 -0800
Message-ID: <4B05EA37.7060704@gmail.com>
References: <1258659887-5244-1-git-send-email-bebarino@gmail.com> <200911200005.08841.jnareb@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Jakub Narebski <jnareb@gmail.com>
X-From: git-owner@vger.kernel.org Fri Nov 20 02:00:48 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NBHrj-0000E4-TD
	for gcvg-git-2@lo.gmane.org; Fri, 20 Nov 2009 02:00:48 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756800AbZKTBAg (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 19 Nov 2009 20:00:36 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756718AbZKTBAg
	(ORCPT <rfc822;git-outgoing>); Thu, 19 Nov 2009 20:00:36 -0500
Received: from mail-gx0-f226.google.com ([209.85.217.226]:33536 "EHLO
	mail-gx0-f226.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755544AbZKTBAf (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 19 Nov 2009 20:00:35 -0500
Received: by mail-gx0-f226.google.com with SMTP id 26so2592150gxk.1
        for <git@vger.kernel.org>; Thu, 19 Nov 2009 17:00:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from
         :user-agent:mime-version:to:cc:subject:references:in-reply-to
         :content-type:content-transfer-encoding;
        bh=2qK0hvnfnzmxIDLv92v1zg1/5qn2xBz7wWEfHFtlnxc=;
        b=hTCCG54OJxg3MHiQYeIJeepdclzxeBqv8GA1/On7gcYZRjGodG6Lns6SMMFIPRP6Zc
         Bu71sHSU9YrRtpBEqs+K7tCDx1YeEMc8wizHuWWQFRYMTKEokcu/UcsYC5sEcpGdsQc1
         jJMheW1/2TgspQWnTwZ+/kDR4qjKtaS7FQavk=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:user-agent:mime-version:to:cc:subject
         :references:in-reply-to:content-type:content-transfer-encoding;
        b=UV6og5Gy2okSPL3s/t/jIinvok8rc0q53Q268yRnfiNuU89uiSKAGN6waQ0fWzo/dU
         +Cr7fF93s7zF9c0BmHxaINH7Tkys81m2V05vqQEwq1b8ZzdjDqq/FGuuqH0W5+PA16+R
         RDlTCPcjH5vTuC2wx7iCwmMNtOxs9kHVoYp4A=
Received: by 10.150.236.17 with SMTP id j17mr1377338ybh.229.1258678842255;
        Thu, 19 Nov 2009 17:00:42 -0800 (PST)
Received: from ?192.168.0.5? (cpe-76-174-15-88.socal.res.rr.com [76.174.15.88])
        by mx.google.com with ESMTPS id 22sm379821ywh.30.2009.11.19.17.00.40
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Thu, 19 Nov 2009 17:00:41 -0800 (PST)
User-Agent: Thunderbird 2.0.0.23 (X11/20091026)
In-Reply-To: <200911200005.08841.jnareb@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/133273>

Jakub Narebski wrote:
>
> Thanks for working on this.  Also it is nice to have incremental blame
> tested for another browser, beside Mozilla 1.17.2 and Konqueror 3.5.3

For those following along, Opera-10.10 has been tested and works.
