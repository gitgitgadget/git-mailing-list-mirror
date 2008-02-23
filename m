From: "Jay Soffian" <jaysoffian@gmail.com>
Subject: Re: [PATCH 2/2] pull: document usage via OPTIONS_SPEC
Date: Fri, 22 Feb 2008 20:40:15 -0500
Message-ID: <76718490802221740ldbf077ch80aa6ec3fedbba61@mail.gmail.com>
References: <1203727950-14980-1-git-send-email-jaysoffian@gmail.com>
	 <1203727950-14980-2-git-send-email-jaysoffian@gmail.com>
	 <7vk5kw5v79.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org,
	"Johannes Schindelin" <Johannes.Schindelin@gmx.de>
To: "Junio C Hamano" <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sat Feb 23 02:40:56 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JSjNn-0008Uo-1I
	for gcvg-git-2@gmane.org; Sat, 23 Feb 2008 02:40:55 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753897AbYBWBkT (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 22 Feb 2008 20:40:19 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753761AbYBWBkT
	(ORCPT <rfc822;git-outgoing>); Fri, 22 Feb 2008 20:40:19 -0500
Received: from wr-out-0506.google.com ([64.233.184.229]:17525 "EHLO
	wr-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753337AbYBWBkR (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 22 Feb 2008 20:40:17 -0500
Received: by wr-out-0506.google.com with SMTP id c48so952260wra.23
        for <git@vger.kernel.org>; Fri, 22 Feb 2008 17:40:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        bh=gPkITD9waHR3JiF4Pn21zFFLqrA/gCU/C+L3lAhyXw4=;
        b=jtE32PyWu5pmcAfn7QIoXYpWy5VBsr2bmgpnKe9UqIy/ek05+dAJFBfc+OuoPRUtEOT3awqa/iJ/+PsuzX02VZM6BJgjRZotTuVgFBBlyEVIU8uYeBgbyGSrXRqyRxEIawNCTqCYhBBHvp9nUTaGWLMpiAe0cT/B/GJQW6lwKD8=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=MX/tkjA+eLv72BkzRJfmUnA4yo/q8BRLMWE6Yl4HrAwZJ3Wm04kJRiN9W2Vf0+bRyt5MmPeY2sLokyHcOdMu7wmAM/EczktUuMOeEhuG5K38X5hK+7Vw207u44uuUeQmHE0Nnr5ejZFbZbJhDtqcBwXSNP+0VAX0Ujg0qjwkltg=
Received: by 10.114.193.1 with SMTP id q1mr843355waf.75.1203730815160;
        Fri, 22 Feb 2008 17:40:15 -0800 (PST)
Received: by 10.114.145.13 with HTTP; Fri, 22 Feb 2008 17:40:15 -0800 (PST)
In-Reply-To: <7vk5kw5v79.fsf@gitster.siamese.dyndns.org>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/74780>

On Fri, Feb 22, 2008 at 8:15 PM, Junio C Hamano <gitster@pobox.com> wrote:
> OPTIONS_SPEC is not just for documentation but it actively mucks
>  with the incoming options list.
>
>  Have you checked if you did not break the actual parsing?

Duh, no. Sorry. Will do.

j.
