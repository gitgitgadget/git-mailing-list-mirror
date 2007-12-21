From: Steven Grimm <koreth@midwinter.com>
Subject: Re: 1.5.4-rc2 plans
Date: Fri, 21 Dec 2007 00:57:46 -0800
Message-ID: <1DCAF728-4B12-4EA8-84BB-DFB30B42BFF8@midwinter.com>
References: <7vwsr8lwf7.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0 (Apple Message framework v915)
Content-Type: text/plain; charset=US-ASCII; format=flowed; delsp=yes
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri Dec 21 09:58:16 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1J5dhs-00011C-Sb
	for gcvg-git-2@gmane.org; Fri, 21 Dec 2007 09:58:13 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753549AbXLUI5s (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 21 Dec 2007 03:57:48 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753508AbXLUI5s
	(ORCPT <rfc822;git-outgoing>); Fri, 21 Dec 2007 03:57:48 -0500
Received: from tater.midwinter.com ([216.32.86.90]:50156 "HELO midwinter.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1753311AbXLUI5r (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 21 Dec 2007 03:57:47 -0500
Received: (qmail 5813 invoked from network); 21 Dec 2007 08:57:47 -0000
Comment: DomainKeys? See http://antispam.yahoo.com/domainkeys
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
  s=200606; d=midwinter.com;
  b=WpaOVivwfNabInVPwZwLIuHq518zKsPZGyQzC+IHVR/qnlxIgv7Xhtc9rsRQLWeK  ;
Received: from localhost (127.0.0.1)
  by localhost with SMTP; 21 Dec 2007 08:57:47 -0000
In-Reply-To: <7vwsr8lwf7.fsf@gitster.siamese.dyndns.org>
X-Mailer: Apple Mail (2.915)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/69047>

On Dec 20, 2007, at 4:32 PM, Junio C Hamano wrote:
> * handling of EDITOR in git commit and git tag is currently different.
>   It expects "vi" not "vi --some-funny-option".  I sent out a
>   for-discussion patch after seeing Steven's and Luciano's.

I'm perfectly fine with your approach (punt and let the shell figure  
it out). It's certainly a lot less code change than mine. However, if  
you want another rev of mine with Johannes' comments taken into  
account, I should be able to do that in the next day or two.

-Steve
