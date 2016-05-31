From: Christian Neukirchen <chneukirchen@gmail.com>
Subject: Re: git add without whitespace
Date: Tue, 31 May 2016 17:59:45 +0200
Message-ID: <87pos2tdzi.fsf@gmail.com>
References: <CAHd499Agn=vLBxDpHi2dy1HMy-_58PZGs7VNtFJnBfP5zXatTA@mail.gmail.com>
	<xmqqlh2r8ixu.fsf@gitster.mtv.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue May 31 18:00:07 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1b7m5K-0007gx-Kz
	for gcvg-git-2@plane.gmane.org; Tue, 31 May 2016 18:00:03 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751288AbcEaP76 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 31 May 2016 11:59:58 -0400
Received: from plane.gmane.org ([80.91.229.3]:46137 "EHLO plane.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750744AbcEaP74 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 31 May 2016 11:59:56 -0400
Received: from list by plane.gmane.org with local (Exim 4.69)
	(envelope-from <gcvg-git-2@m.gmane.org>)
	id 1b7m5A-0007bP-Hs
	for git@vger.kernel.org; Tue, 31 May 2016 17:59:52 +0200
Received: from host120-2.natpool.mwn.de ([138.246.2.120])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Tue, 31 May 2016 17:59:52 +0200
Received: from chneukirchen by host120-2.natpool.mwn.de with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Tue, 31 May 2016 17:59:52 +0200
X-Injected-Via-Gmane: http://gmane.org/
X-Complaints-To: usenet@ger.gmane.org
X-Gmane-NNTP-Posting-Host: host120-2.natpool.mwn.de
In-Reply-To: <xmqqlh2r8ixu.fsf@gitster.mtv.corp.google.com> (Junio C. Hamano's
	message of "Mon, 30 May 2016 12:06:05 -0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.5 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/295991>

Junio C Hamano <gitster@pobox.com> writes:

> Robert Dailey <rcdailey.lists@gmail.com> writes:
>
>> $ git diff -U0 -w --no-color | git apply --cached --ignore-whitespace
>> --unidiff-zero
>>
>> This command explicitly leaves out context because it can sometimes
>> cause the patch to fail to apply, I think due to whitespace being in
>> it, but I'm not completely sure myself.
>
> I have had this in my ~/.gitconfig for a long time.
>
> [alias]
> 	wsadd = "!sh -c 'git diff -- \"$@\" | git apply --cached --whitespace=fix;\
> 		git co -- ${1-.} \"$@\"' -"

Very useful, thanks for sharing!

I wonder which other gems are in your .gitconfig, is it public?

-- 
Christian Neukirchen  <chneukirchen@gmail.com>  http://chneukirchen.org
