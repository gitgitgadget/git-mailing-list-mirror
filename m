From: "Ping Yin" <pkufranky@gmail.com>
Subject: Re: [PATCH v3 4/6] --color-words: Make non-word characters configurable
Date: Sun, 4 May 2008 15:04:03 +0800
Message-ID: <46dff0320805040004g2f38494fx33e062ede4204bd4@mail.gmail.com>
References: <1209815828-6548-1-git-send-email-pkufranky@gmail.com>
	 <1209874815-14411-1-git-send-email-pkufranky@gmail.com>
	 <1209874815-14411-2-git-send-email-pkufranky@gmail.com>
	 <1209874815-14411-3-git-send-email-pkufranky@gmail.com>
	 <1209874815-14411-4-git-send-email-pkufranky@gmail.com>
	 <1209874815-14411-5-git-send-email-pkufranky@gmail.com>
	 <7vk5iar2it.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: "Junio C Hamano" <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sun May 04 09:04:57 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JsYHI-0004Nd-76
	for gcvg-git-2@gmane.org; Sun, 04 May 2008 09:04:56 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752118AbYEDHEI (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 4 May 2008 03:04:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752029AbYEDHEH
	(ORCPT <rfc822;git-outgoing>); Sun, 4 May 2008 03:04:07 -0400
Received: from an-out-0708.google.com ([209.85.132.246]:16313 "EHLO
	an-out-0708.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752079AbYEDHEG (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 4 May 2008 03:04:06 -0400
Received: by an-out-0708.google.com with SMTP id d40so448944and.103
        for <git@vger.kernel.org>; Sun, 04 May 2008 00:04:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        bh=5cvBSTr8v3FOjdBncZgQM0FdcIPam4bnQbBinQRdhDA=;
        b=U4iq9XtIWgN5VteGcfOJFKNjkYcl5JureBcPfTDRBpntQcMDisD2aV4FJOeOvuG+co/CGEuXW4siON4SKx2pQR4SaCOPM14WM0V/IBcpaDGmIOhv+Gm46xJ69V1bdMx0O1pvz2B0GU2k4xXGdq2z1JgL4l5y1+HKbOvXt0MEuYs=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=mk/pHIVr+jB+DG2qLdnSEcEqSzZo4EMvcmeb8bIEx9OhyFPVRnbZ3VHoMqDpHRHhtK7JKQclSv7Bg2Jonyrr6czqOx+CyFVWLw5jxZoR536s/LCNM48wmvxsOWkwc8wMBW/7R1q+HcE6RPhp4oi6qcRVKDq2X3XXhNHApdqUz/k=
Received: by 10.100.33.4 with SMTP id g4mr6441447ang.128.1209884644036;
        Sun, 04 May 2008 00:04:04 -0700 (PDT)
Received: by 10.100.32.10 with HTTP; Sun, 4 May 2008 00:04:03 -0700 (PDT)
In-Reply-To: <7vk5iar2it.fsf@gitster.siamese.dyndns.org>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/81150>

On Sun, May 4, 2008 at 2:45 PM, Junio C Hamano <gitster@pobox.com> wrote:
> Ping Yin <pkufranky@gmail.com> writes:
>
>  > A more sensible implementation is to use 'insert' instead of 'replace'.
>  > Say, to insert a line break between runs of word characters and non-word
>  > characters or between non-word characters.
>  >
>  > That is, "foo>=bar" will be rewritten as "foo\n>\n=\nbar" instead of
>  > "foo\n\nbar".
>
>  Hmmmm.
>
>  I am not sure if/why you would want a separator between '>' and '=' in
>  that example.  Shouldn't that be "foo <sep> >= <sep> bar"?

That's intentional. If i change >= to >, i want it to be highlighted
as <r>=</r> instead of <r> >= </r> <g> > </g> (spaced added for
readability). So i tend to consider each non-word character as a
single word.


-- 
Ping Yin
