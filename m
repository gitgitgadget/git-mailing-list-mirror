From: Junio C Hamano <gitster@pobox.com>
Subject: Re: 0 bot for Git
Date: Sat, 16 Apr 2016 11:02:22 -0700
Message-ID: <xmqq60vh77pt.fsf@gitster.mtv.corp.google.com>
References: <CAGZ79kYWGFN1W0_y72-V6M3n4WLgtLPzs22bWgs1ObCCDt5BfQ@mail.gmail.com>
	<CAGZ79kZOx8ehAB-=Frjgde2CDo_vwoVzQNizJinf4LLXek5PSQ@mail.gmail.com>
	<vpq60vnl28b.fsf@anie.imag.fr>
	<CAGZ79kaLQWVdehMu4nas6UBpCxnAB_-p=xPGH=aueMZXkGK_2Q@mail.gmail.com>
	<vpqoa9ea7vx.fsf@anie.imag.fr>
	<xmqqmvoypn7g.fsf@gitster.mtv.corp.google.com>
	<88CF8CB5-4105-4D0C-8064-D66092169111@gmail.com>
	<xmqqa8kxlbix.fsf@gitster.mtv.corp.google.com>
	<BF9D5A7E-CB73-4F82-8D5F-42E120D07A3B@gmail.com>
	<CAGZ79ka4WmT8NjD-04WqwczuCuJZcoKMyDRQKkRH1sT5xoqRhQ@mail.gmail.com>
	<DB5772D2-89D4-4D14-8FD1-4AF6DDFD77AC@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: Stefan Beller <sbeller@google.com>,
	Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>, lkp@intel.com,
	Greg KH <gregkh@linuxfoundation.org>,
	"git\@vger.kernel.org" <git@vger.kernel.org>
To: Lars Schneider <larsxschneider@gmail.com>
X-From: git-owner@vger.kernel.org Sat Apr 16 20:02:53 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1arUYU-00038A-Os
	for gcvg-git-2@plane.gmane.org; Sat, 16 Apr 2016 20:02:51 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751482AbcDPSC1 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 16 Apr 2016 14:02:27 -0400
Received: from pb-smtp1.pobox.com ([64.147.108.70]:55675 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1751446AbcDPSC0 (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 16 Apr 2016 14:02:26 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 919EE123B5;
	Sat, 16 Apr 2016 14:02:24 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=EInHsvRg3TWZh51BZgdh9f1xUb0=; b=DS5yfj
	x/csIA9ihy2wi0szarNKPdkAxgzsQNiSuZ2agy51fAVC0u+Dps4luWwaWB/8sCpe
	0Pz+cxXP6MHM2lYSFHOAymjUJzEX77HZT363gJG8qiP/dIGHRT1aIvXZ4nSD9Ned
	Z/I6m/OjBYzoZx2PDra+Br6M2oZk7aefkVU5Q=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=QVaMOXH5yKojRgyt/zAAuVsQn0lW5YHQ
	zjE7O6tjIhVoLwCF4Pjmf6KVbUySest0rrVGD8pup8IrVfFCZzAq/mXPXL7rXpmd
	GmJjum9x3AW2e73U8iAHSJ/DBUr8c5uJFESHr4iQb7127G4qd8FA+iJt6bQ+x+ej
	P0XBPHVwjxk=
Received: from pb-smtp1. (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 8934D123B4;
	Sat, 16 Apr 2016 14:02:24 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp1.pobox.com (Postfix) with ESMTPSA id F197E123B3;
	Sat, 16 Apr 2016 14:02:23 -0400 (EDT)
In-Reply-To: <DB5772D2-89D4-4D14-8FD1-4AF6DDFD77AC@gmail.com> (Lars
	Schneider's message of "Sat, 16 Apr 2016 17:51:11 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: 5F30B13A-03FD-11E6-A0BA-9A9645017442-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/291732>

Lars Schneider <larsxschneider@gmail.com> writes:

>> Also this would incur wait time on Junios side
>> 
>> 1) collect patches (many series over the day)
>> 2) push
>> 3) wait
>> 4) do the merges
> He could do the merges as he does them today but after some time
> he (and the contributor of a patch) would know if a certain patch
> brakes pu.

Read what you wrote again and realize that your step 1. does not
require any expertise or taste from the person who does so.  Anybody
could do it, in other words.  Instead of demanding me to do more of
mindless chore, why don't you try doing that yourself with your fork
at GitHub?

I suspect you haven't read my response $gmane/291469 to your message
yet, but "as he does them today" would mean _all_ of the following
has to happen during phase 1) above:

 - Look at the patch and see if it is even remotely interesting;

 - See what maintenance track it should apply to by comparing its
   context and check availability of features post-image wants to
   use in the mantenance tracks;
 
 - Fork a topic and apply, and inspect the result with larger -U
   value (or log -p -W);
 
 - Run tests on the topic.

 - Try merging it to the eventual target track (e.g. 'maint-2.7'),
   'master', 'next' and 'pu' (note that this is not "one of these",
   but "all of these"), and build the result (and optionally test).
   Then discard these trial merges.

Two things you seem to be missing are:

 * I do not pick up patches from the list with the objective of
   queuing them in 'pu'.  I instead look for and process topics that
   could go to 'next', or that I want to see in 'next' eventually
   with fixes.  Queing leftover bits in 'pu' as "not ready for
   'next'" is done only because I saw promises in them (and that
   determination requires time from me), and did not fail in earlier
   steps before they even gain a topic branch in my tree (otherwise
   I wouldn't be able to keep up with the traffic).

 * The last step, trial merges, is often a very good method to see
   potential problems and unintended interactions with other topics.
   A fix we would want to see in older maintenance tracks may depend
   on too new a feature we added recently, etc.

Also see $gmane/291469
