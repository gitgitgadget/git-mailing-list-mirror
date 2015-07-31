From: Stefan Beller <sbeller@google.com>
Subject: Re: New Defects reported by Coverity Scan for git
Date: Fri, 31 Jul 2015 09:11:55 -0700
Message-ID: <CAGZ79kZMzy7x7HufeM1dotmhKn5HEw_Yoo5p8bYOfUKLbjxSww@mail.gmail.com>
References: <55bb53d17f78c_2d71521318537c@scan.mail>
	<CACsJy8AfYHOCBdSNyBZP0CdYJGkXbipn0t7E_C8j7c25LET4Qg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Jeff King <peff@peff.net>, Git Mailing List <git@vger.kernel.org>
To: Duy Nguyen <pclouds@gmail.com>
X-From: git-owner@vger.kernel.org Fri Jul 31 18:12:02 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZLCuf-0005EJ-Er
	for gcvg-git-2@plane.gmane.org; Fri, 31 Jul 2015 18:12:01 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751015AbbGaQL5 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 31 Jul 2015 12:11:57 -0400
Received: from mail-yk0-f172.google.com ([209.85.160.172]:34449 "EHLO
	mail-yk0-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750780AbbGaQL4 (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 31 Jul 2015 12:11:56 -0400
Received: by ykax123 with SMTP id x123so63065876yka.1
        for <git@vger.kernel.org>; Fri, 31 Jul 2015 09:11:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        bh=+5iksf8Zqb0HLyztoA/jE7Q7tIwrt67tI414BHgMybc=;
        b=b/JWli1RpkNsaDXORT1rQM87A3AXdZqXrE3wumnvd+nMnMlEY3VCiLajjnN8hhqYTS
         HmToRTF8VMYrQCXFHZat+1Zgjzumk98vT88HQ53hO+qCjXO/gDFw2tabPpK2iKXHn1OY
         lB5SywyN4O9s+/dQchYN5jCiT8dKCk39QxR2JJ1z3z8erJi+H214+qXwuNw5QMxZSrw1
         MS+M+UJOtFDjnGfJprkR+qs1bD7MIczb9MnxIPztvfdwiYvou09qtnj89e6K6KPgQuXL
         rP13HB5pP6PU2Zpnv8plc4rtGUUPWWJTmg4zDVg/2d37wHu8Jg1aJ2/SqwvcXI4Bisgb
         iW9g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:date
         :message-id:subject:from:to:cc:content-type;
        bh=+5iksf8Zqb0HLyztoA/jE7Q7tIwrt67tI414BHgMybc=;
        b=WdF+iSc60/eGXx8G8iN7ePf/OAJuA1wMnu1YL+tQHQyPvQIFi9yVHb37AY4LiKkHqi
         Jm5ZIVAyaSDmY9+a2wI1LcAnphaweWzoYS/2gViRjDi93BafyO0Dvb+Ox0vbLz9+nBbI
         BoKo8ijo9DMEVVo6VYwJQd+gRoQXD34bmZNxylhJKLA7jqA+NehuPKvAFtugTghwHkrx
         8kVJ8eBkKP5iN+WL2oPaaCae0qedOtfCMrjeYl3AuwcqZ/zK/X7HsA+I+elsx1KkB1kY
         jWJtUIIem4BNMpk+tk0NNHb0XN6zZp1I87iHFmoyKwu0XBa+fFyFNK/Dh+0Kxe3+kBra
         CoWw==
X-Gm-Message-State: ALoCoQn76mnF6pV8Lu/eZAiEeZqWHdW/XdNDcFhlj3ku5pIKoPVOOzRRFodQzwrp1kcxMbtU+wx6
X-Received: by 10.170.73.67 with SMTP id p64mr4156544ykp.101.1438359115522;
 Fri, 31 Jul 2015 09:11:55 -0700 (PDT)
Received: by 10.37.21.129 with HTTP; Fri, 31 Jul 2015 09:11:55 -0700 (PDT)
In-Reply-To: <CACsJy8AfYHOCBdSNyBZP0CdYJGkXbipn0t7E_C8j7c25LET4Qg@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/275052>

On Fri, Jul 31, 2015 at 4:24 AM, Duy Nguyen <pclouds@gmail.com> wrote:
> Jeff, I suppose you are the admin of git on scan.coverity, or knows
> him/her, perhaps we can add a model for xmalloc to suppress these
> "null pointer deferences" reports? We are sure xmalloc() never returns
> NULL. Qemu did it [1] and it looks simple.. I think something like
> this would do
>
> void *xmalloc(size_t size)
> {
>    void *mem = malloc(size);
>    if (!mem) __coverity_panic__();
>    return mem;
> }
>
> [1] http://git.qemu.org/?p=qemu.git;a=blob;f=scripts/coverity-model.c;h=4c99a85cfc292caa9edd9d041e2683ee53490a8d;hb=e40cdb0e6efb795e4d19368987d53e3e4ae19cf7#l104
>

Taking just that excerpt doesn't work. Upload fails with
"modeling_file.c", line 12: error #20:
          identifier "malloc" is undefined
  void *mem = malloc(size);

I'll look into your reference[1] a bit more and try to follow it as a guidance.


>
> ---------- Forwarded message ----------
> From:  <scan-admin@coverity.com>
> Date: Fri, Jul 31, 2015 at 5:54 PM
> Subject: New Defects reported by Coverity Scan for git
> To: pclouds@gmail.com
>
> _______________________________________________________________________________________________________
> *** CID 1313836:  Null pointer dereferences  (FORWARD_NULL)
> /rerere.c: 150 in find_rerere_dir()
> 144                     return NULL; /* BUG */
> 145             pos = sha1_pos(sha1, rerere_dir, rerere_dir_nr,
> rerere_dir_sha1);
> 146             if (pos < 0) {
> 147                     rr_dir = xmalloc(sizeof(*rr_dir));
> 148                     hashcpy(rr_dir->sha1, sha1);
> 149                     rr_dir->status_nr = rr_dir->status_alloc = 0;
>>>>     CID 1313836:  Null pointer dereferences  (FORWARD_NULL)
>>>>     Assigning: "rr_dir->status" = "NULL".
> 150                     rr_dir->status = NULL;
> 151                     pos = -1 - pos;
> 152
> 153                     /* Make sure the array is big enough ... */
> 154                     ALLOC_GROW(rerere_dir, rerere_dir_nr + 1,
> rerere_dir_alloc);
> 155                     /* ... and add it in. */
>
> ** CID 1313835:  Null pointer dereferences  (FORWARD_NULL)
> /builtin/fetch.c: 795 in prune_refs()
> --
> Duy
> --
> To unsubscribe from this list: send the line "unsubscribe git" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
