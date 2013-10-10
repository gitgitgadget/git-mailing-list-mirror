From: Stefan Beller <stefanbeller@googlemail.com>
Subject: Re: [PATCH] checkout tests: enable test with complex relative path
Date: Thu, 10 Oct 2013 10:04:38 +0200
Message-ID: <52565F96.8010809@googlemail.com>
References: <1381329311-5920-1-git-send-email-stefanbeller@googlemail.com> <20131009193952.GL9464@google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Jonathan Nieder <jrnieder@gmail.com>
X-From: git-owner@vger.kernel.org Thu Oct 10 10:04:38 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VUBEb-0003Hf-Cy
	for gcvg-git-2@plane.gmane.org; Thu, 10 Oct 2013 10:04:37 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755553Ab3JJIEa (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 10 Oct 2013 04:04:30 -0400
Received: from mail-ee0-f48.google.com ([74.125.83.48]:40587 "EHLO
	mail-ee0-f48.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751737Ab3JJIE1 (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 10 Oct 2013 04:04:27 -0400
Received: by mail-ee0-f48.google.com with SMTP id l10so944831eei.35
        for <git@vger.kernel.org>; Thu, 10 Oct 2013 01:04:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20120113;
        h=message-id:date:from:user-agent:mime-version:to:cc:subject
         :references:in-reply-to:content-type:content-transfer-encoding;
        bh=gMBGtZjOu4CynOacCUhj1xWslZYzy7ZkUaGgUO5v1sM=;
        b=zZJv5EH0KXxtvheK0mdfF3jXgAUYrineLCPMkWjVkZ04Y/bpOB68df17pcQ+l6npfs
         HtwfW7/l6J3qdg1Dc6LvNy/VfTBIxPkMvZYyjT9FEzE2kj/qDAVGfzy9kKH0BkBUOrju
         vwaIOVycZZcc5+9xu5P1yn0qQvudmFe1jS5WA+G09Rnyw6f8B9ozsigNLX9ctPDJrpbp
         nRdvUJLipZPOXvQNqIHVNpNU/6TvN94iz9eInYtXFq8JDC+wRbsm4y3jGkXxQzSsnrrp
         Dw8DUilk7Dn+hLbVYbIjwizICSdPOOhyv7KU5LZ7aSyydOS4rK3ZmyDsudgpdQ/T1Jgb
         wTqg==
X-Received: by 10.14.101.6 with SMTP id a6mr767525eeg.81.1381392266526;
        Thu, 10 Oct 2013 01:04:26 -0700 (PDT)
Received: from [192.168.1.3] (ip-109-91-109-128.unitymediagroup.de. [109.91.109.128])
        by mx.google.com with ESMTPSA id m54sm98366725eex.2.1969.12.31.16.00.00
        (version=TLSv1 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Thu, 10 Oct 2013 01:04:25 -0700 (PDT)
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:24.0) Gecko/20100101 Thunderbird/24.0
In-Reply-To: <20131009193952.GL9464@google.com>
X-Enigmail-Version: 1.5.2
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/235857>

On 10/09/2013 09:39 PM, Jonathan Nieder wrote:
> Stefan Beller wrote:
> 
>> This test was put in, but commented out in fed1b5ca (2007-11-09,
>> git-checkout: Test for relative path use.)
>> It's been a while since 2007 and the intended test case works now.
>> (I could not find the enabling commit in ls-files however.)
> 
> Bisects to v1.5.5-rc0~184^2~3 (setup: sanitize absolute and funny paths
> in get_pathspec(), 2008-01-28).  Thanks.
> 

Do you want me to resend a reworded patch, or could you amend that
information to this patch?
