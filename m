From: Ronnie Sahlberg <sahlberg@google.com>
Subject: Re: [PATCH v3 05/19] update-ref.c: use the error string from _commit
 to print better message
Date: Mon, 28 Apr 2014 08:11:48 -0700
Message-ID: <CAL=YDWnD74eZ8teXsY1RfWj9ZTvmNmhYa1+3SiDBo+gCRTqf7w@mail.gmail.com>
References: <1398442494-23438-1-git-send-email-sahlberg@google.com>
	<1398442494-23438-6-git-send-email-sahlberg@google.com>
	<20140425223620.GD9218@google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: "git@vger.kernel.org" <git@vger.kernel.org>,
	Michael Haggerty <mhagger@alum.mit.edu>
To: Jonathan Nieder <jrnieder@gmail.com>
X-From: git-owner@vger.kernel.org Mon Apr 28 17:11:57 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WenDn-0005mC-Jo
	for gcvg-git-2@plane.gmane.org; Mon, 28 Apr 2014 17:11:55 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932401AbaD1PLv (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 28 Apr 2014 11:11:51 -0400
Received: from mail-ve0-f179.google.com ([209.85.128.179]:51553 "EHLO
	mail-ve0-f179.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756296AbaD1PLt (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 28 Apr 2014 11:11:49 -0400
Received: by mail-ve0-f179.google.com with SMTP id db12so8153481veb.38
        for <git@vger.kernel.org>; Mon, 28 Apr 2014 08:11:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        bh=1hXVP53hl/G3Q6Ng6h61b0lAEo2lehinYMO3xyohA/U=;
        b=HHpzMu7sGOIPT0XtDkG5fYPV1sCs9m/KZSkaSPlvNZx6YDa6az142C3MWt7wI7rAvD
         0sXgnrDh2rbaaXR9hQ4cCCynf7c/4B0cTeRPxmoy0OEwJriViZ8xI2ERWo82vrFUpwTy
         PTl8DYn7nuY+wr7gQtF1Y16k5KACICof0dinDkTDGN000aYR+bcix0HoXeZAbYRldnjN
         MXybssZS94eD6S9tIZgon5u522ITznd75/vUFntcoepfRbwwBsRij3rgjq4aZ32UA8IE
         F7kPwo00eVdRjZU8wr/HqDwHfSvUqFatdGdrZvH1yC2cOD0BA/jp9P+2xKEEQBlBSbPl
         BpIQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:date
         :message-id:subject:from:to:cc:content-type;
        bh=1hXVP53hl/G3Q6Ng6h61b0lAEo2lehinYMO3xyohA/U=;
        b=Q6fNbCB7ENXyRGSGxGdSQf+6cTmxf6QDC7HpEqxWZq+cInzCt8wzyZSoa9BVhbKT+0
         JtTlZkRJCB+FR6bxItveFVQ1kZeswuhTGZzC1AGH0IH8QxQ+PJ+ct0OgwWNYJluh5alN
         ErGxQRACuUhSdZIQljgeXvTEoykkuWkItNw38ZXVR/+R5lptAcAzuWlewneGHM+ePt7O
         e7K5yFVZX7sLvNotAQ0c+vEVFGmlfrFLZp28QtIRE6aTG/F/P75WZr936BjqC50UCNLH
         X6qsXx5FHlDC/fXcH6+mEOwx+BaRSXO+PFDI6nCw8KTny2rBoCxaMxrovsGfDqDB30dQ
         m0Fw==
X-Gm-Message-State: ALoCoQmLTKFSwxZDB491SB0FTDjnNMsuenZlyntB2QnY7XzRyHbiZhuNrNY975BORLhEVW1wxTePddcsKxbP11h0PEorcAMS0X8g5Eu7dQgqHdcqZWEmKNTT52PoaPelSXqCuCJU7dt4lBBKRr/x2vQtvMFBvrWJGhImwtzpDR3CZJL0gu+Ib9WtVFaLicD3iP6o0C0HLG6l
X-Received: by 10.58.75.114 with SMTP id b18mr31838vew.60.1398697908298; Mon,
 28 Apr 2014 08:11:48 -0700 (PDT)
Received: by 10.52.141.13 with HTTP; Mon, 28 Apr 2014 08:11:48 -0700 (PDT)
In-Reply-To: <20140425223620.GD9218@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/247356>

Good ideas.
Applied, thanks.

On Fri, Apr 25, 2014 at 3:36 PM, Jonathan Nieder <jrnieder@gmail.com> wrote:
> Ronnie Sahlberg wrote:
>
>> Call ref_transaction_commit with QUIET_ON_ERR and use the error string
>> that is returned to print a better log message if/after the transaction
>> fails.
>
> Ah, so that's how the transition to a better API happens.  Makes sense.
>
> (A mention of QUIET_ON_ERR in the patch that introduces the &err
> parameter could help, or feel free to ignore these comments, since it's
> all well by the end of the series.)
>
>> Update the tests to reflect that the log message is now slightly different
>>   fatal: update_ref failed: Cannot lock the ref 'some ref'
>> versus from the previous
>>   fatal: Cannot lock the ref 'some ref'
>
> Makes sense as a demo of what the new code allows, but is this error
> message better?  The use of 'git update-ref' is an implementation
> detail that the user doesn't need to know about.
>
> I think I'd prefer the result of plain die("%s", err), even though
> that's a no-op.
>
> [...]
>> +++ b/builtin/update-ref.c
> [...]
>> @@ -359,17 +360,18 @@ int cmd_update_ref(int argc, const char **argv, const char *prefix)
>>               die("Refusing to perform update with empty message.");
>>
>>       if (read_stdin) {
>> -             int ret;
>>               transaction = ref_transaction_begin();
>> -
>> +             if (!transaction)
>> +                     die("failed to update refs");
>
> This can't happen (xcalloc is defined to die() on malloc failure).
> If you want to protect against it anyway, die("BUG: ...")?
>
> Thanks,
> Jonathan
