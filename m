From: Marius Storm-Olsen <marius@storm-olsen.com>
Subject: Re: untracked file deleted from the master branch, when checked out
 to it from a local branch
Date: Tue, 20 May 2014 12:06:49 -0500
Message-ID: <537B8BA9.7060207@storm-olsen.com>
References: <2525467.KRXv8a3gWS@linux-wzza.site> <537B8959.7090100@gmail.com> <1949847.AaDQEtxZHd@linux-wzza.site>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
To: Arup Rakshit <aruprakshit@rocketmail.com>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue May 20 19:07:06 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WmnVB-0006wP-OM
	for gcvg-git-2@plane.gmane.org; Tue, 20 May 2014 19:06:58 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754100AbaETRGw (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 20 May 2014 13:06:52 -0400
Received: from mail-ob0-f176.google.com ([209.85.214.176]:43758 "EHLO
	mail-ob0-f176.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754072AbaETRGu (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 20 May 2014 13:06:50 -0400
Received: by mail-ob0-f176.google.com with SMTP id wo20so819833obc.21
        for <git@vger.kernel.org>; Tue, 20 May 2014 10:06:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=storm-olsen.com; s=storm;
        h=message-id:date:from:user-agent:mime-version:to:subject:references
         :in-reply-to:content-type:content-transfer-encoding;
        bh=Tt6B9goaCLglzyYVAdJT/wbmKfDpnLOY1TfKL0qKzXQ=;
        b=c1JZK3/ns7qcxjKiMVPjzl84r4xEtCp0Wrmv4n95RuNqENQkJvw4po8me7e0RlgNVj
         LZb8DKAO7A04/xcCtijLOyOnweGGe05CdqbtY4kU3a14zEFJeNMgOOtviDad5qz+00VG
         nUJc/M7whKFJ46HXu28UhBxu3mOBjySI4uFVQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:message-id:date:from:user-agent:mime-version:to
         :subject:references:in-reply-to:content-type
         :content-transfer-encoding;
        bh=Tt6B9goaCLglzyYVAdJT/wbmKfDpnLOY1TfKL0qKzXQ=;
        b=elyUwtGsGOChEMdU4ZYs/O6PFwrZFCpCnQthq3IqhJEk8y+rkdWYU21cvRhv370VEY
         g7Oxs4M2LzjqtcF9+pVmQEdV4vOA6cqDyX/TI0ctlE9dkc1QSO+EoAIfDn1gYJb4GXZG
         POxIHRCS5beM86QNt2rpRykPF8mZZvBbp2N25w3/sbfZ0HEzfEdOyAjAPduAPUFZVtdN
         BQfdGD3bXq5cNz9I7QvR3Q6vitp5wkNXl7zcBslwAm5EvU6Cu/XizCCJ7dqTnq1TOcEt
         UYSCxSRyy1BMucMhVQgys8ZZSgx8H4uIHbwVyJSbb4ETxwJteJedlE43K5swIZx36AHe
         9Ydg==
X-Gm-Message-State: ALoCoQnS/epkmRjioEhmtnQPp2O1fa2V4GytcCP/kmC5saQN86mtUchNI72fHJiWzveUFK2gtDZf
X-Received: by 10.60.58.71 with SMTP id o7mr17638026oeq.67.1400605609684;
        Tue, 20 May 2014 10:06:49 -0700 (PDT)
Received: from [10.3.3.221] ([199.227.34.94])
        by mx.google.com with ESMTPSA id x14sm38775120obp.19.2014.05.20.10.06.49
        for <multiple recipients>
        (version=TLSv1 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Tue, 20 May 2014 10:06:49 -0700 (PDT)
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:24.0) Gecko/20100101 Thunderbird/24.5.0
In-Reply-To: <1949847.AaDQEtxZHd@linux-wzza.site>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/249703>

On 5/20/2014 11:03 AM, Arup Rakshit wrote:
> On Tuesday, May 20, 2014 11:56:57 AM you wrote:
>> On 5/20/2014 10:38 AM, Arup Rakshit wrote:
>>> I was following some tutorial (http://gitref.org/branching/#merge) - and
>>> doing it in my console :
>
>>
>> Because you never committed the original file to the master branch
>> before you created and switched to the change_class branch.
>>
>> You're missing
>>       git add test.rb
>>       git commit -m "initial version of test.rb"
>> before you switch branches the first time.
>
> Hum, But when I create a new branch from master, then it came to the new
> branch, but deleted from the master. Shouldn't it also not come to the new
> local branch also. That's how I expected.

It never "came to the new branch", as it was never version controlled, 
it was an untracked file left behind when you switched branches.

Once you added it to the new branch, change_class, it became a version 
controlled file, and since you moved to a branch without that file (the 
pristine clean master branch), git removed it. (your version history 
says that change_class contains test.rb and master does not.)

-- 
.marius
