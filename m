From: Florian Achleitner <florian.achleitner2.6.31@gmail.com>
Subject: Re: [RFC 01/16] Implement a remote helper for svn in C.
Date: Thu, 26 Jul 2012 10:37:51 +0200
Message-ID: <4267185.trlLBoqjTn@flomedio>
References: <1343287957-22040-1-git-send-email-florian.achleitner.2.6.31@gmail.com> <1707449.hNcpMgVJxF@flomedio> <20120726081443.GA4720@burratino>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7Bit
Cc: Florian Achleitner <florian.achleitner.2.6.31@gmail.com>,
	David Michael Barr <davidbarr@google.com>,
	git@vger.kernel.org
To: Jonathan Nieder <jrnieder@gmail.com>
X-From: git-owner@vger.kernel.org Thu Jul 26 10:38:08 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SuJaC-0000R8-Ci
	for gcvg-git-2@plane.gmane.org; Thu, 26 Jul 2012 10:38:08 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751565Ab2GZIiA (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 26 Jul 2012 04:38:00 -0400
Received: from mailrelay.tu-graz.ac.at ([129.27.2.202]:7291 "EHLO
	mailrelay.tugraz.at" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751304Ab2GZIh7 (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 26 Jul 2012 04:37:59 -0400
Received: from flomedio.localnet (cm56-227-93.liwest.at [86.56.227.93])
	(authenticated bits=0)
	by mailrelay1.tugraz.at (8.14.4/8.14.4) with ESMTP id q6Q8bpNr018086
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
	Thu, 26 Jul 2012 10:37:51 +0200 (CEST)
User-Agent: KMail/4.8.4 (Linux/3.2.0-26-generic; KDE/4.8.4; x86_64; ; )
In-Reply-To: <20120726081443.GA4720@burratino>
X-TUG-Backscatter-control: qyH/vN2riZ/masrHmZoJqQ
X-Spam-Scanner: SpamAssassin 3.003000 
X-Spam-Score-relay: 0.6
X-Scanned-By: MIMEDefang 2.70 on 129.27.10.18
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/202251>

On Thursday 26 July 2012 03:14:43 Jonathan Nieder wrote:
> Florian Achleitner wrote:
> > Yes, I incorporated your review in the new version, as far as applicable.
> > But I didn't send you an answer on the detailed points.
> > I will send an answer to the previous review ..
> 
> Thanks.  Now that I check, I see that you did make lots of important
> changes and probably lost the one I noticed just now in the noise.
> 
> Another way to keep reviewers happy is to describe what changed since
> the last revision under the triple-dash for each patch when sending
> out a new set of patches.  That way, they can see that there was
> progress and there is less frustration when one specific change didn't
> make it.
> 
> See http://thread.gmane.org/gmane.comp.version-control.git/176203
> for example.

Yeah, that makes sense.
In this reroll, I really changed a lot, order and scope of patches is very 
different. Many haven't hit the list yet. I wanted to write a new more useful 
history.
The first patch, this one, consists of many enhancement commits I made after 
each other, finally integrated into one.
