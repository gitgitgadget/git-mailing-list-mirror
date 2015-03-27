From: Martin Pettersson <martin@siamect.com>
Subject: Re: Git with Lader logic
Date: Fri, 27 Mar 2015 15:09:15 +0000 (UTC)
Message-ID: <loom.20150327T160645-181@post.gmane.org>
References: <5F9B9EBF-CD4D-42A8-8A0C-9806702231A1@icloud.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Mar 27 16:15:23 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YbVyj-0002Li-Mh
	for gcvg-git-2@plane.gmane.org; Fri, 27 Mar 2015 16:15:22 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964771AbbC0PPS (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 27 Mar 2015 11:15:18 -0400
Received: from plane.gmane.org ([80.91.229.3]:38686 "EHLO plane.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752956AbbC0PPN (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 27 Mar 2015 11:15:13 -0400
Received: from list by plane.gmane.org with local (Exim 4.69)
	(envelope-from <gcvg-git-2@m.gmane.org>)
	id 1YbVyR-00029W-N2
	for git@vger.kernel.org; Fri, 27 Mar 2015 16:15:04 +0100
Received: from ppp-171-96-7-236.revip8.asianet.co.th ([171.96.7.236])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Fri, 27 Mar 2015 16:15:03 +0100
Received: from martin by ppp-171-96-7-236.revip8.asianet.co.th with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Fri, 27 Mar 2015 16:15:03 +0100
X-Injected-Via-Gmane: http://gmane.org/
X-Complaints-To: usenet@ger.gmane.org
X-Gmane-NNTP-Posting-Host: sea.gmane.org
User-Agent: Loom/3.14 (http://gmane.org/)
X-Loom-IP: 171.96.7.236 (Mozilla/5.0 (X11; Linux) AppleWebKit/538.15 (KHTML, like Gecko) Chrome/18.0.1025.133 Safari/538.15 Midori/0.5)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/266373>

Bharat Suvarna <bharat.bs84 <at> icloud.com> writes:

> 
> Hi 
> 
> I am trying to find a way of using version control on 
PLC programmers like Allen Bradley PLC. I 
can't find a way
> of this.
> 
> Could you please give me an idea if it will work with 
Plc programs. Which are basically Ladder 
logic.
> 
> Sent from my iPad--
> To unsubscribe from this list: send the line "unsubscribe git" in
> the body of a message to majordomo <at> vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> 
> 

I use Git for versioning PLC program written for Beckhoff TwinCAT v2 that 
saves the files in binary format.  
You can probably do the same for most other systems as well.   
  
My way of doing it is... 
I have a batch file that starts TwinCAT including a file that tell Twincat to
open my PLC program and export it into a text based format. 
After that the script opens git gui and gitk.  
  
I have one script like this for each plc program. 
It is quite effcient, the whole procedure only takes a double click and 
less than 10 seconds and you have git gui up and you can see your 
changes in pure text, commit and push.   
I commit both the exported text files and the binary  because the binary
is the one I edit.   
This has been working very well for many years....
  
Take care   
Martin
