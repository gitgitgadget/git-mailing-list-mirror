From: Alan Chandler <alan@chandlerfamily.org.uk>
Subject: Use of the -f flag on checkout
Date: Thu, 29 Sep 2005 07:54:29 +0100
Message-ID: <200509290754.30017.alan@chandlerfamily.org.uk>
References: <433B84BD.8030003@pobox.com> <7vbr2cmle2.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
X-From: git-owner@vger.kernel.org Thu Sep 29 08:55:47 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1EKsJL-0004DT-J4
	for gcvg-git@gmane.org; Thu, 29 Sep 2005 08:54:31 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932103AbVI2Gy3 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 29 Sep 2005 02:54:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932101AbVI2Gy3
	(ORCPT <rfc822;git-outgoing>); Thu, 29 Sep 2005 02:54:29 -0400
Received: from 82-44-22-127.cable.ubr06.croy.blueyonder.co.uk ([82.44.22.127]:27882
	"EHLO home.chandlerfamily.org.uk") by vger.kernel.org with ESMTP
	id S932103AbVI2Gy2 (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 29 Sep 2005 02:54:28 -0400
Received: from kanger.home ([192.168.0.21])
	by home.chandlerfamily.org.uk with esmtp (Exim 4.50)
	id 1EKsJH-0001Li-Qk
	for git@vger.kernel.org; Thu, 29 Sep 2005 07:54:27 +0100
To: git@vger.kernel.org
User-Agent: KMail/1.8.2
In-Reply-To: <7vbr2cmle2.fsf@assigned-by-dhcp.cox.net>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/9470>

On Thursday 29 Sep 2005 07:35, Junio C Hamano wrote:
> Jeff Garzik <jgarzik@pobox.com> writes:
> > My question:  is this the best/right way to pull one branch into
> > another?  It's been working for me, for months, but...
>
> Yes, that is how 'resolve' is designed to work.
>
> You could instead use standard 'git pull' from the local
> repository.  Here is what I usually do in git.git repository:
>
>     $ git checkout foo
>     $ ... work in foo "topic" branch
>     $ git checkout bar
>     $ ... work in bar "topic" branch
>     $ git checkout pu

I notice that Jeff is using the -f flag on checkout whereas you don't.

What is the risk in not using it (ie what are the cases when you should use 
it)?

-- 
Alan Chandler
http://www.chandlerfamily.org.uk
