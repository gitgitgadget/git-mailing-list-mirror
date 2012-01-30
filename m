From: Thomas Rast <trast@inf.ethz.ch>
Subject: Re: [PATCH 3/3] completion: remove unused code
Date: Mon, 30 Jan 2012 08:44:35 +0100
Message-ID: <871uqh3a8s.fsf@thomas.inf.ethz.ch>
References: <1327880479-25275-1-git-send-email-felipe.contreras@gmail.com>
	<1327880479-25275-4-git-send-email-felipe.contreras@gmail.com>
	<20120130025014.GA15944@burratino>
	<CAMP44s1bZeednbHfqXANZR5zVVvGwjRpuV5TFmnh212FD7E-Vg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Cc: Jonathan Nieder <jrnieder@gmail.com>, <git@vger.kernel.org>
To: Felipe Contreras <felipe.contreras@gmail.com>
X-From: git-owner@vger.kernel.org Mon Jan 30 08:44:45 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Rrluv-0002Q5-0B
	for gcvg-git-2@plane.gmane.org; Mon, 30 Jan 2012 08:44:45 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752781Ab2A3Hok (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 30 Jan 2012 02:44:40 -0500
Received: from edge10.ethz.ch ([82.130.75.186]:6383 "EHLO edge10.ethz.ch"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752698Ab2A3Hoj (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 30 Jan 2012 02:44:39 -0500
Received: from CAS11.d.ethz.ch (172.31.38.211) by edge10.ethz.ch
 (82.130.75.186) with Microsoft SMTP Server (TLS) id 14.1.355.2; Mon, 30 Jan
 2012 08:44:35 +0100
Received: from thomas.inf.ethz.ch.ethz.ch (129.132.153.233) by CAS11.d.ethz.ch
 (172.31.38.211) with Microsoft SMTP Server (TLS) id 14.1.355.2; Mon, 30 Jan
 2012 08:44:36 +0100
In-Reply-To: <CAMP44s1bZeednbHfqXANZR5zVVvGwjRpuV5TFmnh212FD7E-Vg@mail.gmail.com>
	(Felipe Contreras's message of "Mon, 30 Jan 2012 05:30:49 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.3 (gnu/linux)
X-Originating-IP: [129.132.153.233]
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/189326>

Felipe Contreras <felipe.contreras@gmail.com> writes:

> No reason. I hope they read the mailing list, otherwise I'll resend
> and CC them. A get_maintainers script, or something like that would
> make things easier.

I simply use

  git shortlog -sn --no-merges v1.7.0.. -- contrib/completion/

(In many parts the revision limiter can be omitted without losing much,
but e.g. here this drops Shawn who hasn't worked on it since 2009.)

-- 
Thomas Rast
trast@{inf,student}.ethz.ch
