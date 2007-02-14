From: Bill Lear <rael@zopyra.com>
Subject: Re: Newbie experience with push over ssh
Date: Wed, 14 Feb 2007 10:25:05 -0600
Message-ID: <17875.14305.910866.273778@lisa.zopyra.com>
References: <vpq64a4bzp1.fsf@olympe.imag.fr>
	<20070214142731.GA1478@moooo.ath.cx>
	<45D33485.5020906@webdrake.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Joseph Wakeling <joseph.wakeling@webdrake.net>
X-From: git-owner@vger.kernel.org Wed Feb 14 17:25:27 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HHMwc-0001qW-To
	for gcvg-git@gmane.org; Wed, 14 Feb 2007 17:25:23 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932363AbXBNQZT (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 14 Feb 2007 11:25:19 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932361AbXBNQZT
	(ORCPT <rfc822;git-outgoing>); Wed, 14 Feb 2007 11:25:19 -0500
Received: from mail.zopyra.com ([65.68.225.25]:61231 "EHLO zopyra.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932363AbXBNQZR (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 14 Feb 2007 11:25:17 -0500
Received: (from rael@localhost)
	by zopyra.com (8.11.6/8.11.6) id l1EGPBP26774;
	Wed, 14 Feb 2007 10:25:11 -0600
In-Reply-To: <45D33485.5020906@webdrake.net>
X-Mailer: VM 7.18 under Emacs 21.1.1
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/39667>

On Wednesday, February 14, 2007 at 16:10:45 (+0000) Joseph Wakeling writes:
>Matthias Lederhofer wrote:
>> I don't think there is any way to 'clone to remote'.  You'd have to
>> ssh to the other machine and clone from there, or you can just create
>> an empty repository on the remote host and push the stuff into it.
>
>I remember coming across the same issue as Matthieu and never got round
>to solving it.  In my case the desire is to upload the code onto a
>remote machine---in particular a cluster where I run simulations.  I
>don't particularly need that remote code to be in a repo or otherwise,
>since it's only there to be run, not edited.
>
>As far as I know I have no way of installing git on that machine.
>Perhaps I could install it locally but I suspect the sysadmin would not
>be supportive.
>
>So, is there a way of using git to upload my code to a machine without a
>repo ready-prepared?

If you must ...

% cat ~/.gitconfig
[alias]
	scp !scp
	rcp !rcp
% git scp -rp . me@remotehost:/directory


Bill
