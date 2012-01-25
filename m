From: "Frans Klaver" <fransklaver@gmail.com>
Subject: Re: [PATCH 1/5] t0061: Fix incorrect indentation
Date: Wed, 25 Jan 2012 07:27:41 +0100
Message-ID: <op.v8mmwftk0aolir@keputer>
References: <1327444346-6243-1-git-send-email-fransklaver@gmail.com>
 <1327444346-6243-2-git-send-email-fransklaver@gmail.com>
 <20120124224000.GE8222@burratino>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed; delsp=yes
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org, "Junio C. Hamano" <gitster@pobox.com>,
	"Johannes Sixt" <j6t@kdbg.org>
To: "Jonathan Nieder" <jrnieder@gmail.com>
X-From: git-owner@vger.kernel.org Wed Jan 25 07:27:52 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RpwKl-0002yR-Jz
	for gcvg-git-2@lo.gmane.org; Wed, 25 Jan 2012 07:27:51 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752392Ab2AYG1q (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 25 Jan 2012 01:27:46 -0500
Received: from mail-ee0-f46.google.com ([74.125.83.46]:44674 "EHLO
	mail-ee0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751833Ab2AYG1p (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 25 Jan 2012 01:27:45 -0500
Received: by eekc14 with SMTP id c14so2476119eek.19
        for <git@vger.kernel.org>; Tue, 24 Jan 2012 22:27:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=content-type:to:cc:subject:references:date:mime-version
         :content-transfer-encoding:from:message-id:in-reply-to:user-agent;
        bh=8gsdCcW4tsgy898eY9ZkFVBeP4mZJt3lddRpRz4OZx4=;
        b=oxXYwkaTte9IbipHB3XdyTeeOqgvWlP+LpuIi79X87P4sFah+XY7ouwEEfwLiLlW0J
         4TcCi0ZsQaunKq7CahoLqH3GXDvdnrYMTB45rAs8s3jaL4MZAamnaGtwuDDoZeMDlsZT
         xcbUUh3CZggZWK6s0ShPz5Bjn+2l6T/VXZHSA=
Received: by 10.14.101.78 with SMTP id a54mr5469511eeg.86.1327472864176;
        Tue, 24 Jan 2012 22:27:44 -0800 (PST)
Received: from keputer (82-136-253-149.ip.telfort.nl. [82.136.253.149])
        by mx.google.com with ESMTPS id c16sm77490935eei.1.2012.01.24.22.27.42
        (version=TLSv1/SSLv3 cipher=OTHER);
        Tue, 24 Jan 2012 22:27:43 -0800 (PST)
In-Reply-To: <20120124224000.GE8222@burratino>
User-Agent: Opera Mail/12.00 (Linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/189097>

On Tue, 24 Jan 2012 23:40:00 +0100, Jonathan Nieder <jrnieder@gmail.com>  
wrote:

> Frans Klaver wrote:
>
>> +++ b/t/t0061-run-command.sh
>> @@ -8,8 +8,8 @@ test_description='Test run command'
>> . ./test-lib.sh
>>
>> cat >hello-script <<-EOF
>> -	#!$SHELL_PATH
>> -	cat hello-script
>> +#!$SHELL_PATH
>> +cat hello-script
>>  EOF
>
> Looks like a no-op --- the script already started with #! and no
> leading tab for me.  Does it behave differently on your machine?

Hurr? I'm fairly sure the script ended up being indented for me. I'll  
recheck.
