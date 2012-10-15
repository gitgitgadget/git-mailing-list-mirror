From: Andrew Wong <andrew.kw.w@gmail.com>
Subject: Re: error: git-fast-import died of signal 11
Date: Mon, 15 Oct 2012 19:00:51 -0400
Message-ID: <507C95A3.8010704@gmail.com>
References: <CAMJd5ATv5XfTK++4=Rs+RUkgb7F-ssrz2Lrch_WxvxZt+yF33A@mail.gmail.com> <CAMJd5AQ_vsQBGnMRrZUUqztjYjaHkU0_FOteNpEvE8NTrPPvQQ@mail.gmail.com> <507C7C35.7080906@gmail.com> <CAMJd5ARTmud_nrUKF8USXJAKVwvLH1gSmhys2o_mjimTW5B+Vg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Uri Moszkowicz <uri@4refs.com>
X-From: git-owner@vger.kernel.org Tue Oct 16 01:01:18 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TNtel-0006Da-4s
	for gcvg-git-2@plane.gmane.org; Tue, 16 Oct 2012 01:01:07 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754055Ab2JOXA4 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 15 Oct 2012 19:00:56 -0400
Received: from mail-ia0-f174.google.com ([209.85.210.174]:61500 "EHLO
	mail-ia0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752975Ab2JOXAz (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 15 Oct 2012 19:00:55 -0400
Received: by mail-ia0-f174.google.com with SMTP id y32so4088332iag.19
        for <git@vger.kernel.org>; Mon, 15 Oct 2012 16:00:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=message-id:date:from:user-agent:mime-version:to:cc:subject
         :references:in-reply-to:content-type:content-transfer-encoding;
        bh=ukPMqXiuZ9phJm1CicTEQq48lM7dmGsB0qEzRUx4Mkg=;
        b=OieDhI8kir2YclBt21qw634YelFcF+gcPhAyw++2lp+BaAEBq6WFTJHRnCf5N5sjEn
         jH6opZwHZDUXYFcjtvaN8luEPT04Y459tot6+XqmrKZN1pHXExyIQHwP2vB38wWKBNRe
         kE2rPo5kY186/P6N8ur0HkEzKqOET2cy7acxWH1i6Ru4AAPrWnT2tkpDYxhq/pzL4Fp/
         F0Z5wTZlnwLRiobP7Pu29RECU0K2A26jJd1PwIdJaYm2br4IF4SnVn+NDBtm1I+1E+8E
         bXiv82BTSO1H23dAjndsrLvhAMupjrcWVdtvTPuNwWdAXaNHaY7IkMtzBfDXkbdnYgJH
         ZxZQ==
Received: by 10.50.155.226 with SMTP id vz2mr10420343igb.54.1350342054843;
        Mon, 15 Oct 2012 16:00:54 -0700 (PDT)
Received: from [192.168.1.112] ([66.207.196.114])
        by mx.google.com with ESMTPS id uz12sm7057221igb.16.2012.10.15.16.00.52
        (version=SSLv3 cipher=OTHER);
        Mon, 15 Oct 2012 16:00:53 -0700 (PDT)
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:12.0) Gecko/20120421 Thunderbird/12.0
In-Reply-To: <CAMJd5ARTmud_nrUKF8USXJAKVwvLH1gSmhys2o_mjimTW5B+Vg@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/207785>

On 10/15/2012 05:28 PM, Uri Moszkowicz wrote:
> Thanks for the reply. Yes I am using a 64-bit build of Git. The report
> is too large to attach to email so I've uploaded it here (~6MB tar.xz
> file):
>
> http://www.tempfiles.net/download/201210/267447/fast_import_crash18192.html
Hm, there are some blanks in the "recent commands" section:

       D someFile
       D someFile
       D someFile
       D someFile
       (blank here)
       reset refs/tags/someTag
       from :1000045763
       reset refs/heads/TAG.FIXUP
     * (blank here)

There should have been some commands there. Maybe that has something to 
do with the crash? Would you be able to locate where this is in the cvs 
dump? You might be able to use those tag names around those lines to 
help locate them.
What are those blanks supposed to be? Probably commits?
