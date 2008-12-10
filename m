From: Luben Tuikov <ltuikov@yahoo.com>
Subject: Re: [PATCH 2/3] gitweb: Cache $parent_commit info in git_blame()
Date: Wed, 10 Dec 2008 13:15:02 -0800 (PST)
Message-ID: <755680.28599.qm@web31804.mail.mud.yahoo.com>
References: <200812102203.30486.jnareb@gmail.com>
Reply-To: ltuikov@yahoo.com
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Jakub Narebski <jnareb@gmail.com>
X-From: git-owner@vger.kernel.org Wed Dec 10 22:16:29 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LAWPy-0000M8-UI
	for gcvg-git-2@gmane.org; Wed, 10 Dec 2008 22:16:27 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755148AbYLJVPI (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 10 Dec 2008 16:15:08 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755106AbYLJVPI
	(ORCPT <rfc822;git-outgoing>); Wed, 10 Dec 2008 16:15:08 -0500
Received: from web31804.mail.mud.yahoo.com ([68.142.207.67]:39366 "HELO
	web31804.mail.mud.yahoo.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with SMTP id S1753502AbYLJVPH (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 10 Dec 2008 16:15:07 -0500
Received: (qmail 31962 invoked by uid 60001); 10 Dec 2008 21:15:04 -0000
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
  s=s1024; d=yahoo.com;
  h=Message-ID:Received:X-Mailer:Date:From:Reply-To:Subject:To:Cc:In-Reply-To:MIME-Version:Content-Type;
  b=SXAWbmW5r2AjFGrpYyxXiU3O62n/Nn9FL7FBUO4A7QTXTWrhoHuyf4V72CGikn84Um5XGfUC7JeNkxtFevgm5c82JA6UBcfTWYP89e/3xtrrHogtxZSVdesutkqkGJaC1/1Rx8trg2b1heTJlRNE9lxbHFVA3eNujxo5UApbH9c=  ;
Received: from [71.132.209.19] by web31804.mail.mud.yahoo.com via HTTP; Wed, 10 Dec 2008 13:15:02 PST
X-Mailer: YahooMailWebService/0.7.260.1
In-Reply-To: <200812102203.30486.jnareb@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/102722>


--- On Wed, 12/10/08, Jakub Narebski <jnareb@gmail.com> wrote:

> You don't need $old_full_rev. We have to save data
> about commit in
> %metainfo hash because information about commit appears in 

Oh, yeah, the hash... Then, it looks correct.

Acked-by: Luben Tuikov <ltuikov@yahoo.com>
