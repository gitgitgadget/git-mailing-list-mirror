From: Junio C Hamano <gitster@pobox.com>
Subject: Re: "git clone --depth <depth>" producing history with <depth + 1>
 commits?
Date: Wed, 01 Apr 2009 19:33:08 -0700
Message-ID: <7veiwbokd7.fsf@gitster.siamese.dyndns.org>
References: <49CBB490.8040908@hartwork.org> <49D3C300.1040303@hartwork.org>
 <alpine.DEB.1.00.0904020303320.10279@pacific.mpi-cbg.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Sebastian Pipping <webmaster@hartwork.org>, git@vger.kernel.org
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Thu Apr 02 04:34:55 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LpClX-0004sT-6g
	for gcvg-git-2@gmane.org; Thu, 02 Apr 2009 04:34:51 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752870AbZDBCdT (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 1 Apr 2009 22:33:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752152AbZDBCdS
	(ORCPT <rfc822;git-outgoing>); Wed, 1 Apr 2009 22:33:18 -0400
Received: from a-sasl-fastnet.sasl.smtp.pobox.com ([207.106.133.19]:44563 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750913AbZDBCdS (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 1 Apr 2009 22:33:18 -0400
Received: from localhost.localdomain (unknown [127.0.0.1])
	by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with ESMTP id 72A7CA7B43;
	Wed,  1 Apr 2009 22:33:15 -0400 (EDT)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with ESMTPSA id C46D1A7B3E; Wed,
  1 Apr 2009 22:33:10 -0400 (EDT)
In-Reply-To: <alpine.DEB.1.00.0904020303320.10279@pacific.mpi-cbg.de>
 (Johannes Schindelin's message of "Thu, 2 Apr 2009 03:04:58 +0200 (CEST)")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
X-Pobox-Relay-ID: 9E6AB87A-1F2E-11DE-891D-32B0EBB1AA3C-77302942!a-sasl-fastnet.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/115432>

Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:

> On Wed, 1 Apr 2009, Sebastian Pipping wrote:
>
>> Sebastian Pipping wrote:
>> > Is "git clone --depth 1 <ropository>" expected to give a history
>> > with 2 commits?  "--depth 2" gives 3 commits, "--depth 0" all.
>> > 
>> > Is that by design or a bug?
>> 
>> Anyone?  Is "git clone --depth 1 <ropository>" really supposed to 
>> produce a history holding _two_ commits?  Why so?
>
> Because storing _no_ commit (according to you, that should happen with 
> --depth=0) would make no sense?

But then you can error out upon such a request.

> After all, if you want to clone, you want to clone at least _something_.

I am a bit puzzled by your logic.  If one is requested, shouldn't you give
only one and not two?
