From: Ilya Bobyr <ilya.bobir@gmail.com>
Subject: Re: [PATCH 1/2] test-lib: tests skipped by GIT_SKIP_TESTS say so
Date: Mon, 03 Mar 2014 15:12:33 -0800
Message-ID: <53150C61.90500@gmail.com>
References: <1393842298-5944-1-git-send-email-ilya.bobyr@gmail.com> <CAPig+cQgYOz7rDax=HFNG9mr-H1FaoL-ss2mgdpMazPS4pWbNQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Cc: Git List <git@vger.kernel.org>,
	Jonathan Nieder <jrnieder@gmail.com>,
	Thomas Rast <tr@thomasrast.ch>
To: Eric Sunshine <sunshine@sunshineco.com>,
	Ilya Bobyr <ilya.bobyr@gmail.com>
X-From: git-owner@vger.kernel.org Tue Mar 04 00:12:45 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WKc2P-0004gA-23
	for gcvg-git-2@plane.gmane.org; Tue, 04 Mar 2014 00:12:45 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755364AbaCCXMl (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 3 Mar 2014 18:12:41 -0500
Received: from mail-pb0-f51.google.com ([209.85.160.51]:61781 "EHLO
	mail-pb0-f51.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755282AbaCCXMk (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 3 Mar 2014 18:12:40 -0500
Received: by mail-pb0-f51.google.com with SMTP id uo5so3651982pbc.24
        for <git@vger.kernel.org>; Mon, 03 Mar 2014 15:12:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=message-id:date:from:user-agent:mime-version:to:cc:subject
         :references:in-reply-to:content-type:content-transfer-encoding;
        bh=/4I/6JjjMcx+XGONDTzMFfeOEeEwdQObtIl45aKZqGk=;
        b=AMvYuxIxKuVCuAIf0zAa/7Y5h4gx1s4okhQzD50OqpCC/nJaqXC4HMc5550gw2S/kv
         WCRzrUEoNJeWb71mO8PT/FFq+DM1XytY9Yw9V6CjiHo62EfEi/jowwvL1E1w/8MkqEhP
         sGrHwAc1lfaH8EUq75jrA83AKjdDcCnnobbSxRI6wvMmr6mk7/7FdRywQ3lJC3LoJyWn
         6nV9N/CWnXusEttyPfy63lr4kVaNtwlU8oT5WgfSgIjHUlMiNxnSbw2Hsup2YT1d+F5a
         n50WIx12wvdvtNCCvYT7KTY5qR/RxmRfiF8aP0j6/ZliBFy1RDnPQHPzO7F74n9u0DC1
         0JbA==
X-Received: by 10.66.155.133 with SMTP id vw5mr2324848pab.124.1393888360055;
        Mon, 03 Mar 2014 15:12:40 -0800 (PST)
Received: from [192.168.1.2] (c-50-136-172-14.hsd1.ca.comcast.net. [50.136.172.14])
        by mx.google.com with ESMTPSA id f5sm92062836pat.11.2014.03.03.15.12.38
        for <multiple recipients>
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 03 Mar 2014 15:12:39 -0800 (PST)
User-Agent: Mozilla/5.0 (Windows NT 6.3; WOW64; rv:27.0) Gecko/20100101 Thunderbird/27.0
In-Reply-To: <CAPig+cQgYOz7rDax=HFNG9mr-H1FaoL-ss2mgdpMazPS4pWbNQ@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/243303>

On 3/3/2014 2:59 PM, Eric Sunshine wrote:
> On Mon, Mar 3, 2014 at 5:24 AM, Ilya Bobyr <ilya.bobyr@gmail.com> wrote:
>> We used to show "(missing )" next to tests skipped because they are
>> specified in GIT_SKIP_TESTS.  Use "(matched by GIT_SKIP_TESTS)" instead.
> Bikeshedding: That's pretty verbose. Perhaps just say "(excluded)"?

The next patch adds another reason for the test to be skipped, so it 
seems reasonable to say why exactly.
The patch actually makes it say "matched GIT_SKIP_TESTS".
It looks OK on the console.
