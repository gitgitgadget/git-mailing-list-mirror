From: Uri Moszkowicz <uri@4refs.com>
Subject: Re: error: git-fast-import died of signal 11
Date: Mon, 15 Oct 2012 16:28:22 -0500
Message-ID: <CAMJd5ARTmud_nrUKF8USXJAKVwvLH1gSmhys2o_mjimTW5B+Vg@mail.gmail.com>
References: <CAMJd5ATv5XfTK++4=Rs+RUkgb7F-ssrz2Lrch_WxvxZt+yF33A@mail.gmail.com>
 <CAMJd5AQ_vsQBGnMRrZUUqztjYjaHkU0_FOteNpEvE8NTrPPvQQ@mail.gmail.com> <507C7C35.7080906@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Cc: git@vger.kernel.org
To: Andrew Wong <andrew.kw.w@gmail.com>
X-From: git-owner@vger.kernel.org Mon Oct 15 23:28:56 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TNsDX-0004NZ-KA
	for gcvg-git-2@plane.gmane.org; Mon, 15 Oct 2012 23:28:55 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755154Ab2JOV2o (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 15 Oct 2012 17:28:44 -0400
Received: from mx71.nozonenet.com ([204.14.89.24]:44018 "EHLO
	mail3.nozonenet.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1754735Ab2JOV2o (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 15 Oct 2012 17:28:44 -0400
Received: (qmail 9669 invoked by uid 399); 15 Oct 2012 17:28:43 -0400
Received: from mail-vc0-f174.google.com (smtp@4refs.com@209.85.220.174)
  (de-)crypted with TLSv1: RC4-SHA [128/128] DN=unknown
  by mail3.nozonenet.com with ESMTPSAM; 15 Oct 2012 17:28:43 -0400
X-Originating-IP: 209.85.220.174
X-Sender: smtp@4refs.com
Received: by mail-vc0-f174.google.com with SMTP id fk26so2324802vcb.19
        for <git@vger.kernel.org>; Mon, 15 Oct 2012 14:28:43 -0700 (PDT)
Received: by 10.52.98.229 with SMTP id el5mr654813vdb.122.1350336522954; Mon,
 15 Oct 2012 14:28:42 -0700 (PDT)
Received: by 10.58.226.164 with HTTP; Mon, 15 Oct 2012 14:28:22 -0700 (PDT)
In-Reply-To: <507C7C35.7080906@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/207781>

Thanks for the reply. Yes I am using a 64-bit build of Git. The report
is too large to attach to email so I've uploaded it here (~6MB tar.xz
file):

http://www.tempfiles.net/download/201210/267447/fast_import_crash18192.html

On Mon, Oct 15, 2012 at 4:12 PM, Andrew Wong <andrew.kw.w@gmail.com> wrote:
> On 10/15/2012 11:53 AM, Uri Moszkowicz wrote:
>>
>> I'm trying to convert a CVS repository to Git using cvs2git. I was able to
>> generate the dump file without problem but am unable to get Git to
>> fast-import it. The dump file is 328GB and I ran git fast-import on a
>> machine with 512GB of RAM.
>
> Just taking a wild guess here. Are you using 64bit version of git? If not,
> maybe it'd help to try 64bit?
>
>
>> fatal: Out of memory? mmap failed: Cannot allocate memory
>> fast-import: dumping crash report to fast_import_crash_18192
>> error: git-fast-import died of signal 11
>
> "fast-import" also produced a crash report. It might help to diagnose the
> issue if you can post that report?
> The report shouldn't be too big. And you might want to strip any sensitive
> information before posting.
