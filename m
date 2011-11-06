From: Jonathan Fine <jfine@pytex.org>
Subject: A Python script to put CTAN into git (from DVDs)
Date: Sun, 06 Nov 2011 15:17:54 +0000
Message-ID: <4EB6A522.3020909@pytex.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: python-list@python.org
X-From: python-list-bounces+python-python-list=m.gmane.org@python.org Sun Nov 06 16:27:00 2011
Return-path: <python-list-bounces+python-python-list=m.gmane.org@python.org>
Envelope-to: python-python-list@m.gmane.org
Received: from mail.python.org ([82.94.164.166])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <python-list-bounces+python-python-list=m.gmane.org@python.org>)
	id 1RN4ce-000754-09
	for python-python-list@m.gmane.org; Sun, 06 Nov 2011 16:27:00 +0100
Received: from albatross.python.org (localhost [127.0.0.1])
	by mail.python.org (Postfix) with ESMTP id 3Sc13R5kwYzMnJ
	for <python-python-list@m.gmane.org>; Sun,  6 Nov 2011 16:26:59 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=python.org; s=200901;
	t=1320593219; bh=LaFLEMN6NJKC/JwL0taUovlJVFB38QhWeTLNXo7X1Lc=;
	h=Message-ID:Date:From:MIME-Version:Subject:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 Content-Transfer-Encoding:Content-Type:Sender;
	b=JOk2wR5VisSZDDRIIREvf4aUgt05uadp7D2OKGf5KY7/ZBaYPq/Ad50xU2h0XFInv
	 osNK2nFTZgzkHndDJB3wt0Cfm61nhl4SFZj5cs25n2GGuq/4ZvcgtRGV+LzD7ZaJ49
	 0qFnT3NXp+sP0MGcSYMq9Whb462dD7rtp+WDNw90=
Path: news.xs4all.nl!newsspool.news.xs4all.nl!newsfeed.xs4all.nl!newsfeed5.news.xs4all.nl!xs4all!news-transit.tcx.org.uk!de-l.enfer-du-nord.net!feeder2.enfer-du-nord.net!border1.nntp.ams2.giganews.com!border3.nntp.ams.giganews.com!Xl.tags.giganews.com!border1.nntp.ams.giganews.com!nntp.giganews.com!local2.nntp.ams.giganews.com!nntp.brightview.co.uk!news.brightview.co.uk.POSTED!not-for-mail
NNTP-Posting-Date: Sun, 06 Nov 2011 09:20:12 -0600
User-Agent: Mozilla/5.0 (X11; U; Linux x86_64; en-US;
	rv:1.9.2.23) Gecko/20110921 Thunderbird/3.1.15
Newsgroups: comp.text.tex,comp.lang.python
Followup-To: comp.text.tex
X-Usenet-Provider: http://www.giganews.com
X-Trace: sv3-P4cDYBBA36OZwBIrdWnpLtlthFgQAomwFdTYQON8NpJvAAXDAyq1Qeaugxiu4IAQ3dadlGgIn4PveDM!55EbHW5fdQZoPJH/8navV6FQ6CAVRpFrQV1swlnZDK7lqxfrqpYYPHdvidy0m2x387oMv4E=
X-Abuse-and-DMCA-Info: Please be sure to forward a copy of ALL headers
X-Abuse-and-DMCA-Info: Otherwise we will be unable to process your complaint
	properly
X-Postfilter: 1.3.40
X-Original-Bytes: 2379
Xref: news.xs4all.nl comp.text.tex:407259 comp.lang.python:670309
X-BeenThere: python-list@python.org
X-Mailman-Version: 2.1.12
Precedence: list
List-Id: General discussion list for the Python programming language
	<python-list.python.org>
List-Unsubscribe: <http://mail.python.org/mailman/options/python-list>,
	<mailto:python-list-request@python.org?subject=unsubscribe>
List-Archive: <http://mail.python.org/pipermail/python-list>
List-Post: <mailto:python-list@python.org>
List-Help: <mailto:python-list-request@python.org?subject=help>
List-Subscribe: <http://mail.python.org/mailman/listinfo/python-list>,
	<mailto:python-list-request@python.org?subject=subscribe>
Sender: python-list-bounces+python-python-list=m.gmane.org@python.org
Errors-To: python-list-bounces+python-python-list=m.gmane.org@python.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/184916>

Hi

This it to let you know that I'm writing (in Python) a script that 
places the content of CTAN into a git repository.
     https://bitbucket.org/jfine/python-ctantools

I'm working from the TeX Collection DVDs that are published each year by 
the TeX user groups, which contain a snapshot of CTAN (about 100,000 
files occupying 4Gb), which means I have to unzip folders and do a few 
other things.

CTAN is the Comprehensive TeX Archive Network.  CTAN keeps only the 
latest version of each file, but old CTAN snapshots will provide many 
earlier versions.

I'm working on putting old CTAN files into modern version control. 
Martin Scharrer is working in the other direction.  He's putting new 
files added to CTAN into Mercurial.
     http://ctanhg.scharrer-online.de/

My script works already as a proof of concept, but needs more work (and 
documentation) before it becomes useful.  I've requested that follow up 
goes to comp.text.tex.

Longer terms goals are git as
* http://en.wikipedia.org/wiki/Content-addressable_storage
* a resource editing and linking system

If you didn't know, a git tree is much like an immutable JSON object, 
except that it does not have arrays or numbers.

If my project interests you, reply to this message or contact me 
directly (or both).

-- 
Jonathan
