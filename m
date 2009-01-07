From: "Arnaud Lacombe" <lacombar@gmail.com>
Subject: Re: git-rev-parse --symbolic-abbrev-name
Date: Tue, 6 Jan 2009 23:58:44 -0500
Message-ID: <1a69a9d80901062058n2e6c51b9vfb2332c79463de37@mail.gmail.com>
References: <quack.20090101T1928.lthzliaqtdf@roar.cs.berkeley.edu>
	 <402731c90901012026j470f35ffj1eaa189a837054f3@mail.gmail.com>
	 <quack.20090103T1818.lth7i5bg6f7@roar.cs.berkeley.edu>
	 <20090104033839.GD21154@genesis.frugalware.org>
	 <quack.20090103T2026.lth3afzg0hx@roar.cs.berkeley.edu>
	 <7vzli73b1g.fsf@gitster.siamese.dyndns.org>
	 <quack.20090104T0434.lthfxjz1c8x_-_@roar.cs.berkeley.edu>
	 <7v63kuyibi.fsf@gitster.siamese.dyndns.org>
	 <1a69a9d80901041223r1f3d2956ne05996793bb23e97@mail.gmail.com>
	 <7vocykkftg.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: "Karl Chen" <quarl@cs.berkeley.edu>,
	"Miklos Vajna" <vmiklos@frugalware.org>,
	"David Aguilar" <davvid@gmail.com>,
	"Git mailing list" <git@vger.kernel.org>
To: "Junio C Hamano" <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Jan 07 06:00:09 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LKQWW-0001kQ-H5
	for gcvg-git-2@gmane.org; Wed, 07 Jan 2009 06:00:08 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754620AbZAGE6q (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 6 Jan 2009 23:58:46 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754120AbZAGE6p
	(ORCPT <rfc822;git-outgoing>); Tue, 6 Jan 2009 23:58:45 -0500
Received: from wa-out-1112.google.com ([209.85.146.181]:62390 "EHLO
	wa-out-1112.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753178AbZAGE6o (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 6 Jan 2009 23:58:44 -0500
Received: by wa-out-1112.google.com with SMTP id v27so4227987wah.21
        for <git@vger.kernel.org>; Tue, 06 Jan 2009 20:58:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from:to
         :subject:cc:in-reply-to:mime-version:content-type
         :content-transfer-encoding:content-disposition:references;
        bh=abyW2w0+oyh2YKXNFpO8wX8h+RUdwyvbNOgakFFO0g0=;
        b=riyUcTFfDC+4Wn58DQHhQmrWbVioSxekGSmIdsG7PW9PmgD3XTHC980TkiZE2rcfM8
         ITmWd3DIOj8SHKUAF9On4B4wp2hXb25iIrskP/3zqeQQS3yHwdg8CsIRtOQFuuhHFDn6
         BgqtuqWlH2EesbaFwZmuAigxoLnpK901Q861w=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:to:subject:cc:in-reply-to:mime-version
         :content-type:content-transfer-encoding:content-disposition
         :references;
        b=DAubJq9LL6rISfHGsNMGHX1KKAMmZPMj0svi3gYWSo/XeuP2oS3fGHNRQgoFi67Jzh
         Wsh9BYfjdGGjI9b6uOZQxxUXa6uRqpIT+ZdujZ6rnYwZNR+tYryrP7JZQn3NKEqhTsCz
         Z5Zgp/1Du6NKx7cvWHIXVgX3Pt2ZnXNZV9FJk=
Received: by 10.115.91.11 with SMTP id t11mr14985129wal.117.1231304324115;
        Tue, 06 Jan 2009 20:58:44 -0800 (PST)
Received: by 10.114.147.8 with HTTP; Tue, 6 Jan 2009 20:58:44 -0800 (PST)
In-Reply-To: <7vocykkftg.fsf@gitster.siamese.dyndns.org>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/104756>

On Tue, Jan 6, 2009 at 3:18 AM, Junio C Hamano <gitster@pobox.com> wrote:
>> diff --git a/builtin-rev-parse.c b/builtin-rev-parse.c
>> index 81d5a6f..70f4a33 100644
>> --- a/builtin-rev-parse.c
>> +++ b/builtin-rev-parse.c
>> @@ -24,6 +24,7 @@ static int show_type = NORMAL;
>>
>>  #define SHOW_SYMBOLIC_ASIS 1
>>  #define SHOW_SYMBOLIC_FULL 2
>> +#define SHOW_SYMBOLIC_SHORT 3
>>  static int symbolic;
>>  static int abbrev;
>>  static int output_sq;
>
> I think --symbolic-short makes the most sense.
>
ok, thanks.

>> @@ -125,13 +129,20 @@ static void show_rev(int type, const unsigned char *sha1, const char *name)
>>                                */
>>                               break;
>>                       case 1: /* happy */
>> +                             if (symbolic == SHOW_SYMBOLIC_SHORT) {
>> +                                     char *p;
>> +                                     p = strrchr(full, (int)'/');
>> +                                     if (p != NULL)
>> +                                             full = p + 1;
>> +                             }
>
> However, this is not a good way to do it, I suspect.  This patch most
> likely will be queued to the al/symbolic-short topic branch, but you are
> losing information here.  You'd probably want to try substings from the
> tail of the full name (e.g. symbolic-short, al/symbolic-short,
> heads/al/symbolic-short, and finally refs/heads/al/symbolic-short) and
> feed them to dwim_ref() and pick the shortest one that yields the same ref
> unambiguously, or something like that.
>
ok, I see what you mean, I'll rework the patch to fix this. I was
about to do a proper patch submission when I saw you reply, so it will
be for next time!

> By the way, I do not see why you need to cast '/'.
>
overzealous type casting due to lack of cafeine in blood :-)

regards,

 - Arnaud
