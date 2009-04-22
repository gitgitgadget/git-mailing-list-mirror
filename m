From: Andy Lester <andy@petdance.com>
Subject: Removing duplicated code between builtin-send-pack.c and transport.c
Date: Wed, 22 Apr 2009 12:01:16 -0500
Message-ID: <09511913-0ED3-41C0-A4F0-9F2D452C00D7@petdance.com>
Mime-Version: 1.0 (Apple Message framework v930.3)
Content-Type: text/plain; charset=US-ASCII; format=flowed; delsp=yes
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Apr 22 19:03:08 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LwfqV-0002Ay-JS
	for gcvg-git-2@gmane.org; Wed, 22 Apr 2009 19:02:52 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753175AbZDVRBS (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 22 Apr 2009 13:01:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752992AbZDVRBR
	(ORCPT <rfc822;git-outgoing>); Wed, 22 Apr 2009 13:01:17 -0400
Received: from huggy.petdance.com ([72.14.176.61]:34094 "EHLO
	huggy.petdance.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752317AbZDVRBR (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 22 Apr 2009 13:01:17 -0400
Received: from alester.flr.follett.com (host3130.follett.com [12.47.12.130])
	by huggy.petdance.com (Postfix) with ESMTP id C956522DE74
	for <git@vger.kernel.org>; Wed, 22 Apr 2009 13:01:16 -0400 (EDT)
X-Mailer: Apple Mail (2.930.3)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/117218>

There's a ton of code duplicated between transport.c and builtin-send- 
pack.c, from print_push_status() and its static helpers.

Is there a reason NOT to refactor it out of the builtin and use the  
transport?

xoa

--
Andy Lester => andy@petdance.com => www.theworkinggeek.com => AIM:petdance
