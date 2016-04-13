From: Junio C Hamano <gitster@pobox.com>
Subject: Re: 0 bot for Git
Date: Wed, 13 Apr 2016 10:47:17 -0700
Message-ID: <xmqqzisxjt96.fsf@gitster.mtv.corp.google.com>
References: <CAGZ79kYWGFN1W0_y72-V6M3n4WLgtLPzs22bWgs1ObCCDt5BfQ@mail.gmail.com>
	<CAGZ79kZOx8ehAB-=Frjgde2CDo_vwoVzQNizJinf4LLXek5PSQ@mail.gmail.com>
	<vpq60vnl28b.fsf@anie.imag.fr>
	<CAGZ79kaLQWVdehMu4nas6UBpCxnAB_-p=xPGH=aueMZXkGK_2Q@mail.gmail.com>
	<vpqoa9ea7vx.fsf@anie.imag.fr>
	<xmqqmvoypn7g.fsf@gitster.mtv.corp.google.com>
	<88CF8CB5-4105-4D0C-8064-D66092169111@gmail.com>
	<xmqqa8kxlbix.fsf@gitster.mtv.corp.google.com>
	<BF9D5A7E-CB73-4F82-8D5F-42E120D07A3B@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>,
	Stefan Beller <sbeller@google.com>, lkp@intel.com,
	Greg KH <gregkh@linuxfoundation.org>,
	"git\@vger.kernel.org" <git@vger.kernel.org>
To: Lars Schneider <larsxschneider@gmail.com>
X-From: git-owner@vger.kernel.org Wed Apr 13 19:47:25 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aqOsu-0000Ma-GL
	for gcvg-git-2@plane.gmane.org; Wed, 13 Apr 2016 19:47:24 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754500AbcDMRrV (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 13 Apr 2016 13:47:21 -0400
Received: from pb-smtp2.pobox.com ([64.147.108.71]:60964 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1754437AbcDMRrU (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 13 Apr 2016 13:47:20 -0400
X-Greylist: delayed 460 seconds by postgrey-1.27 at vger.kernel.org; Wed, 13 Apr 2016 13:47:20 EDT
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp2.pobox.com (Postfix) with ESMTP id D684010948;
	Wed, 13 Apr 2016 13:47:18 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=/qpQz4Zvyyk8Fhw1TnC/RrB9pgE=; b=rusSNV
	ktbEfB/YQHvvnJM5RPYmFZwVrFZGV0iVuS1tOpMX2q7mDQ/Y1Im7HQwSrP++NkiA
	N7UP85ha8sflQ+czqysTTZ6VDENTGth0cfvfsUKhbfQhwLSTJkIKzuO3KjenDv6N
	zJ5nQ9U9R26L+M1B0+cAIi4I51S4MqrAgQP5I=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=LjNBAELoBLYhUEFBltBAB1dgn4yq2WEO
	Ts3Zim3LBFK201/XZlg+qj+La8ao3DqE1wF1+0Dm5bUQ5CyvA3Pg7jMGHS/tPDCu
	2ehSjTxpABYhqAhfufcfy0cVlIxWzWf4BCLDdZ0MTn2AFHPaxJFFvfK/xIEy2wov
	7Fez0nJ1jLA=
Received: from pb-smtp2. (unknown [127.0.0.1])
	by pb-smtp2.pobox.com (Postfix) with ESMTP id CEDA010947;
	Wed, 13 Apr 2016 13:47:18 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 2BE8310946;
	Wed, 13 Apr 2016 13:47:18 -0400 (EDT)
In-Reply-To: <BF9D5A7E-CB73-4F82-8D5F-42E120D07A3B@gmail.com> (Lars
	Schneider's message of "Wed, 13 Apr 2016 19:09:41 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: C4151038-019F-11E6-996E-D05A70183E34-77302942!pb-smtp2.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/291469>

Lars Schneider <larsxschneider@gmail.com> writes:

> I am not sure what you mean by "fail to hit 'pu'". Maybe we talk at
> cross purposes. Here is what I think you do, please correct me:
>
> 1.) You pick the topics from the mailing list and create feature 
>     branches for each one of them. E.g. one of my recent topics 
>     is "ls/config-origin".

I do not do this step blindly.  The patch is studied in MUA, perhaps
applied to a new topic to view it in wider context, and tested in
isolation at this step.  In any of these steps, I may decide it is
way too premature for 'pu' and discard it.
