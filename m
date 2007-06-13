From: Bill Lear <rael@zopyra.com>
Subject: Re: pull into dirty working tree
Date: Wed, 13 Jun 2007 10:36:28 -0500
Message-ID: <18032.3836.710438.73912@lisa.zopyra.com>
References: <1HyUO6-04z4yG0@fwd28.aul.t-online.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: "MichaelTiloDressel@t-online.de" <MichaelTiloDressel@t-online.de>
X-From: git-owner@vger.kernel.org Wed Jun 13 17:36:34 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HyUtd-0007Kq-TK
	for gcvg-git@gmane.org; Wed, 13 Jun 2007 17:36:34 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757924AbXFMPgc (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 13 Jun 2007 11:36:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1758049AbXFMPgc
	(ORCPT <rfc822;git-outgoing>); Wed, 13 Jun 2007 11:36:32 -0400
Received: from mail.zopyra.com ([65.68.225.25]:61115 "EHLO zopyra.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1757804AbXFMPgb (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 13 Jun 2007 11:36:31 -0400
Received: (from rael@localhost)
	by zopyra.com (8.11.6/8.11.6) id l5DFaUi14427;
	Wed, 13 Jun 2007 10:36:30 -0500
In-Reply-To: <1HyUO6-04z4yG0@fwd28.aul.t-online.de>
X-Mailer: VM 7.18 under Emacs 21.1.1
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/50078>

On Wednesday, June 13, 2007 at 17:03:58 (+0200) MichaelTiloDressel@t-online.de writes:
>Hi,
>
>why don't they just do a simple 
>git commit -a
>of their work before pulling?

Because they are basically playing with some code and don't want to
commit it.

>That's different to cvs! Committing only affects the cloned repository.

Yup, we realize that.

>I think one of the biggest advantages of git is the concept of everyone
>working on a clone. So developers are not prevented from actually using
>revision control just because they are afraid of disturbing others. They
>don't until they e.g. push!

Right, but they just want updates to their working tree, as they could
do under CVS, without issuing five (or even one) other commands.


Bill
