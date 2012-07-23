From: Florian Achleitner <florian.achleitner2.6.31@gmail.com>
Subject: Re: GSOC remote-svn
Date: Mon, 23 Jul 2012 11:42:56 +0200
Message-ID: <1571752.59fsElNHEJ@flomedio>
References: <4514544.Xip1OCQ7Uj@flomedio>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7Bit
Cc: jrnieder@gmail.com, davidbarr@google.com, git@vger.kernel.org
To: Florian Achleitner <florian.achleitner.2.6.31@gmail.com>
X-From: git-owner@vger.kernel.org Mon Jul 23 12:28:46 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1StFsb-0006Ry-66
	for gcvg-git-2@plane.gmane.org; Mon, 23 Jul 2012 12:28:45 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751998Ab2GWK2i (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 23 Jul 2012 06:28:38 -0400
Received: from mailrelay.tu-graz.ac.at ([129.27.2.202]:38552 "EHLO
	mailrelay.tugraz.at" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751807Ab2GWK2h (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 23 Jul 2012 06:28:37 -0400
X-Greylist: delayed 2766 seconds by postgrey-1.27 at vger.kernel.org; Mon, 23 Jul 2012 06:28:37 EDT
Received: from flomedio.localnet (cm56-227-93.liwest.at [86.56.227.93])
	(authenticated bits=0)
	by mailrelay1.tugraz.at (8.14.4/8.14.4) with ESMTP id q6N9guX6002725
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
	Mon, 23 Jul 2012 11:42:56 +0200 (CEST)
User-Agent: KMail/4.8.4 (Linux/3.2.0-26-generic; KDE/4.8.4; x86_64; ; )
In-Reply-To: <4514544.Xip1OCQ7Uj@flomedio>
X-TUG-Backscatter-control: qyH/vN2riZ/masrHmZoJqQ
X-Spam-Scanner: SpamAssassin 3.003000 
X-Spam-Score-relay: 0.6
X-Scanned-By: MIMEDefang 2.70 on 129.27.10.18
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/201928>

On Sunday 22 July 2012 23:03:27 Florian Achleitner wrote:
> This got stuck on another problem:
> Incremental update of the note tree doesn't work. fast-import refuses to 
> update the notes tree: '<newsha1> doesn't contain <oldsha1>'.
> I don't yet know what's the reason for this.
> I'm digging into the internals of notes to find out why..
> (no problem with the file tree).

btw, this one was rather simple, just a syntax error in the fast-import 
stream..
