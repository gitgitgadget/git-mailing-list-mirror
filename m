From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH RFC3 INTRO] I hope this will do it!
Date: Tue, 14 Apr 2009 11:47:11 -0700
Message-ID: <7vd4bf3weo.fsf@gitster.siamese.dyndns.org>
References: <1239647037-15381-1-git-send-email-mfwitten@gmail.com>
 <7vy6u36215.fsf@gitster.siamese.dyndns.org>
 <b4087cc50904140926o4bb48c1bs66946078bb3cd2f9@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Michael Witten <mfwitten@gmail.com>
X-From: git-owner@vger.kernel.org Tue Apr 14 20:49:04 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Ltngs-0001MT-B4
	for gcvg-git-2@gmane.org; Tue, 14 Apr 2009 20:49:02 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755640AbZDNSrV (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 14 Apr 2009 14:47:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753963AbZDNSrU
	(ORCPT <rfc822;git-outgoing>); Tue, 14 Apr 2009 14:47:20 -0400
Received: from a-sasl-fastnet.sasl.smtp.pobox.com ([207.106.133.19]:53976 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753544AbZDNSrT (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 14 Apr 2009 14:47:19 -0400
Received: from localhost.localdomain (unknown [127.0.0.1])
	by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with ESMTP id EE948AADC1;
	Tue, 14 Apr 2009 14:47:16 -0400 (EDT)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with ESMTPSA id BAAC7AADBF; Tue,
 14 Apr 2009 14:47:13 -0400 (EDT)
In-Reply-To: <b4087cc50904140926o4bb48c1bs66946078bb3cd2f9@mail.gmail.com>
 (Michael Witten's message of "Tue, 14 Apr 2009 11:26:14 -0500")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
X-Pobox-Relay-ID: AD38EA3E-2924-11DE-A9B7-C121C5FC92D5-77302942!a-sasl-fastnet.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/116554>

Michael Witten <mfwitten@gmail.com> writes:

> On Tue, Apr 14, 2009 at 04:02, Junio C Hamano <gitster@pobox.com> wrote:
>>
>> It is unfortunate that the interesting ones begin at 10th in the series,
>> which are beind the 9th one that is a "churn in the middle".
>
> (http://marc.info/?l=git&m=123959564630157&w=2):
>> The general rule of thumb is to do such a clean-up before you start to work on something of substance.
>
> (http://marc.info/?l=git&m=123914648915106&w=2):
>> a good rule of thumb when preparing a series is to have this kind of obvious clean-up first, leaving enhancement patches later in the series.
>
> I guess, then, this whitespace patch is something of substance---an
> enhancement ;-D
>
> ... or unnecessary "code churn"... I suppose.

An obviously good and uncontroversial clean-up should come first, so that
it can be applied and meat of the change can be discussed on the cleaned
base version.

A clean-up that might be judged as a mere churn should come last, so that
enhancements and fixes can go first without waiting for the controversy to
settle.
