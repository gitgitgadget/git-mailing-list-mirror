From: Samuel Lucas Vaz de Mello <samuellucas@datacom.ind.br>
Subject: Re: Git newbie question: permissions
Date: Fri, 10 Oct 2008 11:44:52 -0300
Organization: DATACOM
Message-ID: <48EF6A64.9060203@datacom.ind.br>
References: <1b5a37350810091320l72ae0a86m39db4258c9f4827e@mail.gmail.com> <2008-10-09-23-41-14+trackit+sam@rfc1149.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Oct 10 16:46:57 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KoJFo-0002vm-3H
	for gcvg-git-2@gmane.org; Fri, 10 Oct 2008 16:46:08 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757703AbYJJOoz (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 10 Oct 2008 10:44:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1757541AbYJJOoz
	(ORCPT <rfc822;git-outgoing>); Fri, 10 Oct 2008 10:44:55 -0400
Received: from mail.datacom-telematica.com.br ([200.213.13.18]:51949 "EHLO
	mail.datacom-telematica.com.br" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1757283AbYJJOoy (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 10 Oct 2008 10:44:54 -0400
Received: by mail.datacom-telematica.com.br (Postfix, from userid 65)
	id 518A12ACD2; Fri, 10 Oct 2008 12:15:02 -0300 (BRST)
Received: from [10.1.3.11] (unknown [10.1.3.11])
	by mail.datacom-telematica.com.br (Postfix) with ESMTP id E27F62ACCF
	for <git@vger.kernel.org>; Fri, 10 Oct 2008 12:15:01 -0300 (BRST)
User-Agent: Thunderbird 2.0.0.17 (X11/20080925)
In-Reply-To: <2008-10-09-23-41-14+trackit+sam@rfc1149.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/97938>

Samuel Tardieu wrote:
> This should fix your current situation. The "sharedrepository = 1"
> will tell git to maintain a proper shared state in the future
> on objects it creates (i.e. mirror "user" permission to "group" ones).
>   
Is git-gc supposed to respect sharedrepository=1 and create 
group-writable files?
For me, it's recreating the files under logs/refs/heads with 644 
permissions.

BR,

 - Samuel
