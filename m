From: Julian Phillips <julian@quantumfyre.co.uk>
Subject: Re: [PATCH 3/3] Teach "git branch" about --new-workdir
Date: Mon, 23 Jul 2007 09:31:36 +0100 (BST)
Message-ID: <Pine.LNX.4.64.0707230930140.20832@reaper.quantumfyre.co.uk>
References: <Pine.LNX.4.64.0707221956210.14781@racer.site>
 <Pine.LNX.4.64.0707222205050.23426@reaper.quantumfyre.co.uk>
 <Pine.LNX.4.64.0707222223460.14781@racer.site>
 <Pine.LNX.4.64.0707222234020.5382@reaper.quantumfyre.co.uk>
 <Pine.LNX.4.64.0707222255010.14781@racer.site>
 <Pine.LNX.4.64.0707222302170.19212@reaper.quantumfyre.co.uk>
 <Pine.LNX.4.64.0707230000020.14781@racer.site>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII; format=flowed
Cc: git@vger.kernel.org, gitster@pobox.com
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Mon Jul 23 10:32:19 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1ICtL1-0002iZ-98
	for gcvg-git@gmane.org; Mon, 23 Jul 2007 10:32:19 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754429AbXGWIbn (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 23 Jul 2007 04:31:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755490AbXGWIbm
	(ORCPT <rfc822;git-outgoing>); Mon, 23 Jul 2007 04:31:42 -0400
Received: from electron.quantumfyre.co.uk ([87.106.55.16]:60618 "EHLO
	electron.quantumfyre.co.uk" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1755655AbXGWIbl (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 23 Jul 2007 04:31:41 -0400
Received: from neutron.quantumfyre.co.uk (neutron.datavampyre.co.uk [212.159.54.235])
	by electron.quantumfyre.co.uk (Postfix) with ESMTP id 74D89C6094
	for <git@vger.kernel.org>; Mon, 23 Jul 2007 09:31:39 +0100 (BST)
Received: (qmail 13386 invoked by uid 103); 23 Jul 2007 09:31:36 +0100
Received: from 192.168.0.2 by neutron.quantumfyre.co.uk (envelope-from <julian@quantumfyre.co.uk>, uid 201) with qmail-scanner-1.25st 
 (clamdscan: 0.91/3735. spamassassin: 3.2.1. perlscan: 1.25st.  
 Clear:RC:1(192.168.0.2):. 
 Processed in 0.029951 secs); 23 Jul 2007 08:31:36 -0000
Received: from reaper.quantumfyre.co.uk (192.168.0.2)
  by neutron.datavampyre.co.uk with SMTP; 23 Jul 2007 09:31:36 +0100
X-X-Sender: jp3@reaper.quantumfyre.co.uk
In-Reply-To: <Pine.LNX.4.64.0707230000020.14781@racer.site>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/53411>

On Mon, 23 Jul 2007, Johannes Schindelin wrote:

> Hi,
>
> On Sun, 22 Jul 2007, Julian Phillips wrote:
>
>> On Sun, 22 Jul 2007, Johannes Schindelin wrote:
>>
>>> Well, I am really not interested in shooting myself in the foot, and
>>> having that option in checkout would make that much more likely.  So I
>>> really, really want to have this in git-branch.
>>
>> Fair enough.  Your patch - so you get to choose.  I don't have any
>> strong objections (and no power to express any if I did :P) - just
>> airing my POV ;)
>
> ;-)
>
> In related news, you got me convinced that my "solution" is not
> sufficient.  So I guess this patch has to wait until after 1.5.3 _and_
> after we convinced Junio to put his BASE index extension in again.
>
> FWIW once git-checkout is builtin, I'll add "--new-workdir" for it.  Deal?

Sounds good to me.  Even gives me some motivation to see checkout a 
builtin sooner rather than later ;)

-- 
Julian

  ---
Logic is the chastity belt of the mind!
