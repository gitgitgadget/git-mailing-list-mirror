From: Andrew Thompson <andrewkt@aktzero.com>
Subject: Re: Mercurial vs Updated git HOWTO for kernel hackers
Date: Tue, 28 Jun 2005 11:10:47 -0400
Message-ID: <42C16877.6000909@aktzero.com>
References: <42B9E536.60704@pobox.com>
	<20050623235634.GC14426@waste.org>	<20050624064101.GB14292@pasky.ji.cz>	<20050624123819.GD9519@64m.dyndns.org>
	<20050628150027.GB1275@pasky.ji.cz>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="------------020209000102070105000101"
Cc: Jeff Garzik <jgarzik@pobox.com>, mercurial@selenic.com,
        Git Mailing List <git@vger.kernel.org>,
        Linux Kernel <linux-kernel@vger.kernel.org>
X-From: mercurial-bounces@selenic.com Tue Jun 28 17:04:10 2005
Return-path: <mercurial-bounces@selenic.com>
Received: from waste.org ([216.27.176.166])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DnHd5-0007de-Jm
	for gcvmd-mercurial@gmane.org; Tue, 28 Jun 2005 17:04:04 +0200
Received: from waste.org (localhost [127.0.0.1])
	by waste.org (8.13.4/8.13.4/Debian-3) with ESMTP id j5SFAv5f025575;
	Tue, 28 Jun 2005 10:10:58 -0500
Received: from octopus.dnsvelocity.com (octopus.dnsvelocity.com [64.21.80.9])
	by waste.org (8.13.4/8.13.4/Debian-3) with ESMTP id j5SFAtfi025569
	(version=TLSv1/SSLv3 cipher=EDH-RSA-DES-CBC3-SHA bits=168 verify=NOT)
	for <mercurial@selenic.com>; Tue, 28 Jun 2005 10:10:56 -0500
Received: from nc-65-40-95-113.sta.sprint-hsd.net ([65.40.95.113]
	helo=[192.168.0.38])
	by octopus.dnsvelocity.com with esmtpa (Exim 4.50)
	id 1DnHjY-0001u5-95; Tue, 28 Jun 2005 15:10:44 +0000
User-Agent: Mozilla Thunderbird 1.0.2 (Windows/20050317)
X-Accept-Language: en-us, en
To: Petr Baudis <pasky@ucw.cz>
In-Reply-To: <20050628150027.GB1275@pasky.ji.cz>
X-AntiAbuse: This header was added to track abuse,
	please include it with any abuse report
X-AntiAbuse: Primary Hostname - octopus.dnsvelocity.com
X-AntiAbuse: Original Domain - selenic.com
X-AntiAbuse: Originator/Caller UID/GID - [0 0] / [47 12]
X-AntiAbuse: Sender Address Domain - aktzero.com
X-Source: 
X-Source-Args: 
X-Source-Dir: 
X-Virus-Scanned: by amavisd-new
X-BeenThere: mercurial@selenic.com
X-Mailman-Version: 2.1.5
Precedence: list
List-Id: mercurial.selenic.com
List-Unsubscribe: <http://selenic.com/mailman/listinfo/mercurial>,
	<mailto:mercurial-request@selenic.com?subject=unsubscribe>
List-Archive: <http://www.selenic.com/pipermail/mercurial>
List-Post: <mailto:mercurial@selenic.com>
List-Help: <mailto:mercurial-request@selenic.com?subject=help>
List-Subscribe: <http://selenic.com/mailman/listinfo/mercurial>,
	<mailto:mercurial-request@selenic.com?subject=subscribe>
Sender: mercurial-bounces@selenic.com
Errors-To: mercurial-bounces@selenic.com

This is a multi-part message in MIME format.
--------------020209000102070105000101
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit

Petr Baudis wrote:
>>Mercurial's undo is taking a snapshot of all the changed file's repo file length
>>at every commit or pull.  It just truncate the file to original size and undo 
>>is done.
> 
> "Trunactes"? That sounds very wrong... you mean replace with old
> version? Anyway, what if the file has same length? It just doesn't make
> much sense to me.

I believe this works because the files stored in a binary format that 
appends new changesets onto the end. Thus, truncating the new stuff from 
the end effectively removes the commit.

-- 
Andrew Thompson
http://aktzero.com/

--------------020209000102070105000101
Content-Type: text/x-vcard; charset=utf-8;
 name="andrewkt.vcf"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
 filename="andrewkt.vcf"

begin:vcard
fn:Andrew Thompson
n:Thompson;Andrew
email;internet:andrewkt@aktzero.com
x-mozilla-html:FALSE
url:http://aktzero.com/
version:2.1
end:vcard


--------------020209000102070105000101
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Mercurial mailing list
Mercurial@selenic.com
http://selenic.com/mailman/listinfo/mercurial

--------------020209000102070105000101--
