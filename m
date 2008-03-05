From: Jean-Luc Herren <jlh@gmx.ch>
Subject: Re: How to make gitk not overwrite my selection?
Date: Wed, 05 Mar 2008 23:44:10 +0100
Message-ID: <47CF223A.60507@gmx.ch>
References: <47CD6D1C.1080202@gmx.ch> <20080304230306.GA18246@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Cc: Paul Mackerras <paulus@samba.org>, git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Wed Mar 05 23:45:21 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JX2MN-0002zn-Vb
	for gcvg-git-2@gmane.org; Wed, 05 Mar 2008 23:45:16 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1764728AbYCEWoQ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 5 Mar 2008 17:44:16 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1764693AbYCEWoP
	(ORCPT <rfc822;git-outgoing>); Wed, 5 Mar 2008 17:44:15 -0500
Received: from mail.gmx.net ([213.165.64.20]:42854 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1764664AbYCEWoN (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 5 Mar 2008 17:44:13 -0500
Received: (qmail invoked by alias); 05 Mar 2008 22:44:11 -0000
Received: from 233-53.79-83.cust.bluewin.ch (EHLO [192.168.123.202]) [83.79.53.233]
  by mail.gmx.net (mp007) with SMTP; 05 Mar 2008 23:44:11 +0100
X-Authenticated: #14737133
X-Provags-ID: V01U2FsdGVkX19p+BZElq9pwPVNf8AExGakiVWwXeYZImGOw7EnCb
	zzPrAz54T/1fvd
User-Agent: Thunderbird 2.0.0.12 (X11/20080229)
In-Reply-To: <20080304230306.GA18246@sigill.intra.peff.net>
X-Enigmail-Version: 0.95.6
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/76282>

Jeff King wrote:
> On Tue, Mar 04, 2008 at 04:39:08PM +0100, Jean-Luc Herren wrote:
>> In gitk, whenever I select a commit in the tree, the SHA1 field
>> gets automatically selected, putting its hash into the current
>> selection for easy pasting into other applications. 

> The patch below seems to work for me (see the "auto-select sha1" option
> under preferences). However, I don't actually know tcl, so I
> cargo-culted all of the option processing magic. Paul, if you want to
> take this patch, please read it carefully. ;)

Thanks, I don't know tcl either, but the patch seems to work great
here.

jlh
