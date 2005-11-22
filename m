From: Luben Tuikov <ltuikov@yahoo.com>
Subject: index manipulation -- how?
Date: Mon, 21 Nov 2005 21:03:37 -0800 (PST)
Message-ID: <20051122050337.46450.qmail@web31808.mail.mud.yahoo.com>
Reply-To: ltuikov@yahoo.com
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
X-From: git-owner@vger.kernel.org Tue Nov 22 06:04:44 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1EeQJh-0001O3-GT
	for gcvg-git@gmane.org; Tue, 22 Nov 2005 06:03:41 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750980AbVKVFDj (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 22 Nov 2005 00:03:39 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750984AbVKVFDi
	(ORCPT <rfc822;git-outgoing>); Tue, 22 Nov 2005 00:03:38 -0500
Received: from web31808.mail.mud.yahoo.com ([68.142.207.71]:43391 "HELO
	web31808.mail.mud.yahoo.com") by vger.kernel.org with SMTP
	id S1750977AbVKVFDi (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 22 Nov 2005 00:03:38 -0500
Received: (qmail 46452 invoked by uid 60001); 22 Nov 2005 05:03:37 -0000
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
  s=s1024; d=yahoo.com;
  h=Message-ID:Received:Date:From:Reply-To:Subject:To:MIME-Version:Content-Type:Content-Transfer-Encoding;
  b=QRwFsDhCeRGAPKRdJGhcgmHzRXStPCOsDz8dECG/WHDy1dcBcSqqftXgUWP8yG1eUK9VXHKiY4QFNvxB5M7Wq7U48SwaYFndBWhSglftccMUkVZnX7IBkLWYCXaA96PW3Da42OXcLu1ar9/pj76bQjX5OV4hKs7h8f8idpknQrY=  ;
Received: from [68.221.119.157] by web31808.mail.mud.yahoo.com via HTTP; Mon, 21 Nov 2005 21:03:37 PST
To: git@vger.kernel.org
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/12522>

I've a question:

Suppose I've updated the index and there is
several updates pending in it: several new
files, and several updates, etc.

That is a sequence of:
git-update-index [options] <file>
...

My question is:
How do I reverse a _single_ "git-update-index" operation?
Be it --add or just an update.

Thanks,
    Luben
