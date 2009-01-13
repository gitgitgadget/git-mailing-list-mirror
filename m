From: Jan Engelhardt <jengelh@medozas.de>
Subject: gitignore excludes too much
Date: Tue, 13 Jan 2009 14:30:26 +0100 (CET)
Message-ID: <alpine.LSU.2.00.0901131429020.23531@fbirervta.pbzchgretzou.qr>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Jan 13 14:32:02 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LMjN9-0003FM-OB
	for gcvg-git-2@gmane.org; Tue, 13 Jan 2009 14:32:00 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1760332AbZAMNab (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 13 Jan 2009 08:30:31 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1760310AbZAMNaa
	(ORCPT <rfc822;git-outgoing>); Tue, 13 Jan 2009 08:30:30 -0500
Received: from sovereign.computergmbh.de ([85.214.69.204]:60833 "EHLO
	sovereign.computergmbh.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1760298AbZAMNa3 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 13 Jan 2009 08:30:29 -0500
Received: by sovereign.computergmbh.de (Postfix, from userid 25121)
	id 6901E18030639; Tue, 13 Jan 2009 14:30:26 +0100 (CET)
Received: from localhost (localhost [127.0.0.1])
	by sovereign.computergmbh.de (Postfix) with ESMTP id 67B751C00DB1B
	for <git@vger.kernel.org>; Tue, 13 Jan 2009 14:30:26 +0100 (CET)
User-Agent: Alpine 2.00 (LSU 1167 2008-08-23)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/105496>

Hi,


I noticed that having "*.d" in .gitignore ignores files that would start 
with a dot, such as ".main.o.d". This is against Unix shell behavior;
but maybe it's a feature rather than a bug?
In case of latter, please fix :-)


Jan
