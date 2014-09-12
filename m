From: Michael Haggerty <mhagger@alum.mit.edu>
Subject: Re: [PATCH v4 10/32] cache.h: define constants LOCK_SUFFIX and LOCK_SUFFIX_LEN
Date: Fri, 12 Sep 2014 18:44:12 +0200
Message-ID: <541322DC.4050009@alum.mit.edu>
References: <1409989846-22401-1-git-send-email-mhagger@alum.mit.edu>	<1409989846-22401-11-git-send-email-mhagger@alum.mit.edu> <CAL=YDWmhSuk9rqBKRbJLfNSn8QTtebbBMwSJqqAYOKS=ZZ1=qg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Cc: Junio C Hamano <gitster@pobox.com>, Johannes Sixt <j6t@kdbg.org>,
	=?UTF-8?B?VG9yc3RlbiBCw7ZnZXJzaGF1c2Vu?= <tboegi@web.de>,
	Jeff King <peff@peff.net>,
	"git@vger.kernel.org" <git@vger.kernel.org>
To: Ronnie Sahlberg <sahlberg@google.com>
X-From: git-owner@vger.kernel.org Fri Sep 12 18:44:24 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XSTxM-0008Mm-TF
	for gcvg-git-2@plane.gmane.org; Fri, 12 Sep 2014 18:44:21 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751266AbaILQoR (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 12 Sep 2014 12:44:17 -0400
Received: from alum-mailsec-scanner-8.mit.edu ([18.7.68.20]:56115 "EHLO
	alum-mailsec-scanner-8.mit.edu" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751245AbaILQoQ (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 12 Sep 2014 12:44:16 -0400
X-AuditID: 12074414-f79446d000001f1d-e3-541322dfefda
Received: from outgoing-alum.mit.edu (OUTGOING-ALUM.MIT.EDU [18.7.68.33])
	by alum-mailsec-scanner-8.mit.edu (Symantec Messaging Gateway) with SMTP id E6.3D.07965.FD223145; Fri, 12 Sep 2014 12:44:15 -0400 (EDT)
Received: from [192.168.69.130] (p5DDB1EE6.dip0.t-ipconnect.de [93.219.30.230])
	(authenticated bits=0)
        (User authenticated as mhagger@ALUM.MIT.EDU)
	by outgoing-alum.mit.edu (8.13.8/8.12.4) with ESMTP id s8CGiChZ011772
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES128-SHA bits=128 verify=NOT);
	Fri, 12 Sep 2014 12:44:13 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:31.0) Gecko/20100101 Icedove/31.0
In-Reply-To: <CAL=YDWmhSuk9rqBKRbJLfNSn8QTtebbBMwSJqqAYOKS=ZZ1=qg@mail.gmail.com>
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFtrFKsWRmVeSWpSXmKPExsUixO6iqHtfSTjE4M5udouuK91MFg29V5gt
	nsy9y2zxo6WH2eLfhBqLzo6vjA5sHgs2lXo8fNXF7vGsdw+jx8VLyh6fN8l53H62jSWALYrb
	JimxpCw4Mz1P3y6BO+PU/N2MBVMkK6Z+n8PawPhAqIuRk0NCwETi08KDLBC2mMSFe+vZuhi5
	OIQELjNKPO47wA7hnGeSWHv/PyNIFa+AtsSye6dZQWwWAVWJTQs2gcXZBHQlFvU0M4HYogIB
	Eh86H0DVC0qcnPkEbIOIgKbEzf7TTCBDmQVuMEosvdEDVMTBISwQLvHpWhzEssOMEjcvLWAG
	aeAUCJQ4OKGHHcRmFlCX+DPvEjOELS+x/e0c5gmMArOQ7JiFpGwWkrIFjMyrGOUSc0pzdXMT
	M3OKU5N1i5MT8/JSi3Qt9HIzS/RSU0o3MULCXmQH45GTcocYBTgYlXh4K1gEQ4RYE8uKK3MP
	MUpyMCmJ8jooCIcI8SXlp1RmJBZnxBeV5qQWH2KU4GBWEuFVFAXK8aYkVlalFuXDpKQ5WJTE
	eb8tVvcTEkhPLEnNTk0tSC2CycpwcChJ8K5UBGoULEpNT61Iy8wpQUgzcXCCDOeSEilOzUtJ
	LUosLcmIB0VrfDEwXkFSPEB7pUHaeYsLEnOBohCtpxh1OdZ1futnEmLJy89LlRLnvQxSJABS
	lFGaB7cCluReMYoDfSzM+xykigeYIOEmvQJawgS05N0cIZAlJYkIKakGRrljOod89uwVM1t+
	foXeSusz8mrdTDobzD4dnVuk6XRigfiD82l/Qrc1zw3MbzVkf7jqwX9X88cys7aF 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/256927>

On 09/12/2014 12:15 AM, Ronnie Sahlberg wrote:
> On Sat, Sep 6, 2014 at 12:50 AM, Michael Haggerty <mhagger@alum.mit.edu> wrote:
>> There are a few places that use these values, so define constants for
>> them.
>>
>> Signed-off-by: Michael Haggerty <mhagger@alum.mit.edu>
>> ---
>>  cache.h    |  4 ++++
>>  lockfile.c | 11 ++++++-----
>>  refs.c     |  7 ++++---
>>  3 files changed, 14 insertions(+), 8 deletions(-)
>>
>> diff --git a/cache.h b/cache.h
>> index da77094..41d829b 100644
>> --- a/cache.h
>> +++ b/cache.h
>> @@ -569,6 +569,10 @@ extern void fill_stat_cache_info(struct cache_entry *ce, struct stat *st);
>>  #define REFRESH_IN_PORCELAIN   0x0020  /* user friendly output, not "needs update" */
>>  extern int refresh_index(struct index_state *, unsigned int flags, const struct pathspec *pathspec, char *seen, const char *header_msg);
>>
>> +/* String appended to a filename to derive the lockfile name: */
>> +#define LOCK_SUFFIX ".lock"
>> +#define LOCK_SUFFIX_LEN 5
>> +
>>  struct lock_file {
>>         struct lock_file *next;
>>         int fd;
>> diff --git a/lockfile.c b/lockfile.c
>> index 964b3fc..bfea333 100644
>> --- a/lockfile.c
>> +++ b/lockfile.c
>> @@ -176,10 +176,11 @@ static char *resolve_symlink(char *p, size_t s)
>>  static int lock_file(struct lock_file *lk, const char *path, int flags)
>>  {
>>         /*
>> -        * subtract 5 from size to make sure there's room for adding
>> -        * ".lock" for the lock file name
>> +        * subtract LOCK_SUFFIX_LEN from size to make sure there's
>> +        * room for adding ".lock" for the lock file name:
>>          */
>> -       static const size_t max_path_len = sizeof(lk->filename) - 5;
>> +       static const size_t max_path_len = sizeof(lk->filename) -
>> +                                          LOCK_SUFFIX_LEN;
>>
>>         if (!lock_file_list) {
>>                 /* One-time initialization */
>> @@ -204,7 +205,7 @@ static int lock_file(struct lock_file *lk, const char *path, int flags)
>>         strcpy(lk->filename, path);
>>         if (!(flags & LOCK_NODEREF))
>>                 resolve_symlink(lk->filename, max_path_len);
>> -       strcat(lk->filename, ".lock");
>> +       strcat(lk->filename, LOCK_SUFFIX);
>>         lk->fd = open(lk->filename, O_RDWR | O_CREAT | O_EXCL, 0666);
>>         if (0 <= lk->fd) {
>>                 lk->owner = getpid();
>> @@ -314,7 +315,7 @@ int commit_lock_file(struct lock_file *lk)
>>         if (lk->fd >= 0 && close_lock_file(lk))
>>                 return -1;
>>         strcpy(result_file, lk->filename);
>> -       i = strlen(result_file) - 5; /* .lock */
>> +       i = strlen(result_file) - LOCK_SUFFIX_LEN; /* .lock */
> 
> Not a new bug since the previous code is broken too.
> Should probably checkstrlen(result_file) >= 5 here before subtracting 5.
> 
> Otherwise, a caller that calls commit_lock_file() with an already
> committed/closed  lock_file can cause writing outside the bounds of
> the array on the line below.

Good catch; thanks. I will fix this in the reroll (though probably in a
later patch).

>> [...]

Michael

-- 
Michael Haggerty
mhagger@alum.mit.edu
