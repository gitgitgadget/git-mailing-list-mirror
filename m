From: Joe Perches <joe@perches.com>
Subject: Re: [PATCH 2/2] send-email: add series-cc-cmd option
Date: Mon, 12 Nov 2012 14:52:39 -0800
Message-ID: <1352760759.18715.7.camel@joe-AO722>
References: <1352653463-1923-1-git-send-email-felipe.contreras@gmail.com>
	 <1352653463-1923-3-git-send-email-felipe.contreras@gmail.com>
	 <CALkWK0mRKznNN7750h=k6aE3OJ7hBLVC-G51gEYi2+NuYjPWrQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"
Content-Transfer-Encoding: 7bit
Cc: Felipe Contreras <felipe.contreras@gmail.com>, git@vger.kernel.org,
	Junio C Hamano <gitster@pobox.com>,
	Jonathan Nieder <jrnieder@gmail.com>,
	Pascal Obry <pascal@obry.net>
To: Ramkumar Ramachandra <artagnon@gmail.com>
X-From: git-owner@vger.kernel.org Mon Nov 12 23:52:53 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TY2s8-0005Rp-Hd
	for gcvg-git-2@plane.gmane.org; Mon, 12 Nov 2012 23:52:52 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753875Ab2KLWwj (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 12 Nov 2012 17:52:39 -0500
Received: from perches-mx.perches.com ([206.117.179.246]:38079 "EHLO
	labridge.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S1752506Ab2KLWwi (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 12 Nov 2012 17:52:38 -0500
Received: from [173.51.221.202] (account joe@perches.com HELO [192.168.1.167])
  by labridge.com (CommuniGate Pro SMTP 5.0.14)
  with ESMTPA id 19833127; Mon, 12 Nov 2012 14:52:38 -0800
In-Reply-To: <CALkWK0mRKznNN7750h=k6aE3OJ7hBLVC-G51gEYi2+NuYjPWrQ@mail.gmail.com>
X-Mailer: Evolution 3.6.0-0ubuntu3 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/209538>

On Tue, 2012-11-13 at 03:21 +0530, Ramkumar Ramachandra wrote:
> Felipe Contreras wrote:
> > cc-cmd is only per-file, and many times receipients get lost without
> > seing the full patch series.
> 
> s/seing/seeing
> 
> > [...]
> 
> Looks good otherwise.

s/receipients/recipients/ too

Practically this is ok but I think it's unnecessary.

Output from git format-patch is always in a single
directory.

My work flow is to use a script for --to and --cc
lines that can be set to emit the same addresses for
all files in a patch series or generate different
addresses per patch file.
