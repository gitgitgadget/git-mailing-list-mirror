From: Florian Achleitner <florian.achleitner2.6.31@gmail.com>
Subject: Re: GSOC Proposal draft: git-remote-svn
Date: Wed, 11 Apr 2012 21:09 +0200
Message-ID: <1533147.bdVc1SQHSj@flomedio>
References: <11292500.AVmZFUUvNi@flobuntu> <20120410171707.GA3869@burratino> <4F84B47D.1080301@pileofstuff.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7Bit
Cc: Jonathan Nieder <jrnieder@gmail.com>,
	Git Mailing List <git@vger.kernel.org>,
	Ramkumar Ramachandra <artagnon@gmail.com>,
	David Barr <davidbarr@google.com>,
	Sverre Rabbelier <srabbelier@gmail.com>,
	Dmitry Ivankov <divanorama@gmail.com>
To: Andrew Sayers <andrew-git@pileofstuff.org>
X-From: git-owner@vger.kernel.org Wed Apr 11 21:22:16 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SI37Q-0006JW-3u
	for gcvg-git-2@plane.gmane.org; Wed, 11 Apr 2012 21:22:16 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932980Ab2DKTWG (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 11 Apr 2012 15:22:06 -0400
Received: from mailrelay.tu-graz.ac.at ([129.27.2.202]:24621 "EHLO
	mailrelay.tugraz.at" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756893Ab2DKTWF (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 11 Apr 2012 15:22:05 -0400
Received: from flomedio.localnet (91-115-90-225.adsl.highway.telekom.at [91.115.90.225])
	(authenticated bits=0)
	by mailrelay1.tugraz.at (8.14.4/8.14.4) with ESMTP id q3BJJGhh025635
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
	Wed, 11 Apr 2012 21:19:16 +0200 (CEST)
User-Agent: KMail/4.7.3 (Linux/3.0.0-17-generic; KDE/4.7.4; x86_64; ; )
In-Reply-To: <4F84B47D.1080301@pileofstuff.org>
X-TUG-Backscatter-control: qyH/vN2riZ/masrHmZoJqQ
X-Spam-Scanner: SpamAssassin 3.003000 
X-Spam-Score-relay: 0.6
X-Scanned-By: MIMEDefang 2.70 on 129.27.10.18
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/195242>

On Tuesday 10 April 2012 23:30:21 you wrote:
> On 10/04/12 18:17, Jonathan Nieder wrote:
> <snip>
> 
> > Given the goal described here of an import with support for
> > automatically detecting branches, here are some rough steps I imagine
> 
> > would be involved:
> Just to be clear, my understanding is that this project will take SBL
> created by another program (that I'm writing) and create branches as
> specified.  This frees Florian from having to deal with the maze of edge
> cases involved in that part of the problem.

Furthermore the remote-helper has no way of asking the user something, right?
So it can only fail if something is ambigous in the svn repository layout. So 
I thought the SBL is exactly to describe these cases, and that's what I need.

> [..]
