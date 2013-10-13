From: =?ISO-8859-1?Q?Torsten_B=F6gershausen?= <tboegi@web.de>
Subject: Re: Git send-email fail on Mac OS X Lion
Date: Sun, 13 Oct 2013 10:32:40 +0200
Message-ID: <525A5AA8.5050909@web.de>
References: <04374E86-02D8-4E76-A7F5-7DEE34F25C7F@gmail.com> <20131012134711.GG79408@vauxhall.crustytoothpaste.net> <194068D5-0134-48CA-89E0-484CD296BD83@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: "git@vger.kernel.org" <git@vger.kernel.org>
To: Gmail <eratos2000@gmail.com>,
	"brian m. carlson" <sandals@crustytoothpaste.net>
X-From: git-owner@vger.kernel.org Sun Oct 13 10:33:55 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VVH7a-0007Ks-Lr
	for gcvg-git-2@plane.gmane.org; Sun, 13 Oct 2013 10:33:55 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753808Ab3JMIde (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 13 Oct 2013 04:33:34 -0400
Received: from mout.web.de ([212.227.15.3]:54236 "EHLO mout.web.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753566Ab3JMIdc (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 13 Oct 2013 04:33:32 -0400
Received: from [192.168.209.26] ([217.208.218.204]) by smtp.web.de (mrweb004)
 with ESMTPA (Nemesis) id 0MBH5Z-1VfUOl018n-00AFe8 for <git@vger.kernel.org>;
 Sun, 13 Oct 2013 10:33:30 +0200
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.6; rv:24.0) Gecko/20100101 Thunderbird/24.0.1
In-Reply-To: <194068D5-0134-48CA-89E0-484CD296BD83@gmail.com>
X-Provags-ID: V03:K0:hdBhxC67KNJxW1WMfFun8ZD9DyPrXtYx2hI1S4r87SrjO8PCAob
 EfMv1YftQ1zrSTrS6hS6e2Yz13SyfceubbMmhevcUJVXByMaoOCoSnn3N45KZxuWo6wlwq7
 DgzUrrCa72TkKJH8Er48GFcRrw1phqPUScDe9MpSp/bPGBu3t6kh1qGI2kc1N97MvjOWtWR
 cBNQrBIoWmPcBieIhIrKw==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/236066>

(Please, not top-posting)

>> On Oct 12, 2013, at 8:47 AM, "brian m. carlson" <sandals@crustytoothpaste.net> wrote:
>>
>>> On Fri, Oct 11, 2013 at 11:06:17PM -0500, Fernando Ortiz (e2k) wrote:
>>> I'm getting the following error when I do:
>>>
>>> git send-email --compose --from Fernando Ortiz <eratos2000@gmail.com> --to fortiz2k@gmail.com --cc fortiz2k@gmail.com 0001-Change-zcat-to-gzcat-to-fix-build-restore-steps.patch
>>>
>>> Net::SSLeay version 1.46 required--this is only version 1.36 at /Users/fortiz/perl5/perlbrew/perls/perl-5.14.4/lib/site_perl/5.14.4/IO/Socket/SSL.pm line 17.
>>
>> Here's your answer: Net::SSLeay is too old for IO::Socket::SSL.  You
>> either need to use cpan or cpanm to install a newer Net::SSLeay, and
>> then it will work.

On 2013-10-12 19.40, Gmail wrote:> Brian,
> 
> I already tried to reinstall with cpan/m using -f -i options.  I even removed the PERL5LIB location and reinstalled the packages from scratch to no avail.
> 
> Nando
> 
> Sent from my iPhone
> 
This may be a stupid question:
Which perl is in your $PATH ?
What do you get entering
type perl
on the command line ?
/Torsten
