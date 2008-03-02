From: "Carlos Rica" <jasampler@gmail.com>
Subject: Re: [PATCH] Make builtin-reset.c use parse_options.
Date: Sun, 2 Mar 2008 13:37:38 +0100
Message-ID: <1b46aba20803020437p2a5128a5wfee3e98c32c1a610@mail.gmail.com>
References: <47C98472.8000002@gmail.com>
	 <7vir05x2di.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: "Junio C Hamano" <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sun Mar 02 13:38:45 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JVnSn-0002By-9k
	for gcvg-git-2@gmane.org; Sun, 02 Mar 2008 13:38:45 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753534AbYCBMhm (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 2 Mar 2008 07:37:42 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753535AbYCBMhm
	(ORCPT <rfc822;git-outgoing>); Sun, 2 Mar 2008 07:37:42 -0500
Received: from wf-out-1314.google.com ([209.85.200.172]:16496 "EHLO
	wf-out-1314.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753534AbYCBMhm (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 2 Mar 2008 07:37:42 -0500
Received: by wf-out-1314.google.com with SMTP id 28so5892797wff.4
        for <git@vger.kernel.org>; Sun, 02 Mar 2008 04:37:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        bh=D2uuO6yWFA06VsjoAQeiXaz9gZIJO2ZiDoh+S2MU+qU=;
        b=YCN18g8f2CAJoHI2+Zi7wYlstVJOqeUANYxNd00EPv/Q1tqsCqHUOjb9Ja1WlziyKUu+7KxwTYqQUb5JMN6/ak+SzBjJpO0vdkw8j8+GPRnNv4mahOPSj1ECv5Djb9LmQfGyy1XcsFOK6oUfyveAEGNeUp8OVnRHSKZH1Q9Oda8=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=PlyuiX0xj2evuXbjZuEeuJOZZV970pHyWfoDAem42j064hKL1kg0J4O1ufsW1CcjCgiRnCcyvVw0j0UzXyzCjrh/ooZuIc3Aig4oDVIMwc13NYvT9+Ya8dD0KLpzCETZJnYBAwLy9wKySoNgB5a4a7cvfzmUIpIHA2k8JW5moII=
Received: by 10.143.34.11 with SMTP id m11mr8295383wfj.222.1204461459422;
        Sun, 02 Mar 2008 04:37:39 -0800 (PST)
Received: by 10.142.99.13 with HTTP; Sun, 2 Mar 2008 04:37:38 -0800 (PST)
In-Reply-To: <7vir05x2di.fsf@gitster.siamese.dyndns.org>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/75775>

On Sun, Mar 2, 2008 at 3:53 AM, Junio C Hamano <gitster@pobox.com> wrote:
> Carlos Rica <jasampler@gmail.com> writes:
>
>  > Signed-off-by: Carlos Rica <jasampler@gmail.com>
>
>  Hmmm.  "git reset -h" now defaults to --hard?
>
>  It somehow feels a bit risky for new people.  I dunno.
>

I don't understand what do you mean.

Option -h just prints the options and exits.
Do you mean that the help message is wrong?

Also, there is a test to check that "git reset" defaults to
--mixed ('--mixed reset to HEAD should unadd the files'
only run a "git reset" without parameters),
and changing it to do a --hard reset makes the tests to fail.

If there's a change in the behaviour of the command,
please, show me how to test it. I cannot see anything
wrong now.

-- Carlos
