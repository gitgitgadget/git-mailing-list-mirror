From: Andreas Ericsson <ae@op5.se>
Subject: Re: VCS comparison table
Date: Tue, 17 Oct 2006 11:59:57 +0200
Message-ID: <4534A99D.4060208@op5.se>
References: <9e4733910610140807p633f5660q49dd2d2111c9f5fe@mail.gmail.com>
	<200610170119.09066.jnareb@gmail.com>
	<45346290.6050300@utoronto.ca>
	<200610171120.09747.jnareb@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15; format=flowed
Content-Transfer-Encoding: 7bit
Cc: bazaar-ng@lists.canonical.com, git@vger.kernel.org
X-From: bazaar-ng-bounces@lists.canonical.com Tue Oct 17 12:00:24 2006
Return-path: <bazaar-ng-bounces@lists.canonical.com>
Envelope-to: gcvbg-bazaar-ng@m.gmane.org
Received: from esperanza.ubuntu.com ([82.211.81.173])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1GZlkB-0003NG-J5
	for gcvbg-bazaar-ng@m.gmane.org; Tue, 17 Oct 2006 12:00:19 +0200
Received: from localhost ([127.0.0.1] helo=esperanza.ubuntu.com)
	by esperanza.ubuntu.com with esmtp (Exim 4.60)
	(envelope-from <bazaar-ng-bounces@lists.canonical.com>)
	id 1GZljv-0000q0-Pm; Tue, 17 Oct 2006 11:00:03 +0100
Received: from linux-server1.op5.se ([193.201.96.2] helo=smtp-gw1.op5.se)
	by esperanza.ubuntu.com with esmtp (Exim 4.60)
	(envelope-from <ae@op5.se>) id 1GZljs-0000pv-Tn
	for bazaar-ng@lists.canonical.com; Tue, 17 Oct 2006 11:00:01 +0100
Received: by smtp-gw1.op5.se (Postfix, from userid 588)
	id 7AA7C6BDAA; Tue, 17 Oct 2006 12:00:00 +0200 (CEST)
X-Spam-Checker-Version: SpamAssassin 3.1.4 (2006-07-25) on 
	linux-server1.op5.se
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=5.0 tests=AWL,BAYES_00 autolearn=ham 
	version=3.1.4
Received: from [192.168.1.20] (unknown [213.88.215.14])
	by smtp-gw1.op5.se (Postfix) with ESMTP
	id 8396B6BD2A; Tue, 17 Oct 2006 11:59:57 +0200 (CEST)
User-Agent: Thunderbird 1.5.0.7 (X11/20060913)
To: Jakub Narebski <jnareb@gmail.com>
In-Reply-To: <200610171120.09747.jnareb@gmail.com>
X-BeenThere: bazaar-ng@lists.canonical.com
X-Mailman-Version: 2.1.8
Precedence: list
List-Id: bazaar-ng discussion <bazaar-ng.lists.canonical.com>
List-Unsubscribe: <https://lists.ubuntu.com/mailman/listinfo/bazaar-ng>,
	<mailto:bazaar-ng-request@lists.canonical.com?subject=unsubscribe>
List-Archive: <https://lists.ubuntu.com/archives/bazaar-ng>
List-Post: <mailto:bazaar-ng@lists.canonical.com>
List-Help: <mailto:bazaar-ng-request@lists.canonical.com?subject=help>
List-Subscribe: <https://lists.ubuntu.com/mailman/listinfo/bazaar-ng>,
	<mailto:bazaar-ng-request@lists.canonical.com?subject=subscribe>
Sender: bazaar-ng-bounces@lists.canonical.com
Errors-To: bazaar-ng-bounces@lists.canonical.com
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/29045>

Jakub Narebski wrote:
> 
> About new command detection: if you put program named git-<command>
> in directory with the rest of git commands, then you can call it
> as "git <command>" using git wrapper. I think.
> 

Yup. The new command will also automagically appear in the "git help -a" 
output. Those two functions have been available since the C wrapper was 
born, although "git help -a" was the only available output for "command 
not found" until someone introduced the more newbie-friendly list that 
pops up now adays.
