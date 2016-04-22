From: Junio C Hamano <gitster@pobox.com>
Subject: Re: 0 bot for Git
Date: Fri, 22 Apr 2016 10:30:24 -0700
Message-ID: <xmqqr3dxpn4f.fsf@gitster.mtv.corp.google.com>
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
	<xmqq60vh77pt.fsf@gitster.mtv.corp.google.com>
	<7F130640-40F1-454F-BC00-ACC5364404B8@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: Stefan Beller <sbeller@google.com>,
	Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>, lkp@intel.com,
	Greg KH <gregkh@linuxfoundation.org>,
	"git\@vger.kernel.org" <git@vger.kernel.org>
To: Lars Schneider <larsxschneider@gmail.com>
X-From: git-owner@vger.kernel.org Fri Apr 22 19:30:35 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ateuX-0000uF-6e
	for gcvg-git-2@plane.gmane.org; Fri, 22 Apr 2016 19:30:33 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932145AbcDVRa2 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 22 Apr 2016 13:30:28 -0400
Received: from pb-smtp2.pobox.com ([64.147.108.71]:54367 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1754478AbcDVRa1 (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 22 Apr 2016 13:30:27 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp2.pobox.com (Postfix) with ESMTP id 5DE6212ADE;
	Fri, 22 Apr 2016 13:30:26 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=syKO6oujTrY5HTnSNC6djsotsVU=; b=KZjaTP
	L5L0QcLqam9kQWiRcC8MUP4fw/9HnFGPb4TqAWxoWC/oc8WDZT9svZ95mpEqnlnS
	94hISfDpzDLgO33/e7vG8GvukaWQdKfp9nGN1pS15LqfP64DwN0BgGGpfocpJT8t
	zfNrU/zE4vHCftTLjXLSEVCosVCDN62AjIilM=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=pIH1CWZeDIVMH7VR71WaicBVNCZdtLEb
	65MK7SmczMQXxCvvW3gBlTAc9ORyc3r8+xamuWME8tsJIiblxRW+13iP/DYWGJLo
	EAHuq5a4dSyBKlIxZmV6n1lA7RK9U09ZU5YCePLzLT2C+8P7JY1iKXESpxjVUY5Z
	77dVYx4IbME=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
	by pb-smtp2.pobox.com (Postfix) with ESMTP id 53C5712ADD;
	Fri, 22 Apr 2016 13:30:26 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp2.pobox.com (Postfix) with ESMTPSA id B41E012ADC;
	Fri, 22 Apr 2016 13:30:25 -0400 (EDT)
In-Reply-To: <7F130640-40F1-454F-BC00-ACC5364404B8@gmail.com> (Lars
	Schneider's message of "Fri, 22 Apr 2016 10:19:21 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: E657078E-08AF-11E6-9E38-D05A70183E34-77302942!pb-smtp2.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/292234>

Lars Schneider <larsxschneider@gmail.com> writes:

> Thanks for the explanation. My intention was not to be offensive.
> I was curious about your workflow and I was wondering if the
> Travis CI integration could be useful for you in any way.

Don't worry; I didn't feel offended.  The Travis stuff running on
the branches at http://github.com/git/git would surely catch issues
on MacOSX and/or around git-p4 (neither of which I test myself when
merging to 'pu') before they hit 'next', and that is already helping
us greatly.

And if volunteers or bots pick up in-flight patches that have not
hit 'pu' and feed them to Travis through their repositories, that
would also help the project, so your work on hooking up our source
tree with Travis is greatly appreciated.

It was just that Travis running on broken-down topic branches that
appear in http://github.com/gitster/git would not help my workflow,
which was the main point of illustrating the way how these branches
work.

Thanks.


  
