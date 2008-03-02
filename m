From: "Ping Yin" <pkufranky@gmail.com>
Subject: Re: Re* [PATCH] git-submodule: Don't blame when git-describe fails
Date: Mon, 3 Mar 2008 01:17:16 +0800
Message-ID: <46dff0320803020917s154c204cl56d85e47de892173@mail.gmail.com>
References: <1204469152-24227-1-git-send-email-pkufranky@gmail.com>
	 <7vy791oyqa.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org, "Shawn O. Pearce" <spearce@spearce.org>,
	"Johannes Schindelin" <Johannes.Schindelin@gmx.de>
To: "Junio C Hamano" <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sun Mar 02 18:18:00 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JVrox-0008KM-KS
	for gcvg-git-2@gmane.org; Sun, 02 Mar 2008 18:17:56 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755128AbYCBRRT (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 2 Mar 2008 12:17:19 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755246AbYCBRRS
	(ORCPT <rfc822;git-outgoing>); Sun, 2 Mar 2008 12:17:18 -0500
Received: from hs-out-0708.google.com ([64.233.178.243]:34167 "EHLO
	hs-out-0708.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754933AbYCBRRS (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 2 Mar 2008 12:17:18 -0500
Received: by hs-out-0708.google.com with SMTP id 4so1594479hsl.5
        for <git@vger.kernel.org>; Sun, 02 Mar 2008 09:17:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        bh=ym4muCIBbQpbliqEiHmjbooY9jm3xh8fsd2Aub+oKkU=;
        b=tFjDuDgCECY8PgyrJry6VJIZ/ngD4fuGDqlVM+8YCR433ljDiDrhSxY5G/lDAHpzJESU+yn8GhINTor9O2VYVrwHE01LpHQpzTyQPPMHG2RZiH4EFchzn89C12vHQBcZPHA4nmL3WiKaI4bri4VwWNjKEs68Vefj/wXT2R0zbRE=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=Uvgk2QdtIZVFF2eGE08moqwEWThjrZcm3gmRbzdR3CSe6e2Qs3A/3FHZ5+wz++r5WkCpJmLvcNfvTqnVc4lNubEwX70iaGR++EGwkkBv5i4UNmIGfBpZkXYd+zW8F0w1QBQEZBNhvVR/hH89apl6upcCT+LAyMG2UBfaGFoUWNI=
Received: by 10.100.195.15 with SMTP id s15mr19546148anf.28.1204478236168;
        Sun, 02 Mar 2008 09:17:16 -0800 (PST)
Received: by 10.100.95.20 with HTTP; Sun, 2 Mar 2008 09:17:16 -0800 (PST)
In-Reply-To: <7vy791oyqa.fsf@gitster.siamese.dyndns.org>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/75815>

On 3/3/08, Junio C Hamano <gitster@pobox.com> wrote:
> Ping Yin <pkufranky@gmail.com> writes:
>
> > Avoid 'fatal: cannot describe' message
> >
> > Signed-off-by: Ping Yin <pkufranky@gmail.com>
>
> I see you reworded the commit log somewhat in your second attempt.  I
> would have written it this way, though:
>
>    git-submodule: Avoid 'fatal: cannot describe' message
>
>    When "git submodule status" command tries to show the name of the
>    submodule HEAD revision more descriptively, but the submodule
>    repository lacked a suitable tag to do so, it leaked "fatal: cannot
>    describe" message to the UI.  Squelch it.
>
That's ok. You can sign off it.

-- 
Ping Yin
