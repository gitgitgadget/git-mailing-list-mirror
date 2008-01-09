From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] Add [HOWTO] using merge subtree.
Date: Tue, 08 Jan 2008 22:28:16 -0800
Message-ID: <7v8x2zpl6n.fsf@gitster.siamese.dyndns.org>
References: <1199838182-15178-1-git-send-email-vmiklos@frugalware.org>
	<7vwsqjpyqi.fsf@gitster.siamese.dyndns.org>
	<7vfxx7psoq.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Sean <seanlkml@sympatico.ca>, git@vger.kernel.org
To: Miklos Vajna <vmiklos@frugalware.org>
X-From: git-owner@vger.kernel.org Wed Jan 09 07:29:01 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JCUQu-00042K-UI
	for gcvg-git-2@gmane.org; Wed, 09 Jan 2008 07:29:01 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751364AbYAIG2d (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 9 Jan 2008 01:28:33 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751174AbYAIG2d
	(ORCPT <rfc822;git-outgoing>); Wed, 9 Jan 2008 01:28:33 -0500
Received: from a-sasl-quonix.sasl.smtp.pobox.com ([208.72.237.25]:48935 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751149AbYAIG2c (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 9 Jan 2008 01:28:32 -0500
Received: from a-sasl-quonix (localhost [127.0.0.1])
	by a-sasl-quonix.pobox.com (Postfix) with ESMTP id BBC4B2CF0;
	Wed,  9 Jan 2008 01:28:30 -0500 (EST)
Received: from pobox.com (ip68-225-240-77.oc.oc.cox.net [68.225.240.77])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by a-sasl-quonix.pobox.com (Postfix) with ESMTP id 67F772CEF;
	Wed,  9 Jan 2008 01:28:22 -0500 (EST)
In-Reply-To: <7vfxx7psoq.fsf@gitster.siamese.dyndns.org> (Junio C. Hamano's
	message of "Tue, 08 Jan 2008 19:46:13 -0800")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/69956>

Junio C Hamano <gitster@pobox.com> writes:

> * http://thread.gmane.org/gmane.comp.version-control.git/39443
>
> This was the explanation on the way how the initial git-gui
> subtree merge was created.

For the record, the very first cross-project merge is:

    http://thread.gmane.org/gmane.comp.version-control.git/5126

The procedure to maintain the resulting re-merge of two
histories do not involve subtree merge because "The coolest
merge ever" merges non-overlapping two trees at the same level,
but the principle used to bootstrap the process is the same.
You prepare a tree that is a overlay of the tips of your two
projects, and record that tree in a commit that is a merge
between two parents.
