From: "Avery Pennarun" <apenwarr@gmail.com>
Subject: Re: git-svn and svn properties on upstream
Date: Sat, 12 Jul 2008 17:30:58 -0400
Message-ID: <32541b130807121430ia85a3c8u3efc0b5a8591eb44@mail.gmail.com>
References: <608871.39190.qm@web27807.mail.ukl.yahoo.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: gnuruandstuff@yahoo.co.uk
X-From: git-owner@vger.kernel.org Sat Jul 12 23:32:02 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KHmhD-0004oa-3Q
	for gcvg-git-2@gmane.org; Sat, 12 Jul 2008 23:31:59 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752887AbYGLVbA (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 12 Jul 2008 17:31:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752313AbYGLVbA
	(ORCPT <rfc822;git-outgoing>); Sat, 12 Jul 2008 17:31:00 -0400
Received: from yw-out-2324.google.com ([74.125.46.29]:17922 "EHLO
	yw-out-2324.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752063AbYGLVa7 (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 12 Jul 2008 17:30:59 -0400
Received: by yw-out-2324.google.com with SMTP id 9so2146405ywe.1
        for <git@vger.kernel.org>; Sat, 12 Jul 2008 14:30:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from:to
         :subject:cc:in-reply-to:mime-version:content-type
         :content-transfer-encoding:content-disposition:references;
        bh=+HZwF/cJ7vwb0xwkMkZHVTD+FxW/CgylPc1PJbUjukA=;
        b=dqF/OMm/CBx77lJe7oFvF8xvvonuuK0zNNH8T5x8rlJyifn2mKv/h6XYusvqLfP6rq
         8mZbUADC8rkg211WF5MlZ+GXPehXx+uChXLAVjg4p+ISZXvpNVxt77RBCO/pfdg9bRiG
         FYg2jPX+QM4oSW6InUYWJHKR/thxTKU9rcA5c=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:to:subject:cc:in-reply-to:mime-version
         :content-type:content-transfer-encoding:content-disposition
         :references;
        b=prHILaJfFJWQDPjjV3tjufj4KWZ/EqjoM9kHGPrl+Lexp8XZSptPZvtqNnRiU4eg6j
         8siTXZlXlC0sKCjimUCmsFRpZdGqbYPV8YKAg8mrjIvqDoXpYll/f8SMAet/3KMd6T7F
         CGizSMDDRMB/xHIeySLf0SQa9R5TNrLltTtAI=
Received: by 10.151.142.16 with SMTP id u16mr17983420ybn.177.1215898258843;
        Sat, 12 Jul 2008 14:30:58 -0700 (PDT)
Received: by 10.150.98.19 with HTTP; Sat, 12 Jul 2008 14:30:58 -0700 (PDT)
In-Reply-To: <608871.39190.qm@web27807.mail.ukl.yahoo.com>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/88266>

On 7/12/08, Paul Talacko <gnuruandstuff@yahoo.co.uk> wrote:
>  * amend SVN::Git::Editor::generate_diffs to add another hash key to amend properties.
>  * look for ~/.subversion/config or /etc/subversion/config to see whether auto-props are set
>  * if set, set the properties accordingly in the @mods array of hashes.
>  * SVN::Git::Editor::A then sets the properties according to the contents of the $mods hash
> ref, using set_file_prop().

This sounds like it would be fine for almost all users.  Specifically
me :)  I think it's a good starting point, so you could build
something even more flexible on top later if you wanted.

I guess in an ideal world there'd be a way to track svn properties in
the git history, but I have no idea where such things should probably
go.

Have fun,

Avery
