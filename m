From: "J.H." <warthog9@kernel.org>
Subject: Re: [PATCH/RFC] gitweb: Create install target for gitweb in Makefile
Date: Tue, 11 May 2010 16:49:56 -0700
Message-ID: <4BE9ED24.1050400@kernel.org>
References: <20100429235046.29606.35311.stgit@localhost.localdomain> <7vbpcz4d95.fsf@alter.siamese.dyndns.org> <201005012236.16703.jnareb@gmail.com> <20100511234558.GP3563@machine.or.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: Jakub Narebski <jnareb@gmail.com>,
	Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: Petr Baudis <pasky@suse.cz>
X-From: git-owner@vger.kernel.org Wed May 12 02:45:16 2010
connect(): No such file or directory
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OC04Z-0007yb-Mo
	for gcvg-git-2@lo.gmane.org; Wed, 12 May 2010 02:45:16 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753642Ab0ELApI (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 11 May 2010 20:45:08 -0400
Received: from shards.monkeyblade.net ([198.137.202.13]:38656 "EHLO
	shards.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753308Ab0ELApH (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 11 May 2010 20:45:07 -0400
X-Greylist: delayed 3270 seconds by postgrey-1.27 at vger.kernel.org; Tue, 11 May 2010 20:45:06 EDT
Received: from voot-cruiser.eaglescrag.net (c-71-202-185-40.hsd1.ca.comcast.net [71.202.185.40])
	(authenticated bits=0)
	by shards.monkeyblade.net (8.14.3/8.14.3) with ESMTP id o4BNnujP017387
	(version=TLSv1/SSLv3 cipher=DHE-RSA-CAMELLIA256-SHA bits=256 verify=NO);
	Tue, 11 May 2010 16:49:56 -0700
X-Virus-Status: Clean
X-Virus-Scanned: clamav-milter 0.95.3 at shards.monkeyblade.net
User-Agent: Mozilla/5.0 (X11; U; Linux x86_64; en-US; rv:1.9.1.9) Gecko/20100330 Fedora/3.0.4-1.fc12 Lightning/1.0b2pre Thunderbird/3.0.4
In-Reply-To: <20100511234558.GP3563@machine.or.cz>
X-Enigmail-Version: 1.0.1
X-Greylist: Sender succeeded SMTP AUTH, not delayed by milter-greylist-4.2.3 (shards.monkeyblade.net [198.137.202.13]); Tue, 11 May 2010 16:49:56 -0700 (PDT)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/146914>

On 05/11/2010 04:45 PM, Petr Baudis wrote:
> On Sat, May 01, 2010 at 10:36:15PM +0200, Jakub Narebski wrote:
>> Subject: [PATCHv2] gitweb: Create install target for gitweb in Makefile
>>
>> Installing gitweb is now as easy as
>>
>>   # make gitwebdir=/var/www/cgi-bin gitweb-install  ;# as root
>>
>> The gitweb/INSTALL file was updated accordingly, to make use of this
>> new target.
>>
>> Fix shell quoting, i.e. setting bindir_SQ etc., in gitweb/Makefile.
>> Those variables were not used previously.
>>
>> Signed-off-by: Jakub Narebski <jnareb@gmail.com>
> 
> Acked-by: Petr Baudis <pasky@suse.cz>

Most installations I've seen install gitweb into /var/www/git[web] and
set it up to be CGI executable.  I'm not sure I've actually seen cgi-bin
used on most systems in quite a long time.

Just my $0.02

- John 'Warthog9' Hawley
