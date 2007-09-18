From: Mike Hommey <mh@glandium.org>
Subject: Re: [PATCH] Drop UTF-8 characters in manual pages
Date: Tue, 18 Sep 2007 11:34:26 +0200
Organization: glandium.org
Message-ID: <20070918093426.GA9216@glandium.org>
References: <11901003792475-git-send-email-mh@glandium.org> <7vd4wgwczs.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Sep 18 11:35:38 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IXZUV-000637-39
	for gcvg-git-2@gmane.org; Tue, 18 Sep 2007 11:35:35 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756833AbXIRJf1 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 18 Sep 2007 05:35:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756725AbXIRJf1
	(ORCPT <rfc822;git-outgoing>); Tue, 18 Sep 2007 05:35:27 -0400
Received: from vawad.err.no ([85.19.200.177]:53700 "EHLO vawad.err.no"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756386AbXIRJfZ (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 18 Sep 2007 05:35:25 -0400
Received: from aputeaux-153-1-18-194.w82-124.abo.wanadoo.fr ([82.124.60.194] helo=namakemono.glandium.org)
	by vawad.err.no with esmtps (TLS-1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.62)
	(envelope-from <mh@glandium.org>)
	id 1IXZUG-0001F5-V0; Tue, 18 Sep 2007 11:35:22 +0200
Received: from mh by namakemono.glandium.org with local (Exim 4.67)
	(envelope-from <mh@glandium.org>)
	id 1IXZTO-0002QG-CY; Tue, 18 Sep 2007 11:34:26 +0200
Content-Disposition: inline
In-Reply-To: <7vd4wgwczs.fsf@gitster.siamese.dyndns.org>
X-GPG-Fingerprint: A479 A824 265C B2A5 FC54  8D1E DE4B DA2C 54FD 2A58
User-Agent: Mutt/1.5.16 (2007-06-11)
X-Spam-Status: (score 0.0): Status=No hits=0.0 required=5.0 tests=none version=3.1.4
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/58564>

On Tue, Sep 18, 2007 at 02:15:35AM -0700, Junio C Hamano <gitster@pobox.com> wrote:
> Mike Hommey <mh@glandium.org> writes:
> 
> > The default character encoding for english manual pages is ISO8859-1,
> 
> On which distro?

Debian, at least, though transition to UTF-8 manpages is going to happen
(it seems there was a lack of proper encoding handling in man-db until
very recently)

> > so
> > UTF-8 characters are just displayed as their sequence of bytes, which is
> > not very appealing.
> 
> Perhaps not.  I cannot decide what to do with
> Documentation/git-pack-redundant.txt, though.

I'd say just use a transliterated form until man-db mess is sorted out.

Mike
