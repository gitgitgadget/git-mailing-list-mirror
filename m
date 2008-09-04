From: "Giuseppe Bilotta" <giuseppe.bilotta@gmail.com>
Subject: Re: [PATCH] Teach "log -F --author=<match>" to behave better
Date: Thu, 4 Sep 2008 15:56:27 +0200
Message-ID: <cb7bb73a0809040656n7f53c033w2b932d4bb5388f54@mail.gmail.com>
References: <g9o0ac$qig$1@ger.gmane.org>
	 <7v4p4w75b7.fsf@gitster.siamese.dyndns.org>
	 <7vprnk5n3c.fsf_-_@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: "Junio C Hamano" <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Sep 04 15:57:36 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KbFL5-0004T8-Sx
	for gcvg-git-2@gmane.org; Thu, 04 Sep 2008 15:57:36 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751098AbYIDN43 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 4 Sep 2008 09:56:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751404AbYIDN43
	(ORCPT <rfc822;git-outgoing>); Thu, 4 Sep 2008 09:56:29 -0400
Received: from mail-gx0-f16.google.com ([209.85.217.16]:52660 "EHLO
	mail-gx0-f16.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750958AbYIDN42 (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 4 Sep 2008 09:56:28 -0400
Received: by gxk9 with SMTP id 9so6291453gxk.13
        for <git@vger.kernel.org>; Thu, 04 Sep 2008 06:56:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from:to
         :subject:cc:in-reply-to:mime-version:content-type
         :content-transfer-encoding:content-disposition:references;
        bh=YhHgrJYwockbfl3nB41Il3sSPey1dJAUS8xCd/LBCJ4=;
        b=XsoSuYMpqugm8yr10bULLFrLOr2TewHYIOi0/7Ur8SC8CANeuNfb5qG1F6kkp7Y9J4
         VqiHOcYV1twQLjM6uXcLQz3AXMMmDF5ID/phJRoUV1rQCaIvvJ6MDlgcbc9dY+LLd4MR
         JkwOTQhm0b7JHBFZvypWoibIm7ZCJcHSNNzmA=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:to:subject:cc:in-reply-to:mime-version
         :content-type:content-transfer-encoding:content-disposition
         :references;
        b=uHVJsVTBm4mGsTS2/+I/oIPtVOXjoUoAuCcvd+56ln7USVM5IuV5ZorHFKKpQOUPXA
         y9np26posu69rJJe2rbqAdHXL2WjswKWhA/8YCW+rfxjF/bV5h0mbdBvcyGNHUutdLlj
         dfOcZPP9jWVvwvxIbwkcYK57F11M1ovNIwKjM=
Received: by 10.150.133.18 with SMTP id g18mr14463896ybd.188.1220536587442;
        Thu, 04 Sep 2008 06:56:27 -0700 (PDT)
Received: by 10.150.145.2 with HTTP; Thu, 4 Sep 2008 06:56:27 -0700 (PDT)
In-Reply-To: <7vprnk5n3c.fsf_-_@gitster.siamese.dyndns.org>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/94935>

On Thu, Sep 4, 2008 at 10:31 AM, Junio C Hamano <gitster@pobox.com> wrote:
> This extends the grep machinery so that a match insn can ignore user
> specified --fixed-string request, and uses the '( -e A --and -e B )'

(insn?)

>  * A variant of this would be to make the --author match always ignore -F,
>   which is now possible with the enhancement to the grep machinery.  But
>   it is unlikely that you would have regexp metacharacters in author
>   field, so it might not be necessary.

Well,  if the user greps for a dotted email address, not escaping the
search string might cause some false positives to pop up.

-- 
Giuseppe "Oblomov" Bilotta
