From: Geoff Russell <geoffrey.russell@gmail.com>
Subject: Re: wierd git show syntax
Date: Tue, 5 Oct 2010 09:02:12 +1030
Message-ID: <AANLkTineQDgVUvbjR-9LvtuVVw3RX_gB=urY5Fn4K6QE@mail.gmail.com>
References: <AANLkTi=Zz-1dSC0imJ3NZXWcdvhXWXt-Kk94zwKe8+6Y@mail.gmail.com>
	<vpqtyl7fovk.fsf@bauges.imag.fr>
Reply-To: geoffrey.russell@gmail.com
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Cc: git@vger.kernel.org
To: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>, tom@dbservice.com
X-From: git-owner@vger.kernel.org Tue Oct 05 00:32:20 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1P2tZz-0001Mn-Ut
	for gcvg-git-2@lo.gmane.org; Tue, 05 Oct 2010 00:32:20 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756432Ab0JDWcO (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 4 Oct 2010 18:32:14 -0400
Received: from mail-ww0-f44.google.com ([74.125.82.44]:33311 "EHLO
	mail-ww0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756274Ab0JDWcN (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 4 Oct 2010 18:32:13 -0400
Received: by wwj40 with SMTP id 40so4810416wwj.1
        for <git@vger.kernel.org>; Mon, 04 Oct 2010 15:32:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:received:reply-to
         :in-reply-to:references:date:message-id:subject:from:to:cc
         :content-type;
        bh=8NMocpdodg3sxhUz+WZahkBFoDzbMXh64hVQ1IZS8Vc=;
        b=q3eQJFGaMeUxAtNpXNMOzmhYlOZG0Q3mZYSZjYAJElO78Z5a9ZjTaxIjZDTsqluYF6
         jqCT7PFcw9n+UeubwissXz92uRa0A0lQJGBtrmkDjQcV4RBiFvjuLLQSCDwuDIOu3WUb
         zejOISWI0YRBExP1a+ihKrDanCafVM7mdBCyg=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:reply-to:in-reply-to:references:date:message-id
         :subject:from:to:cc:content-type;
        b=F4lLqrBjv9lQMdTCBO0s8VvdQYdZ9SIFybqL/enn1OE+sBJRn322DVvuu3XITchnWX
         gpx4kN/+fKrhLhqwf8kZnYjBFztJsPI77bRzZQaP/xckURUozf8ZlHv8qUdrZtvnj/85
         fCcJvTmkmMflcY/3RHopkifQB7dRqUxmlLS8E=
Received: by 10.216.17.211 with SMTP id j61mr8375094wej.14.1286231532171; Mon,
 04 Oct 2010 15:32:12 -0700 (PDT)
Received: by 10.216.16.130 with HTTP; Mon, 4 Oct 2010 15:32:12 -0700 (PDT)
In-Reply-To: <vpqtyl7fovk.fsf@bauges.imag.fr>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/158134>

On Thu, Sep 30, 2010 at 10:02 PM, Matthieu Moy
<Matthieu.Moy@grenoble-inp.fr> wrote:
> Geoff Russell <geoffrey.russell@gmail.com> writes:
>
>> Hi,
>>
>> $ git show XXXX:data/path/object.c
>>
>> Gives me what I want, a cat of the objects contents. However
>> for some files I get a message about ambiguous argument telling me to
>> separate paths from revisions with '--'.
>
> This happens if data/path/object.c doesn't exist in XXXX.

Thanks Matthieu and Tom for your explanations on this. It's clearer
now ... even if my intuition failed to match the syntax!

Cheers,
Geoff
