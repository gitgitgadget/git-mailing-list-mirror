From: Stefan Beller <sbeller@google.com>
Subject: Re: New Defects reported by Coverity Scan for git
Date: Fri, 31 Jul 2015 09:58:58 -0700
Message-ID: <CAGZ79kYKykLBD9VddmuV7BXJGF5YncJbn8pvs-wdEy-=1ucpuA@mail.gmail.com>
References: <55bb53d17f78c_2d71521318537c@scan.mail>
	<CACsJy8AfYHOCBdSNyBZP0CdYJGkXbipn0t7E_C8j7c25LET4Qg@mail.gmail.com>
	<CAGZ79kZMzy7x7HufeM1dotmhKn5HEw_Yoo5p8bYOfUKLbjxSww@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Jeff King <peff@peff.net>, Git Mailing List <git@vger.kernel.org>
To: Duy Nguyen <pclouds@gmail.com>
X-From: git-owner@vger.kernel.org Fri Jul 31 18:59:05 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZLDeC-0000C5-4O
	for gcvg-git-2@plane.gmane.org; Fri, 31 Jul 2015 18:59:04 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753241AbbGaQ7A (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 31 Jul 2015 12:59:00 -0400
Received: from mail-yk0-f169.google.com ([209.85.160.169]:35389 "EHLO
	mail-yk0-f169.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752828AbbGaQ66 (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 31 Jul 2015 12:58:58 -0400
Received: by ykdu72 with SMTP id u72so63980452ykd.2
        for <git@vger.kernel.org>; Fri, 31 Jul 2015 09:58:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        bh=oT4XPSXQpbQBzQEuVfkUbXXwmHHWldsa9hywALBeXIw=;
        b=Ay8lWloXd49we/QglHRBE2l6nUJ3WMox2D4Ajb/3qUjSf6Yv/Z3e8z5aTkTGIEh9dU
         j89NYk4HuRYsdvVYsF9o6okbU+TaN7k6PlpWj7yCTvCc/g/tJIpUCbmp8lW4Xmj/eSVB
         o6MX9HYZPhpD9hsv4j14DglOFQl5cVKf+fJfllbojpHkqIRSBC2KrLvxOv7hCvXCxGrG
         wU74TKLjrndyRxAkeHco5Pc9Z4noTzuOehSG/ACEBFRPByg/rSPzRyi0UL1dHUFxMRYO
         tPy969zubuq320Cctl4VG/1Cdju29vPrY3cL0gUgrH7H+DRgQhlAmh1zeWVldxOOfkB4
         eVIg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:date
         :message-id:subject:from:to:cc:content-type;
        bh=oT4XPSXQpbQBzQEuVfkUbXXwmHHWldsa9hywALBeXIw=;
        b=TpZePKXJJRmoi+h/YSAqLF294+exLqjI4asYvLi6yY4pfLd0+/KaPYaOn+ZoVKfH04
         aMoPJME3+4qptHGE+DARV1SCk3hGSsT6ugidO1kG0spRvDHf+DKX8WCXusVOGWwgu1w9
         UFrPZWQe+Z1a2jg7TRHOPYAHtjiOdb4SC+46yeu9FzuVIlDw1xhxNwLKsTOIKz/6YvDw
         Z8GwDsDcYcHYFw6j16MxCjRt7JzUD9YUbzoAJz758fR4vroZH6cWpqNTLDg+FUh0j5JJ
         Olxm3XYN9ck42aGCsAyFCey/M4LyGzjMKd0y0bfWS1p74r0CGimqHzr/AEb2slJMQoyI
         ZLTA==
X-Gm-Message-State: ALoCoQnTSToNHQ9YFdGuGgmnqH/HMwY4xk1plirRl/3GXYcXJ0vM2eAZB+VIbAud64MxEhTJwCiu
X-Received: by 10.129.124.139 with SMTP id x133mr4634259ywc.88.1438361938097;
 Fri, 31 Jul 2015 09:58:58 -0700 (PDT)
Received: by 10.37.21.129 with HTTP; Fri, 31 Jul 2015 09:58:58 -0700 (PDT)
In-Reply-To: <CAGZ79kZMzy7x7HufeM1dotmhKn5HEw_Yoo5p8bYOfUKLbjxSww@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/275054>

On Fri, Jul 31, 2015 at 9:11 AM, Stefan Beller <sbeller@google.com> wrote:
> On Fri, Jul 31, 2015 at 4:24 AM, Duy Nguyen <pclouds@gmail.com> wrote:
>> Jeff, I suppose you are the admin of git on scan.coverity, or knows
>> him/her, perhaps we can add a model for xmalloc to suppress these
>> "null pointer deferences" reports? We are sure xmalloc() never returns
>> NULL. Qemu did it [1] and it looks simple.. I think something like
>> this would do
>>
>> void *xmalloc(size_t size)
>> {
>>    void *mem = malloc(size);
>>    if (!mem) __coverity_panic__();
>>    return mem;
>> }
>>
>> [1] http://git.qemu.org/?p=qemu.git;a=blob;f=scripts/coverity-model.c;h=4c99a85cfc292caa9edd9d041e2683ee53490a8d;hb=e40cdb0e6efb795e4d19368987d53e3e4ae19cf7#l104
>>
>
> Taking just that excerpt doesn't work. Upload fails with
> "modeling_file.c", line 12: error #20:
>           identifier "malloc" is undefined
>   void *mem = malloc(size);
>
> I'll look into your reference[1] a bit more and try to follow it as a guidance.

So I put in these lines into the modeling file:
void *malloc(size_t);
void *calloc(size_t, size_t);
void *realloc(void *, size_t);
void free(void *);


void *xrealloc(void *ptr, size_t size)
{
  void *ret = realloc(ptr, size);
  if (!ret) __coverity_panic__();
  return ret;
}

void *xmalloc(size_t size)
{
  void *mem = malloc(size);
  if (!mem) __coverity_panic__();
  return mem;
}

void xcalloc(size_t num, size_t size)
{
  void *ret = calloc(num, size);
  if (!ret)  __coverity_panic__();
  return ret;
}

and there seem to be 42 new defects and 20 fixed defects by the modeling of
memory allocations. We'd need to check if coverity understood the modeling
as we intended it. Looking at the first few issues, they seem to be
correctly finding
leaks.


>
>
>>
>> ---------- Forwarded message ----------
>> From:  <scan-admin@coverity.com>
>> Date: Fri, Jul 31, 2015 at 5:54 PM
>> Subject: New Defects reported by Coverity Scan for git
>> To: pclouds@gmail.com
>>
>> _______________________________________________________________________________________________________
>> *** CID 1313836:  Null pointer dereferences  (FORWARD_NULL)
>> /rerere.c: 150 in find_rerere_dir()
>> 144                     return NULL; /* BUG */
>> 145             pos = sha1_pos(sha1, rerere_dir, rerere_dir_nr,
>> rerere_dir_sha1);
>> 146             if (pos < 0) {
>> 147                     rr_dir = xmalloc(sizeof(*rr_dir));
>> 148                     hashcpy(rr_dir->sha1, sha1);
>> 149                     rr_dir->status_nr = rr_dir->status_alloc = 0;
>>>>>     CID 1313836:  Null pointer dereferences  (FORWARD_NULL)
>>>>>     Assigning: "rr_dir->status" = "NULL".
>> 150                     rr_dir->status = NULL;
>> 151                     pos = -1 - pos;
>> 152
>> 153                     /* Make sure the array is big enough ... */
>> 154                     ALLOC_GROW(rerere_dir, rerere_dir_nr + 1,
>> rerere_dir_alloc);
>> 155                     /* ... and add it in. */
>>
>> ** CID 1313835:  Null pointer dereferences  (FORWARD_NULL)
>> /builtin/fetch.c: 795 in prune_refs()
>> --
>> Duy
>> --
>> To unsubscribe from this list: send the line "unsubscribe git" in
>> the body of a message to majordomo@vger.kernel.org
>> More majordomo info at  http://vger.kernel.org/majordomo-info.html
