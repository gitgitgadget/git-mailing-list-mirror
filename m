From: Adam Nielsen <adam.nielsen@uq.edu.au>
Subject: Re: How do you switch branches in a bare repo?
Date: Fri, 12 Mar 2010 17:38:23 +1000
Organization: The University of Queensland
Message-ID: <4B99EF6F.90207@uq.edu.au>
References: <4B99DEA2.6050104@uq.edu.au> <4B99E5DD.3020005@viscovery.net> <4B99E957.60905@uq.edu.au> <4B99EE7C.4060902@viscovery.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Johannes Sixt <j.sixt@viscovery.net>
X-From: git-owner@vger.kernel.org Fri Mar 12 08:38:53 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1NpzS3-0000bJ-Ui
	for gcvg-git-2@lo.gmane.org; Fri, 12 Mar 2010 08:38:32 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751682Ab0CLHi0 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 12 Mar 2010 02:38:26 -0500
Received: from mailhub3.uq.edu.au ([130.102.148.131]:56514 "EHLO
	mailhub3.uq.edu.au" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751114Ab0CLHi0 (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 12 Mar 2010 02:38:26 -0500
Received: from smtp3.uq.edu.au (smtp3.uq.edu.au [130.102.128.18])
	by mailhub3.uq.edu.au (8.13.8/8.13.8) with ESMTP id o2C7cNbj016228;
	Fri, 12 Mar 2010 17:38:24 +1000
Received: from [192.168.173.208] (rrtd-it1.research.uq.edu.au [192.168.173.208])
	by smtp3.uq.edu.au (8.13.8/8.13.8) with ESMTP id o2C7cNIX022099
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NOT);
	Fri, 12 Mar 2010 17:38:23 +1000
User-Agent: Thunderbird 2.0.0.23 (X11/20091130)
In-Reply-To: <4B99EE7C.4060902@viscovery.net>
X-UQ-FilterTime: 1268379504
X-Scanned-By: MIMEDefang 2.58 on UQ Mailhub on 130.102.148.131
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/142031>

> Perhaps non-fast-forwards are denied for a reason?
> 
> If not, then you can enable them by setting receive.denynonfastforwards to
> false in the bare repository.

Ah, that did the trick!  Although it was actually 
receive.denyNonFastforwards for me (adding the lowercase option had no 
effect, I had to edit the fancy-case version.)

But that allowed the push to work and I have gotten rid of my unwanted 
commits, so thanks a lot for your help!

Cheers,
Adam.
