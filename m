From: Remi LESPINET <remi.lespinet@ensimag.grenoble-inp.fr>
Subject: [RFC] send-email aliases when editing patches or using --xx-cmd
Date: Thu, 04 Jun 2015 22:17:51 +0200
Message-ID: <87pp5b1b4g.fsf@ensimag.grenoble-inp.fr>
Mime-Version: 1.0
Content-Type: text/plain
Cc: Remi Galan <remi.galan-alfonso@ensimag.grenoble-inp.fr>,
	Guillaume Pages <guillaume.pages@ensimag.grenoble-inp.fr>,
	Louis-Alexandre Stuber 
	<louis--alexandre.stuber@ensimag.grenoble-inp.fr>,
	Antoine Delaite <antoine.delaite@ensimag.grenoble-inp.fr>,
	Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Jun 04 22:18:22 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Z0baV-0006ia-4a
	for gcvg-git-2@plane.gmane.org; Thu, 04 Jun 2015 22:18:03 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752341AbbFDUR6 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 4 Jun 2015 16:17:58 -0400
Received: from zm-etu-ensimag-1.grenet.fr ([130.190.244.117]:59590 "EHLO
	zm-etu-ensimag-1.grenet.fr" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752282AbbFDUR5 (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 4 Jun 2015 16:17:57 -0400
Received: from localhost (localhost [127.0.0.1])
	by zm-smtpout-1.grenet.fr (Postfix) with ESMTP id 174FF4886B;
	Thu,  4 Jun 2015 22:17:54 +0200 (CEST)
Received: from zm-smtpout-1.grenet.fr ([127.0.0.1])
	by localhost (zm-smtpout-1.grenet.fr [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id y+G1OObQDf1R; Thu,  4 Jun 2015 22:17:54 +0200 (CEST)
Received: from zm-smtpauth-2.grenet.fr (zm-smtpauth-2.grenet.fr [130.190.244.123])
	by zm-smtpout-1.grenet.fr (Postfix) with ESMTP id F0D4748864;
	Thu,  4 Jun 2015 22:17:53 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
	by zm-smtpauth-2.grenet.fr (Postfix) with ESMTP id EC25320E4;
	Thu,  4 Jun 2015 22:17:53 +0200 (CEST)
Received: from zm-smtpauth-2.grenet.fr ([127.0.0.1])
	by localhost (zm-smtpauth-2.grenet.fr [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 53SpMzIbgu4E; Thu,  4 Jun 2015 22:17:53 +0200 (CEST)
Received: from Groseille (AGrenoble-652-1-407-223.w90-42.abo.wanadoo.fr [90.42.42.223])
	by zm-smtpauth-2.grenet.fr (Postfix) with ESMTPSA id BC14F20DF;
	Thu,  4 Jun 2015 22:17:52 +0200 (CEST)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/270797>


Hi,

Working on git-send-email, I've seen that there's no aliases support
when manually adding a recipient in a 'To' or 'Cc' field in a patch
and for the --to-cmd and --cc-cmd.

I would like to add this support, and I wonder if there are reasons
not to do it.

Thanks.
