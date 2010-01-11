From: Johannes Sixt <j.sixt@viscovery.net>
Subject: Re: Unable to get "pretty" URL aliases working
Date: Mon, 11 Jan 2010 08:46:06 +0100
Message-ID: <4B4AD73E.6090302@viscovery.net>
References: <4B4ABDB5.9000203@uq.edu.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Adam Nielsen <adam.nielsen@uq.edu.au>
X-From: git-owner@vger.kernel.org Mon Jan 11 08:46:18 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NUEye-0003KD-9v
	for gcvg-git-2@lo.gmane.org; Mon, 11 Jan 2010 08:46:16 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751488Ab0AKHqM (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 11 Jan 2010 02:46:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751303Ab0AKHqM
	(ORCPT <rfc822;git-outgoing>); Mon, 11 Jan 2010 02:46:12 -0500
Received: from lilzmailso01.liwest.at ([212.33.55.23]:58046 "EHLO
	lilzmailso02.liwest.at" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1751247Ab0AKHqL (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 11 Jan 2010 02:46:11 -0500
Received: from cpe228-254.liwest.at ([81.10.228.254] helo=theia.linz.viscovery)
	by lilzmailso02.liwest.at with esmtpa (Exim 4.69)
	(envelope-from <j.sixt@viscovery.net>)
	id 1NUEyV-0007rZ-9b; Mon, 11 Jan 2010 08:46:07 +0100
Received: from [127.0.0.1] (J6T.linz.viscovery [192.168.1.95])
	by theia.linz.viscovery (Postfix) with ESMTP id 0B87D1660F;
	Mon, 11 Jan 2010 08:46:06 +0100 (CET)
User-Agent: Thunderbird 2.0.0.23 (Windows/20090812)
In-Reply-To: <4B4ABDB5.9000203@uq.edu.au>
X-Spam-Score: 1.9 (+)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/136612>

Adam Nielsen schrieb:
> I would like to be able to do this:
> 
>   git clone ssh://myserver/project.git
>   git push
> 
> And have it work, but I keep getting errors about "/project.git" not
> existing in the root directory of my server.  (Which is correct, they
> are stored elsewhere.)

This form of URL can only accept the absolute path to project.git on
myserver, eg.:

   ssh://myserver/home/adam/project.git

-- Hannes
