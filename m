From: Marius Storm-Olsen <mstormo@gmail.com>
Subject: Re: [PATCH 04/15] Set _O_BINARY as default fmode for both MinGW and
 MSVC
Date: Thu, 17 Sep 2009 10:45:15 +0200
Message-ID: <4AB1F71B.6050004@gmail.com>
References: <cover.1253088099.git.mstormo@gmail.com>	 <6e6345fb3fbc19b1a2467e33e1633fe9025e547b.1253088099.git.mstormo@gmail.com>	 <929c5a34cd2621af24bcda7e47ff2e76b51c2e09.1253088099.git.mstormo@gmail.com>	 <4AB10F01.9010703@viscovery.net>	 <e2480c70909161300o3db4b416k8f33ccce2f987c55@mail.gmail.com>	 <4AB1E118.70504@viscovery.net> <4AB1E4C5.80102@gmail.com>	 <4AB1E6E4.1040100@viscovery.net> <4AB1EB02.2090308@gmail.com>	 <4AB1EF0E.5010600@viscovery.net> <e2480c70909170139x9580bb4pcc1ad8e1b93aef17@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Cc: Johannes Sixt <j.sixt@viscovery.net>, git@vger.kernel.org,
	Johannes.Schindelin@gmx.de, msysgit@googlegroups.com,
	gitster@pobox.com, j6t@kdbg.org, lznuaa@gmail.com,
	raa.lkml@gmail.com,
	Marius Storm-Olsen <marius.storm-olsen@nokia.com>
To: Alexey Borzenkov <snaury@gmail.com>
X-From: git-owner@vger.kernel.org Thu Sep 17 10:45:57 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MoCcn-0002IC-18
	for gcvg-git-2@lo.gmane.org; Thu, 17 Sep 2009 10:45:57 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754572AbZIQIpo (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 17 Sep 2009 04:45:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754551AbZIQIpo
	(ORCPT <rfc822;git-outgoing>); Thu, 17 Sep 2009 04:45:44 -0400
Received: from mail-ew0-f206.google.com ([209.85.219.206]:57661 "EHLO
	mail-ew0-f206.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754529AbZIQIpm (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 17 Sep 2009 04:45:42 -0400
Received: by ewy2 with SMTP id 2so180331ewy.17
        for <git@vger.kernel.org>; Thu, 17 Sep 2009 01:45:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from
         :user-agent:mime-version:to:cc:subject:references:in-reply-to
         :content-type:content-transfer-encoding;
        bh=ZrjZf542/x7KeyRUzjMa3WoeN+8izKSfh+rl4UfnTs4=;
        b=s8hHLTqH5fHsrXvdytckRrWBHElivSGlyTp1hOpHfJ5DzetUUKRkTfFyRRTpN4tkg+
         b2OCAgXi/KqTej76R22Mu6jTD82sdhZbRABbiHE8kwZ2i0eoqmr6keRzTIvEBvuGl+iq
         B1UvX/MLjIBl1/kgFS3d8EvAdrLi2bzNBxiYo=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:user-agent:mime-version:to:cc:subject
         :references:in-reply-to:content-type:content-transfer-encoding;
        b=Jmrub9gufC/KLjWbTZET1RbCyt4/V2rbjVOKBaO6bszmVxC4K9kwphEBFc9DTUXXvk
         3i7KLE+YyN/59rasnjKDbbeQr6Qe9YlTG67VO4ISfuzNZVBKsrhRoQUTGA2SkBljDhC2
         IQzmpEk88DVK4/OvA/w4AUS6ok+/mpfgg7hjY=
Received: by 10.210.155.2 with SMTP id c2mr3481979ebe.23.1253177145279;
        Thu, 17 Sep 2009 01:45:45 -0700 (PDT)
Received: from ?172.24.90.95? ([62.70.27.104])
        by mx.google.com with ESMTPS id 24sm1101894eyx.47.2009.09.17.01.45.43
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Thu, 17 Sep 2009 01:45:44 -0700 (PDT)
User-Agent: Mozilla/5.0 (Windows; U; Windows NT 5.1; en-US; rv:1.8.1.23) Gecko/20090812 Lightning/0.9 Thunderbird/2.0.0.23 ThunderGit/0.1a Mnenhy/0.7.6.666
In-Reply-To: <e2480c70909170139x9580bb4pcc1ad8e1b93aef17@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/128734>

Alexey Borzenkov said the following on 17.09.2009 10:39:
> On Thu, Sep 17, 2009 at 12:10 PM, Johannes Sixt <j.sixt@viscovery.net> wrote:
>> Marius Storm-Olsen schrieb:
>>> BTW, I ran all the tests (make /k test) before and after the
>>> whole series, with msysgit 'devel' branch + plain git.git 'next',
>>> and it turns out that 2 more tests pass after this series :)
>> Sorry to disappoint you: these 2 tests only passed by chance. For a
>> work-around see e95a73ef in mingw.git (it papers over an undetected
>> racily-clean index).
> 
> Maybe we should just implement nsec for mingw? The code is already almost there:
> 
> Converter filetime_to_timespec is available in cygwin.c
> Definition of struct timespec and struct stat that uses it can be
> borrowed from cygwin's cygwin/stat.h and cygwin/types.h, we could call
> it struct mingw_timespec and struct mingw_stat. Then #define timespec
> mingw_timespec and #define stat mingw_stat, as well as #define
> st_atime (st_atim.tv_sec) and similarly others, just like
> cygwin/stat.h does.
> Since we already reimplement stat/lstat/fstat it should be relatively
> simple and we don't care about usage of mingw's stat.
> Do you want me to cook up a patch?

we already override the stat() implementation with our own :)

compat/mingw.h (~174):

/* Use mingw_lstat() instead of lstat()/stat() and
  * mingw_fstat() instead of fstat() on Windows.
  */
#define off_t off64_t
#define stat _stati64
#define lseek _lseeki64
int mingw_lstat(const char *file_name, struct stat *buf);
int mingw_fstat(int fd, struct stat *buf);
#define fstat mingw_fstat
#define lstat mingw_lstat
#define _stati64(x,y) mingw_lstat(x,y)

int mingw_utime(const char *file_name, const struct utimbuf *times);
#define utime mingw_utime

See compat/mingw.c for implementation..

--
.marius
