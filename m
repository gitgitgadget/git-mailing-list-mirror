From: Jonas Fonseca <fonseca@diku.dk>
Subject: Re: [ANNOUNCE] tig-0.14
Date: Sun, 8 Feb 2009 12:49:29 +0100
Message-ID: <2c6b72b30902080349m2acfe12ao2f6295187e7549d3@mail.gmail.com>
References: <20090205204436.GA6072@diku.dk>
	 <20090206191511.GD19494@coredump.intra.peff.net>
	 <2c6b72b30902061410l64c98c33g19b97f656d347c83@mail.gmail.com>
	 <20090207071056.GB14856@coredump.intra.peff.net>
	 <2c6b72b30902080231i3f550322s106e1be2e5a4ed@mail.gmail.com>
	 <20090208110042.GA14359@coredump.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Sun Feb 08 12:51:02 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LW8Be-0001jG-Jt
	for gcvg-git-2@gmane.org; Sun, 08 Feb 2009 12:50:59 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753503AbZBHLte (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 8 Feb 2009 06:49:34 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752541AbZBHLtd
	(ORCPT <rfc822;git-outgoing>); Sun, 8 Feb 2009 06:49:33 -0500
Received: from fk-out-0910.google.com ([209.85.128.191]:12884 "EHLO
	fk-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753487AbZBHLtc (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 8 Feb 2009 06:49:32 -0500
Received: by fk-out-0910.google.com with SMTP id f33so1187794fkf.5
        for <git@vger.kernel.org>; Sun, 08 Feb 2009 03:49:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:sender:received:in-reply-to
         :references:date:x-google-sender-auth:message-id:subject:from:to:cc
         :content-type:content-transfer-encoding;
        bh=2gtZAtUecIbsozZOJkNITjzeiDmhsLvnRMRYwvWp5uA=;
        b=XUfTXaH9q+eJ0JPhmlp0qEUDSl6Q7Lanpba/FZ4cclSkkVX5/stzBEFdQBsxhbk24W
         +utmiL2W+VqqGF2oQfmHRPGov15w2KfJ0s/vObpHLhJBPrPSwW6SWwMNVuRol5AygMBX
         QwrVlVySsYFnirBjheH6YTOxI/sZvb6fDqMIM=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:sender:in-reply-to:references:date
         :x-google-sender-auth:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        b=YwycijettcfwEh0zexyA/xt7FvNunBiRJaKTQ4eo65ZuJLsXlSpn+DHeU5BgRxE7kt
         sWCo5GJxZzHa44lRj+zgRyISRuaDZ+ti8rg26SMZ432F2Kp0rOLMp7FAGrYmkyKcD9aq
         t8lir/ufFU/z9pHFSuao5HSfd+2FX6ttZKocQ=
Received: by 10.181.239.8 with SMTP id q8mr738281bkr.1.1234093769837; Sun, 08 
	Feb 2009 03:49:29 -0800 (PST)
In-Reply-To: <20090208110042.GA14359@coredump.intra.peff.net>
X-Google-Sender-Auth: 0bdacad50b30d14f
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/108964>

On Sun, Feb 8, 2009 at 12:00, Jeff King <peff@peff.net> wrote:
> I do have one more complaint, though. :)
>
> If you parent-blame far enough, you will reach a point before the file
> existed at all, in which case blame_read_file will die() with an error.
> It would be nice to print an error and stay on the same screen. Below is
> a patch which implements (I think) reasonably elegant solution.

OK, will apply.

-- 
Jonas Fonseca
