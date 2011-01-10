From: Thomas Rast <trast@student.ethz.ch>
Subject: Re: [PATCH] submodule: fix relative url parsing for scp-style origin
Date: Mon, 10 Jan 2011 19:18:22 +0100
Message-ID: <201101101918.22955.trast@student.ethz.ch>
References: <7a578ef3384a891cebd4a39421302983499771e0.1294655635.git.trast@student.ethz.ch> <201101101805.13251.trast@student.ethz.ch> <20110110172227.GA7882@burratino>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Cc: <git@vger.kernel.org>, Junio C Hamano <gitster@pobox.com>,
	Mark Levedahl <mlevedahl@gmail.com>,
	Jeffrey Phillips Freeman <jeffrey.freeman@syncleus.com>
To: Jonathan Nieder <jrnieder@gmail.com>
X-From: git-owner@vger.kernel.org Mon Jan 10 19:18:31 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PcMK6-0002sa-Dc
	for gcvg-git-2@lo.gmane.org; Mon, 10 Jan 2011 19:18:30 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753821Ab1AJSSZ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 10 Jan 2011 13:18:25 -0500
Received: from edge10.ethz.ch ([82.130.75.186]:37074 "EHLO edge10.ethz.ch"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751220Ab1AJSSY (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 10 Jan 2011 13:18:24 -0500
Received: from CAS11.d.ethz.ch (172.31.38.211) by edge10.ethz.ch
 (82.130.75.186) with Microsoft SMTP Server (TLS) id 14.1.218.12; Mon, 10 Jan
 2011 19:18:22 +0100
Received: from pctrast.inf.ethz.ch (129.132.153.233) by CAS11.d.ethz.ch
 (172.31.38.211) with Microsoft SMTP Server (TLS) id 14.1.218.12; Mon, 10 Jan
 2011 19:18:22 +0100
User-Agent: KMail/1.13.5 (Linux/2.6.37-rc8-desktop; KDE/4.5.4; x86_64; ; )
In-Reply-To: <20110110172227.GA7882@burratino>
X-Originating-IP: [129.132.153.233]
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/164891>

Jonathan Nieder wrote:
> 
> manually using a relative path as in
> 
> 	git remote add origin subdir
> 
> creates a remote that is not usable, perhaps because different parts
> of the code treat it as relative to different directories (.git or the
> toplevel).

Oh, now I see.  I just assumed this was not supported without looking,
so thanks for double-checking.

-- 
Thomas Rast
trast@{inf,student}.ethz.ch
