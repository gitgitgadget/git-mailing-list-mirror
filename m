From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] builtin-config: add --exec-editor for use in scripts
Date: Mon, 02 Feb 2009 22:30:58 -0800
Message-ID: <7vocxkdobh.fsf@gitster.siamese.dyndns.org>
References: <20090201025349.GA22160@dcvr.yhbt.net>
 <7v4ozdo7yt.fsf@gitster.siamese.dyndns.org>
 <m3pri1w484.fsf@localhost.localdomain> <20090203045520.GB2483@dcvr.yhbt.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Jakub Narebski <jnareb@gmail.com>, git@vger.kernel.org
To: Eric Wong <normalperson@yhbt.net>
X-From: git-owner@vger.kernel.org Tue Feb 03 07:32:33 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LUEpk-0003e6-Fq
	for gcvg-git-2@gmane.org; Tue, 03 Feb 2009 07:32:32 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751599AbZBCGbJ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 3 Feb 2009 01:31:09 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751501AbZBCGbH
	(ORCPT <rfc822;git-outgoing>); Tue, 3 Feb 2009 01:31:07 -0500
Received: from a-sasl-fastnet.sasl.smtp.pobox.com ([207.106.133.19]:55849 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751495AbZBCGbG (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 3 Feb 2009 01:31:06 -0500
Received: from localhost.localdomain (unknown [127.0.0.1])
	by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with ESMTP id 0E92A96A00;
	Tue,  3 Feb 2009 01:31:05 -0500 (EST)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES256-SHA (256/256 bits)) (No client certificate requested) by
 a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with ESMTPSA id BA317969FF; Tue,
  3 Feb 2009 01:31:00 -0500 (EST)
In-Reply-To: <20090203045520.GB2483@dcvr.yhbt.net> (Eric Wong's message of
 "Mon, 2 Feb 2009 20:55:20 -0800")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
X-Pobox-Relay-ID: 3BCC254A-F1BC-11DD-8985-8B21C92D7133-77302942!a-sasl-fastnet.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/108153>

Eric Wong <normalperson@yhbt.net> writes:

> Perhaps a new command called 'git exec-helper' ?
>
> git exec-helper pager
> git exec-helper editor <FILE>
> ...
> git exec-helper sendmail ?
> git exec-helper browser <URL> ?

"git sensible editor" ;-)
