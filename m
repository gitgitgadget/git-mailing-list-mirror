From: Johannes Sixt <j.sixt@viscovery.net>
Subject: Re: [PATCH 2/2] reflog: ignore expire-unreachable for "HEAD" reflog
Date: Thu, 15 Apr 2010 14:58:29 +0200
Message-ID: <4BC70D75.70801@viscovery.net>
References: <7vljcppycc.fsf@alter.siamese.dyndns.org> <7vfx2xpyam.fsf@alter.siamese.dyndns.org> <4BC6B5FF.6030406@viscovery.net> <7vochlkvtg.fsf@alter.siamese.dyndns.org> <4BC6D30F.5020004@viscovery.net> <7v4ojclwyu.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Apr 15 14:58:41 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1O2OeW-0005aR-KX
	for gcvg-git-2@lo.gmane.org; Thu, 15 Apr 2010 14:58:40 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753481Ab0DOM6f (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 15 Apr 2010 08:58:35 -0400
Received: from lilzmailso01.liwest.at ([212.33.55.23]:64126 "EHLO
	lilzmailso01.liwest.at" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752297Ab0DOM6e (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 15 Apr 2010 08:58:34 -0400
Received: from cpe228-254.liwest.at ([81.10.228.254] helo=theia.linz.viscovery)
	by lilzmailso01.liwest.at with esmtpa (Exim 4.69)
	(envelope-from <j.sixt@viscovery.net>)
	id 1O2OeM-0007N2-Dz; Thu, 15 Apr 2010 14:58:30 +0200
Received: from [127.0.0.1] (J6T.linz.viscovery [192.168.1.95])
	by theia.linz.viscovery (Postfix) with ESMTP id 272A31660F;
	Thu, 15 Apr 2010 14:58:30 +0200 (CEST)
User-Agent: Mozilla/5.0 (Windows; U; Windows NT 5.1; de; rv:1.9.1.9) Gecko/20100317 Thunderbird/3.0.4
In-Reply-To: <7v4ojclwyu.fsf@alter.siamese.dyndns.org>
X-Enigmail-Version: 1.0.1
X-Spam-Score: -1.4 (-)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/144981>

Am 4/15/2010 14:30, schrieb Junio C Hamano:
> A reflog consists of entries, each of which records how you got to the
> current history by pointing to different commit objects.  Some entries
> matter more than others do.  Dead-end experiments stop mattering faster
> than others.  It is these _entries_ that we expire, because keeping them
> indefinitely is a wasteful clutter.

I have no problem with this point of view, i.e., that expiration is merely
about the entries, and that garbage-collecting objects is just a
side-effect of removed entries.

But I don't see yet, why an entry pointing to a dead-end experiment is
less important when it is an entry in a branch reflog than when it is an
entry in the HEAD reflog. Care to explain?

-- Hannes
