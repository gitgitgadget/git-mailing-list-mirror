From: Stefan Naewe <stefan.naewe@atlas-elektronik.com>
Subject: Re: [PATCH] let core.excludesfile default to ~/.gitignore.
Date: Fri, 20 Nov 2009 15:30:06 +0100
Organization: ATLAS Elektronik GmbH
Message-ID: <4B06A7EE.2090801@atlas-elektronik.com>
References: <1258723430-31684-1-git-send-email-Matthieu.Moy@imag.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Cc: "git@vger.kernel.org" <git@vger.kernel.org>,
	"gitster@pobox.com" <gitster@pobox.com>
To: Matthieu Moy <Matthieu.Moy@imag.fr>
X-From: git-owner@vger.kernel.org Fri Nov 20 15:30:19 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NBUV8-0003ID-3g
	for gcvg-git-2@lo.gmane.org; Fri, 20 Nov 2009 15:30:18 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753351AbZKTOaD (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 20 Nov 2009 09:30:03 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752656AbZKTOaD
	(ORCPT <rfc822;git-outgoing>); Fri, 20 Nov 2009 09:30:03 -0500
Received: from lxsrv96.atlas.de ([194.156.172.86]:51064 "EHLO mail96.atlas.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752296AbZKTOaB (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 20 Nov 2009 09:30:01 -0500
Received: from VSSRV01.atlas.de (vssrv01.atlas.de [10.200.101.18])
	by mail96.atlas.de (Postfix) with ESMTP id CCC08138A9
	for <git@vger.kernel.org>; Fri, 20 Nov 2009 15:30:06 +0100 (CET)
X-AuditID: 0ac86512-00000094000005bc-c1-4b06a7ee5022
Received: from mgsrv01.atlas.de ([10.200.101.16]) by VSSRV01.atlas.de with Microsoft SMTPSVC(6.0.3790.3959);
	 Fri, 20 Nov 2009 15:30:06 +0100
Received: from mgsrv01.atlas.de (localhost [127.0.0.1])
	by mail01-int.atlas.de (Postfix) with ESMTP id 3042127172;
	Fri, 20 Nov 2009 15:30:06 +0100 (CET)
X-Spam-Checker-Version: SpamAssassin 3.2.5 (2008-06-10) on mgsrv01.atlas.de
X-Spam-Level: 
X-Spam-Status: No, score=-1.6 required=5.0 tests=ALL_TRUSTED,BAYES_50,
	SUBJECT_FUZZY_TION autolearn=disabled version=3.2.5
Received: from [141.200.42.243] (as106913.atlas.de [141.200.42.243])
	by mail01.atlas.de (Postfix) with ESMTP id 20F662716A;
	Fri, 20 Nov 2009 15:30:06 +0100 (CET)
User-Agent: Mozilla/5.0 (Windows; U; Windows NT 5.1; de; rv:1.8.1.14) Gecko/20080421 Lightning/0.8 Thunderbird/2.0.0.14 Mnenhy/0.7.5.0
In-Reply-To: <1258723430-31684-1-git-send-email-Matthieu.Moy@imag.fr>
X-Enigmail-Version: 0.96.0
X-Brightmail-Tracker: AAAAAA==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/133348>

On 11/20/2009 2:23 PM, Matthieu Moy wrote:
> It seems this is the value most users set, so let's make it the default.

I like the idea but would suggest to use ~/.gitexcludes instead.
That way it doesn't clash with .gitignore if your $HOME is 
under git-control.

Regards

Stefan
-- 
----------------------------------------------------------------
/dev/random says: INTERLACE: To tie two boots together.
