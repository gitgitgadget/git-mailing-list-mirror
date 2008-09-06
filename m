From: "Eric Raible" <raible@gmail.com>
Subject: Re: Bug? - Unexpected lock file error
Date: Fri, 5 Sep 2008 17:05:36 -0700
Message-ID: <279b37b20809051705o1f00ac4fpfc085fe58fdf5133@mail.gmail.com>
References: <279b37b20809051622q6b3ab37tec3f1726c71952e4@mail.gmail.com>
	 <7v63paupd8.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: "Git Mailing List" <git@vger.kernel.org>, vmiklos@frugalware.org
To: "Junio C Hamano" <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sat Sep 06 02:06:46 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KblK9-0004nt-Pa
	for gcvg-git-2@gmane.org; Sat, 06 Sep 2008 02:06:46 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751825AbYIFAFi (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 5 Sep 2008 20:05:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751867AbYIFAFi
	(ORCPT <rfc822;git-outgoing>); Fri, 5 Sep 2008 20:05:38 -0400
Received: from wf-out-1314.google.com ([209.85.200.172]:56057 "EHLO
	wf-out-1314.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751685AbYIFAFh (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 5 Sep 2008 20:05:37 -0400
Received: by wf-out-1314.google.com with SMTP id 27so662300wfd.4
        for <git@vger.kernel.org>; Fri, 05 Sep 2008 17:05:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from:to
         :subject:cc:in-reply-to:mime-version:content-type
         :content-transfer-encoding:content-disposition:references;
        bh=cN1YHK98lKKsRS7agoc5LxY1yo9qRqpWXpwweH2SxCA=;
        b=MlDJTd6xJs6F3nClIAMOwTzC75Wej3At/uaCHFA+Oiw/rU+RMiQNRdXf4uyb+9gosV
         TchxarsNUcsVix2c6n4uFZIPVAhaJwxW4STP8tnX3WZ9Pp3eleqs5upVxAlEIxvKzXlj
         VocdT/JGANcy2mRqwpm5wMmQQbrnyDNibcWgc=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:to:subject:cc:in-reply-to:mime-version
         :content-type:content-transfer-encoding:content-disposition
         :references;
        b=mtgkDjgzoucc0ZHCrp9IWt0SdlFU9IB99l5gkbYZK9oREenFAKn+GL102iBPio5sKm
         yfeRWrpr2tI1af9t+0FfFxGue/b/WLpHuPtPp1JdgqRvTB35i3ZPS+KViyQBPawrmbW5
         W7rcZ/7qIgDSPilRwFajRx5J72U+5Z21Ca994=
Received: by 10.142.139.14 with SMTP id m14mr4276086wfd.207.1220659536877;
        Fri, 05 Sep 2008 17:05:36 -0700 (PDT)
Received: by 10.142.177.12 with HTTP; Fri, 5 Sep 2008 17:05:36 -0700 (PDT)
In-Reply-To: <7v63paupd8.fsf@gitster.siamese.dyndns.org>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/95051>

On Fri, Sep 5, 2008 at 4:47 PM, Junio C Hamano <gitster@pobox.com> wrote:
> "Eric Raible" <raible@gmail.com> writes:
>
>> If 'empty' has any commits then the merge happens as expected.
>
> I think it is a bug in the git-merge rewritten in C, in "Already
> uptodate!" codepath.

And the ""Already uptodate!" codepath isn't even triggered when we're up-to-date
but 'empty' has at even one actual commit.  In that case we get a friendly
"Already up-to-date" and no fatal error.
