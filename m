From: Julian Phillips <julian@quantumfyre.co.uk>
Subject: Re: adding file by absolute name -- problem
Date: Mon, 23 Apr 2007 12:02:48 +0100 (BST)
Message-ID: <Pine.LNX.4.64.0704231156230.3653@reaper.quantumfyre.co.uk>
References: <f36b08ee0704230239i4892983q4feb4a1872a320ea@mail.gmail.com>
 <Pine.LNX.4.64.0704231215370.8822@racer.site>
 <f36b08ee0704230330if89d417udefb8e50062d5a05@mail.gmail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII; format=flowed
Cc: Git Mailing List <git@vger.kernel.org>
To: Yakov Lerner <iler.ml@gmail.com>
X-From: git-owner@vger.kernel.org Mon Apr 23 13:03:10 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HfwK2-00054V-9J
	for gcvg-git@gmane.org; Mon, 23 Apr 2007 13:03:06 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161358AbXDWLCv (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 23 Apr 2007 07:02:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161369AbXDWLCv
	(ORCPT <rfc822;git-outgoing>); Mon, 23 Apr 2007 07:02:51 -0400
Received: from electron.quantumfyre.co.uk ([87.106.55.16]:43328 "EHLO
	electron.quantumfyre.co.uk" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1161358AbXDWLCu (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 23 Apr 2007 07:02:50 -0400
Received: from neutron.quantumfyre.co.uk (neutron.datavampyre.co.uk [212.159.54.235])
	by electron.quantumfyre.co.uk (Postfix) with ESMTP id 23E6DC6132
	for <git@vger.kernel.org>; Mon, 23 Apr 2007 12:02:49 +0100 (BST)
Received: (qmail 5775 invoked by uid 103); 23 Apr 2007 12:01:53 +0100
Received: from 192.168.0.2 by neutron.quantumfyre.co.uk (envelope-from <julian@quantumfyre.co.uk>, uid 201) with qmail-scanner-1.25st 
 (clamdscan: 0.90.2/3147. spamassassin: 3.1.8. perlscan: 1.25st.  
 Clear:RC:1(192.168.0.2):. 
 Processed in 0.040508 secs); 23 Apr 2007 11:01:53 -0000
Received: from reaper.quantumfyre.co.uk (192.168.0.2)
  by neutron.datavampyre.co.uk with SMTP; 23 Apr 2007 12:01:53 +0100
X-X-Sender: jp3@reaper.quantumfyre.co.uk
In-Reply-To: <f36b08ee0704230330if89d417udefb8e50062d5a05@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/45316>

On Mon, 23 Apr 2007, Yakov Lerner wrote:

> On 4/23/07, Johannes Schindelin <Johannes.Schindelin@gmx.de> wrote:
>>  Hi,
>>
>>  On Mon, 23 Apr 2007, Yakov Lerner wrote:
>> 
>> >  When I give absolute pathname /a/b/repo/d to git add, it
>> >  mostly does not work. I get errors from git-add. Is it by design ?
>>
>>  AFAICT it is by design. I fail to see why absolute paths should be
>>  supported, too. You are supposed to be _in_ the working directory when
>>  adding files...
>
> Let's say I have $SRC that points to the dir of sources. Let's say
> I am testing the software, somewhere under /tmp. I edit sources as
> 'vi $SRC/something' and I am not in $SRC. I could do 'make -C $SRC' and
> I can do everything (incl checkins) without switching cwd back and
> forth all the time.

git () { cd $SRC; ~/bin/git "$@"; } ?

-- 
Julian

  ---
Man and wife make one fool.
