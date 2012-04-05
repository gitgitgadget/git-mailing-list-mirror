From: Florian Achleitner <florian.achleitner2.6.31@gmail.com>
Subject: Re: GSOC Proposal draft: git-remote-svn
Date: Thu, 05 Apr 2012 15:36:40 +0200
Message-ID: <1421035.yALBSXSHGd@flomedio>
References: <11292500.AVmZFUUvNi@flobuntu> <2148933.pnpYo0xMAP@flomedio> <2487557.B8qfnaixh3@flomedio>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7Bit
Cc: Ramkumar Ramachandra <artagnon@gmail.com>,
	David Barr <davidbarr@google.com>,
	Andrew Sayers <andrew-git@pileofstuff.org>,
	Jonathan Nieder <jrnieder@gmail.com>,
	Sverre Rabbelier <srabbelier@gmail.com>,
	Dmitry Ivankov <divanorama@gmail.com>
To: Git Mailing List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Thu Apr 05 15:37:57 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SFmsn-0002zs-3L
	for gcvg-git-2@plane.gmane.org; Thu, 05 Apr 2012 15:37:49 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752561Ab2DENhF (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 5 Apr 2012 09:37:05 -0400
Received: from mailrelay.tu-graz.ac.at ([129.27.2.202]:53371 "EHLO
	mailrelay.tugraz.at" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751887Ab2DENhE (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 5 Apr 2012 09:37:04 -0400
Received: from flomedio.localnet (93-82-150-223.adsl.highway.telekom.at [93.82.150.223])
	(authenticated bits=0)
	by mailrelay1.tugraz.at (8.14.4/8.14.4) with ESMTP id q35Daelx018219
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
	Thu, 5 Apr 2012 15:36:41 +0200 (CEST)
User-Agent: KMail/4.7.3 (Linux/3.0.0-17-generic; KDE/4.7.4; x86_64; ; )
In-Reply-To: <2487557.B8qfnaixh3@flomedio>
X-TUG-Backscatter-control: qyH/vN2riZ/masrHmZoJqQ
X-Spam-Scanner: SpamAssassin 3.003000 
X-Spam-Score-relay: 0.6
X-Scanned-By: MIMEDefang 2.70 on 129.27.10.18
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/194773>

Hi everybody!

Thanks for your inputs. I've now submitted a slightly updated version of my 
proposal to google. Additionally it's on github [1].

Summary of diffs:
I'll concentrate on the fetching from svn, writing a remote helper without 
branch detection (like svn-fe) first, and then creating the branch mapper.

[1] https://github.com/flyingflo/git/wiki/

-- Florian

On Monday 02 April 2012 10:30:58 Florian Achleitner wrote:

> 
> ==Remote helper for Subversion==
> 
