X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=-3.1 required=3.0 tests=AWL,BAYES_00,
	DKIM_ADSP_CUSTOM_MED,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MSGID_FROM_MTA_HEADER,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
From: "Aneesh Kumar K.V" <aneesh.kumar@gmail.com>
Subject: Shallow clone [Was Re: What's in git.git ]
Date: Wed, 08 Nov 2006 22:10:18 +0530
Message-ID: <45520872.3090506@gmail.com>
References: <7v8ximwrm3.fsf@assigned-by-dhcp.cox.net> <Pine.LNX.4.63.0611072009220.2601@qynat.qvtvafvgr.pbz>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
NNTP-Posting-Date: Wed, 8 Nov 2006 16:41:01 +0000 (UTC)
Cc: git@vger.kernel.org
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:user-agent:mime-version:cc:subject:references:in-reply-to:content-type:content-transfer-encoding;
        b=bCP83D9fdVbLMrcs8joZVpMKIlYdv4+ccBXHp280ucUJN0fJ83DwXqNoOjVAPFGq6Hqc/b0SxFZLgYhklyENzijY2eA0r+Qo6R8u17ahr3HdK+W/NHLpTekAymRqag4Fm55ceWXoZxctD9HKYn5mkO2EVE8Twvp4FAOcvcS44Y8=
User-Agent: Thunderbird 1.5.0.7 (X11/20060918)
In-Reply-To: <Pine.LNX.4.63.0611072009220.2601@qynat.qvtvafvgr.pbz>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/31141>
Received: from vger.kernel.org ([209.132.176.167]) by ciao.gmane.org with
 esmtp (Exim 4.43) id 1GhqTZ-000434-FR for gcvg-git@gmane.org; Wed, 08 Nov
 2006 17:40:33 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id
 S1161237AbWKHQk3 (ORCPT <rfc822;gcvg-git@m.gmane.org>); Wed, 8 Nov 2006
 11:40:29 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161293AbWKHQk3
 (ORCPT <rfc822;git-outgoing>); Wed, 8 Nov 2006 11:40:29 -0500
Received: from nz-out-0102.google.com ([64.233.162.206]:24737 "EHLO
 nz-out-0102.google.com") by vger.kernel.org with ESMTP id S1161237AbWKHQk2
 (ORCPT <rfc822;git@vger.kernel.org>); Wed, 8 Nov 2006 11:40:28 -0500
Received: by nz-out-0102.google.com with SMTP id z3so1502664nzf for
 <git@vger.kernel.org>; Wed, 08 Nov 2006 08:40:28 -0800 (PST)
Received: by 10.35.33.15 with SMTP id l15mr5899213pyj.1163004028121; Wed, 08
 Nov 2006 08:40:28 -0800 (PST)
Received: from ?192.168.2.47? ( [59.92.130.252]) by mx.google.com with ESMTP
 id a22sm7816281pye.2006.11.08.08.40.26; Wed, 08 Nov 2006 08:40:27 -0800 (PST)
To: unlisted-recipients:; (no To-header on input)
Sender: git-owner@vger.kernel.org

David Lang wrote:
> On Tue, 7 Nov 2006, Junio C Hamano wrote:
> 
>> [pu]
>>
>>  Johannes's shallow clone work now should rebase cleanly on top
>>  of 'master' although I haven't done so yet.  As he said
>>  himself the series is waiting for people who have needs for
>>  such a feature to raise hands.
> 
> I haven't been watching this recently, but if this is what I understand 
> it to be (the ability to get a partial repository from upstream and work 
> normally from there with the result of data-mineing tools sometimes 
> reporting 'that's part of the truncated history' if they hit the cutoff) 
> consider my hand raised.
> 
> there are a number of cases where I would be interested in following a 
> project as it moves forwards, but do not have the need to have the full 
> history (even with the good compression that a git pack provides, it's 
> still a significant amount of disk space and download time for large 
> projects)
> 

I am trying to test this feature. Is there a documentation .git/shallow some where. Atleast what those entries
mean ? I know in the mail johannes mentioned only core git will touch this file. But it should be ok to be 
descriptive like other files. (FETCH_HEAD)

-aneesh 
