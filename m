From: Juan Zanos <juan_zanos@talkhouse.com>
Subject: git confusing a submodule & subdirectory?
Date: Mon, 16 Mar 2009 14:39:11 -0400
Message-ID: <135FFBD1-83C2-4538-8311-A69A0D7D7016@talkhouse.com>
Mime-Version: 1.0 (Apple Message framework v753.1)
Content-Type: text/plain; charset=US-ASCII; delsp=yes; format=flowed
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Mar 16 19:47:27 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LjHq6-0004ty-L6
	for gcvg-git-2@gmane.org; Mon, 16 Mar 2009 19:47:07 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755364AbZCPSpi (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 16 Mar 2009 14:45:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752949AbZCPSph
	(ORCPT <rfc822;git-outgoing>); Mon, 16 Mar 2009 14:45:37 -0400
Received: from outbound-mail-115.bluehost.com ([69.89.24.5]:39612 "HELO
	outbound-mail-115.bluehost.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with SMTP id S1753234AbZCPSph (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 16 Mar 2009 14:45:37 -0400
X-Greylist: delayed 398 seconds by postgrey-1.27 at vger.kernel.org; Mon, 16 Mar 2009 14:45:36 EDT
Received: (qmail 17493 invoked by uid 0); 16 Mar 2009 18:38:55 -0000
Received: from unknown (HELO box392.bluehost.com) (69.89.31.192)
  by outboundproxy3.bluehost.com with SMTP; 16 Mar 2009 18:38:55 -0000
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws; s=default; d=talkhouse.com;
	h=Received:Mime-Version:Content-Transfer-Encoding:Message-Id:Content-Type:To:From:Subject:Date:X-Mailer:X-Identified-User;
	b=HCD/eLODlbGMKCz50QJy3/6fI20F9w1O9IAL8DKSemBTOhP1dqhZz4StW+TvueTol1pbrMpKvhDNxiFQeNpBQKIgRBu0zzmtiQW59CA1rE38zrjPQ67N3aKxla/6mp6Y;
Received: from 146-115-56-250.c3-0.wtr-ubr1.sbo-wtr.ma.cable.rcn.com ([146.115.56.250] helo=[192.168.1.2])
	by box392.bluehost.com with esmtpsa (TLSv1:AES128-SHA:128)
	(Exim 4.69)
	(envelope-from <juan_zanos@talkhouse.com>)
	id 1LjHiA-0000zo-Mv
	for git@vger.kernel.org; Mon, 16 Mar 2009 12:38:54 -0600
X-Mailer: Apple Mail (2.753.1)
X-Identified-User: {2758:box392.bluehost.com:talkhous:talkhouse.com} {sentby:smtp auth 146.115.56.250 authed with juan_zanos@talkhouse.com}
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/113352>

Is it possible for git to confuse a submodule with a subdirectory?   
When I modify my submodule git seems to think the directory has  
changed.   A commit isn't going to add all that content to the  
containing repository.  Is it?

Best,
Juan
