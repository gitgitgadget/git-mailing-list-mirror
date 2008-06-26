From: "Sam G." <ceptorial@comcast.net>
Subject: Re: Searching all git objects
Date: Thu, 26 Jun 2008 15:23:07 -0700
Message-ID: <4F53E903-38EF-464F-919D-42AD5A9F39B4@comcast.net>
References: <E99352BE-5C43-437E-A5E6-622BEEA03DFA@comcast.net> <20080625231742.GT11793@spearce.org> <905315640806251632m416a2406x301b857ec7faf09d@mail.gmail.com> <321F18C8-351F-4E91-9F00-CFE2711B67D1@comcast.net> <7v7icdvwml.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0 (Apple Message framework v919.2)
Content-Type: text/plain; charset=US-ASCII; format=flowed; delsp=yes
Content-Transfer-Encoding: 7bit
Cc: Tarmigan <tarmigan+git@gmail.com>,
	"Paul Mackerras" <paulus@samba.org>,
	"Shawn O. Pearce" <spearce@spearce.org>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri Jun 27 00:24:51 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KBztM-0007n1-9q
	for gcvg-git-2@gmane.org; Fri, 27 Jun 2008 00:24:36 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751756AbYFZWXM (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 26 Jun 2008 18:23:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752320AbYFZWXM
	(ORCPT <rfc822;git-outgoing>); Thu, 26 Jun 2008 18:23:12 -0400
Received: from mail.box.net ([67.15.218.250]:55131 "EHLO mail.box.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751519AbYFZWXM (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 26 Jun 2008 18:23:12 -0400
Received: (qmail 20686 invoked from network); 26 Jun 2008 17:21:40 -0500
Received: from c-24-130-19-112.hsd1.ca.comcast.net (HELO ?192.168.1.199?) (24.130.19.112)
  by mail.box.net with (AES128-SHA encrypted) SMTP; 26 Jun 2008 17:21:40 -0500
In-Reply-To: <7v7icdvwml.fsf@gitster.siamese.dyndns.org>
X-Mailer: Apple Mail (2.919.2)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/86493>

git-lost-found actually did it... she had git-stashed it a number of  
times throughout development, so through some grepping of the lost- 
found objects, we were able to find a very close version. What a  
relief! Thanks to everyone for your help!

-Sam


On Jun 25, 2008, at 6:00 PM, Junio C Hamano wrote:

> "Sam G." <ceptorial@comcast.net> writes:
>
>> And, just in case, is there any way to
>> search raw objects for text, either commit text, file name or  
>> content?
>> Thanks very much!
>
> Or run "git lost-found" and grep for blobs in .git/lost-found/other/*
