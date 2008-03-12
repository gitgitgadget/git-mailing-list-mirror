From: Charles Bailey <charles@hashpling.org>
Subject: Re: [PATCH] Simplify MSGFMT setting in Makefile
Date: Wed, 12 Mar 2008 10:19:12 +0000
Message-ID: <20080312101912.GB5530@hashpling.org>
References: <46a038f90802220957y7db67d8nb6b7ad784124546a@mail.gmail.com> <47C5A974.7080207@gmail.com> <alpine.LSU.1.00.0802271825330.22527@racer.site> <47C5AEFA.5020004@gmail.com> <alpine.LSU.1.00.0802272203270.22527@racer.site> <7vablmqc7q.fsf@gitster.siamese.dyndns.org> <47C7000C.1000809@gmail.com> <20080305071915.GI8410@spearce.org> <7v63w0gs87.fsf@gitster.siamese.dyndns.org> <7vr6eg7bn3.fsf_-_@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: "Shawn O. Pearce" <spearce@spearce.org>,
	Paul Mackerras <paulus@samba.org>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Mar 12 11:20:20 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JZO4J-0001b6-5X
	for gcvg-git-2@gmane.org; Wed, 12 Mar 2008 11:20:19 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751426AbYCLKTi (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 12 Mar 2008 06:19:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751422AbYCLKTi
	(ORCPT <rfc822;git-outgoing>); Wed, 12 Mar 2008 06:19:38 -0400
Received: from ptb-relay01.plus.net ([212.159.14.212]:55433 "EHLO
	ptb-relay01.plus.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751391AbYCLKTi (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 12 Mar 2008 06:19:38 -0400
Received: from [212.159.69.125] (helo=hashpling.plus.com)
	 by ptb-relay01.plus.net with esmtp (Exim) id 1JZO3N-0006kb-Tq; Wed, 12 Mar 2008 10:19:22 +0000
Received: from fermat.hashpling.org (fermat.hashpling.org [127.0.0.1])
	by hashpling.plus.com (8.13.8/8.13.6) with ESMTP id m2CAJFZp006386;
	Wed, 12 Mar 2008 10:19:15 GMT
Received: (from charles@localhost)
	by fermat.hashpling.org (8.13.8/8.13.6/Submit) id m2CAJCAw006385;
	Wed, 12 Mar 2008 10:19:12 GMT
Content-Disposition: inline
In-Reply-To: <7vr6eg7bn3.fsf_-_@gitster.siamese.dyndns.org>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-Plusnet-Relay: 4820e7f9e3aa31841f69b3bb8bf7f587
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/76941>

On Tue, Mar 11, 2008 at 10:29:52PM -0700, Junio C Hamano wrote:
> To prepare msg files for Tcl scripts, the command that is set to MSGFMT
> make variable needs to be able to grok "--tcl -l <lang> -d <here>" options
> correctly.  This patch simplifies the tests done in git-gui's Makefile to
> directly test this condition.  If the test run does not exit properly with
> zero status (either because you do not have "msgfmt" itself, or your
> "msgfmt" is too old to grok --tcl option --- the reason does not matter),
> have it fall back to po/po2msg.sh
> 
> Signed-off-by: Junio C Hamano <gitster@pobox.com>

Tested-by: Charles Bailey <charles@hashpling.org>

This looks good to me on Mac OS X 10.5.2, would anyone like me to
prepare a patch for gitk as without it we still need to manually
specifiy NO_MSGFMT to the top level git make in any case?

Charles.
