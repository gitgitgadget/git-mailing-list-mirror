From: "Arnaud Lacombe" <lacombar@gmail.com>
Subject: Re: git-rev-parse --symbolic-abbrev-name
Date: Mon, 5 Jan 2009 00:35:23 -0500
Message-ID: <1a69a9d80901042135w5f1c4aa2jd56ff1d9e4ffd38a@mail.gmail.com>
References: <quack.20090101T1928.lthzliaqtdf@roar.cs.berkeley.edu>
	 <402731c90901012026j470f35ffj1eaa189a837054f3@mail.gmail.com>
	 <quack.20090103T1818.lth7i5bg6f7@roar.cs.berkeley.edu>
	 <20090104033839.GD21154@genesis.frugalware.org>
	 <quack.20090103T2026.lth3afzg0hx@roar.cs.berkeley.edu>
	 <7vzli73b1g.fsf@gitster.siamese.dyndns.org>
	 <quack.20090104T0434.lthfxjz1c8x_-_@roar.cs.berkeley.edu>
	 <7v63kuyibi.fsf@gitster.siamese.dyndns.org>
	 <1a69a9d80901041223r1f3d2956ne05996793bb23e97@mail.gmail.com>
	 <20090104223819.GI21154@genesis.frugalware.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: "Junio C Hamano" <gitster@pobox.com>,
	"Karl Chen" <quarl@cs.berkeley.edu>,
	"David Aguilar" <davvid@gmail.com>,
	"Git mailing list" <git@vger.kernel.org>
To: "Miklos Vajna" <vmiklos@frugalware.org>
X-From: git-owner@vger.kernel.org Mon Jan 05 06:36:52 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LJi8t-0006b1-Py
	for gcvg-git-2@gmane.org; Mon, 05 Jan 2009 06:36:48 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751165AbZAEFf0 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 5 Jan 2009 00:35:26 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751099AbZAEFf0
	(ORCPT <rfc822;git-outgoing>); Mon, 5 Jan 2009 00:35:26 -0500
Received: from rn-out-0910.google.com ([64.233.170.187]:28296 "EHLO
	rn-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750774AbZAEFfZ (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 5 Jan 2009 00:35:25 -0500
Received: by rn-out-0910.google.com with SMTP id k40so4875448rnd.17
        for <git@vger.kernel.org>; Sun, 04 Jan 2009 21:35:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from:to
         :subject:cc:in-reply-to:mime-version:content-type
         :content-transfer-encoding:content-disposition:references;
        bh=Ew7b6aUCXVHdroKXz8S2cwkYcfv8gITxTSPofTfYt6s=;
        b=pVXxw1tPKeL7BlHVg7CvW3EQY/DJ2PHsg3K9bESEoq8FAu5kyf/wQXIeZB8/I9Zkd7
         sGG3YPU4gclZvLH7txnSc2e9Td0NQcdncUfYGr5ieDwio8Rc1FONDgcC0WsstzHNyIWC
         91FRj6rO7n5doJ8z1M8UtXajpHL3p5fKFcW2U=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:to:subject:cc:in-reply-to:mime-version
         :content-type:content-transfer-encoding:content-disposition
         :references;
        b=uAgAfDJQKcDoNzcneyfohGAHMeQsxuzeQhS/F1vwGnsRAn7tXsiuUmmai4AhyvhdEB
         E2YhxbCuKv7uM0duovm3FQZoo8jkn9YfT2Eyndjrzn1wrC1zfPf05cMsDxhC6YfkzCLo
         dcizM1ubCseBPS5orkfnt4/Zjit/DHc586GLg=
Received: by 10.150.198.14 with SMTP id v14mr10806638ybf.24.1231133723435;
        Sun, 04 Jan 2009 21:35:23 -0800 (PST)
Received: by 10.151.48.18 with HTTP; Sun, 4 Jan 2009 21:35:23 -0800 (PST)
In-Reply-To: <20090104223819.GI21154@genesis.frugalware.org>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/104562>

Hi,

On Sun, Jan 4, 2009 at 5:38 PM, Miklos Vajna <vmiklos@frugalware.org> wrote:
> On Sun, Jan 04, 2009 at 03:23:03PM -0500, Arnaud Lacombe <lacombar@gmail.com> wrote:
>> ps: I choose --symbolic-short-name as the opposite of
>> --symbolic-full-name for consistency.
>> ps2: sorry for the bogus mime-type
>
> That's not a problem, just don't attach your patch. Please read
> Documentation/SubmittingPatches.
>
ok, looks, I did these patch this morning quickly, didn't commit
anything or so. If there worth anything, then I'll spent time
commiting, doing nice integration, documentation, whatsoever ... Just
need a quick yes or no, these as patch are really trivial.

 - Arnaud

ps: btw, Documentation/git-format-patch.txt does not describe the -M
flag, not does it describe the -B flag
