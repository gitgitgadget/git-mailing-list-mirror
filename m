From: Junio C Hamano <gitster@pobox.com>
Subject: Re: GIT BUG? GIT occasionally redownloads its entire data set
Date: Mon, 23 Mar 2009 23:02:38 -0700
Message-ID: <7vmybb4fwh.fsf@gitster.siamese.dyndns.org>
References: <28707.1237855543@redhat.com>
 <7vskl34qc9.fsf@gitster.siamese.dyndns.org>
 <37fcd2780903231953pdfaa679r8a680f64ee692c8d@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: David Howells <dhowells@redhat.com>, git@vger.kernel.org,
	Daniel Barkalow <barkalow@iabervon.org>,
	"Shawn O. Pearce" <spearce@spearce.org>
To: Dmitry Potapov <dpotapov@gmail.com>
X-From: git-owner@vger.kernel.org Tue Mar 24 07:08:05 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Llznw-0007Je-Rn
	for gcvg-git-2@gmane.org; Tue, 24 Mar 2009 07:08:05 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752724AbZCXGCv (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 24 Mar 2009 02:02:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752495AbZCXGCv
	(ORCPT <rfc822;git-outgoing>); Tue, 24 Mar 2009 02:02:51 -0400
Received: from a-sasl-fastnet.sasl.smtp.pobox.com ([207.106.133.19]:38788 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751876AbZCXGCu (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 24 Mar 2009 02:02:50 -0400
Received: from localhost.localdomain (unknown [127.0.0.1])
	by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with ESMTP id 9E3A7A44E7;
	Tue, 24 Mar 2009 02:02:47 -0400 (EDT)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with ESMTPSA id C5584A44E6; Tue,
 24 Mar 2009 02:02:40 -0400 (EDT)
In-Reply-To: <37fcd2780903231953pdfaa679r8a680f64ee692c8d@mail.gmail.com>
 (Dmitry Potapov's message of "Tue, 24 Mar 2009 05:53:26 +0300")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
X-Pobox-Relay-ID: 664CA9C2-1839-11DE-8A89-32B0EBB1AA3C-77302942!a-sasl-fastnet.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/114402>

Dmitry Potapov <dpotapov@gmail.com> writes:

> On Tue, Mar 24, 2009 at 5:17 AM, Junio C Hamano <gitster@pobox.com> wrote:
>>
>> Rings a bell, anybody?
>
> Maybe this:
> http://article.gmane.org/gmane.comp.version-control.git/75201
>
> It was fixed in Git 1.5.5 if I am not mistaken.

Thanks.  Distributed memory works very well ;-)
