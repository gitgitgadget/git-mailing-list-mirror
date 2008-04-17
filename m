From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] git-branch: add support for --merged and --unmerged
Date: Thu, 17 Apr 2008 12:13:45 -0700
Message-ID: <7vr6d4nvkm.fsf@gitster.siamese.dyndns.org>
References: <12084250231245-git-send-email-hjemli@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Lars Hjemli <hjemli@gmail.com>
X-From: git-owner@vger.kernel.org Thu Apr 17 21:39:27 2008
connect(): Connection refused
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JmZZD-0003Xg-QC
	for gcvg-git-2@gmane.org; Thu, 17 Apr 2008 21:14:44 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754273AbYDQTN7 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 17 Apr 2008 15:13:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754065AbYDQTN7
	(ORCPT <rfc822;git-outgoing>); Thu, 17 Apr 2008 15:13:59 -0400
Received: from a-sasl-fastnet.sasl.smtp.pobox.com ([207.106.133.19]:38526 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753981AbYDQTN6 (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 17 Apr 2008 15:13:58 -0400
Received: from localhost.localdomain (localhost [127.0.0.1])
	by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with ESMTP id 675712C89;
	Thu, 17 Apr 2008 15:13:55 -0400 (EDT)
Received: from pobox.com (ip68-225-240-77.oc.oc.cox.net [68.225.240.77])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits)) (No client
 certificate requested) by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with
 ESMTP id DBC022C87; Thu, 17 Apr 2008 15:13:52 -0400 (EDT)
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/79813>

How does --merged compare with existing --contains?

If the existing --contains implemenation can be extended to allow negative
selection, we do not have to introduce yet another mechanism that is very
similar.
