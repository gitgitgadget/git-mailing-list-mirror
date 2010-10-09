From: Jens Lehmann <Jens.Lehmann@web.de>
Subject: Re: [PATCH v2 0/3] Teach fetch and pull to recursively fetch submodules
 too
Date: Sat, 09 Oct 2010 21:28:57 +0200
Message-ID: <4CB0C279.8050407@web.de>
References: <4C9351A7.7050609@web.de> <4C9359D4.2030109@viscovery.net> <4C935D77.3080008@web.de> <329A2E43-ADE3-467C-A2A6-24ACB9DF641E@sb.org> <4C953DE5.6020900@web.de> <DD3654D9-46B9-4980-9138-38FDC33A383C@sb.org> <4C963D00.9050207@web.de> <28BC3A45-D3CF-4A8C-A818-B92A9827C8FB@sb.org> <4CAB8DDF.8080004@web.de> <FB03A7DB-67D2-4EAE-A0F0-2F3E3CEA9878@sb.org> <20101006232243.GA30302@burratino>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: Kevin Ballard <kevin@sb.org>, Junio C Hamano <gitster@pobox.com>,
	Git Mailing List <git@vger.kernel.org>
To: Jonathan Nieder <jrnieder@gmail.com>
X-From: git-owner@vger.kernel.org Sat Oct 09 21:32:01 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1P4f9E-000230-Na
	for gcvg-git-2@lo.gmane.org; Sat, 09 Oct 2010 21:32:01 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1760482Ab0JITby (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 9 Oct 2010 15:31:54 -0400
Received: from fmmailgate01.web.de ([217.72.192.221]:54479 "EHLO
	fmmailgate01.web.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756388Ab0JITby (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 9 Oct 2010 15:31:54 -0400
Received: from smtp08.web.de  ( [172.20.5.216])
	by fmmailgate01.web.de (Postfix) with ESMTP id B3FE316DB68B3;
	Sat,  9 Oct 2010 21:28:57 +0200 (CEST)
Received: from [93.246.43.182] (helo=[192.168.178.29])
	by smtp08.web.de with asmtp (WEB.DE 4.110 #24)
	id 1P4f6H-0000Tk-00; Sat, 09 Oct 2010 21:28:57 +0200
User-Agent: Mozilla/5.0 (X11; U; Linux i686; de; rv:1.9.2.9) Gecko/20100915 Thunderbird/3.1.4
In-Reply-To: <20101006232243.GA30302@burratino>
X-Sender: Jens.Lehmann@web.de
X-Provags-ID: V01U2FsdGVkX1/Sg+7DNkpKvbEh5MWPv7YK3l3Hm50p4Jyn+Hhc
	QZXoPll7nYzMAFE6XJz80/r2MsQOMihhwZyrU5K6cE4bKadZZw
	uIS4316mJYkfUJvFO6yA==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/158600>

Am 07.10.2010 01:22, schrieb Jonathan Nieder:
> Kevin Ballard wrote:
> 
>> After thinking on it a bit, I think the best solution is to add a switch
>> --submodules to fetch which will also fetch all submodules, but otherwise
>> fetch will fetch no submodules.
> 
> For what it's worth, for my (odd) use cases, what would be most practical
> is
> 
> 	[remote "foo"]
> 		fetch = ...
> 		submodules = ...
> 
> I could care less about the defaults. :)
> 
> Rationale: I shouldn't have to explicitly use --submodules to get
> everything I need to hack before dropping connectivity,

Ack.


> but I also
> don't want to pay the penalty of fetching, say, git-gui when I don't
> need it.

I'm not sure I understand your setup, do you want to configure that for
each remote or for each submodule? Because you can already do the latter
with my patches. And configuring that via .gitmodules has the advantage
that every clone inherits that setting instead of having to set the
options for the remote again after each clone.
