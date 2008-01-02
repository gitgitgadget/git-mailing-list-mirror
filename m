From: Junio C Hamano <gitster@pobox.com>
Subject: Re: Trouble generating info documentation
Date: Wed, 02 Jan 2008 10:59:37 -0800
Message-ID: <7vsl1gvysm.fsf@gitster.siamese.dyndns.org>
References: <86myrol7xf.fsf@lola.quinscape.zz>
	<20080102170556.GD29972@genesis.frugalware.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: David Kastrup <dak@gnu.org>, git@vger.kernel.org
To: Miklos Vajna <vmiklos@frugalware.org>
X-From: git-owner@vger.kernel.org Wed Jan 02 20:00:52 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JA8pa-0008CA-9z
	for gcvg-git-2@gmane.org; Wed, 02 Jan 2008 20:00:46 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756748AbYABS7r (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 2 Jan 2008 13:59:47 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756736AbYABS7r
	(ORCPT <rfc822;git-outgoing>); Wed, 2 Jan 2008 13:59:47 -0500
Received: from a-sasl-quonix.sasl.smtp.pobox.com ([208.72.237.25]:48723 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752726AbYABS7q (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 2 Jan 2008 13:59:46 -0500
Received: from a-sasl-quonix (localhost [127.0.0.1])
	by a-sasl-quonix.pobox.com (Postfix) with ESMTP id F1EFB437A;
	Wed,  2 Jan 2008 13:59:44 -0500 (EST)
Received: from pobox.com (ip68-225-240-77.oc.oc.cox.net [68.225.240.77])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by a-sasl-quonix.pobox.com (Postfix) with ESMTP id 23C644379;
	Wed,  2 Jan 2008 13:59:40 -0500 (EST)
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/69484>

Miklos Vajna <vmiklos@frugalware.org> writes:

> On Wed, Jan 02, 2008 at 01:37:48PM +0100, David Kastrup <dak@gnu.org> wrote:
>> in my version of docbook2x, the --to-stdout option is broken and
>> requires the following patch:
>
> according to the INSTALL file, you need docbook2X 0.8.3. the latest
> stable 0.8.8 doesn't work here either.

Yuck.  Also docbook2x seems to be available even much less
widely than other tools we use for documentation, which is
double yuck.

For now the "info" pages need to stay as a second class citizen,
it appears.
