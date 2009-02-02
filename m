From: Pieter de Bie <pdebie@ai.rug.nl>
Subject: Re: How let git think UTF-16 file as text file
Date: Mon, 2 Feb 2009 00:50:17 +0000
Message-ID: <E9FE0F4D-8E6C-47D6-BA35-DDD739BD1AD6@ai.rug.nl>
References: <1976ea660902011643h379e41f1nd2f2c5f7b8d729f3@mail.gmail.com>
Mime-Version: 1.0 (Apple Message framework v930.3)
Content-Type: text/plain; charset=US-ASCII; format=flowed; delsp=yes
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Frank Li <lznuaa@gmail.com>
X-From: git-owner@vger.kernel.org Mon Feb 02 01:51:55 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LTn2Y-0006vp-3Y
	for gcvg-git-2@gmane.org; Mon, 02 Feb 2009 01:51:54 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751748AbZBBAu2 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 1 Feb 2009 19:50:28 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751631AbZBBAu2
	(ORCPT <rfc822;git-outgoing>); Sun, 1 Feb 2009 19:50:28 -0500
Received: from frim.nl ([87.230.85.232]:34493 "EHLO
	lvps87-230-85-232.dedicated.hosteurope.de" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751300AbZBBAu1 (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 1 Feb 2009 19:50:27 -0500
Received: from 82-41-227-224.cable.ubr11.sgyl.blueyonder.co.uk ([82.41.227.224] helo=[192.168.50.100])
	by lvps87-230-85-232.dedicated.hosteurope.de with esmtpsa (TLS-1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.63)
	(envelope-from <pdebie@ai.rug.nl>)
	id 1LTn16-0002ek-Vq; Mon, 02 Feb 2009 01:50:25 +0100
In-Reply-To: <1976ea660902011643h379e41f1nd2f2c5f7b8d729f3@mail.gmail.com>
X-Mailer: Apple Mail (2.930.3)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/108032>


On 2 feb 2009, at 00:43, Frank Li wrote:

> VS project resource file and resource header file use UTF-16 as  
> unicode.
> Default git think it is binary file.
> How to let git think it is text file.

Perhaps something like

*vs diff crlf

in your .gitattributes file?
