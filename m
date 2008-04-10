From: Jan Engelhardt <jengelh@computergmbh.de>
Subject: rev-list date-order not overridable
Date: Thu, 10 Apr 2008 13:43:06 +0200 (CEST)
Message-ID: <alpine.LNX.1.10.0804101342090.8765@fbirervta.pbzchgretzou.qr>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Apr 10 13:44:49 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JjvCo-0005TD-94
	for gcvg-git-2@gmane.org; Thu, 10 Apr 2008 13:44:38 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755026AbYDJLnR (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 10 Apr 2008 07:43:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756142AbYDJLnM
	(ORCPT <rfc822;git-outgoing>); Thu, 10 Apr 2008 07:43:12 -0400
Received: from sovereign.computergmbh.de ([85.214.69.204]:44519 "EHLO
	sovereign.computergmbh.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755643AbYDJLnH (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 10 Apr 2008 07:43:07 -0400
Received: by sovereign.computergmbh.de (Postfix, from userid 25121)
	id 98A4A180A6EA1; Thu, 10 Apr 2008 13:43:06 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
	by sovereign.computergmbh.de (Postfix) with ESMTP id 923981CF5013D
	for <git@vger.kernel.org>; Thu, 10 Apr 2008 13:43:06 +0200 (CEST)
User-Agent: Alpine 1.10 (LNX 962 2008-03-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/79210>

Hi,


git-rev-list --topo-order (the default) can be overriden by specifying 
--date-order, but --date-order cannot be overriden by passing in 
--topo-order again. Having it work would be really nice because it 
allows extra programs to default to --date-order in some way.
