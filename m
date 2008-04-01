From: "Jonathan del Strother" <maillist@steelskies.com>
Subject: Re: Sending patches via gmail
Date: Tue, 1 Apr 2008 11:51:38 +0100
Message-ID: <57518fd10804010351x341ba728i69cfcad8f3909d6a@mail.gmail.com>
References: <57518fd10804010249h4fe43bbfu64cf9576ca2edcf3@mail.gmail.com>
	 <402731c90804010309w6a27d2d1t2df25ac41fff96b9@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: "Git Mailing List" <git@vger.kernel.org>
To: "David Aguilar" <davvid@gmail.com>
X-From: git-owner@vger.kernel.org Tue Apr 01 12:52:46 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Jge6T-0003Yw-E9
	for gcvg-git-2@gmane.org; Tue, 01 Apr 2008 12:52:33 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758176AbYDAKvk (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 1 Apr 2008 06:51:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1757547AbYDAKvk
	(ORCPT <rfc822;git-outgoing>); Tue, 1 Apr 2008 06:51:40 -0400
Received: from rv-out-0910.google.com ([209.85.198.186]:1511 "EHLO
	rv-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755897AbYDAKvj (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 1 Apr 2008 06:51:39 -0400
Received: by rv-out-0910.google.com with SMTP id k20so1181192rvb.1
        for <git@vger.kernel.org>; Tue, 01 Apr 2008 03:51:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=beta;
        h=domainkey-signature:received:received:message-id:date:from:sender:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references:x-google-sender-auth;
        bh=8LRDqwWJ195TODjqDIUjdwN/3SqLXH2l0tiArEHrLJE=;
        b=fNWxxtLV6ZP2tXyrOMNLQBMiMsVtA90uUyy421ppPgvoXJbPiXxdmGUsdKCdhcoJDTYJlqr9zZGFX58ZkqBDCwRKs0vogLMIyQaXbux60wqKo4kwACjUDIy6QezbJ5TU304oqLFS+Nrv0ksuMadGdQluy9+0tUeGBxSmfNEGi4Y=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=beta;
        h=message-id:date:from:sender:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references:x-google-sender-auth;
        b=D8Gd3tr9uw/qBVfkF87DJJ5o/5RSAfbcnaePoMYGxXuBjF//1FSSuchzbBGxXBkVWIswk2owAJSx4LH2eA+NYknrWkQLXxBnropeA8YDRc2751ApvKoZX/MwI3i7OGkZ3L0boHXAeBJPryvWX1yhI0RseyYM2eXvUg7dVp/inTo=
Received: by 10.140.201.1 with SMTP id y1mr4143693rvf.200.1207047098952;
        Tue, 01 Apr 2008 03:51:38 -0700 (PDT)
Received: by 10.141.86.15 with HTTP; Tue, 1 Apr 2008 03:51:38 -0700 (PDT)
In-Reply-To: <402731c90804010309w6a27d2d1t2df25ac41fff96b9@mail.gmail.com>
Content-Disposition: inline
X-Google-Sender-Auth: d5c0b84306fbb031
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/78641>

On Tue, Apr 1, 2008 at 11:09 AM, David Aguilar <davvid@gmail.com> wrote:
> On 4/1/08, Jonathan del Strother <maillist@steelskies.com> wrote:
>
>
> > I can't seem to send patches via gmail without it adding spurious line
>  >  breaks -  eg http://article.gmane.org/gmane.comp.version-control.git/78407.
>  >   I thought this was supposed to be possible...  All I'm doing is
>  >  copying the contents of my patch, then in Gmail, clicking Compose
>  >  Mail, make sure it's in Plain Text rather than Rich Formatting mode,
>  >  paste my patch, and moving the mail header lines out of the message
>  >  body.
>  >
>  >  What am I missing?
>  >  Jonathan del Strother
>
>
>
> Try git send-email w/ msmtp:
>  http://git.or.cz/gitwiki/GitTips#head-a015948617d9becbdc9836776f96ad244ba87cb8
>

...which seems to work ok, except for the fact that the From line in
my patch (the output of git format-patch) then appears at the top of
my message body in the resulting email (from git send-email).
Deleting the From line from the patch seems to make everything work as
expected.  Any ideas what's going on there?
