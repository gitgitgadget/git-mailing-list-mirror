From: Luke Diamand <luke@diamand.org>
Subject: Re: [PATCH 1/4] git p4: bring back files in deleted client directory
Date: Mon, 30 Apr 2012 19:34:28 +0100
Message-ID: <4F9EDB34.5090103@diamand.org>
References: <1335747437-24034-1-git-send-email-pw@padd.com> <1335747437-24034-2-git-send-email-pw@padd.com> <4F9E376B.1000107@diamand.org> <20120430123650.GB25045@padd.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org, Gary Gibbons <ggibbons@perforce.com>
To: Pete Wyckoff <pw@padd.com>
X-From: git-owner@vger.kernel.org Mon Apr 30 20:34:36 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SOvQi-0004v5-5f
	for gcvg-git-2@plane.gmane.org; Mon, 30 Apr 2012 20:34:36 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756376Ab2D3Sec (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 30 Apr 2012 14:34:32 -0400
Received: from mail-ey0-f174.google.com ([209.85.215.174]:59117 "EHLO
	mail-ey0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756227Ab2D3Seb (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 30 Apr 2012 14:34:31 -0400
Received: by eaaq12 with SMTP id q12so765512eaa.19
        for <git@vger.kernel.org>; Mon, 30 Apr 2012 11:34:30 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=message-id:date:from:user-agent:mime-version:to:cc:subject
         :references:in-reply-to:content-type:content-transfer-encoding
         :x-gm-message-state;
        bh=6S8mYStGI3IRK3WBybB9bw6fWqdedn0qzLI1tq12iaM=;
        b=k2XXqGMvrd1SKxC1eXDduR7R+FkIop35eyI/f+sWdID+gnd6iiq33dvf7Y/uDFpqsz
         jX9nHCp2S9qu57KS15Dwi38gkHbWK1rg5jtRGJjrRH2XICU0IvZWIu+e0M0bfCZYTCEH
         ousTVqklV8Cq5PRddL+ZBozo18sUrJHNUyTkJqSflOaXUrs6PVh7PHtsPS562W+SycHM
         a9qqrCf9Dp6XbOvwQOrBrMYliS1H6E94kwSNaGYQF2XfJOcE/vdw1/fhcKV1EB/sAtAK
         Q/blYnA6lp5Wt3HTDMaunR0LALAMyaBlSmBc6xDeHxIuw/gRtMVMwqmdfaKCjQezKZkz
         jcng==
Received: by 10.14.28.3 with SMTP id f3mr4611570eea.16.1335810869861;
        Mon, 30 Apr 2012 11:34:29 -0700 (PDT)
Received: from [86.6.30.7] (cpc19-cmbg14-2-0-cust6.5-4.cable.virginmedia.com. [86.6.30.7])
        by mx.google.com with ESMTPS id x4sm78972344eef.10.2012.04.30.11.34.28
        (version=SSLv3 cipher=OTHER);
        Mon, 30 Apr 2012 11:34:29 -0700 (PDT)
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:10.0.3) Gecko/20120324 Icedove/10.0.3
In-Reply-To: <20120430123650.GB25045@padd.com>
X-Gm-Message-State: ALoCoQmwfKMEXPld/61DtktAHI46tEQpizoXZtdHpEbMm/Cfo2XxfUNt8GAsv+kVpS0CuulOwh9Z
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/196588>

On 30/04/12 13:36, Pete Wyckoff wrote:
> luke@diamand.org wrote on Mon, 30 Apr 2012 07:55 +0100:
>>
>> Rebasing the current branch onto remotes/p4/master
>> First, rewinding head to replay your work on top of it...
>> File file1 doesn't exist. file1
>> not ok - 3 submit with no client dir
>
> I can't figure it out.  Will you help debug a bit?  Something
> like this maybe.

User error.

% cp git-p4.py git-p4

Then it works fine.

Is there a way to get lib-git-p4.sh to check this?

Thanks
Luke
