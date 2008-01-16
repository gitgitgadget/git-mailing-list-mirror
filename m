From: Mike <fromlists@talkingspider.com>
Subject: Re: I don't want the .git directory next to my code.
Date: Wed, 16 Jan 2008 12:31:07 -0500
Message-ID: <478E3F5B.5040000@talkingspider.com>
References: <478D79BD.7060006@talkingspider.com>	<86hcheig3n.fsf@blue.stonehenge.com>	<478D82FA.2030404@talkingspider.com> <BAYC1-PASMTP143D18D25EC9A59ABD42D7AE400@CEZ.ICE>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Sean <seanlkml@sympatico.ca>
X-From: git-owner@vger.kernel.org Wed Jan 16 18:32:03 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JFC7A-0003EL-5J
	for gcvg-git-2@gmane.org; Wed, 16 Jan 2008 18:31:48 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750991AbYAPRbL (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 16 Jan 2008 12:31:11 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750901AbYAPRbK
	(ORCPT <rfc822;git-outgoing>); Wed, 16 Jan 2008 12:31:10 -0500
Received: from relay00.pair.com ([209.68.5.9]:2380 "HELO relay00.pair.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1750702AbYAPRbJ (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 16 Jan 2008 12:31:09 -0500
Received: (qmail 5119 invoked from network); 16 Jan 2008 17:31:07 -0000
Received: from unknown (HELO ?192.168.1.100?) (unknown)
  by unknown with SMTP; 16 Jan 2008 17:31:07 -0000
X-pair-Authenticated: 72.225.213.70
User-Agent: Thunderbird 2.0.0.9 (Windows/20071031)
In-Reply-To: <BAYC1-PASMTP143D18D25EC9A59ABD42D7AE400@CEZ.ICE>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/70706>


Sean wrote:
> On Tue, 15 Jan 2008 23:07:22 -0500
> Mike <fromlists@talkingspider.com> wrote:
> 
> 
>>> git archive --help
>>>
>> I got:
>>
>> $ git archive --help
>> No manual entry for git-archive
>>
>> Did I install it wrong?  I have CentOS 5, and I did:
>>
>> su
>> yum install git
>>
> 
> Yes, on Centos you probably need "yum install git-core"  which installs all
> the assorted pieces and dependencies of Git.
> 

Thanks but didn't work-

# yum install git-core
Loading "installonlyn" plugin
Setting up Install Process
Setting up repositories
rpmforge                  100% |=========================| 1.1 kB    00:00
base                      100% |=========================| 1.1 kB    00:00
updates                   100% |=========================|  951 B    00:00
addons                    100% |=========================|  951 B    00:00
extras                    100% |=========================| 1.1 kB    00:00
Reading repository metadata in from local files
Parsing package install arguments
Nothing to do

Also if this helps, here's what I have for git:

$ rpm -qa | grep -i git
git-1.5.2.1-1.el5.rf
xorg-x11-drv-digitaledge-1.1.0-1.1
perl-Git-1.5.2.1-1.el5.rf
