From: Florian Achleitner <florian.achleitner2.6.31@gmail.com>
Subject: Re: [PATCH] Add a svnrdump-simulator replaying a dump file for testing.
Date: Mon, 23 Jul 2012 15:16:50 +0200
Message-ID: <14140147.99YetxyXPJ@flomedio>
References: <4514544.Xip1OCQ7Uj@flomedio> <1448476.VR1Gla8Cvg@flomedio> <20120723125921.GA16768@burratino>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7Bit
Cc: Florian Achleitner <florian.achleitner.2.6.31@gmail.com>,
	davidbarr@google.com, git@vger.kernel.org
To: Jonathan Nieder <jrnieder@gmail.com>
X-From: git-owner@vger.kernel.org Mon Jul 23 15:17:08 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1StIVU-00076y-UO
	for gcvg-git-2@plane.gmane.org; Mon, 23 Jul 2012 15:17:05 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753185Ab2GWNQ6 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 23 Jul 2012 09:16:58 -0400
Received: from mailrelay.tu-graz.ac.at ([129.27.2.202]:49857 "EHLO
	mailrelay.tugraz.at" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753111Ab2GWNQ6 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 23 Jul 2012 09:16:58 -0400
Received: from flomedio.localnet (cm56-227-93.liwest.at [86.56.227.93])
	(authenticated bits=0)
	by mailrelay2.tugraz.at (8.14.4/8.14.4) with ESMTP id q6NDGpmX014584
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
	Mon, 23 Jul 2012 15:16:51 +0200 (CEST)
User-Agent: KMail/4.8.4 (Linux/3.2.0-26-generic; KDE/4.8.4; x86_64; ; )
In-Reply-To: <20120723125921.GA16768@burratino>
X-TUG-Backscatter-control: qyH/vN2riZ/masrHmZoJqQ
X-Spam-Scanner: SpamAssassin 3.003000 
X-Spam-Score-relay: 0.6
X-Scanned-By: MIMEDefang 2.70 on 129.27.10.19
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/201933>

On Monday 23 July 2012 07:59:21 Jonathan Nieder wrote:
> Florian Achleitner wrote:
> > To ease testing without depending on a reachable svn server, this
> > compact python script mimics parts of svnrdumps behaviour.
> 
> Thanks.  Mind if I forge your sign-off?

Ups. No problem, anyways I've added it locally, so here's the new version ..
