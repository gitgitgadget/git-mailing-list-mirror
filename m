From: Johannes Sixt <j.sixt@viscovery.net>
Subject: Re: RFE: support change-id generation natively
Date: Fri, 25 Oct 2013 08:37:28 +0200
Message-ID: <526A11A8.90200@viscovery.net>
References: <2127507934.9293293.1382367063640.JavaMail.root@openwide.fr>	<201310212029.01589.thomas@koch.ro>	<1382380858.25852.36711509.53CF173C@webmail.messagingengine.com>	<201310211249.49568.mfick@codeaurora.org>	<xmqqy55lrsoo.fsf@gitster.dls.corp.google.com>	<CACsJy8A7r-gsbru0eLxtJbFk2vgqvBH9akHn6e53k=UJbZ1K7Q@mail.gmail.com>	<xmqqzjq0q8nl.fsf@gitster.dls.corp.google.com>	<CACsJy8CuEvdTu+P-P-kYC0dKQKnjh5sRoevd_hsbqF0796i0xw@mail.gmail.com>	<8D1AF6D7-F7AA-4E64-B6B3-3C8C931312C3@codeaurora.org>	<CACsJy8BoqWMqGPM8JDny6mxkxZzhWrQ6RYZiNK=vzdwXL4a=vQ@mail.gmail.com>	<5268B7D6.5050106@viscovery.net> <xmqqzjpymo4y.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: Duy Nguyen <pclouds@gmail.com>,
	Nasser Grainawi <nasser@codeaurora.org>,
	Martin Fick <mfick@codeaurora.org>, james.moger@gitblit.com,
	Thomas Koch <thomas@koch.ro>,
	Jeremy Rosen <jeremy.rosen@openwide.fr>,
	Git Mailing List <git@vger.kernel.org>,
	Shawn Pearce <spearce@spearce.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri Oct 25 08:37:43 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VZb1i-0008Ut-O5
	for gcvg-git-2@plane.gmane.org; Fri, 25 Oct 2013 08:37:43 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751913Ab3JYGhi (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 25 Oct 2013 02:37:38 -0400
Received: from so.liwest.at ([212.33.55.16]:48121 "EHLO so.liwest.at"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751261Ab3JYGhh (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 25 Oct 2013 02:37:37 -0400
Received: from [81.10.228.254] (helo=theia.linz.viscovery)
	by so.liwest.at with esmtpa (Exim 4.80.1)
	(envelope-from <j.sixt@viscovery.net>)
	id 1VZb1U-0002Tn-VM; Fri, 25 Oct 2013 08:37:29 +0200
Received: from [192.168.1.95] (J6T.linz.viscovery [192.168.1.95])
	by theia.linz.viscovery (Postfix) with ESMTP id 9A11A16613;
	Fri, 25 Oct 2013 08:37:28 +0200 (CEST)
User-Agent: Mozilla/5.0 (Windows NT 5.1; rv:24.0) Gecko/20100101 Thunderbird/24.0.1
In-Reply-To: <xmqqzjpymo4y.fsf@gitster.dls.corp.google.com>
X-Enigmail-Version: 1.5.2
X-Spam-Score: -1.0 (-)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/236683>

Am 10/24/2013 22:04, schrieb Junio C Hamano:
> Johannes Sixt <j.sixt@viscovery.net> writes:
>> That said, I don't think that --change-id option that the user must not
>> forget to use is any better than a hook that the user must not forget to
>> install.
> 
> That is why I said this in my first response to this thread:
> 
>>> ...  We may even want to
>>> introduce commit.changeId boolean configuration variable if we did
>>> so.

That's only slightly different and still "must not forget to set".

But I am more concerned that a non-volatile change-id is totally outside
the Git data model. After we have git commit --change-id, what will be the
next requests for enhancement? 'git merge' and 'git cherry-pick' take a
change-id? Where will it end?

We could ship a git-gerrit-commit wrapper script in contrib that adds the
change-id and that people can alias their 'git ci' to globally or on a
per-repo basis.

-- Hannes
