From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: [PATCH] gitweb: use out-of-line GIT logo.
Date: Mon, 31 Jul 2006 07:21:39 +0200
Organization: At home
Message-ID: <eak40m$68u$1@sea.gmane.org>
References: <20060730223839.GB16364@admingilde.org> <20060731035904.53458.qmail@web31813.mail.mud.yahoo.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7Bit
X-From: git-owner@vger.kernel.org Mon Jul 31 07:21:48 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1G7QDm-0007Nu-Dw
	for gcvg-git@gmane.org; Mon, 31 Jul 2006 07:21:42 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751486AbWGaFVj (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 31 Jul 2006 01:21:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751491AbWGaFVj
	(ORCPT <rfc822;git-outgoing>); Mon, 31 Jul 2006 01:21:39 -0400
Received: from main.gmane.org ([80.91.229.2]:64956 "EHLO ciao.gmane.org")
	by vger.kernel.org with ESMTP id S1751486AbWGaFVi (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 31 Jul 2006 01:21:38 -0400
Received: from list by ciao.gmane.org with local (Exim 4.43)
	id 1G7QDb-0007MF-Qi
	for git@vger.kernel.org; Mon, 31 Jul 2006 07:21:31 +0200
Received: from 193.0.122.19 ([193.0.122.19])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Mon, 31 Jul 2006 07:21:31 +0200
Received: from jnareb by 193.0.122.19 with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Mon, 31 Jul 2006 07:21:31 +0200
X-Injected-Via-Gmane: http://gmane.org/
To: git@vger.kernel.org
X-Complaints-To: usenet@sea.gmane.org
X-Gmane-NNTP-Posting-Host: 193.0.122.19
Mail-Copies-To: jnareb@gmail.com
User-Agent: KNode/0.10.2
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/24492>

Luben Tuikov wrote:

> --- Martin Waitz <tali@admingilde.org> wrote:
> 
>> Use the normal web server instead of the CGI to provide the git logo,
>> just like the gitweb.css.
> 
> NACK.  I'd really rather keep the logo (which is essential) in the
> file itself.  This would mean one less file to worry about.

I'm not sure. On the one hand this introduces yet another file which we have
to worry about, on the other it probably help performance. Any hard
numbers?

The difference with gitweb.css is that you edit gitweb.css, and that
inclused CSS can be cached; we could probably do the same trick like with
logo (i.e. embed it in gitweb.css, but still use 
  <link rel="stylesheet" type="text/css" href="$my_uri?a=gitweb.css"/>
and not
  <style type="text/css">
  ...
  </style>

Besides, mixed language files are hard to syntax highlight correctly...

-- 
Jakub Narebski
Warsaw, Poland
ShadeHawk on #git
