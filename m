From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: That improved git-gui blame viewer..
Date: Wed, 13 Jun 2007 13:45:49 +0100 (BST)
Message-ID: <Pine.LNX.4.64.0706131344430.4059@racer.site>
References: <alpine.LFD.0.98.0706091117510.20321@woody.linux-foundation.org>
  <20070611064203.GG6073@spearce.org>  <alpine.LFD.0.98.0706110826590.14121@woody.linux-foundation.org>
  <7vveduqxxr.fsf@assigned-by-dhcp.pobox.com> 
 <e5bfff550706112316j42c7c8e8uf8383de990ca9707@mail.gmail.com> 
 <7vbqflll55.fsf@assigned-by-dhcp.pobox.com> 
 <e5bfff550706120427g7ad9d38bpc34d9ea284ace693@mail.gmail.com> 
 <20070612135303.GT6073@spearce.org>  <7v645thto7.fsf@assigned-by-dhcp.pobox.com>
  <e5bfff550706130411g151b76e3sa2e351aff5dbb35b@mail.gmail.com>
 <e5bfff550706130544m40e2f210p2412ef7fde2867a1@mail.gmail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Junio C Hamano <gitster@pobox.com>,
	"Shawn O. Pearce" <spearce@spearce.org>,
	Linus Torvalds <torvalds@linux-foundation.org>,
	Git Mailing List <git@vger.kernel.org>
To: Marco Costalba <mcostalba@gmail.com>
X-From: git-owner@vger.kernel.org Wed Jun 13 14:49:14 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HySHi-000729-Aa
	for gcvg-git@gmane.org; Wed, 13 Jun 2007 14:49:14 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757442AbXFMMtM (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 13 Jun 2007 08:49:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1757546AbXFMMtM
	(ORCPT <rfc822;git-outgoing>); Wed, 13 Jun 2007 08:49:12 -0400
Received: from mail.gmx.net ([213.165.64.20]:59594 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1757027AbXFMMtL (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 13 Jun 2007 08:49:11 -0400
Received: (qmail invoked by alias); 13 Jun 2007 12:49:10 -0000
Received: from unknown (EHLO [138.251.11.74]) [138.251.11.74]
  by mail.gmx.net (mp018) with SMTP; 13 Jun 2007 14:49:10 +0200
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX18G7oF23W4Gzg5UeF5WjkAzWZ6/CErtMKG91+kOMn
	/VJ/LVSgaggkjZ
X-X-Sender: gene099@racer.site
In-Reply-To: <e5bfff550706130544m40e2f210p2412ef7fde2867a1@mail.gmail.com>
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/50055>

Hi,

On Wed, 13 Jun 2007, Marco Costalba wrote:

> I've made some tests on a git tree copied under Windows:
> 
> running:  git rev-list --header --parents --boundary HEAD > tmp.txt
> 
> [...]
> 
> then running: git log --pretty=raw -z --parents --boundary HEAD > tmp.txt

Isn't that a bit unfair? You should have passed "--pretty=raw" to 
rev-list, too.

Since you already have that tree, could you try rev-list _with_ 
"--pretty=raw", just for comparison?

Thanks,
Dscho
