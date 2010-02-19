From: Thomas Rast <trast@student.ethz.ch>
Subject: Re: [BUG] ? - git log :/text results are strange
Date: Sat, 20 Feb 2010 00:45:59 +0100
Message-ID: <201002200045.59908.trast@student.ethz.ch>
References: <76c5b8581002191350h61d6d8c2jd0245c0963fcc85f@mail.gmail.com> <201002192334.52495.trast@student.ethz.ch> <76c5b8581002191541x95c3378je6f0528c11aaba4f@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Cc: <git@vger.kernel.org>
To: Eugene Sajine <euguess@gmail.com>
X-From: git-owner@vger.kernel.org Sat Feb 20 00:46:10 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1NicXx-0005eY-MF
	for gcvg-git-2@lo.gmane.org; Sat, 20 Feb 2010 00:46:10 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752112Ab0BSXqE (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 19 Feb 2010 18:46:04 -0500
Received: from gwse.ethz.ch ([129.132.178.238]:29552 "EHLO gwse.ethz.ch"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751828Ab0BSXqC (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 19 Feb 2010 18:46:02 -0500
Received: from CAS00.d.ethz.ch (129.132.178.234) by gws01.d.ethz.ch
 (129.132.178.238) with Microsoft SMTP Server (TLS) id 8.2.234.1; Sat, 20 Feb
 2010 00:46:02 +0100
Received: from thomas.localnet (217.162.250.31) by mail.ethz.ch
 (129.132.178.227) with Microsoft SMTP Server (TLS) id 8.2.234.1; Sat, 20 Feb
 2010 00:46:00 +0100
User-Agent: KMail/1.13.0 (Linux/2.6.31.12-0.1-desktop; KDE/4.4.0; x86_64; ; )
In-Reply-To: <76c5b8581002191541x95c3378je6f0528c11aaba4f@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/140505>

On Saturday 20 February 2010 00:41:32 Eugene Sajine wrote:
> oh. I see, thanks!
> 
> I had to do
> 
> $git log --pretty=oneline | grep fix
> 
> to get what i wanted...

Well, you can also do

  git log --grep=fix --pretty=oneline

Sorry for not mentioning that in my first reply...

-- 
Thomas Rast
trast@{inf,student}.ethz.ch
