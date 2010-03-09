From: Johannes Sixt <j.sixt@viscovery.net>
Subject: Re: Some information that git diff saves and that git status does
 not
Date: Tue, 09 Mar 2010 07:35:47 +0100
Message-ID: <4B95EC43.2040705@viscovery.net>
References: <loom.20100308T111146-322@post.gmane.org> <7vpr3emr3s.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: Sergio <sergio.callegari@gmail.com>
X-From: git-owner@vger.kernel.org Tue Mar 09 13:31:37 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1NoyVa-0001Do-RP
	for gcvg-git-2@lo.gmane.org; Tue, 09 Mar 2010 13:25:59 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751889Ab0CIGfy (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 9 Mar 2010 01:35:54 -0500
Received: from lilzmailso02.liwest.at ([212.33.55.13]:30090 "EHLO
	lilzmailso02.liwest.at" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751823Ab0CIGfw (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 9 Mar 2010 01:35:52 -0500
Received: from cpe228-254.liwest.at ([81.10.228.254] helo=theia.linz.viscovery)
	by lilzmailso02.liwest.at with esmtpa (Exim 4.69)
	(envelope-from <j.sixt@viscovery.net>)
	id 1Not2i-0001aB-0Z; Tue, 09 Mar 2010 07:35:48 +0100
Received: from [127.0.0.1] (J6T.linz.viscovery [192.168.1.95])
	by theia.linz.viscovery (Postfix) with ESMTP id A528A1660F;
	Tue,  9 Mar 2010 07:35:47 +0100 (CET)
User-Agent: Thunderbird 2.0.0.23 (Windows/20090812)
In-Reply-To: <7vpr3emr3s.fsf@alter.siamese.dyndns.org>
X-Spam-Score: -1.4 (-)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/141809>

Junio C Hamano schrieb:
> I didn't fully read what you wrote but after you copy a repository from
> one to another outside git (be it done with unison or rsync), you should
> run "update-index --refresh".

And the reason for this is that git also looks at the inode numbers, and I
guess that unison does not go as far as to preserve them between machines...

-- Hannes
