From: Ron Rondis <ron.rondis@gmail.com>
Subject: duplicate commit entries
Date: Thu, 28 Oct 2010 16:42:08 +0200
Message-ID: <4CC98BC0.9070003@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Oct 28 16:42:20 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PBTgJ-0004K3-Nr
	for gcvg-git-2@lo.gmane.org; Thu, 28 Oct 2010 16:42:20 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758995Ab0J1OmO (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 28 Oct 2010 10:42:14 -0400
Received: from mail-wy0-f174.google.com ([74.125.82.174]:39695 "EHLO
	mail-wy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758817Ab0J1OmM (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 28 Oct 2010 10:42:12 -0400
Received: by wyf28 with SMTP id 28so2028827wyf.19
        for <git@vger.kernel.org>; Thu, 28 Oct 2010 07:42:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from
         :user-agent:mime-version:to:subject:content-type
         :content-transfer-encoding;
        bh=zTno7tFz6uz/NPcYIZPiK/9jbNdqV4/F9K0M5QfLTwk=;
        b=vuKh28UQSiE+S54dptNWhw9ckockHDVKOpWWg6aZHNdKZjXC9BMuEMNwxBIR3t27UH
         mg5ANyBJ8ZqCbU4+wOZ3juNllYE9CnMxsKYrbL7GE+AZ+rRNRQvmlKeSbgeB6B5L6koY
         m0zuceJFkjzAuaUSBG6pfCRdTPi/3wW32a3Wc=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:user-agent:mime-version:to:subject
         :content-type:content-transfer-encoding;
        b=GMR2TjggaGVIuSNjH9Y71QgubTLSgAAISirdlWRW7glYeYxJfJmB0o+VokTbTXMGKi
         gyBNqT8Zx91aMJrnUEJvGwi0gifUfVeS/fek0AZ4mMAYlZm5FQEiRXYQKQFAnb8QRKgi
         tMTe4DmrEdqpMsChUiHCnTldwyOe4a3fGn+Dw=
Received: by 10.227.157.79 with SMTP id a15mr2568903wbx.208.1288276931648;
        Thu, 28 Oct 2010 07:42:11 -0700 (PDT)
Received: from [192.168.2.51] (line132-250.adsl.actcom.co.il [192.115.132.250])
        by mx.google.com with ESMTPS id h29sm998988wbc.21.2010.10.28.07.42.09
        (version=SSLv3 cipher=RC4-MD5);
        Thu, 28 Oct 2010 07:42:10 -0700 (PDT)
User-Agent: Mozilla/5.0 (X11; U; Linux x86_64; en-US; rv:1.9.2.9) Gecko/20100907 Fedora/3.1.3-1.fc13 Thunderbird/3.1.3
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/160180>

  Hi,

Why do I get duplicate commit entries after the following steps
1. git am to master repo
2. git pull from master repo

And if it is the expected result than how, when working with
patches, one can keep its repo in a healthy condition?

Thanks,
Ron
