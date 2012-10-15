From: Andrew Wong <andrew.kw.w@gmail.com>
Subject: Re: error: git-fast-import died of signal 11
Date: Mon, 15 Oct 2012 17:12:21 -0400
Message-ID: <507C7C35.7080906@gmail.com>
References: <CAMJd5ATv5XfTK++4=Rs+RUkgb7F-ssrz2Lrch_WxvxZt+yF33A@mail.gmail.com> <CAMJd5AQ_vsQBGnMRrZUUqztjYjaHkU0_FOteNpEvE8NTrPPvQQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Uri Moszkowicz <uri@4refs.com>
X-From: git-owner@vger.kernel.org Mon Oct 15 23:12:43 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TNrxq-00071b-Jt
	for gcvg-git-2@plane.gmane.org; Mon, 15 Oct 2012 23:12:42 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753101Ab2JOVMc (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 15 Oct 2012 17:12:32 -0400
Received: from mail-ie0-f174.google.com ([209.85.223.174]:65367 "EHLO
	mail-ie0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750895Ab2JOVMb (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 15 Oct 2012 17:12:31 -0400
Received: by mail-ie0-f174.google.com with SMTP id k13so8630268iea.19
        for <git@vger.kernel.org>; Mon, 15 Oct 2012 14:12:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=message-id:date:from:user-agent:mime-version:to:cc:subject
         :references:in-reply-to:content-type:content-transfer-encoding;
        bh=fbH6DSku36IbaMJ6D2tdfrNTAvlm3ZvxP126OVUMhYA=;
        b=PKfNCK53zgqykwMKQ5BDQx8zXP2nffm6xitR7zjgPbjdht0B6/pkhOncF1q5aYommx
         2VT74bQ9ZEpErNpYNqF6ZmPsW6c2tyRdJ4Nu81hQ6aIicAW+OcHGZFGDhln15vtmQSjE
         0HjsOeIx5DRjJDbMGnoxY8OhOd/KCNjIoZfroJBSLoM+7vIK7qMZHwXkbtE/lfd4HBXv
         +NP794jOFH2RFW+j1aAm2gz9j7guAI+zdMAzASRFWfYf+eBL4MiEumpNXVUXYUwhQ2fQ
         2N2z6CfnjuL3A5HI8Cm7a57ljY4qZjUTfmt4FWRsx/LiTNfwEiwouLsoZ8d/d4sOgzQ4
         QYIA==
Received: by 10.50.153.162 with SMTP id vh2mr9940746igb.67.1350335550643;
        Mon, 15 Oct 2012 14:12:30 -0700 (PDT)
Received: from [192.168.1.112] ([66.207.196.114])
        by mx.google.com with ESMTPS id v12sm7344687igv.3.2012.10.15.14.12.28
        (version=SSLv3 cipher=OTHER);
        Mon, 15 Oct 2012 14:12:29 -0700 (PDT)
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:12.0) Gecko/20120421 Thunderbird/12.0
In-Reply-To: <CAMJd5AQ_vsQBGnMRrZUUqztjYjaHkU0_FOteNpEvE8NTrPPvQQ@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/207780>

On 10/15/2012 11:53 AM, Uri Moszkowicz wrote:
> I'm trying to convert a CVS repository to Git using cvs2git. I was able to
> generate the dump file without problem but am unable to get Git to
> fast-import it. The dump file is 328GB and I ran git fast-import on a
> machine with 512GB of RAM.
Just taking a wild guess here. Are you using 64bit version of git? If 
not, maybe it'd help to try 64bit?

> fatal: Out of memory? mmap failed: Cannot allocate memory
> fast-import: dumping crash report to fast_import_crash_18192
> error: git-fast-import died of signal 11
"fast-import" also produced a crash report. It might help to diagnose 
the issue if you can post that report?
The report shouldn't be too big. And you might want to strip any 
sensitive information before posting.
