From: Jan Engelhardt <jengelh@medozas.de>
Subject: Re: Not so happy about build system
Date: Wed, 23 Jul 2008 13:04:36 +0200 (CEST)
Message-ID: <alpine.LNX.1.10.0807231304170.23410@fbirervta.pbzchgretzou.qr>
References: <alpine.LNX.1.10.0807222036230.23410@fbirervta.pbzchgretzou.qr> <20080723103312.GE32057@genesis.frugalware.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org
To: Miklos Vajna <vmiklos@frugalware.org>
X-From: git-owner@vger.kernel.org Wed Jul 23 13:06:01 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KLcA5-0007vM-75
	for gcvg-git-2@gmane.org; Wed, 23 Jul 2008 13:05:50 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751625AbYGWLEi (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 23 Jul 2008 07:04:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751942AbYGWLEh
	(ORCPT <rfc822;git-outgoing>); Wed, 23 Jul 2008 07:04:37 -0400
Received: from sovereign.computergmbh.de ([85.214.69.204]:37054 "EHLO
	sovereign.computergmbh.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751557AbYGWLEh (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 23 Jul 2008 07:04:37 -0400
Received: by sovereign.computergmbh.de (Postfix, from userid 25121)
	id 1FF1A1803BE3A; Wed, 23 Jul 2008 13:04:36 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
	by sovereign.computergmbh.de (Postfix) with ESMTP id 192081CF30E94;
	Wed, 23 Jul 2008 13:04:36 +0200 (CEST)
In-Reply-To: <20080723103312.GE32057@genesis.frugalware.org>
User-Agent: Alpine 1.10 (LNX 962 2008-03-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/89629>


On Wednesday 2008-07-23 12:33, Miklos Vajna wrote:

>On Wed, Jul 23, 2008 at 11:33:56AM +0200, Jan Engelhardt <jengelh@medozas.de> wrote:
>> 	./configure --prefix=$HOME/rt --with-openssl=/opt/csw 
>> 	--with-curl=/opt/csw CFLAGS="-O2 -I/opt/csw/include -L/opt/csw/lib 
>> 	-R/opt/csw/lib"
>
>Why do you put -L/opt/csw/lib to CFLAGS instead of LDFLAGS?
>
Oversight I guess. Had --with-{openssl,curl} any effect, I would not even
need the -I and -L.
