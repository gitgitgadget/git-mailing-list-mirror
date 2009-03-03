From: Jay Soffian <jaysoffian@gmail.com>
Subject: Re: [PATCH v3] send-email: add --confirm option and configuration 
	setting
Date: Tue, 3 Mar 2009 13:18:01 -0500
Message-ID: <76718490903031018o57d5e33fv9936a3a3234558fc@mail.gmail.com>
References: <7v1vtfjpad.fsf@gitster.siamese.dyndns.org>
	 <1236055938-65407-1-git-send-email-jaysoffian@gmail.com>
	 <36ca99e90903030354j33de0313n41d8a95ff898798b@mail.gmail.com>
	 <76718490903030822j690cb97blea292d391c0d0112@mail.gmail.com>
	 <7vvdqqblij.fsf@gitster.siamese.dyndns.org>
	 <36ca99e90903031005g3d54436cs486133a340c1eec1@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org,
	Nanako Shiraishi <nanako3@lavabit.com>,
	Paul Gortmaker <paul.gortmaker@windriver.com>
To: Bert Wesarg <bert.wesarg@googlemail.com>
X-From: git-owner@vger.kernel.org Tue Mar 03 19:19:45 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LeZDL-0002BA-EI
	for gcvg-git-2@gmane.org; Tue, 03 Mar 2009 19:19:35 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752370AbZCCSSH (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 3 Mar 2009 13:18:07 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750860AbZCCSSG
	(ORCPT <rfc822;git-outgoing>); Tue, 3 Mar 2009 13:18:06 -0500
Received: from rv-out-0506.google.com ([209.85.198.236]:4303 "EHLO
	rv-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751130AbZCCSSE (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 3 Mar 2009 13:18:04 -0500
Received: by rv-out-0506.google.com with SMTP id g37so2899269rvb.1
        for <git@vger.kernel.org>; Tue, 03 Mar 2009 10:18:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :date:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=BfqddSJ3ggFuwgwWi7wC3vGFEcbiD7Im1rTZqyw17nI=;
        b=gE5Wxp05imzOiTv7RG1NI6ZuarTvPsooMuUGl0CZpNbyeDrxgT5GHAehjHZEJDt2sx
         /2qo6sZRMtfD92+ilF9zujrdSLvQ7pJWutxRfy3plLFeTlRRf6ohtgHGR6zrEYi8FXYo
         aDU4uN9bcFIH8IRKnp+gceRNYmev3mfhEqczQ=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=p7KQOP1LuVga3VVDp/YuYoftRK7y/qIVPAcFqxJMziVs0QuDINm0U4nZh4JsC2ZTeI
         ZQQrUp1wr6Nu5lzdagZ1bJnDHj1isx1MIAegaid8Mg7gvkeehXkM+fhWFD9NFMMaXN5N
         NKX+MGDoOWKlTFWwS6IhvF1klNOrc0ekSencU=
Received: by 10.141.197.14 with SMTP id z14mr3654496rvp.203.1236104281735; 
	Tue, 03 Mar 2009 10:18:01 -0800 (PST)
In-Reply-To: <36ca99e90903031005g3d54436cs486133a340c1eec1@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/112140>

On Tue, Mar 3, 2009 at 1:05 PM, Bert Wesarg <bert.wesarg@googlemail.com> wrote:
>
> Just to clarify: A user who runs a --dry-run before every sending
> (like me) would check the Cc list anyway (like me), so he either would
> have sendmail.confirm=never in the config, so that he will not
> bothered by send-email while sending or he sees some Cc's that he
> don't want and can remove them in the sending process.

Correct. This confirm addition was motivated by new users who do not know about
--dry-run and are surprised when their email is sent to unintended recipients.

If you always use --dry-run, and don't want to be prompted when you actually
send, then setting sendemail.confirm=never is what you want.

> Ok, than I'm fine with this.

Phew. :-)

j.
