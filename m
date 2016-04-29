From: Lars Schneider <larsxschneider@gmail.com>
Subject: Re: [PATCH] t9824: fix wrong reference value
Date: Fri, 29 Apr 2016 22:29:43 +0200
Message-ID: <ACC53CBE-D83A-49E9-9DC7-C99F485D3E55@gmail.com>
References: <0102015462bcd1c3-4196e36b-515b-447f-beca-649922456098-000000@eu-west-1.amazonses.com> <xmqqmvocz5d6.fsf@gitster.mtv.corp.google.com>
Mime-Version: 1.0 (Mac OS X Mail 7.3 \(1878.6\))
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 8BIT
Cc: Git Users <git@vger.kernel.org>,
	=?iso-8859-1?Q?SZEDER_G=E1bor?= <szeder@ira.uka.de>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri Apr 29 22:29:53 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1awF2t-0004VU-IW
	for gcvg-git-2@plane.gmane.org; Fri, 29 Apr 2016 22:29:51 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752817AbcD2U3s (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 29 Apr 2016 16:29:48 -0400
Received: from mail-wm0-f46.google.com ([74.125.82.46]:38903 "EHLO
	mail-wm0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752412AbcD2U3r convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 29 Apr 2016 16:29:47 -0400
Received: by mail-wm0-f46.google.com with SMTP id g17so53889820wme.1
        for <git@vger.kernel.org>; Fri, 29 Apr 2016 13:29:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=x1VWb3UERcWQBIxqbC0pTvySCGFG9GXniSavRXOY9R4=;
        b=SmOMR2w0k7sMWbszyaa8ix4JQMznfGuwm8oJnqZJRuCxwGRKQcUcb5xbtJnrlCt/dn
         LQXWfU+j96hIXNIwsF+SORgPsELXZfN2D9+BSLRZhdRtDxBA1Vwf6RMiTAfbEXO1CWcY
         PjRD0catDrZZNamMsvvyX75mb+M72agF4i7bQC/b+kIvzle9UbKfb4hz7w2tvhl0Mb/J
         DBnmeefRjxnrGSDNac9XXfU5DjWjsoopsQJQX24caWd9XahJGZ03QG3cUv7DSg2cnrNK
         oHeICz4VDMi0UVIBS06F4rvEHBSze//5LTFHZWJ41JGWVrKbRAogSY28JYhrM5vd3UCS
         l/mg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=x1VWb3UERcWQBIxqbC0pTvySCGFG9GXniSavRXOY9R4=;
        b=HfvOyIsCLsstQpZI7ue+tWJyYPl6o2cxpVYmtoDHXJ1y/pBlbPuakbzKXZ8tLy+mbg
         PU0qE5KzZNg4JfhbV05MskerRdER6je1bp5nElV4dWg5WIeKzW/hlTM/e6HpJLs7/YOU
         Ab3CUZbZRMcpnaF/2nhNnYrt4eX/7BbU1aiDkOJ4QZivb3rIixhNtulwHHqS16P0fNJP
         NOmi9AoEEyreEsBwvHx1e4TeF0vrryvM7rHG1fps9TEA+zzcxyjrH0jn43S8GlkEuCJM
         ty50oZL/4TjQ44/NmOPVhC15rY/E4O7+GfJDxGvmf/vFN+LirPzhh/8yeWCj63rRcakq
         TSIg==
X-Gm-Message-State: AOPr4FW/GVSfwelJJZo4Uz7u6/cVMw9Qt/FmPKBJ/ydamGj6Aecj99Y49uxkbZJeru0q6w==
X-Received: by 10.28.236.88 with SMTP id k85mr6392196wmh.53.1461961785978;
        Fri, 29 Apr 2016 13:29:45 -0700 (PDT)
Received: from slxbook3.fritz.box (p5DDB43DC.dip0.t-ipconnect.de. [93.219.67.220])
        by smtp.gmail.com with ESMTPSA id a200sm4962839wme.8.2016.04.29.13.29.44
        (version=TLS1 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Fri, 29 Apr 2016 13:29:45 -0700 (PDT)
In-Reply-To: <xmqqmvocz5d6.fsf@gitster.mtv.corp.google.com>
X-Mailer: Apple Mail (2.1878.6)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/293050>


On 29 Apr 2016, at 19:34, Junio C Hamano <gitster@pobox.com> wrote:

> Lars Schneider <larsxschneider@gmail.com> writes:
> 
>> 0492eb4 fixed a broken &&-chain in this test which broke the test as it
>> checked for a wrong size. The expected size of the file under test is
>> 39 bytes. The test checked that the size is 13 bytes. Fix the reference
>> value to make the test pass, again.
>> 
>> Signed-off-by: Lars Schneider <larsxschneider@gmail.com>
>> ---
> 
> That breaking "fix" seems to have been acked by you.
> 
> It was sort of clear that SZEDER didn't actually ran the test from
> the patch, saying "As far as I can tell after eyeballing the test
> script,", but you obviously didn't actually have a chance to test it
> until now.
> 
> Thanks for fixing it before it hits 'master'; this time I think it
> is safe to assume that this was actually tested ;-)

Yes! Lesson learned! Sorry Szeder!

- Lars


> 
> 
>> t/t9824-git-p4-git-lfs.sh | 2 +-
>> 1 file changed, 1 insertion(+), 1 deletion(-)
>> 
>> diff --git a/t/t9824-git-p4-git-lfs.sh b/t/t9824-git-p4-git-lfs.sh
>> index 64f8d18..3fc6790 100755
>> --- a/t/t9824-git-p4-git-lfs.sh
>> +++ b/t/t9824-git-p4-git-lfs.sh
>> @@ -265,7 +265,7 @@ test_expect_success 'Add big files to repo and store files in LFS based on compr
>> 		# We only import HEAD here ("@all" is missing!)
>> 		git p4 clone --destination="$git" //depot &&
>> 
>> -		test_file_in_lfs file6.bin 13 "content 6 bin 39 bytes XXXXXYYYYYZZZZZ" &&
>> +		test_file_in_lfs file6.bin 39 "content 6 bin 39 bytes XXXXXYYYYYZZZZZ" &&
>> 		test_file_count_in_dir ".git/lfs/objects" 1 &&
>> 
>> 		cat >expect <<-\EOF &&
>> 
>> --
>> https://github.com/git/git/pull/235
