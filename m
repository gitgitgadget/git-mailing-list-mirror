From: Johannes Sixt <johannes.sixt@telecom.at>
Subject: Re: [PATCH 1/5] Change git_connect() to return a struct child_process instead of a pid_t.
Date: Sun, 30 Sep 2007 23:40:17 +0200
Message-ID: <200709302340.17644.johannes.sixt@telecom.at>
References: <1191183001-5368-1-git-send-email-johannes.sixt@telecom.at> <1191183001-5368-2-git-send-email-johannes.sixt@telecom.at> <7vbqbjg9zz.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Cc: Junio C Hamano <gitster@pobox.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Sep 30 23:40:29 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Ic6Wa-0000xQ-23
	for gcvg-git-2@gmane.org; Sun, 30 Sep 2007 23:40:28 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752077AbXI3VkU (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 30 Sep 2007 17:40:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752171AbXI3VkU
	(ORCPT <rfc822;git-outgoing>); Sun, 30 Sep 2007 17:40:20 -0400
Received: from smtp2.srv.eunet.at ([193.154.160.116]:40601 "EHLO
	smtp2.srv.eunet.at" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752077AbXI3VkT (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 30 Sep 2007 17:40:19 -0400
Received: from dx.sixt.local (at00d01-adsl-194-118-045-019.nextranet.at [194.118.45.19])
	by smtp2.srv.eunet.at (Postfix) with ESMTP id 1AFA1BEEE6;
	Sun, 30 Sep 2007 23:40:18 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
	by dx.sixt.local (Postfix) with ESMTP id D68BC1226F;
	Sun, 30 Sep 2007 23:40:17 +0200 (CEST)
User-Agent: KMail/1.9.3
In-Reply-To: <7vbqbjg9zz.fsf@gitster.siamese.dyndns.org>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/59574>

On Sunday 30 September 2007 22:43, Junio C Hamano wrote:
> Johannes Sixt <johannes.sixt@telecom.at> writes:
> > +	struct child_process *chld;
>
> Is "child" a reserved keyword or something that we need to avoid
> its use as an identifier?

Allow me to call it "conn": We are using this as a "connection object".

Will integrate your and Dscho's suggestions and resend when the strbuf series 
appears in master.

-- Hannes
